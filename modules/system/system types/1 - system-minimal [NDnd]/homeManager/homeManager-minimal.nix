{
  inputs,
  ...
}:
{
  # default settings needed for all homeManagerConfigurations

  flake.modules.homeManager.system-minimal =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      home.homeDirectory =
        if pkgs.stdenv.isDarwin then
          (lib.mkForce "/Users/${config.home.username}")
        else
          "/home/${config.home.username}";
      home.stateVersion = "23.05";
    };
}
