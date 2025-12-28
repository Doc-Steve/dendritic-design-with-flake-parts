{
  inputs,
  ...
}:
{
  flake.modules.nixos.homeserver = {
    imports = with inputs.self.modules.nixos; [
      iperf
    ];
  };
}
