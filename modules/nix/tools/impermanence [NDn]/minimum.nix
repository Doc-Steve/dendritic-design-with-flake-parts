{
  flake.modules.nixos.impermanence =
    { config, ... }:
    {
      environment.persistence."/persistent" = {
        hideMounts = true;
        directories = [
          "/var/log"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/etc/NetworkManager/system-connections"
        ];
        files = [
          "/etc/machine-id"
        ];
      };

      programs.fuse.userAllowOther = true;

    };

  flake.modules.homeManager.impermanence =
    { config, ... }:
    {
      home.persistence."/persistent/home/${config.home.username}" = {
        allowOther = false;
      };
    };
}
