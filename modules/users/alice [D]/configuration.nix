{
  inputs,
  self,
  ...
}:

let
  username = "alice";
in
{
  flake.modules.darwin."${username}" =
    { pkgs, ... }:
    {

      imports = with inputs.self.modules.darwin; [
        # videoEditing
      ];

      home-manager.users."${username}" = {
        imports = [
          inputs.self.modules.homeManager."${username}"
        ];
      };

      users.users."${username}" = {
        name = "${username}";
        shell = pkgs.zsh;
      };
      programs.zsh.enable = true;
    };
}
