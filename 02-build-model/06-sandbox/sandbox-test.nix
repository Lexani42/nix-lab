# To reproduce this model, user should create /tmp/nix-secret.txt on his system
# printf 'SUPER SECRET HOST DATA\n' > /tmp/nix-secret.txt
# and verify
# cat /tmp/nix-secret.txt

# And make sure that sandbox is enabled
# nix config show sandbox
# should return true

# At evaluation level, nix have no idea what is nix-secret.txt and why it's used
# Nix will consider that it's just plaintext argument not path
# If user tries to realise this derivation, nix will fall with an error
# /tmp/nix-secret.txt: No such file or directory
# That is exactly the kind of hidden dependency sandboxing is intended to expose

let
  nixpkgs = builtins.getFlake "nixpkgs";
  pkgs = nixpkgs.legacyPackages.${builtins.currentSystem};

  bash = pkgs.bash;
in
derivation {
  name = "sandbox-test";
  system = builtins.currentSystem;

  builder = "${bash}/bin/bash";

  args = [
    "-c"
    ''
      IFS= read -r line < /tmp/nix-secret.txt
      printf '%s\n' "$line" > "$out"
    ''
  ];
}