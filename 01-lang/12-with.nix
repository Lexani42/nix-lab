# With is a shortcut for accessing attributes from an attrSet
# without writing the attrSet name
# Seems to be useless when writing an example with 2 packages,
# but imagine you need to get 178 packages for x86_64-linux,
# that has pkgs.x86_64-linux prefix

# IMPORTANT CONCEPTUAL NOTE
# "with" DOES NOT create additional variables in the same way let does
# It is more like adding an additional lookup source for identifiers
# while evaluating an expression
# With has lower priority than lexical bindings (x_foundation example)

let
    pkgs = {
        nginx = "nginx-package";
        curl = "curl-package";
    };
    my_attrs = {
        x = "inside";
    };
    x = "outside";
in
{
    packages = (with pkgs;
        [
            nginx
            curl
        ]
    );
    x_foundation = (with my_attrs;
        x # Result: outsde
    );
}
