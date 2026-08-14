# Again, user should not worry about fetchurl for now
# idea of blocking external data without hashes is inconsistent builds
# external data can silently change the output if changed without hash-check
# without an ordinary derivation nix controls inputs
# with fixed-output derivation nix cannot control where bytes come from
# but it controls which bytes are actually accessible
# in case of hash-mismatch - nix will fail build instead of silently
# produce a completely different package

let
  nixpkgs = builtins.getFlake "nixpkgs";
  pkgs = nixpkgs.legacyPackages.${builtins.currentSystem};
in
pkgs.fetchurl {
  url = "https://ftp.gnu.org/gnu/hello/hello-2.12.1.tar.gz";

  # hash = pkgs.lib.fakeHash; <- this will fail (hash will be AAA....)
  
  hash = "sha256-jZkUKv2SV28wsM18tCqNxoCZmLxdYH2Idh9RLibH2yA";
}
