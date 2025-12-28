{
  inputs,
  ...
}:
let
  username = "bob";

  flake.modules.homeManager."${username}" =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        system-desktop
        # adminTools
        # vscode
        # passwordManager
      ];
      home.username = "${username}";
      home.packages = with pkgs; [
        mediainfo
      ];
    };
in
{
  inherit flake;
}
