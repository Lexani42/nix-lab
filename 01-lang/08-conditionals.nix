# if/elif/then/else works pretty predictible in nix
# There will be just one example for ifelse - using port value

# Logical operators also pretty conventional including == != < <= > >= && || !
# There is only one logical operator that works unclearly - logical implication operator
# a -> b means (!a) || b which means NOT a OR b
let
    env = "production";
in
{
    port = if env == "production" then 443 else 8080;
}
