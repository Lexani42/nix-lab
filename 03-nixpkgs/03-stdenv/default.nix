# 'stdenv' in nixpkgs is an attribute set containing a shell, toolchain,
# platform information and mkDerivation function
# its setup script establishes the phase protocol used by standard builds
# different platforms can provide different stdenvs while exposing
# the same broad interface
let
    pkgs = import <nixpkgs> {};
in 
{
    shell = pkgs.stdenv.shell;
    ccBuiltinType = builtins.typeOf pkgs.stdenv.cc;
    ccSemanticType = pkgs.stdenv.cc.type;
    mkType = builtins.typeOf pkgs.stdenv.mkDerivation;
    platform = pkgs.stdenv.hostPlatform.system;
}