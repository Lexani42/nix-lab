# There will be several builtins
# Common sense - builtins are available for usage by default
# There is common pattern: builtins.*
# While in languages like Python user cannot use type name as a varname
# in nix you can easily create value with name "string" and "set"

# typeOf is used to get a type of object
# trace is useful when lost in huge Nix expression. it prints message and returns value
# IMPORTANT: trace is writing not to stdout, but to stderr
# readFile reads file's content. Uses only path value, do not pass strings
# hasAttr - functional equivalent to "?". Useful when attr name to check
# is stored in a variable. functional analogue is convenient for dynamic code
# getAttr - functional approach for retrieving dynamically named attributes
# Note that set.${attr_var} can be used instead of getAttr
# builtins.tryEval receives an expression and returns:
# { success = true; value = ... } or
# { success = false; value = false; }
# builtins.attrNames generates list of attribute names from attrSet
# builtins.attrValues generates lsit of attribute values from attrSet
# builtins.length returns count of elements in list
# builtins.elem checks whether a list contains a value

let
    integer = 42;
    string = "hello";
    set = { a = 1; };
    x = 10;
    ports = {
        api = 8080;
        db = 5432;
        frontend = 80;
    };
in
rec {
    type_int = builtins.typeOf integer; # int
    type_str = builtins.typeOf string; # string
    type_attrset = builtins.typeOf set; # set
    type_lambda = builtins.typeOf (x: x); # lambda
    trace = builtins.trace "x is being evaluated" (x * 2); # writes message to stderr, returns 20
    message = builtins.readFile ./message.txt;
    set_has_a = builtins.hasAttr "a" set;
    set_has_b = builtins.hasAttr "b" set;
    a_value_from_set = builtins.getAttr "a" set;
    try_math = builtins.tryEval (2 + 2);
    try_throw = builtins.tryEval (throw "haha");
    list_of_services = builtins.attrNames ports;
    list_of_ports = builtins.attrValues ports;
    count_of_services = builtins.length list_of_services;
    api_presented = builtins.elem "api" list_of_services;
}