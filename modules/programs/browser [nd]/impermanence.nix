{
  flake.modules.homeManager.browser =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home.persistence."/persistent/home/${config.home.username}" = {
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
}
