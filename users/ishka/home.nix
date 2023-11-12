{ lib, pkgs, home, ... }:

{
  imports = [
    ./../../home-plugins/direnv.nix
    ./../../home-plugins/i18n.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ishka";
  home.homeDirectory = "/home/ishka";

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

    perl
    stack
    ghc
    texlive.combined.scheme-full

    # Terminal packages
    bsdgames
    file
    magic-wormhole
    rlwrap
    screen

    # X-related packages
    xorg.xmodmap
    xorg.xrandr
    xorg.xkill
    xclip
    xlockmore

    # GUI packages
    audacity
    gimp
    keepassxc
    mate.atril
    mplayer
    libreoffice
    pqiv
    xournal

    # GUI web packages
    firefox
    chromium
    thunderbird
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
  };

  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };

  gtk.enable = true;

  programs = {
    bash = {
      enable = true;
      historyControl = [ "ignorespace" "ignoredups" ];
      bashrcExtra = ''
        if [[ -e .bashrc_stateful ]]; then
          . .bashrc_stateful
        fi
      '';
    };

    git = {
      enable = true;
      extraConfig = {
        pull.rebase = false;
        submodule.recurse = true;
      };
    };

    ssh.enable = true;

    vim.enable = true;
  };

  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.xlockmore}/bin/xlock";
  };

  xsession = {
    enable = true;
    windowManager.command = "wmaker";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
