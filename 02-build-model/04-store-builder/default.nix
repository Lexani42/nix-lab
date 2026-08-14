# For this experiment we do need to build bash from nixpkgs
# At this point it's not really interesting for us to know about nixpkgs
# nix build nixpkgs#bash --no-link
# Then bash path in nix store can be found using nix eval
# nix eval --raw nixpkgs#bash.outPath
# At this point, executable that will be used as a builder, lives in store
# It's bad decision to hardcode store path, of course,
# instead, we'd like to let nix know about it's origin and the fact that it's stored somewhere
# But right here it will be hardcoded to isolate the concept

let
    bash = builtins.storePath /nix/store/90nk33c4fkyg4x4dfk5cykqiryf2nlqq-bash-interactive-5.3p15;
in
derivation {
    name = "store-builder";
    system = builtins.currentSystem;
    builder = "${bash}/bin/bash";

    args = [
        "-c"
        ''
        printf '%s\n' "built with store bash" > "$out"
        '' 
    ];

    inherit bash;
}
