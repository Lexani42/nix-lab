let
  pkgs = import <nixpkgs> {};
in
{
  mkDerivationType =
    builtins.typeOf pkgs.stdenv.mkDerivation; # lambda

  package = # derivation
    pkgs.stdenv.mkDerivation {
      pname = "mkdrv-lab";
      version = "1.0";

      dontUnpack = true;

      buildCommand = ''
        mkdir -p "$out"
        printf '%s\n' "hello from mkDerivation" > "$out/result.txt"
      '';
    };

  packageType = # set
    builtins.typeOf (
      pkgs.stdenv.mkDerivation {
        pname = "mkdrv-lab-2";
        version = "1.0";

        dontUnpack = true;

        buildCommand = ''
          mkdir -p "$out"
        '';
      }
    );
}
