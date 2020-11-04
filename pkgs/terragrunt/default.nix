{ stdenv, lib, buildGoModule, fetchFromGitHub, terraform, makeWrapper }:

buildGoModule rec {
  pname = "terragrunt";
  version = "0.23.4";

  src = fetchFromGitHub {
    owner  = "gruntwork-io";
    repo   = "terragrunt";
    rev    = "v${version}";
    sha256 = "0rlkrigfisl2c83diw443x4mn4c5c9pvnx660yf5226jcy5kipms";
  };

  vendorSha256 = "10d4wy5dp4y56mqk7f9fnib4605xyly3m7k7h0drk2di4kwjl0nn";

  doCheck = false;

  buildInputs = [ makeWrapper ];

  preBuild = ''
    buildFlagsArray+=("-ldflags" "-X main.VERSION=v${version}")
  '';

  postInstall = ''
    wrapProgram $out/bin/terragrunt \
      --set TERRAGRUNT_TFPATH ${lib.getBin terraform}/bin/terraform
  '';

  meta = with stdenv.lib; {
    description = "A thin wrapper for Terraform that supports locking for Terraform state and enforces best practices.";
    homepage = https://github.com/gruntwork-io/terragrunt/;
    license = licenses.mit;
  };
}
