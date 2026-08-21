let
  pkgs = import <nixpkgs> {};
in
pkgs.stdenv.mkDerivation {
  pname = "attrs-lab";
  version = "1.0";

  dontUnpack = true;

  myMessage = "hello from custom attribute";

  buildCommand = ''
    mkdir -p "$out"
    printf '%s\n' "$myMessage" > "$out/message.txt"
  '';

  passthru = {
    answer = 42;
  };

  meta = {
    description = "Experiment with mkDerivation attributes";
  };
}
