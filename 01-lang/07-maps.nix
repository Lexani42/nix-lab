# Example 1 by default will generate list of lists
# If user wants lsit of integers - he should use builtins.concatMap
# buildins.concatMap is conceptually equal to concatLists + map
# builtins.mapAttrs is conceptually the same as map, 
# but generates not list but attrSet
let
    int_list = [ 1 2 3 ];
    attrSet = {
        api = 1;
        db = 2;
    };
in
{
    list_of_lists = builtins.map (x: [ x ( x * 10 ) ] ) int_list;
    # Result: [ [ 1 10 ] [ 2 20 ] [ 3 30 ] ]
    list_of_ints = builtins.concatMap (x: [ x ( x * 10 ) ] ) int_list;
    # Result: [ 1 10 2 20 3 30 ]
    attrSet_multiplied = builtins.mapAttrs (name: value: value * 10) attrSet;
    # Result: { api: 10; db: 20 }
}
