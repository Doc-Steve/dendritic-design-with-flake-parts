{
  flake.modules.homeManager.shell =
    {
      config,
      ...
    }:
    {
      home.persistence."/persistent/home/${config.home.username}" = {
        directories = [ ".config/zsh" ];
        files = [ ".bash_history" ];
      };
    };
}
