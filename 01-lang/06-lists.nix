# lists in nix are created WITHOUT comma
# lists can contain any values with any types
# also can be mixed
# lists can be concatinated with ++
# for creating loop through each list element builtins.map is used
# builtins.filter is used to create filtered list using function that returns boolean values
# builtins.concatLists can be used to concat functionally generated lists

let
    list1 = [ 1 2 3 ];
    list2 = [ 2 3 4 ];
    services = [
        { name = "api"; port = 8080; }
        { name = "db"; port = 5432; }
    ];
    if_more_than_two = x: x > 2;
in
{
    concat = list1 ++ list2;
    service_names = builtins.map (service: service.name) services;
    more_than_two = builtins.filter if_more_than_two list1 ++ list2;
    service_attrs = builtins.concatLists (builtins.map (service: builtins.attrNames service) services);
    mixed_list = [ "qwe" 123 { qwe = 123; } [ 1 2 3 ]];
}
