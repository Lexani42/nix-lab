# so several important moments:
# 1. default output here will be "out" as it's first in outputs list
# 2. default output will have name multi-output while dev output will have multi-output-dev name
# 3. user can rely to dev output using (import ./default.nix).dev
# 4. user can rely to out output using (import ./default.nix).out explicitly, 
# or implicitly without specifiing out
# 5. if some derivation will rely on this and ONLY dev output, it will be related only
# to .dev artifact. it won't be related to out artifact at all
# 6. though some derivation does not need .out, it will be produced anyway
# because multi-output.drv will run bash to produce artifacts

derivation {
    name = "multi-output";
    system = builtins.currentSystem;
    builder = "/bin/sh";

    outputs = [
        "out"
        "dev"
    ];

    args = [
        "-c"
        ''
        printf '%s\n' "runtime stuff" > "$out"
        pritnf '%s\n' "development stuff" > "$dev"
        ''
    ];
}
