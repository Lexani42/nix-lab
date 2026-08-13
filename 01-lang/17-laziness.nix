# Nix is lazily evaluated
# That means that it will not evaluate value,
# until it actually needs this value

# In this example nix will actually just return 42 as nix does not need x for evaluating 42

# let
#     x = throw "BOOM";
# in
#     42

# In this example nix will fail evaluation with BOOM message

# let 
#     x = throw "BOOM";
# in
#     x

# And agin in this example nix will just evaluate 42
# set.bad will NOT be evaluated. Nix does not need to evaluate entire set

# let
#     set = {
#         good = 42;
#         bad = throw "BOOM";
#     };
# in
#     set.good

# This is weird and perfect in the same time
# Think about giant attrset with tons of packages
# Until nix actually need specific package,
# it won't be evaluated at all

# if is also lazy. This example will just return 42,
# because "else" branch is not needed

# let
#     x = 123;
# in
# if true 
# then 42 
# else throw "BOOM"


# Also works with false

# let
#     x = 123;
# in
# if false 
# then throw "BOOM"
# else 100

# will return 100

# And functions arguments are lazy!
# This function will return 42
# Nix does not need to evaluate x argument

# let
#     f = x: 42;
# in
# f (throw "BOOM")

# Potentially brainrot things are also possible
# Here x = x does not generate error because x is not evaluated at all

# let
#     x = x;
# in
# 42

# This is actually an explanation to rec
# Parameters are not necessarily evailuated in textural order like
# first x than y
# Instead nix will build dependency relationship
# "for evaluation y needs x; x is 10; y is 11"

# let
#     z = 123;
# in
# rec {
#     x = 10;
#     y = x + 1;
# }

# So the point is DO NOT imaging nix as
# execute line 1
# execute line 2
# execute line 3
# execute line 4

# Think more like about a graph of values
# evaluating demands particular values and follows only dependencies,
# required to compute them

# Lists behave similarly
# Result here is 10

# let
#     xs = [
#         10
#         (throw "BOOM")
#         30
#     ];
# in
# builtins.head xs

# builtins.tryEval has a subtle trap
# In this example, necessary and sufficient answer for tryEval is the fact,
# that { good = 42; bad = throw "BOOM"; } is actually a set
# tryEval will secure only that part, but after that, tryEval will succeed and produce next set:
# {
#     success = true;

#     value = {
#         good = 42;
#         bad = throw "BOOM";
#     };
# }
# and as it is need to be evaluated in "in" block - it will throw actual error

# let
#     x = 1;
# in
# builtins.tryEval {
#     good = 42;
#     bad = throw "BOOM";
# }
