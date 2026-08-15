# This nix code uses pkgs.callPackage function
# Note that callPackage is not built-in nix function but took from nixpkgs repo
# callPackage function checks which inputs needs a function and
# tries to find package with the same name as parameter in nixpkgs
# For example typical reuqired input variable for package is fetchFromGitHub
# callPackage function will pass pkgs.fetchFromGitHub
# By default, callPackage function does not pass non-required parameters,
# means parameters with default value
# callPackage has 2 arguments - function itself to call and optional overrides
# Note that callPackage can consume any nix function, not only that generates derivations

# In this example one fact is conceptually important
# manual and automatic has exactly the same sets
# It is because passing pkgs.hello and pkgs.git is literally that callPackage does in this case
# explicit contains overrided message attribute
# Also I've added commented thisDoesNotExistInNixpkgs parameter to package.nix
# If I uncomment it and related code, each evaluation that does not contain
# thisDoesNotExistInNixpkgs - so manual and automatic - will fall
# Manual evaluation of course will fall because I didn't passed value
# Automatic - becasue pkgs.thisDoesNotExistInNixpkgs DOES NOT EXIST in nixpkgs
let
  pkgs = import <nixpkgs> {};

  manual = (import ./package.nix) {
    hello = pkgs.hello;
    git = pkgs.git;
  };

  automatic = pkgs.callPackage ./package.nix {};

  explicit = pkgs.callPackage ./package.nix {
    message = "explicit-value";
    # thisDoesNotExistInNixpkgs = "supplied manually";
  };
in
{
  inherit manual automatic explicit;
}
