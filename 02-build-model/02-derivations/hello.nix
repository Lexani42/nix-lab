# Conceptually is't important to know difference between built package
# and derivations
# Derivations in nix is a description of how to produce something,
# while derivation output is thing that was actually produced
# The actual pipeline needs evaluate nix expression, save derivation,
# run derivation and output store object

# Derivation set has bunch of attributes:
# type = equals to "derivation"
# drvPath = path of stored derivation in nix store
# outPath = path of package build output

# drvPath exists right after evaluation, though nix build wasn't run

# NOTE: nix does not actually know the hash of the future artifact's content
# Instead, the output path is normally input-addressed - so its identity
# is derived from the derivation and its build-time dependency graph
# not from the bytes that will appear in the output
# Thanks to this, nix can define place in store BEFORE artifact is actually built,
# and know the dependency graph on evaluation stage

# after realise the derivation, output will be stored in predicted location
# if user tries to re-realisee - nothing will be changed if artifact is already in out location
# realisation in nix means "make output available and valid" not "execute builder"
# it actually even does not mean "build locally"

derivation {
    # Actually derivation is builtin function that takes attrset
    # and returns an attrSet
    # Creation a store derivation is a side effect of evaluation
    name = "hello";

    system = builtins.currentSystem;

    builder = "/bin/sh"; # this is intentionally specified for learning purposes
                         # normally, nix build uses its builder to be a store object
                         # so nix builders normally executed with explicitly defined deps
                         # rather than inheriting the user's shell environment

    args = [
        "-c"
        ''
            echo "hello from derivation" > "$out"
        ''
        # here is questionable moment - how bash should know where is out?
        # actually, nix passes builder environment, which are env vars
        # out is one of the variables, so bash will treat it as an envvar
    ];
}