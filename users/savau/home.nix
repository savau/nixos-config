{ lib, pkgs, home, ... }:

{
  imports = [
    ./../../home-plugins/direnv.nix
    ./../../home-plugins/games.nix
    ./../../home-plugins/gtk.nix
    ./../../home-plugins/i18n.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "savau";
  home.homeDirectory = "/home/savau";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
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

    stack
    texlive.combined.scheme-full

    # Terminal packages
    magic-wormhole
    screen

    # X-related packages
    xorg.xmodmap
    xorg.xrandr
    xclip

    # XFCE packages
    xfce.xfce4-session
    xfce.xfce4-power-manager
    # panel
    autoconf automake pkg-config # needed for xmonad integration with xfce4-panel # TODO: maybe move to xmonad nix file and integrate that one?
    xfce.xfce4-panel
    xfce.xfce4-panel-profiles   # simple application to manage xfce panel layouts
    xfce.xfce4-battery-plugin   # battery plugin for xfce panel
    xfce.xfce4-clipman-plugin   # clipboard manager plugin for xfce panel
    xfce.xfce4-datetime-plugin  # shows the date and time in the panel, and a calendar appears when you left-click on it
    xfce.xfce4-mailwatch-plugin # mail watcher plugin for xfce panel
    xfce.xfce4-cpugraph-plugin  # CPU graph show for xfce panel
    xfce.xfce4-genmon-plugin    # generic monitor plugin for xfce panel
    xfce.xfce4-fsguard-plugin   # filesystem usage monitor plugin for xfce panel
    xfce.xfce4-netload-plugin   # internet load speed plugin for xfce panel
    # xfce.xfce4-embed-plugin     # embed arbitrary app windows on xfce panel (currently marked as broken)
    # pulseaudio
    # xfce.xfce4panel_gtk3  # required for pulseaudio, see https://github.com/NixOS/nixpkgs/issues/18724
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-volumed-pulse
    # thunar
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.thunar-volman
    xfce.tumbler # thunar thumbnails
    xfce.xfconf  # thunar save settings

    # GUI packages
    dmenu # TODO: maybe move this to xmonad nix file and integrate that one?
    arandr
    audacity
    gimp
    keepassxc
    libreoffice
    okular
    vlc
    xournal

    # GUI web packages
    firefox
    nextcloud-client
    thunderbird
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".Xmodmap".source = ./dotfiles/.Xmodmap;

    ".config/xfce4" = {
      source    = ./dotfiles/.config/xfce4;
      recursive = true;
    };

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # TODO: fetch xmonad-config in "workable" state, i.e. with .git and over ssh with pubkey
    # ".xmonad" = {
    #   source = pkgs.fetchFromGitHub {
    #     owner = "savau";
    #     repo = "xmonad-config";
    #     leaveDotGit = true;
    #     fetchSubmodules = true;
    #   };
    #   recursive = true;
    # };
  };

  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };

  programs = {
    autorandr = {
      enable = true;
      hooks = {}; # TODO: maybe configure
      profiles = {}; # TODO: configure (caution: partially host-specific!)
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

    # TODO: configure coc (see vim-config repo)
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true; vimAlias = true; vimdiffAlias = true;
      withPython3 = true;
      plugins = with pkgs.vimPlugins; [
        airline
        fugitive
        vim-nix
      ];
      extraConfig = builtins.readFile (builtins.fetchGit {
        url = "https://github.com/savau/vim-config.git";
        ref = "main";
      } + "/.vimrc");
    };

    ssh = {
      enable = true;
      hashKnownHosts = true;
      extraConfig = ''
        IdentitiesOnly true
      '';
    };

    tmux = {
      enable = true;
      clock24 = true;
      historyLimit = 50000;
      extraConfig = lib.readFile (pkgs.stdenv.mkDerivation {
        name = "tmux.conf";
        src = ./dotfiles/tmux.conf;
        mandb = pkgs.man;

        buildInputs = with pkgs; [ makeWrapper ];

        phases = [ "installPhase" ];
        installPhase = ''
          substituteAll $src $out
        '';

        inherit (pkgs) zsh;
      });
    };

    zsh = {
      enable = true;
      autocd = true;
      enableAutosuggestions = true;
      history = {
        size = 1000000;
        save = 1000000;
        ignorePatterns = [
          "rm *"
          "pkill *"
        ];
        ignoreSpace = true;
        extended = true;
        share = true;
      };
      shellAliases = {
        "ll" = "ls -la";
      };
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ "git" ];
      };
      initExtraFirst = ''
        export PATH=~/.utils/bin:$PATH
      '';
      initExtra = ''
        GPG_TTY=$(tty)
        export GPG_TTY
      '';
    };
  };

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
        } + "/xmonad-monolith.hs");
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
