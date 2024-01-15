{ lib, pkgs, home, ... }:

rec {
  imports = [
    # Host-agnostic generic home plugins
    ./../../home-plugins/direnv.nix
    ./../../home-plugins/i18n.nix

    # Host-agnostic user plugins
    ./plugins/browsers/firefox.nix
    ./plugins/browsers/chromium.nix
    ./plugins/mail/thunderbird.nix
    ./plugins/mail/protonmail-bridge.nix
    ./plugins/games.nix
    ./plugins/gtk.nix
    ./plugins/neovim.nix
    ./plugins/qt.nix
    ./plugins/screen-locker.nix
    ./plugins/tmux.nix
    ./plugins/zsh.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "savau";
  home.homeDirectory = "/home/savau";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    # TODO use pkgs.writeShellScriptBin instead of uwx scripts in xmonad

    stack
    texlive.combined.scheme-full

    # Terminal packages
    magic-wormhole
    screen

    # X-related packages
    xorg.xmodmap
    xorg.xrandr
    xclip

    # GUI packages
    dmenu # TODO: maybe move this to xmonad nix file and integrate that one?
    arandr
    evince
    gimp
    inkscape
    keepassxc
    libreoffice
    mplayer gnome_mplayer
    xournal

    # GUI web packages
    element-desktop
    nextcloud-client
  ];

  # Home Manager is pretty good at managing dotfiles.
  # The primary way to manage plain files is through 'home.file'.
  home.file = {
    ".Xmodmap".source = ./dotfiles/.Xmodmap;

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xresources.properties = {
    "XTerm*cursorBlink" = true;
    "XTerm*selectToClipboard" = true;
    "XTerm*background" = "black";
    "XTerm*foreground" = "white";
    "XTerm*faceName" = "Liberation Mono for Powerline";
    "XTerm*faceSize" = 10;
  };

  # Set up Xfce configuration
  # Using `xdg.configFile` instead of `home.file` to allow for overwriting
  # existing files, which otherwise would cause the home-manager activation
  # to fail due to the old configuration being "in the way".
  # (xfce seems to touch all configuration files on session start by default,
  #  so the home activation would basically fail after every nixos-rebuild
  #  when using `home.file` for xfce config files.)
  xdg.configFile.".config/xfce4" = {
    source    = ./dotfiles/.config/xfce4;
    recursive = true;
    force     = true; # allow overwriting existing xfce config files
  };


  programs = {
    autorandr = {
      enable = true;
      hooks = {
        postswitch = {
          "restart-panel" = "xfce4-panel -r";
          "set-background" = "xsetroot -solid black";
        };
      };
      profiles = {}; # TODO: configure (caution: partially host-specific!)
      # see https://github.com/nix-community/home-manager/blob/master/modules/programs/autorandr.nix for config options
    };

    git = {
      enable = true;
      userName = "Sarah Vaupel";
      userEmail = "sarah.vaupel@protonmail.com";
      extraConfig = {
        pull.rebase = false;
        submodule.recurse = true;
      };
    };

    ssh = {
      enable = true;
      hashKnownHosts = true;
      forwardAgent = false;
      compression = false;
      controlMaster = "auto";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "30m";
      serverAliveInterval = 6;
      serverAliveCountMax = 10;
      extraConfig = builtins.readFile ./dotfiles/.ssh/config;
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableScDaemon = false;
      pinentryFlavor = "gnome3";
      enableZshIntegration = true;
    };
  };

  # Git repositories that should be synchronised to your home directory
  # systemd.user.services = import ./../../utils/systemd-git-init.nix {
  #   uwx-utils = {
  #     src = "git@github.com:savau/uwx-utils.git";
  #     dest = "${home.homeDirectory}/.utils/uniworx";
  #   };

  #   nixos-config = {
  #     src = "git@github.com:savau/nixos-config.git";
  #     dest = "${home.homeDirectory}/git/configs/nixos-config";
  #   };
  #   vim-config = {
  #     src = "git@github.com:savau/vim-config.git";
  #     dest = "${home.homeDirectory}/git/configs/vim-config";
  #   };
  #   xmonad-config = {
  #     src = "git@github.com:savau/xmonad-config.git";
  #     dest = "${home.homeDirectory}/git/configs/xmonad-config";
  #   };

  #   srv01-config = {
  #     src = "git@gitlab.uniworx.de:uniworx/machines/srv01.git";
  #     dest = "${home.homeDirectory}/git/machines/srv01";
  #   };

  #   uniworx-website = {
  #     src = "git@gitlab.uniworx.de:uniworx/uniworx.de.git";
  #     dest = "${home.homeDirectory}/git/websites/uniworx.de";
  #   };

  #   fradrive = {
  #     src = "git@gitlab.uniworx.de:fradrive/fradrive.git";
  #     dest = "${home.homeDirectory}/git/projects/fradrive/fradrive";
  #   };
  #   uni2work = {
  #     src = "git@gitlab.uniworx.de:uni2work/uni2work.git";
  #     dest = "${home.homeDirectory}/git/projects/uni2work/uni2work";
  #   };
  #   u2w-workflows = {
  #     src = "git@gitlab.uniworx.de:uni2work/workflows/workflows.git";
  #     dest = "${home.homeDirectory}/git/projects/uni2work/workflows/workflows";
  #   };
  # };

  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: with haskellPackages; [
        xmonad xmonad-contrib xmonad-extras
        dbus
        gtk-sni-tray
        status-notifier-item
        tuple
      ];
      config = pkgs.writeTextFile {
        name = "xmonad.hs";
        text = builtins.readFile (builtins.fetchGit {
          url = "https://github.com/savau/xmonad-config.git";
          ref = "master";
          rev = "6225c82cf37caf31f3b53f5aa3fbd75c39c4a1d3";
        } + "/xmonad.hs");
      };
    };

    initExtra = ''
      xmodmap ~/.Xmodmap
      exec xfce4-session &
      exec xfce4-panel &
      exec xmonad
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
