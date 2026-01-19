{
  inputs,
  ...
}:
{
  # expansion of default system with basic system settings & cli-tools

  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-default

      ssh
      firmware
      cli-tools
    ];
  };

  flake.modules.darwin.system-cli = {
    imports = with inputs.self.modules.darwin; [
      system-default

      ssh
      cli-tools
    ];
  };

  flake.modules.homeManager.system-cli = {
    imports = with inputs.self.modules.homeManager; [
      system-default

      shell
    ];
  };
}
