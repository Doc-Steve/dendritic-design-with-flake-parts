{
  flake.modules.homeManager.shell =
    {
      config,
      ...
    }:
    {
      programs.zsh = {
        enable = true;
        dotDir = "${config.xdg.configHome}/zsh";
        enableCompletion = true;
      };

      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
    };

}
