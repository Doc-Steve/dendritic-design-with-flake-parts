{
  inputs,
  ...
}:
{
  # age-encrypted secrets for NixOS / Darwin and Home Manager
  # https://github.com/ryantm/agenix

  flake-file.inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      # url = "github:yaxitech/ragenix"; # rust drop-in replacment
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    secrets = {
      url = "path:./secrets";
      flake = false;
      # It's also possible to directly depend on a local Git repository.
      # git-directory-example.url = "git+file:/path/to/repo?shallow=1";
    };
  };
}
