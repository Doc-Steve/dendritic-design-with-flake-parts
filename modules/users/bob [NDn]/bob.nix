{
  self,
  lib,
  ...
}:
{
  flake.modules = lib.mkMerge [
    (self.factory.user "bob" true)
    {
      nixos.bob = {
        imports = with self.modules.nixos; [
          # developmentEnvironment
        ];
        users.users.bob = {
          group = "audio";
        };
      };

      darwin.bob = {
        imports = with self.modules.darwin; [
          # drawingApps
          # developmentEnvironment
        ];
      };

      homeManager.bob =
        { pkgs, ... }:
        {
          imports = with self.modules.homeManager; [
            system-desktop
            # adminTools
            # vscode
            # passwordManager
          ];
          home.packages = with pkgs; [
            mediainfo
          ];
        };
    }
  ];
}
