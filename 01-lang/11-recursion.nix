# Nix's let is by default recursive
# Does not matter on which row the value is defined
# while each value is in let block, each other value can see it
# IMPORTANT NOTE
# This behavior is shallow. Commented example just after x/y WILL NOT
# WORK by defaule. Use rec keyword for attrSet to do it behave recursively
let
    x = 5 + y;
    y = 10;
    # shallow_example = { <- THIS WILL CAUSE AN ERROR
    #     x = 5 + y;
    #     y = 10;
    # };
    recursive_example = rec {
        x = 5 + y;
        y = 10;
    };
in
{
    inherit x y recursive_example;
}