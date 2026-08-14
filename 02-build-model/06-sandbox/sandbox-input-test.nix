# This derivation will realised successfully
# It happens because secret was put as a path value
# During evaluation, nix copies the referenced files into the store;
# derivation path-valued attributes are then represented byu that store pach
# in the builder environment
# And that's the answer about how builder can access source code.
# Actually, builder can not access source code in it's original location,
# builder has an access to nix store

let
  nixpkgs = builtins.getFlake "nixpkgs";
  pkgs = nixpkgs.legacyPackages.${builtins.currentSystem};

  bash = pkgs.bash;

  secret = /tmp/nix-secret.txt;
in
derivation {
  name = "sandbox-test";
  system = builtins.currentSystem;

  builder = "${bash}/bin/bash";

  args = [
    "-c"
    ''
      IFS= read -r line < "$secret"
      printf '%s\n' "$line" > "$out"
    ''
  ];

  inherit secret;
}