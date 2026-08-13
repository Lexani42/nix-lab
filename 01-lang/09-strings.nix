# In nix integers are NOT automatically interpolated the same way strings are
# Multiline strings are defined with x2 single quotes
# Important note: PATHS are NOT strings!
# Actual paths can use interpolation
let
    name = "John";
    port = 8080;
    howdy_msg = ''
        Hallo!
        Wie geht's?
    '';
    string_path = "./foo";
    actual_path = ./foo;
    modules_dir = "modules";
in
{
    inherit string_path actual_path howdy_msg;
    hello_msg = "Hello ${name}";
#   port_msg = "Currently used port: ${port}"; <- here will be an error message
    port_msg = "Currently used port: ${toString port}";
    foo_module_path = ./${modules_dir}/foo.nix;
}