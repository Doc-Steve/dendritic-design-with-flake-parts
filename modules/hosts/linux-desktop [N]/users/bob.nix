{
  inputs,
  ...
}:
{
  flake.modules.nixos.linux-desktop = {
    imports =
      with inputs.self.modules.nixos;
      with inputs.self.factory;
      [
        bob
        (mount-cifs-nixos {
          host = "home-server.lan";
          resource = "home";
          destination = "/home/users/bob/homeserver";
          credentialspath = "${config.age.secrets."homeserver-cred".path}";
          UID = "bob";
          GID = "users";
        })
      ];

    # ...

    home-manager.users.bob = {
      ###
    };
  };
}
