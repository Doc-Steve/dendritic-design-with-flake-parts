{
  inputs,
  ...
}:
let
  username = "eve";

  flake.modules.homeManager."${username}" =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        system-cli
        # drawing
      ];
      home.username = "${username}";
      home.packages = with pkgs; [
        imagemagick
      ];
    };
in
{
  inherit flake;
}
