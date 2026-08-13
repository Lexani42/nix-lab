# throw is the easiest keyword - after it runs, evaluation falls with error message
# assert takes condition and fails evaluation if condition is not met
# abort terminates evaluation. the only difference between abort and throw:
# abort is uncatchable. abort immediately stops program, when assert and throw can be catched
# abort should be used on system-wide or unrecoverable flaws if exists

let
    to_be_failed = false; # when true - fails with "error!!!" message
    port = 8080; # if port will be <= 0 - evaluation fails with assertion error
in
if to_be_failed then throw "error!!!"
else assert port > 0;
{
    inherit port;
}