# example-nix-vscode-golang

Very simple example repository for doing golang projects.

Features:
* Works with `nix-shell` (old) and `nix develop` (flakes)
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

Test and Lint:
```bash
just test
just lint
```

Build:
```bash
just build
```

Run the binary:
```bash
./bin/demo help
```

Update the flake:
```bash
nix flake update
```
