# This consumer will use producer in runtie, so it's artifact will refer to producer
# User can check this relation using nix-store --query --references CONSUMER_OUT
let
    producer = import ./producer.nix;
in
derivation {
    name = "runtime-consumer";
    system = builtins.currentSystem;
    builder = "/bin/sh";

    args = [
        "-c"
        ''
            printf '%s\n' "$producer" > "$out"
        ''
    ];

    inherit producer;
}
