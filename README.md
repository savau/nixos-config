# nixos-config
My personal NixOS configuration


## NixOS Installation Guide
Full guide to install NixOS with UEFI and LVM on LUKS

### 1. Create Bootable USB Stick

1. Download NixOS Minimal ISO image from https://nixos.org/download.html

2. Write image to USB drive:
    ```dd if=/path/to/image.iso of=/dev/sdX bs=4M oflag=direct status=progress && sync```
    
    - `status=progress && sync` to show progress info while writing data
    - `oflag=direct` as a workaround for the `dd` process remaining in D state indefinitely: `oflag=direct` avoids `dd` finishing writing data too quickly for kernel buffers waiting for the (slow) device, i.e. makes `dd` avoid buffering (see [this linuxquestions.org thread](https://www.linuxquestions.org/questions/slackware-14/dd-and-status%3Dprogress-4175581355/#post5555338) for further details)

### 2. Boot the Installer

- Disable Secure Boot Control
- Disable USB legacy boot
- Enable Launch CSM

### 3. Partitioning
(Assuming an NVMe SSD drive called `nvme0n1` as our main device and 16GB physical RAM)

Use `gdisk /dev/nvme0n1` to write the following partition table to your main device:
```
Number      Size  Code
     1      500M  ef00
     2  100%FREE  8300
```

- An EFI partition of size 500M in FAT32
- A root partition with LVM on LUKS, containing both the swapspace and the root filesystem

Set up the encrypted LUKS partition and open it:
```
$ cryptsetup luksFormat /dev/nvme0n1p2
$ cryptsetup luksOpen /dev/nvme0n1p2 enc-pv
```

Create two logical volumes, a 32GB swap partition and the rest as our root filesystem:
```
$ pvcreate /dev/mapper/enc-pv
$ vgcreate vg /dev/mapper/enc-pv
$ lvcreate -L 32G -n swap vg
$ lvcreate -l '100%FREE' -n root vg
```
(General rule of thumb: The amount of swap space should be double the amount of physical RAM available on your machine)

Format the partitions:
```
$ mkfs.fat -F 32 /dev/nvme0n1p1
$ mkfs.ext4 -L root /dev/vg/root
$ mkswap -L swap /dev/vg/swap
```

### 4. Install NixOS

Mount the newly created partitions under `/mnt`:
```
$ mount /dev/vg/root /mnt
$ mkdir /mnt/boot
$ mount /dev/nvme0n1p1 /mnt/boot
$ swapon /dev/vg/swap
```

Configure WPA supplicant if you want to use WiFi for installing (if not, make sure you are connected via Ethernet):
```
$ wpa_passphrase SSID PWD > /etc/wpa_supplicant.conf
```

Generate an initial NixOS configuration:
```
$ nixos-generate-config --root /mnt
```

Note the UUID of the root partition `/dev/nvme0n1p2`:
```
$ blkid /dev/nvme0n1p2
```

Edit the newly generated `/mnt/etc/nixos/configuration.nix` and add the following options:
```
  ...
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/<UUID>";
    preLVM = true;
    allowDiscards = true;
  };
  ...
  environment.systemPackages = with pkgs; [
    wget curl vim htop git
  ];
  ...
```

Now we are ready to install NixOS:
```
$ nixos-install
$ reboot
```

### 5. Fetch configurations

I maintain various configurations (NixOS, XMonad, ZSH, Vim, ...) on GitHub repositories, so I want to clone my configurations from there. 
To be able to do so, I first need to generate a new key pair to use git with SSH.

#### 5.0 Preparation

To be able to get your NixOS config (i.e. to clone this repository), you first need to generate an SSH key and add it to your GitHub account.

On `github.com`, generate a personal access token for this purpose:

- Using the web interface, go to "Settings" -> "Developer settings" -> "Personal access token"
- Click "Generate new token"
- Give the token a descriptive name (e.g. "USER@MACHINE")
- Grant `write:public_key` and `read:public_key` permissions

Now, generate a new SSH key pair as/for root (use the default file location, i.e. `/root/.ssh/`):
```
$ ssh-keygen -t ed25519 -C "<EMAIL>"
```

Add this SSH key to the ssh-agent:
```
$ # start the ssh-agent in the background:
$ eval "$(ssh-agent -s)"
> Agent pid X
$ ssh-add ~/.ssh/id_ed25519
```

Add the generated SSH key to your GitHub account:
```
$ curl -i -u GITHUB_USER:GITHUB_PATOKEN --data 
    "{\"title\":\"USER@MACHINE\",\"key\":\"$(cat ~/.ssh/id_ed25519.pub)\"}" 
    https://api.github.com/user/keys
```

#### 5.1 NixOS configuration

We clone our NixOS configuration directly to `/etc/nixos`. The main configuration file, `<git:>/configuration.nix`, (like all its modules in `<git:>/modules`) is machine-independent and imports all machine-dependent options from `<git:>/machines/<HOSTNAME>`.

First delete the old configuration, clone your configuration from GitHub and regenerate the `hardware-configuration.nix`:
```
$ rm -rf /etc/nixos
$ git clone --recurse-submodules git@github.com:savau/nixos-config.git /etc/nixos
$ nixos-generate-config
$ mv /etc/nixos/hardware-configuration.nix
     /etc/nixos/machines/<HOSTNAME>/hardware-configuration.nix
```

Now that we have our configuration, we need to specify which machine-specific options to use. Each supported machine has its own options directory under `<git>:/machines/<HOSTNAME>`.
This NixOS configuration expects the name of the machine to load specific options for in the `<git>:/host` file:
```
$ echo <HOSTNAME> > /etc/nixos/host
```

Make sure that the UUID of your LUKS root partition (see `blkid /dev/nvme0n1p2`) is the same as `luksRootUUID` in the machine-specific options. If this is not the case, change `luksRootUUID` in `<git:>/machines/<HOSTNAME>/machine.nix` to the output UUID of `blkid /dev/nvme0n1p2`:
```
{
  ...
  luksRootUUID = "<UUID>";
  ...
}
```

#### 5.2 Other configurations

- [XMonad config](https://github.com/savau/xmonad-config)

### 6 Switch to `nixos-unstable`

Switch to `nixos-unstable` to allow for rolling releases:
```
$ # as root:
$ # sanity check; the NixOS version that was installed
$ #   on the USB drive should be listed:
$ nix-channel --list
$ nix-channel --add https://nixos.org/channels/nixos-unstable nixos
$ nixos-rebuild switch --upgrade
```

### 7 Finishing

When you're happy with the result and whenever you make changes to your NixOS configuration, use the following command to rebuild NixOS with the latest configuration and to directly switch to the new build:
```
$ nixos-rebuild switch
```

If you want to remove previous generations including boot entries, tell the nix package manager to collect garbage and then rebuild the new configuration and make it the new boot default:
```
$ # delete all previous garbage 
$ # (warning: you will be unable 
$ #  to rollback afterwards!): 
$ nix-collect-garbage -d

$ # alternatively, delete generations older than 
$ # N days by using the following 
$ # instead of the previous command: 
$ nix-collect-garbage --delete-older-than ${N}d
