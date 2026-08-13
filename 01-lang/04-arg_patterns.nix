# Extra arguments
# makeUser function will fail without "..." because got an unexpected argument "admin"
# Default arguments
# When not passed, function makeService uses 80 as default port
# If contains
# ? can be used as check if attrSet contains attribute
# x_foo is true because x contains foo
# x_bar is false because x does not contain bar
# args@ means that args will contain originally passed argument
# if also can be ARG@args e.g. { name, port, ... }@args
let
    makeUser = { name, id, ... }: {
        inherit name id;
    };
    makeService = { name, port ? 80 }: {
        inherit name port;
    };
    x = {
        foo = 123;
    };
    describe = args@{ name, port, ... }: {
        inherit name port;
        original = args;
    };
in
{
    outputs = {
        user = makeUser {
            name = "John";
            id = 123123;
            admin = true;
        };
        service = makeService {
            name = "backend";
        };
        contains = {
            x_foo = x ? foo;
            x_bar = x ? bar;
        };
        describe_res = describe {
            name = "api";
            port = 8080;
            env = "prod";
        };
    };
}
