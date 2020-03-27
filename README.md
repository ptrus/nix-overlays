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

Or to fix a sepcific commit:

```nix
let
    ptrus-overlay = fetchTarball {
      url = https://github.com/ptrus/nix-overlays/tarball/a88ca4e54667048467c67efed594e0301eb19b9e;
      sha256 = "1ba40f9f38131852z1hyal0fa0i4lkh4qpv115vq09w9l6r24asb";
    };
    nixpkgs = import <nixpkgs> {
        overlays = [ (import ptrus-overlay) ];
    };
in
```
