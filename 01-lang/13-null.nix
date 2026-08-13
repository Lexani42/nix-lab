# It is quite easy and short but important to understand
# null in nix is A VALUE. While checking if attr is null using ?
# it will be a bug. Example is presented in this file

let
    x = {
        foo = null;
    };
in
{
    foo_exists = x ? foo; # true
    bar_exists = x ? bar; # false
    value = x.foo; # null
    foo_useful = x.foo != null; # false
}
