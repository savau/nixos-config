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
(Assuming a 256GB NVMe SSD and 16GB physical RAM)

Use `gdisk /dev/nvme0n1` to write the following partition table:
```
Number      Size  Code
     1      500M  ef00
     2  100%FREE  8300
```

- One partition of size 500M in FAT32 (EFI partition)
- One partition with LVM on LUKS, containing both the swap and the root filesystem
    - (Note: only works with LUKS1 in case of Grub!)
- As a rule of thumb: The amount of swap space should be double the amount of physical RAM available on your machine

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
$ wpa_passphrase $SSID $PWD > /etc/wpa_supplicant.conf
```

Generate an initial NixOS configuration:
```
$ nixos-generate-config --root /mnt
```

Note the UUID of the root partition `/dev/nvme0n1p2`:
```
$ blkid /dev/nvme0n1p2
```

Edit the newly generated /mnt/etc/nixos/configuration.nix and add the following:
```
  ...
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/$UUID";
    preLVM = true;
    allowDiscards = true;
  };
  ...
  environment.systemPackages = with pkgs; [
    wget curl vim htop git xclip
  ];
  ...
```

Now, we are ready to install NixOS:
```
$ nixos-install
$ reboot
```

### 5. Fetch configurations

I maintain various configurations (NixOS, XMonad, ZSH, Vim, ...) on GitHub repositories, so I want to clone my configurations from there. To be able to do so, I first need to generate a new key pair to use git with SSH.

#### 5.0 Preparation

On github.com, generate a personal access token (to be able to add an ssh key to your GitHub account later on):

    - Using the web interface, go to "Settings" -> "Developer settings" (left sidebar) -> "Personal access token" (left sidebar)
    - Click "Generate new token"
    - Give the token a descriptive name
    - Grant `write:public_key` and `read:public_key` permissions

Login as user `savau` and generate a new SSH key pair (use the default file location):
```
$ ssh-keygen -t ed25519 -C "sarah.vaupel@protonmail.com"
```

Then, add your SSH key to the ssh-agent:
```
$ eval "$(ssh-agent -s)"  # start the ssh-agent in the background
> Agent pid X
$ ssh-add ~/.ssh/id_ed25519
```

Add the newly generated SSH key to your GitHub account:
```
$ xclip -selection clipboard < ~/.ssh/id_ed25519.pub  # copy the SSH public key to your clipboard
$ curl -H "Authorization: token $TOKEN" --data '{"title":"$KEYTITLE","key":"$CLIPBOARDCONTENT"}' https://api.github.com/user/keys
```

#### 5.1 NixOS configuration

We clone our NixOS configuration directly to /etc/nixos, and then symlink the machine-specific configurations from /etc/nixos/machines/$MACHINENAME.

We first delete the old configuration, clone our configuration and regenerate the hardware-configuration.nix:
```
$ rm -rf /etc/nixos
$ git clone git@github.com:savau/nixos-config.git /etc/nixos
$ nixos-generate-config && mv /etc/nixos/hardware-configuration.nix /etc/nixos/machines/xego/hardware-configuration.nix  # alternatively, move the previous hardware-configuration.nix to some temporary location and, after cloning the config repo, move it back to /etc/nixos/machines/xego/hardware-configuration.nix
```

Now that we have our configuration files, symlink the relevant config for this machine (under `machines/$MACHINENAME/configuration.nix`) to `/etc/nixos/configuration.nix`:
```
$ cd /etc/nixos
$ ln -sf "machines/$MACHINENAME/configuration.nix" .
```

Restore the UUID of `/dev/nvme0n1p2` (see `blkid /dev/nvme0n1p2`) in `/etc/nixos/configuration.nix`:
```
...
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/$UUID";
    ...
  };
...
```

#### 5.2 Miscellanenous configuration

- [ZSH config](https://github.com/savau/zsh-config)
- [Vim config](https://github.com/savau/vim-config)
- [XMonad config](https://github.com/savau/xmonad-config)
