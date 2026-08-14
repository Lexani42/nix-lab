# this derivation produces a file <hash>-producer

derivation {
    name = "producer";
    system = builtins.currentSystem;
    builder = "/bin/sh";

    args = [
        "-c"
        ''
        printf '%s\n' "hello from producer" > "$out"
        ''
    ];
}
