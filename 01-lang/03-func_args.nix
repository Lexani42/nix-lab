# User can use function that is created by function
# In this case function makeBackend uses lambda function,
# generated with makeService function
# makeBackend function knows that name is "backend",
# and can be used to produce more attributes with "name = backend" key-value pair
# It also can be used as a way to pass several arguments to function,
# though attrSets are preferred for it

# let
#     serviceName = "api";

#     makeService = name: port: {
#         inherit name port;
#     };
# in
# {
#     services.${serviceName} = makeService "backend" 8080;
# }

let
    makeService = name: port: {
        inherit name port;
    };

    makeBackend = makeService "backend";
in
{
    service.api = makeBackend 8080;
    service.admin = makeBackend 9090;
}
