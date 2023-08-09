{ lib, pkgs, ... }:

{
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
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello

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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".xmonad" = {
      source = ./dotfiles/xmonad;
      recursive = true;
    };
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/savau/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
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
      # initExtra = ;
      # initExtraFirst = ;
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ "git" ];
      };
    };
  };

  xsession = {
    enable = true;
    windowManager.command = "exec xmonad";
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: with haskellPackages; [
        xmonad
        xmonad-contrib
        xmonad-extras
        dbus
        status-notifier-item
        gtk-sni-tray
        tuple
      ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    iconTheme = {
      name = "Arc-Dark";
      package = pkgs.arc-icon-theme;
    };
    font.name = "Sans 10";
    gtk2.extraConfig = ''
      gtk-enable-event-sounds = 0
      gtk-enable-input-feedback-sounds = 0
    '';
    gtk3.extraConfig = {
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
