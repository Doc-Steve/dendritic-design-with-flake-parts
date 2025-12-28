{
  inputs,
  ...
}:
{
  # basic system with ssh

  flake.modules.nixos.system-basic = {
    imports = with inputs.self.modules.nixos; [
      system-essential
      ssh
      firmware
    ];
  };

  flake.modules.darwin.system-basic = {
    imports = with inputs.self.modules.darwin; [
      system-essential
      ssh
    ];
  };

  flake.modules.homeManager.system-basic = {
    imports = with inputs.self.modules.homeManager; [
      system-essential
    ];
  };
}
