{
  inputs,
  ...
}:
{
  # Manage your macOS using Nix
  # https://github.com/nix-darwin/nix-darwin

  flake-file.inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };
}
