{
  pkgs ? import <nixpkgs> { },
}:
# example package for wrapped cowsay
pkgs.symlinkJoin {
  name = "cowsay";

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  paths = [ pkgs.cowsay ];

  # cowsay is now always sleepy
  postBuild = ''
    wrapProgram $out/bin/cowsay --add-flag "-s" 
  '';
}
