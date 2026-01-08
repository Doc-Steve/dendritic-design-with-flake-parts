{
  inputs,
  ...
}:
{
  flake.modules.homeManager.shell =
    {
      config,
      ...
    }:
    {
      home = inputs.self.lib.mkIfPersistence config {
        persistence."/persistent" = {
          directories = [ ".config/zsh" ];
          files = [ ".bash_history" ];
        };
      };
    };
}
