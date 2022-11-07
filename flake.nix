{
  description = "demo is a golang binary";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    nix-filter = {
      url = github:numtide/nix-filter;
    };
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat, nix-filter }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        packages = {
          demo = pkgs.buildGoModule rec {
            pname = "demo";
            # To update the derivation, bump the version and set
            #
            #   vendorSha256 = pkgs.lib.fakeSha256;
            #
            # then run `nix shell`, take the correct hash from the output, and set
            #
            #   vendorSha256 = <the updated hash>;
            #
            # (Yes, that's really how you're expected to do this.)
            version = "0.0.1";
            vendorSha256 = "sha256-vanKL5s+szW0hduUXGnJNUlyu8wZ2HsBVklIUb/+DLY=";
            #vendorSha256 = pkgs.lib.fakeSha256;

            # src = pkgs.lib.sources.cleanSource ./.
            src = pkgs.lib.sources.trace
              (
                nix-filter.lib.filter {
                  root = ./.;
                  include = [
                    "./pkg"
                    "./cmd"
                    "go.mod"
                    "go.sum"
                  ];
                }
              );

            # Add any extra packages required to build the binary should go here.
            buildInputs = [ ];

            # every subpackage will get built with `go build`
            subPackages = [ "cmd/demo" ];
          };
        };
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            delve
            go-outline
            go_1_19
            golangci-lint
            gopkgs
            gopls
            gotools
            just
            nixpkgs-fmt
          ];

          shellHook = ''
            # The path to this repository
            shell_nix="''${IN_LORRI_SHELL:-$(pwd)/shell.nix}"
            workspace_root=$(dirname "$shell_nix")
            export WORKSPACE_ROOT="$workspace_root"

            # We put the $GOPATH/$GOCACHE/$GOENV in $TOOLCHAIN_ROOT,
            # and ensure that the GOPATH's bin dir is on our PATH so tools
            # can be installed with `go install`.
            #
            # Any tools installed explicitly with `go install` will take precedence
            # over versions installed by Nix due to the ordering here.
            export TOOLCHAIN_ROOT="$workspace_root/.toolchain"
            export GOROOT=
            export GOCACHE="$TOOLCHAIN_ROOT/go/cache"
            export GOENV="$TOOLCHAIN_ROOT/go/env"
            export GOPATH="$TOOLCHAIN_ROOT/go/path"
            export GOMODCACHE="$GOPATH/pkg/mod"
            export PATH=$(go env GOPATH)/bin:$PATH
          '';

          # Need to disable fortify hardening because GCC is not built with -oO,
          # which means that if CGO_ENABLED=1 (which it is by default) then the golang
          # debugger fails.
          # see https://github.com/NixOS/nixpkgs/pull/12895/files
          hardeningDisable = [ "fortify" ];
        };
        packages.default = packages.demo;
      }
    );
}
