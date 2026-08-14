# This derivation will fail with an error that declares unavailable example.com,
# actually it says that host can not be resolved
# Ordinary derivation is not allowed arbitrary network access with sandbox=true
# But the answer for the question "how does nix download source code?" is:
# fixed-output derivations
# Nix has derivations where you say: download whatever you need, but I already know exactly
# what resulting content's hash must be
# So instead of trusting website, nix trusts sha256 sum


# NOTE: There is NO WAY to declare https://example.com/ as an ordinary derivation input

let
  nixpkgs = builtins.getFlake "nixpkgs";
  pkgs = nixpkgs.legacyPackages.${builtins.currentSystem};

  bash = pkgs.bash;
  curl = pkgs.curl;
in
derivation {
  name = "network-test";

  system = builtins.currentSystem;

  builder = "${bash}/bin/bash";

  args = [
    "-c"
    ''
      "${curl}/bin/curl" -L https://example.com > "$out"
    ''
  ];
}
