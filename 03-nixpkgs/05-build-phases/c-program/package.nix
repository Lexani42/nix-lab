# in this package.nix we will leave all phases to be default
# common sense of this file is to show the default mkDerivation behavior
# it's working basically because typical Unix package need only make install
# by default checkPhase is skipped.
# to run checkPhase user should explicitly add doCheck = true;
# stdenv does not understand the semantic relationships like
# "tests require compilation"
# if user excplicitly disables build (line 21 uncommented)
# build will fail on checkPhase

let
  pkgs = import <nixpkgs> {};
in
pkgs.stdenv.mkDerivation {
  pname = "default-phases-lab";
  version = "1.0";

  src = ./src;

  doCheck = true;
#   dontBuild = true; <- will fail
}
