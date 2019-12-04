self: super:

let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
{
  terragrunt_0_21_6 = super.callPackage ./pkgs/terragrunt {
    terraform = unstable.terraform_0_12;
  };
}
