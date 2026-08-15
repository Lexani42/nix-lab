# Actually nixpkgs is a huge NixOS/nixpkgs github repository
# It contains huge amount of nix derivations, libs and helper functions
# to use in development
# Because of Nix laziness, user can import entire nixpkgs repository,
# without actually building all packages or even evaluating them
# Conceptual issue is treating nixpkgs as a package repository, binaries
# can be downloaded from cache but it has nothing to do with nixpkgs

let
  pkgs = import <nixpkgs> {};
in
{
  pkgsType = builtins.typeOf pkgs; # set

  helloExists = pkgs ? hello; # true
  helloType = builtins.typeOf pkgs.hello; # set

  helloDerivationType = pkgs.hello.type; # derivation

  libType = builtins.typeOf pkgs.lib; # set
  callPackageType = builtins.typeOf pkgs.callPackage; # lambda
  pythonPackagesType = builtins.typeOf pkgs.python3Packages; # set
}
