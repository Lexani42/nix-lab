# or is used for check if attr exists in attrSet and if not return right value
# ? is used for check if attr exists in attrSet and returns bool value
# // is used to merge attrSets
# in case when both attrSets contains the same key, right attrSet will win
# so a // b will always return b
# IMPORTANT NOTE
# // is shallow
# parameters won't be overridden recursively
# in case of config/full_config, full config will ONLY contain service = { port = 8080 }
# as service parameter in config will be completely replaced by new
# builtins.attrNames can be used to get list with attribe names in attrSet

let
    service = {
        name = "api";
        port = 80;
    };
    config = {
        service = {
            name = "api";
            port = 80;
        };
    };
in
{
    name = service.name;
    timeout = service.timeout or 30;
    port_exists = service ? port;
    full_description = service // {
        port = 8080;
        env = "prod";
    };
    full_config = config // {
        service = {
            port = 8080;
        };
    };
    service_attrs = builtins.attrNames service;
}
