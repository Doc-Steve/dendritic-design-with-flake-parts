{
  self,
  ...
}:
{
  config.flake.factory.user = username: isAdmin: {

    nixos."${username}" =
      {
        lib,
        pkgs,
        ...
      }:
      {
        users.users."${username}" = {
          isNormalUser = true;
          home = "/home/${username}";
          extraGroups = lib.optionals isAdmin [
            "wheel"
          ];
          shell = pkgs.zsh;
        };
        programs.zsh.enable = true;

        home-manager.users."${username}" = {
          imports = [
            self.modules.homeManager."${username}"
          ];
        };
      };

    darwin."${username}" =
      { lib, pkgs, ... }:
      {
        users.users."${username}" = {
          home = "/Users/${username}";
          shell = pkgs.zsh;
        };

        home-manager.users."${username}" = {
          imports = [
            self.modules.homeManager."${username}"
          ];
        };

        system.primaryUser = lib.mkIf isAdmin "${username}";

        programs.zsh.enable = true;
      };

    homeManager."${username}" = {
      home.username = "${username}";
    };
  };
}
