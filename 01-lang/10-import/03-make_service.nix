# This file evaluates as an anonymous function
# Function accepts 2 arguments for name and port
# Port default value is 80

{ name, port ? 80 }:
{
    inherit name port;
}