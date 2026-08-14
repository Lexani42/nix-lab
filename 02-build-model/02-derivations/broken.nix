derivation {
    name = "broken";
    system = builtins.currentSystem;
    builder = "/bin/sh";
    args = [
        "-c"
        ''
        echo "I am going to fail"
        exit 42
        ''
    ];
}