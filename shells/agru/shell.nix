#  pkgs = import (fetchTarball https://github.com/NixOS/nixpkgs/archive/<rev>.tar.gz) {}
{ pkgs ? import <nixpkgs> {} }:

let
  src = pkgs.fetchFromGitHub {
    owner = "etkecc";
    repo  = "agru";
    rev = "b81f06b2c8d5713ebb3992df930107a0829be344";
    # Compute the correct SHA256 with:
    #   nix-prefetch-github etkecc agru --rev=v0.1.19
    sha256 = "sha256-K48f4wDGH7SYy69CYsTjM0WnwUxzWctV1NFR8IB/bYY=";
  };

  agru = pkgs.buildGoModule {
    pname = "agru";
    version = "v0.1.19";
    src = src;

    # Go module mode (default for Go 1.11+)
    # If the project does NOT use go.mod, set goModuleMode = false;
    # and adjust buildFlags / installFlags accordingly.
    goModuleMode = true;
    vendorHash = null;
    # If the build needs any CGO‑enabled C libraries, list them here:
    # e.g. nativeBuildInputs = [ pkgs.pkgconfig pkgs.openssl ];
    nativeBuildInputs = [ ];   # <-- add if needed

    # Optional: set ldflags for version info, stripping, etc.
    buildFlags = [ "-ldflags" "-w" ];
    ldflags = [ "-extldflags 'static'"];
    tags = [ "timetzdata" "goolm" ];
  };

in
pkgs.mkShell {
  # Name shown in the shell prompt
  name = "agru-dev";

  # Put the built binary on $PATH
  buildInputs = [ agru ];

}
