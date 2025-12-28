{
  flake.modules.nixos.homeserver = {
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    nixpkgs.hostPlatform = "x86_64-linux";

    hardware.cpu.intel.updateMicrocode = true;
  };
}
