{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs
    python3
    python38Packages.fontforge
    ttfautohint-nox
    zip
  ];
}
