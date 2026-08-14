# Nix store is a collection of store objects, each addressed by a unique store path
# Store path acts as an opaque identifier for that object
# /nix/store/7f9...-bash-5.2 - is a nix store
# pattern: /nix/store/<hash>-<name>
# To add something to nix store use nix store add
# For adding files use --mode flat
# After adding hello.txt you should get /nix/store/<hash>-hello.txt
# Nix store existing independently of "building packages"
# Nix can place files or directories inside directly as store objects

# Store objects are immutalbe from nix's perspective,
# that's why after changing something in hello.nix hash will be changed
# This is foundational to why nix can have multiple versions or configurations
# of software side by side
