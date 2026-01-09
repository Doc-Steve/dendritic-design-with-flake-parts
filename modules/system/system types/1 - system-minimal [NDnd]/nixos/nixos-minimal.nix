{
  inputs,
  ...
}:
{
  # default settings needed for all nixosConfigurations

  flake.modules.nixos.system-minimal =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (final: _prev: {
          unstable = import inputs.nixpkgs-unstable {
            inherit (final) config;
            system = pkgs.stdenv.hostPlatform.system;
          };
        })
      ];
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "25.05";

      nix.settings = {
        substituters = [
          # high priority since it's almost always used
          "https://cache.nixos.org?priority=10"
          "https://install.determinate.systems"
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM"
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        experimental-features = [
          "nix-command"
          "flakes"
          # "allow-import-from-derivation"
        ];

        download-buffer-size = 1024 * 1024 * 1024;

        trusted-users = [
          "root"
          "@wheel"
        ];
      };

      nix.extraOptions = ''
        warn-dirty = false
        keep-outputs = true
      '';

    };
}
