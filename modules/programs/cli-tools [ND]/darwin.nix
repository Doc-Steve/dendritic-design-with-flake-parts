{
  flake.modules.darwin.cli-tools =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        mas
      ];
    };
}
