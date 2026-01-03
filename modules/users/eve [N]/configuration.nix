{
  inputs,
  self,
  ...
}:

let
  username = "eve";
in
{
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
}
