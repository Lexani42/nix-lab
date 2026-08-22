# nixpkgs's generic builder does not normally execute one giant shell script
# instead, it runs a sequence of named phases
# the default order is:
# unpackPhase
# patchPhase
# configurePhase
# buildPhase
# checkPhase
# installPhase
# fixupPhase
# installCheckPhase
# distPhase
# Some are skipped depending on configuration. checkPhase, as an example,
# inactive unless doCheck = true
# configurePhase effectively do nothing if there is no script

# to start with logs:
# nix build --impure --file ./package.nix -L
let
  pkgs = import <nixpkgs> {};
in
pkgs.stdenv.mkDerivation {
  pname = "phase-lab";
  version = "1.0";

  src = ./src;

  unpackPhase = ''
    runHook preUnpack

    echo "=== UNPACK PHASE ==="
    mkdir source
    cp -r "$src"/* source/
    chmod -R u+w source
    cd source

    runHook postUnpack
  '';

  patchPhase = ''
    runHook prePatch

    echo "=== PATCH PHASE ==="
    printf '%s\n' "patched" >> hello.txt

    runHook postPatch
  '';

  configurePhase = ''
    runHook preConfigure

    echo "=== CONFIGURE PHASE ==="

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    echo "=== BUILD PHASE ==="
    tr 'a-z' 'A-Z' < hello.txt > built.txt

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    echo "=== INSTALL PHASE ==="
    mkdir -p "$out"
    cp built.txt "$out/result.txt"

    runHook postInstall
  '';
}
