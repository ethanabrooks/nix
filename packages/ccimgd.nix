{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule {
  pname = "ccimgd";
  version = "unstable-2025-04-25";

  src = fetchFromGitHub {
    owner = "AlexZeitler";
    repo = "claude-ssh-image-skill";
    rev = "86fe7c2cb53e0dbbbf3c5dcdf2a82f7921b1cf39";
    hash = "sha256-bBG+pdMFOsZIr+YEE28cBOCvgYG3jbsWKj8UzNaQGxo=";
  };

  vendorHash = null;
  sourceRoot = "source/daemon";

  postPatch = ''
    substituteInPlace go.mod --replace-fail "go 1.26.1" "go 1.25"
  '';

  postInstall = ''
    mv $out/bin/daemon $out/bin/ccimgd
  '';

  meta = {
    description = "Clipboard image daemon for Claude Code over SSH";
    homepage = "https://github.com/AlexZeitler/claude-ssh-image-skill";
    license = lib.licenses.mit;
    mainProgram = "ccimgd";
  };
}
