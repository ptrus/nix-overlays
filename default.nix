self: super:

let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
{
  terragrunt_0_21_6 = super.callPackage ./pkgs/terragrunt {
    terraform = unstable.terraform_0_12;
  };

  terraform_0_12_16 = super.terraform_0_12.overrideAttrs (old: {
    version = "0.12.16";
    src = super.fetchFromGitHub {
        owner = "hashicorp";
        repo = "terraform";
        rev = "v0.12.16";
        sha256 = "10r9vra4d3lyms9cvl0g1ij6ldcfi3vjrqsmd52isrmlmjdzm8nk";
    };
  });

  packer_1_4_5 = super.packer.overrideAttrs (old: {
    version = "1.4.5";
    src = super.fetchFromGitHub {
      owner = "hashicorp";
      repo = "packer";
      rev = "v1.4.5";
      # nix-prefetch-git --url https://github.com/hashicorp/packer --rev v${version}
      sha256 = "045hdzqh1fqay1apppg2hji27fh9nhka06g4b9c43amydpgk3gf5";
    };
  });

}
