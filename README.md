# nix-overlays

Personal nix packages and overlays repository.

List of packages:

* [terragrunt](https://github.com/gruntwork-io/terragrunt)
* [packer](https://github.com/hashicorp/packer)

Example usage in `shell.nix`:

```nix

let
    overlay = fetchTarball https://github.com/ptrus/nix-overlays/tarball/master;
    nixpkgs = import <nixpkgs> {
        overlays = [ (import overlay) ];
    };
in
```
