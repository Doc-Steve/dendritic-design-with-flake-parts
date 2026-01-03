{
  inputs,
  ...
}:
let
  username = "alice";
in
{
  flake.modules.homeManager."${username}" =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        system-desktop
        # messaging
      ];
      home.username = "${username}";
    };
}
