{
  flake.modules.nixos.linux-desktop = {
    fileSystems."/" = {
      device = "/dev/sda";
    };
  };
}
