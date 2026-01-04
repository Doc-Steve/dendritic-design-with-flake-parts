{
  inputs,
  self,
  ...
}:

let
  username = "mallory";
in
{
  flake.modules.nixos."${username}" =
    {
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

  flake.modules.homeManager."${username}" = {
    imports = with inputs.self.modules.homeManager; [
      system-desktop
    ];
    home.username = "${username}";
  };
}
