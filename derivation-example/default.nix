# Model for building stuff at NixOS using derivations
{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  # We can optionally set our own phases
  phases = [
    "unpackPhase"
    "buildPhase"
    "installPhase"
    #"myCustomPhaseWhatever"
  ];

  #	myCustomPhaseWhatever = ''
  #		blah blah blah
  #	''
  name = "hello-world";
  src = ./src;

  # Specifies dependencies to be packaged with this derivation
  buildInputs = with pkgs; [
    ncurses
  ];

  # Specifies dependencies that are only avaiable at the phases
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  # Here we can specify a buildPhase if we don't nix will try
  # To use a Makefile from src directory

  buildPhase = ''
    g++ hello-world.cpp -o hello-world #-lncurses
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp hello-world $out/bin
  '';

  # Makes cowsay avaiable only for the hello world binary
  # postFixup = ''
  # 	wrapProgram $out/bin/hello-world \
  # 	--set PATH ${pkgs.lib.makeBinPath (with pkgs; [
  # 		cowsay
  # 	])}
  # '';
  #
}
