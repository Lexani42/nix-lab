# inherit keyword is used to create an key=value pair with the same key as got
# think about inherit name as about name = name construction
let
    env = "production";

    makeService = name: {
        inherit name;
        port = 8080;
    };
in
{
    services.${env}.api = makeService "backend";
}
