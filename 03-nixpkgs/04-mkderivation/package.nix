let
  pkgs = import <nixpkgs> {};
in
pkgs.stdenv.mkDerivation {
  pname = "mkdrv-lab";
  version = "1.0";

  dontUnpack = true;

  # treat buildCommand as temp. lab equipment to skip normal build phases
  buildCommand = ''
    mkdir -p "$out"
    printf '%s\n' "hello from mkDerivation" > "$out/result.txt"
  '';
}
