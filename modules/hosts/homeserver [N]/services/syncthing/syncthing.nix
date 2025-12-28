{
  inputs,
  ...
}:
{
  flake.modules.nixos.homeserver = {
    imports = with inputs.self.modules.nixos; [
      syncthing
    ];

    services.syncthing = {
      settings = {
        folders = {
          "sharedfolder" = {
            enable = true;
            devices = [
              # "otherserver"
            ];
            path = "/sharedfolder";
            type = "sendreceive";
          };
        };
      };
    };
  };
}
