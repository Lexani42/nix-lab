# makeUser is a function that requires attrSet with username and id parameters as an argument
# technically, as nix is a functional programming language, { username, id }: -> function
# makeUser is a variable that contains lambda function in self
# makeUser function can ONLY work with attrSet contains username and id parameters
# additional or incomplete parameters will cause an error

let
  name = "John";
  number = 123;

  makeUser = { username, id }: {
    user = username;
    userId = id;
  };
in
{
    users.${name} = makeUser {
        username = name;
        id = number;
    };
}
