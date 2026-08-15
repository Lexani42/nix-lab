{
  hello,
  git,
  # thisDoesNotExistInNixpkgs,
  message ? "default-message",
}:

{
  helloName = hello.pname;
  gitName = git.pname;
  # thisDoesNotExistInNixpkgs = thisDoesNotExistInNixpkgs;
  inherit message;
}
