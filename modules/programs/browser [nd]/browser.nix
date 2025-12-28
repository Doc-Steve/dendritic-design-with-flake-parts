{
  flake.modules.homeManager.browser =
    {
      pkgs,
      lib,
      ...
    }:
    {
      home.packages =
        with pkgs;
        [
          firefox
        ]
        ++ lib.optionals (
          stdenv.hostPlatform.system == "x86_64-linux"
          || stdenv.hostPlatform.system == "aarch64-darwin"
          || stdenv.hostPlatform.system == "x86_64-darwin"
        ) [ google-chrome ]
        ++ lib.optionals (stdenv.hostPlatform.system == "aarch64-linux") [ chromium ];
    };
}
