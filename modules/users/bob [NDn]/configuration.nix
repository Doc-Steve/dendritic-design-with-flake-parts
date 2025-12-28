{
  inputs,
  self,
  ...
}:

let
  username = "bob";

  flake.modules.nixos."${username}" =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {

      imports = with inputs.self.modules.nixos; [
        # developmentEnvironment
      ];

      home-manager.users."${username}" = {
        imports = [
          inputs.self.modules.homeManager."${username}"
        ];
      };

      users.users."${username}" = {
        isNormalUser = true;
        initialPassword = "changeme";
        shell = pkgs.zsh;
      };
      programs.zsh.enable = true;

    };

  flake.modules.darwin."${username}" =
    { pkgs, ... }:
    {

      imports = with inputs.self.modules.darwin; [
        # drawingApps
        # developmentEnvironment
      ];

      home-manager.users."${username}" = {
        imports = [
          inputs.self.modules.homeManager."${username}"
        ];
      };

      system.primaryUser = "${username}";

      users.users."${username}" = {
        name = "${username}";
        shell = pkgs.zsh;
      };
      programs.zsh.enable = true;

    };
in
{
  inherit flake;
}
