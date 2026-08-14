# in this file nixpkgs will be used. we do not learning nixpkgs still
# treat bash = pkgs.bash;
# as bash is a derivation value supplied by nixpkgs
# the ugly getFlake and legacyPackages part is also not interesting for us for now
# after evaluating this derivation, user can see in derivation show, that instead of inputs.srcs,
# there is set in inputs.drvs
# but user can see that actual builder is the same as for derivation created in default.nix file
# it's because "${bash}/bin/bash" is not merely a string containing some store path
# the string actaully carries output context and say
# this path comes from bash.drv output "out"

# this is conceptually better code then the code that was in default.nix file
# because in default.nix case, nix can do nothing if actual /nix/store/AAA-bash is not existing yet
# and in THIS case, nix knows where to find bash and do not rely on searching existing package
# if it is already exist, nix will take path that it's already know
# if not - it knows that this path is in bash.out and has derivation that tells,
# how to obtain this value properly

let
    nixpkgs = builtins.getFlake "nixpkgs";
    pkgs = nixpkgs.legacyPackages.${builtins.currentSystem};

    bash = pkgs.bash;
in
derivation {
    name = "real-store-builder";
    system = builtins.currentSystem;
    builder = "${bash}/bin/bash";

    args = [
        "-c"
        ''
        printf '%s\n' "hello from properly tracked bash" > "$out"
        ''
    ];
}