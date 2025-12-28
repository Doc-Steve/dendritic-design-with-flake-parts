{
  flake.modules.homeManager.office =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      home.packages =
        with pkgs;
        [
          pdfarranger
          notesnook
        ]
        ++ (lib.optionals (pkgs.stdenv.isLinux) [
          libreoffice-qt6
          gimp3-with-plugins
        ])
        ++ (lib.optionals (pkgs.stdenv.isDarwin) [
          libreoffice-bin
          brewCasks.gimp
        ]);
    };
}
