# in this package.nix we will leave all phases to be default
# common sense of this file is to show the default mkDerivation behavior
# it's working basically because typical Unix package need only make install#

let
  pkgs = import <nixpkgs> {};

  preBuild = ''
    echo ">>> PRE BUILD"
    printf '%s\n' '#define EXTRA_MESSAGE "injected by preBuild"' \
        > extra.h
    '';

    postBuild = ''
    echo ">>> POST BUILD"
    ls -l hello
    '';

    preInstall = ''
    echo ">>> PRE INSTALL"
    '';

    postInstall = ''
    echo ">>> POST INSTALL"
    find "$out"
    '';
in
pkgs.stdenv.mkDerivation {
  pname = "default-phases-lab";
  version = "1.0";

  src = ./src;
}
