{
  flake.modules.homeManager.gnome =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gnome-extension-manager
        gnomeExtensions.caffeine
      ];

      dconf.settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          disable-extension-version-validation = true;
          enabled-extensions = [
            "caffeine@patapon.info"
          ];
        };
      };
    };
}
