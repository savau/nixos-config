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
    device = "/dev/disk/by-uuid/UUID";
    preLVM = true;
    allowDiscards = true;
  };
  ...
  environment.systemPackages = with pkgs; [
    wget curl vim htop git
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

To be able to get your NixOS config (i.e. to clone this repository), you first need to generate an SSH key and add it to your GitHub account.

On `github.com`, generate a personal access token for this purpose:

- Using the web interface, go to "Settings" -> "Developer settings" -> "Personal access token"
- Click "Generate new token"
- Give the token a descriptive name (e.g. "USER@MACHINE")
- Grant `write:public_key` and `read:public_key` permissions

Now, generate a new SSH key pair as/for root (use the default file location, i.e. `/root/.ssh/`):
```
$ ssh-keygen -t ed25519 -C "EMAIL"
```

Add this SSH key to the ssh-agent:
```
$ # start the ssh-agent in the background:
$ eval "$(ssh-agent -s)"
> Agent pid X
$ ssh-add ~/.ssh/id_ed25519
```

To be able to clone this repository, add the newly generated SSH key to your GitHub account:
```
$ curl -i -u GITHUB_USER:GITHUB_PATOKEN --data 
    "{\"title\":\"USER@MACHINE\",\"key\":\"$(cat ~/.ssh/id_ed25519.pub)\"}" 
    https://api.github.com/user/keys
```

Repeat this process for your main user later on (generate a fresh token for this purpose, if needed).

#### 5.1 NixOS configuration

We clone our NixOS configuration directly to `/etc/nixos`, and then symlink the machine-specific configurations from `/etc/nixos/machines/MACHINE`.

We first delete the old configuration, clone our configuration and regenerate the `hardware-configuration.nix`:
```
$ rm -rf /etc/nixos
$ git clone git@github.com:savau/nixos-config.git /etc/nixos
$ nixos-generate-config
$ mv /etc/nixos/hardware-configuration.nix
     /etc/nixos/machines/MACHINE/hardware-configuration.nix
```

Now that we have our configuration files, symlink the relevant config for this machine (under `machines/MACHINE/configuration.nix`) to `/etc/nixos/configuration.nix`:
```
$ cd /etc/nixos
$ ln -sf "machines/MACHINE/configuration.nix" .
```

Finally, restore the UUID of `/dev/nvme0n1p2` (see `blkid /dev/nvme0n1p2`) in `/etc/nixos/configuration.nix`:
```
...
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/UUID";
    ...
  };
...
```

#### 5.2 Miscellanenous configuration

- [XMonad config](https://github.com/savau/xmonad-config)
- [X config](https://github.com/savau/x-config)
- [Miscellaneous utilities](https://github.com/savau/misc-utils)

### 6 Switch to `nixos-unstable`

I recommend to switch to `nixos-unstable` to allow for rolling releases:
```
$ # as root:
$ # sanity check; the NixOS version that was installed
$ #   on the USB drive should be listed:
$ nix-channel --list
$ nix-channel --add https://nixos.org/channels/nixos-unstable nixos
$ nixos-rebuild switch --upgrade
```

Switching to `nixos-unstable` is also required for your u2w development environment.

### 7 Finishing

When you're happy with the result and whenever you make changes to your NixOS configuration, use the following command to rebuild NixOS with the latest configuration and to directly switch to the new build:
```
$ nixos-rebuild switch
```


## Uni2work Setup Guide
Ad-hoc written guide to setup Uni2work productive environment under NixOS. Also contains comments how the README.md in the Uni2work repository should be updated at specific steps. Note that this part is currently a work in progress.

### Prerequisites

- `de_DE.UTF-8/UTF-8` locale: `config.i18n.supportedLocales` defaults to `[ "all" ]`, so `de_DE.UTF-8/UTF-8` should be available by default. If `config.i18n.supportedLocales` is explicitely set to something else, make sure to include `"de_DE.UTF-8/UTF-8"` in the list.

### Clone Repository

- Edit u2w README.md:
    - Update repo link! (Also default to clone via SSH and paste link to how-to-ssh)
    - Maybe also add best practice of dest:
    ```
    $ git clone git@gitlab2.rz.ifi.lmu.de:uni2work/uni2work.git uni2work/uni2work
    $ cd ~
    $ ln -s uni2work/uni2work u2w
    $ cd u2w
    ```

### LDAP

Install:
```
environment.systemPackages = [ pkgs.openldap ];
```

For local development without authenticating LDAP users, this might not be necessary. TODO: verify

### PostgreSQL

Install: See `modules/u2w.nix`. With this, you can also skip the manual process of adding psql users (including linking them to linux users) and databases.

When creating new `uniworx` psql account, in the current state `createuser --interactive` will not ask for a password prompt (which is okay, I guess).

### Compiling the Frontend

Node and npm are required to compile the frontend:
```
environment.systemPackages = with pkgs; [ nodejs ];
```

Generate a `.npmrc` before `npm install`:
```
$ FONTAWESOME_NPM_AUTH_TOKEN=<insert token> ./.npmrc.gup
```

Now setup npm:
```
$ npm install
```

### Other prerequisites

Prerequisites that are listed in u2w README, but not needed on NixOS:

- `stack`
- `slapd`, `ldap-utils` (included in `openldap` afaik)
- `postgresql`
- `libsasl2-dev`, `libldap2-dev` (TODO: double-check for errors about missing C libs in `stack setup` or `stack build`
- `libsodium-dev` (TODO: verify), `pkg-config` (already installed afaik)

### Stack

Using `stack` from `nixpkgs`, let's see if that works... ~~(if not, fixiate stack version or sth)~~ (it works, hooray)


### Compilation

Update u2w README: 

- first db fill with test data: `cd u2w && ./db.sh -cf`
- include `npm install` before compiling frontend
- use `npm run start` for watcher; local app will be reachable under `localhost:3000`
- after first start of the application, use `cp -r .stack-work .stack-work-run` to enable caching (for faster compilation)

maybe include error cases:

- `wellKnownBase is not a directory`: run `npm install` (e.g. before calling `./db.sf`)
- `Not Found - GET https://registry.npmjs.org/@fortawesome%2ffontawesome-pro - Not found` when running `npm install`: remove `package-lock.json` and try again
- `no space left on device` (tested with 8GB RAM and 40GB swap)
    - does not occur in nix shell, i.e. use `nix-shell --command "npx npm-run-all start"` instead for now
- `npm-run-all` command not found, even though installed (via prior `npm i`): 
    - `npx npm-run-all <command>` works around this issue
    - running `npm install` in nix shell seems to fix this issue (TODO: verify)
- `In nix shell but runExecL is False` (or sth like this):
    - running build or start outside of nix-shell, use this instead: `nix-shell --comand "npx npm-run-all start"` (`npx npm-run-all start` instead of `npm run start` right now, see fix above)
- `npm run (build|start)` failed with exec code 1, no further errors reported => remove `.stack-work.lock` and try again
- in nix shell, when running `npm run (start|build)`: `devel.hs: Network.Socket.connect: <socket: 13>: does not exist (Connection refused)`
    - no idea yet...
