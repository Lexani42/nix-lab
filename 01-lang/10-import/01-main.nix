# Technically import in nix is different from importing in e.g. Python
# Nix import evaluates imported file and returns it result
# In case of service we can leave file without let/in at all
# and leave only import ./02-value.nix,
# and result will be the same

# Imported file may also be evaluated to return function
# This is how makeService function actually works
# 03-make_service.nix generates anonymous function,
# that is stored in makeService variable
# Technically nothing stops us to write this function right in let block,
# but importing helps to increase code readability

# There are no obligations to import functions in let
# Also you don't need to even put imported function in a variable
# Like any other anonymous function it can be used right after importing
# This is shown in another_generated_service attribute
let
    service_values = import ./02-value.nix;
    makeService = import ./03-make_service.nix;
in
{
    # name = service.name;
    # port = service.port;
    hardcoded_service = {
        inherit (service_values) name port;
    };
    
    generated_service = makeService {
        name = "api";
        port = 8080;
    };

    another_generated_service = (import ./03-make_service.nix) { name = "frontend"; };
}
