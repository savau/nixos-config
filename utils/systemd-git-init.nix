repositories:

let
  pkgs = import <nixpkgs> {};
  lib = import <nixpkgs/lib>;

  mkService = name': repo: {
    name = "git-init-${name'}";
    value = {
      Unit.Description = "Initializing git repository ${name'}";
      Unit.After = [ "network.target" ];
      Unit.ConditionPathExists = "!${repo.dest}";
      Service.ExecStart = pkgs.writeShellScript "git-init-${name'}" ''
        echo "git-init-${name'}: Creating directory ${repo.dest}"
        ${pkgs.coreutils}/bin/mkdir -p ${repo.dest}

        echo "git-init-${name'}: Cloning repository from ${repo.src} to ${repo.dest}"
        ${pkgs.git}/bin/git clone ${repo.src} ${repo.dest}

        if [ $? -eq 0 ]; then
          echo "git-init-${name'}: Successfully initialized ${name'}."
        else
          echo "git-init-${name'}: An error occurred while initializing ${name'}. Maybe the destination isn't empty?"
          exit 1
        fi
      '';
      Service.Environment = "PATH=${pkgs.openssh}/bin:$PATH";
      Service.Type = "simple";
      Install.WantedBy = [ "default.target" ];
    };
  };
in
  lib.mapAttrs' mkService repositories
