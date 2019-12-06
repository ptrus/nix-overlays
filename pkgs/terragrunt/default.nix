{ stdenv, lib, buildGoPackage, fetchFromGitHub, terraform, makeWrapper }:

# Didin't get it to work using overlays. (overrdigin src and godeps resulted
# in build failures).
buildGoPackage rec {
  pname = "terragrunt";
  version = "0.21.6";

  goPackagePath = "github.com/gruntwork-io/terragrunt";

  src = fetchFromGitHub {
    owner  = "gruntwork-io";
    repo   = "terragrunt";
    rev    = "v${version}";
    sha256 = "1agpwj8vgng0z63by51d3qg8j26x0i0sa1xcmcs7dar75qjl6zhv";
  };

  goDeps = ./deps.nix;

  buildInputs = [ makeWrapper ];

  # Remove vendor folder as it leads to compliation errors with 'buildGoPackage'.
  preBuild = ''
    rm -rf $NIX_BUILD_TOP/go/src/github.com/hashicorp/terraform/vendor

    buildFlagsArray+=("-ldflags" "-X main.VERSION=v${version}")
  '';

  postInstall = ''
    wrapProgram $bin/bin/terragrunt \
      --set TERRAGRUNT_TFPATH "${lib.getBin terraform}/bin/terraform"
  '';

  meta = with stdenv.lib; {
    description = "A thin wrapper for Terraform that supports locking for Terraform state and enforces best practices.";
    homepage = https://github.com/gruntwork-io/terragrunt/;
    license = licenses.mit;
  };
}
