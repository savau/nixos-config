# nixos-config
My personal NixOS configuration


## NixOS Installation Guide
Full guide to install NixOS with UEFI and full disk encryption (encrypted /boot) using LVM on LUKS

### 1. Create Bootable USB Stick

1. Download NixOS Minimal ISO image from https://nixos.org/download.html

2. Write image to USB drive:
    ```dd if=/path/to/image.iso of=/dev/sdX bs=4M oflag=direct status=progress && sync```
    
    - `status=progress && sync` to show progress info while writing data
    - `oflag=direct` as a workaround for the `dd` process remaining in D state indefinitely: `oflag=direct` avoids `dd` finishing writing data too quickly for kernel buffers waiting for the (slow) device, i.e. makes `dd` avoid buffering (see [this linuxquestions.org thread](https://www.linuxquestions.org/questions/slackware-14/dd-and-status%3Dprogress-4175581355/#post5555338) for further details)

### 2. Boot the Installer

- disable Secure Boot Control
- disable USB legacy boot
- enable Launch CSM

### 3. Partitioning
(Assuming a 256GB NVMe SSD and 16GB physical RAM)

Use `gdisk /dev/nvme0n1` to write the following partition table:
```
NAME          SIZE   TYPE  MOUNTPOINT
nvme0n1       238.5G disk
├─nvme0n1p1     500M part  /boot/efi
└─nvme0n1p2     238G part
  └─root        238G crypt
    ├─vg-swap    32G lvm   [SWAP]
    └─vg-root   206G lvm   /
```

- one partition of size 500M in FAT (EFI partition)
- one partition with LVM on LUKS, containing both the swap and the root filesystem (only works with LUKS1 in case of Grub!)
- as a rule of thumb: the amount of swap space should be double the amount of physical RAM available on your machine

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
$ mkfs.fat /dev/nvme0n1p1
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
    wget vim htop git
  ];
  ...
```

Now, we are ready to install NixOS:
```
$ nixos-install
$ reboot
```

### 5. Fetch configurations

I maintain my NixOS configuration on GitHub, so I want to clone my configuration from there:
(TODO: move hardware-configuration.nix to git as well?)
```
$ rm -rf /etc/nixos
$ git clone https://github.com/savau/nixos-config.git /etc/nixos
$ nixos-generate-config && mv /etc/nixos/hardware-configuration.nix /etc/nixos/machines/xego/hardware-configuration.nix  # alternatively, move the previous hardware-configuration.nix to some temporary location and, after cloning the config repo, move it back to /etc/nixos/machines/xego/hardware-configuration.nix
```

Now that we have our config, symlink the relevant config file (under `machines/$MACHINENAME/configuration.nix`) to `/mnt/etc/nixos/configuration.nix`:
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
