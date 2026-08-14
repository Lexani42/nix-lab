# This derivation will fail with an error that declares unavailable example.com,
# actually it says that host can not be resolved

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
