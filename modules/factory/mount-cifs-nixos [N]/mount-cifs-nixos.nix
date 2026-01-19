{
  config.flake.factory.mount-cifs-nixos =
    {
      host,
      resource,
      destination,
      credentialspath,
      UID,
      GID,
    }:
    {
      config,
      lib,
      ...
    }:
    {
      fileSystems."${destination}" = {
        device = "//${host}/${resource}";
        fsType = "cifs";
        options =
          let
            # prevent hanging on network split
            automount-opts = [
              "x-systemd.automount"
              "noauto"
              "nofail"
              "soft"
              "x-systemd.idle-timeout=60"
              "x-systemd.device-timeout=5s"
              "x-systemd.mount-timeout=5s"
            ];
            mount-opts = [
              "rw"
              "iocharset=utf8"
            ];
            user = [
              "uid=${UID}"
              "gid=${GID}"
            ];
            credentials = [ "credentials=${credentialspath}" ];
          in
          automount-opts ++ mount-opts ++ user ++ credentials;
      };
    };
}
