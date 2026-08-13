# Function's available names are determined by where the function was defined,
# not where it is called
# Function scope is overriding outer scope in function. 
# In other terms, inner binding shadows the outer one
# Nested "let" has the same idea
let
    x = 10;
    f1 = y: x + y;
    f2 = x: x * 2;
in
{
    f1_res = f1 5; # Result will be 5, however x is defined in let block
    f2_res = f2 10; # Result will be 20. In terms of this function, 
                   # x is not 10 but function's argument. 
                   # Even though x is defined in the same block and is accessible by function
    x_value = x; # Result will be 10 because it's not literally overriden, but shadowed
    new_x_value = let
        x = 20;
        in
        x; # new_x_value's result will be 20 because in nested let value of x is shadowed
        interesting_example = let
        x = 10;
        f = y: x + y; # IMPORTANT: f is defined in scope where x equals to 10
        g = let
            x = 100;
        in
        f;
    in
    g 5; # In this example it is very importand to understand scoping,
         # because actual value is equal to 15 but not 105
         # It is so because f was originally defined in that scope where x is equal to 10
         # and will use 10 as an x value always 
         # So changing the scope where you later reference f does not rewrite closure
}

# This example will be kinda relevant to real nix code:

# { lib }:
# let
#     foo = {
#         lib = "something completely different";
#     };
# in
# lib.comcatMap ...

# So which lib is used?
# Of course, will be used that lib, that was passed as an argument
# { lib }
# And not foo.lib
# Because merely having an attribute called lib does not put it into lexical scope
