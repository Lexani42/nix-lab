# Here derivation declared in producer.nix file is imported
# Nix can coerce that derivation value to its output path
# This relationship is part of how derivation dependencies are tracked:
# when one derivation refers to another derivation's input,
# nix records dependency in inputs.drvs
# Actually nix will store inputs.drvs.<hash>-producer.drv.outputs with name of attribute,
# from which nix will get an actual output location


let
    producer = import ./producer.nix;
in
derivation {
    name = "consumer";
    system = builtins.currentSystem;
    builder = "/bin/sh";

    args = [
        "-c"
        ''
        IFS= read -r line < "$producer"
        printf '%s\n' "$line consumed" > "$out"
        ''
    ];

    inherit producer;
}