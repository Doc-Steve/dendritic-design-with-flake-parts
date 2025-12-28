let
  genericPackages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
        tmux
        home-manager
      ];
    };
in
{
  flake.modules.nixos.cli-tools = {
    imports = [
      genericPackages
    ];
  };

  flake.modules.darwin.cli-tools = {
    imports = [
      genericPackages
    ];
  };
}
