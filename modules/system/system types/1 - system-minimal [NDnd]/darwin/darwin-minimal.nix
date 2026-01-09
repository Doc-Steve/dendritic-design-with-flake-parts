{
  inputs,
  ...
}:
{
  # default settings needed for all darwinConfigurations

  flake.modules.darwin.system-minimal =
    {
      pkgs,
      ...
    }:
    {
      nixpkgs.config.allowUnfree = true;

      system.stateVersion = 6;

      # Custom settings written to /etc/nix/nix.custom.conf

      determinate-nix.customSettings = {
        # Enables parallel evaluation (remove this setting or set the value to 1 to disable)
        eval-cores = 0;

        # Disable global registry
        flake-registry = "";

        lazy-trees = true;
        warn-dirty = false;

        experimental-features = [
          "nix-command"
          "flakes"
        ];

        extra-experimental-features = [
          "build-time-fetch-tree" # Enables build-time flake inputs
          "parallel-eval" # Enables parallel evaluation
        ];
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
      };

      nixpkgs.overlays = [
        (final: _prev: {
          unstable = import inputs.nixpkgs-unstable {
            inherit (final) config system;
          };
        })
      ];

      environment.systemPackages = with inputs.nix-darwin.packages.${pkgs.stdenv.hostPlatform.system}; [
        darwin-option
        darwin-rebuild
        darwin-version
        darwin-uninstaller
      ];

    };
}
