# example-nix-vscode-golang

Very simple example repository for doing golang projects.

Features:
* Works with `nix-shell`/`nix-build` (old) and `nix develop`/`nix build`/`nix shell` (flakes)
* Works with `direnv` and `lorri`
* Example golang setup with `pkg` and `cmd`
* Uses `cobra` for the example binary
* Uses `just` for command running

## How to

Develop:
```bash
nix develop
code .
```

### Test and Lint:
```bash
just test
just lint
```

### Build:
```bash
just build # binary will be in ./bin/demo
nix build # binary will be in ./result/bin/demo
nix-build # binary will be in ./result/bin/demo

```

### Run the binary:
```bash
./bin/demo help
./result/bin/demo help
nix run . -- help
nix shell -c demo help
```

### Update the flake.lock:
```bash
nix flake update
```

### Update dependencies:

see the instructions in `flake.nix`. You'll have to do this if you see a warning like this when running `nix build`;
```
# update dependencies, resulting in changes to go.mod / go.sum

$ nix build
...
warning: Git tree '/Users/pld/code/example-nix-vscode-golang' is dirty
error: builder for '/nix/store/v9jmxky8shhb5b8p9ky490vr9b3qmfjl-demo-0.0.1.drv' failed with exit code 1;
       last 10 log lines:
       > 	github.com/mattn/go-isatty@v0.0.14: is marked as explicit in vendor/modules.txt, but not explicitly required in go.mod
       > 	github.com/mattn/go-runewidth@v0.0.13: is marked as explicit in vendor/modules.txt, but not explicitly required in go.mod
       > 	github.com/muesli/reflow@v0.2.1-0.20210115123740-9e1d0d53df68: is marked as explicit in vendor/modules.txt, but not explicitly required in go.mod
       > 	github.com/muesli/termenv@v0.11.1-0.20220204035834-5ac8409525e0: is marked as explicit in vendor/modules.txt, but not explicitly required in go.mod
       > 	github.com/rivo/uniseg@v0.2.0: is marked as explicit in vendor/modules.txt, but not explicitly required in go.mod
       > 	golang.org/x/sys@v0.0.0-20210630005230-0f9fa26af87c: is marked as explicit in vendor/modules.txt, but not explicitly required in go.mod
       >
       > 	To ignore the vendor directory, use -mod=readonly or -mod=mod.
       > 	To sync the vendor directory, run:
       > 		go mod vendor
       For full logs, run 'nix log /nix/store/v9jmxky8shhb5b8p9ky490vr9b3qmfjl-demo-0.0.1.drv'.

# update the flake.nix according to its instructions

$ nix build
error: hash mismatch in fixed-output derivation '/nix/store/hnhrjsg74n1yamn5xnv9rzs4jzppwi26-demo-0.0.1-go-modules.drv':
         specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
            got:    sha256-vanKL5s+szW0hduUXGnJNUlyu8wZ2HsBVklIUb/+DLY=
error: 1 dependencies of derivation '/nix/store/y9940ln7pyjiq33pkz50b75xhjb90q2b-demo-0.0.1.drv' failed to build
```
