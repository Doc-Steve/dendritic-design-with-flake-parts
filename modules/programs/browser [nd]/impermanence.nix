{
  inputs,
  ...
}:
{
  flake.modules.homeManager.browser =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home = inputs.self.lib.mkIfPersistence config {
        persistence."/persistent" = {
          directories = [
            ".mozilla/firefox"
          ]
          ++ lib.optionals (lib.elem pkgs.google-chrome config.home.packages) [
            ".config/Google-Chrome"
          ]
          ++ lib.optionals (lib.elem pkgs.chromium config.home.packages) [
            ".config/chromium"
          ];
        };
      };
    };
}
