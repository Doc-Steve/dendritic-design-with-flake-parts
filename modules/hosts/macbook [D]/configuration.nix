{
  inputs,
  ...
}:
{
  flake.modules.darwin.macbook = {
    imports = with inputs.self.modules.darwin; [
      system-desktop
      ###
    ];
    networking.hostName = "macbook";

    system.primaryUser = "bob";

    homebrew = {
      enable = true;
      masApps = {
        "Numbers" = 409203825;
        "Pages" = 409201541;
        "Keynote" = 409183694;
        "iMovie" = 408981434;
      };
    };
  };
}
