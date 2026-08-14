# When reading this derivation with nix derivation show, user will find inputs.srcs with <hash>-message.txt value in list

let
    message = ./message.txt;
in
derivation {
    name = "from-file";
    system = builtins.currentSystem;
    builder = "/bin/sh";

    args = [ # as we used /bin/sh as builder without explicit declaring dependencies, nix sets $PATH to dummy value, so we can't just use cp as it's unknown executable for bash
        "-c"
        ''
        IFS= read -r line < "$message"
        printf '%s\n' "$line" > "$out"
        ''
    ];

    inherit message;
}