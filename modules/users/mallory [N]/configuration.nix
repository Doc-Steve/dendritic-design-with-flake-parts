{
  inputs,
  self,
  ...
}:

let
  username = "mallory";

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

      users.users."${username}" = {
        isNormalUser = true;
        initialPassword = "changeme";
        shell = pkgs.zsh;
      };
      programs.zsh.enable = true;
    };
in
{
  inherit flake;
}
