# onnx2c-nix

Nix packaging for [onnx2c](https://github.com/kraiskil/onnx2c).

This repository provides a Nix flake plus plain derivations for building and exposing the `onnx2c` binary.
It supports both flake-based workflows and traditional `nix-build`.

## Using the flake

You need Nix with flake support enabled.

### Use directly from GitHub (no clone)

You can build, run, or install `onnx2c` straight from this repo without checking it out locally:

```bash
# Run once
nix run github:Accommodus/onnx2c-nix -- -h
```

```bash
# Temporary shell with onnx2c on PATH
nix shell github:Accommodus/onnx2c-nix
```

```bash
# Install into your user profile
nix profile install github:Accommodus/onnx2c-nix
onnx2c -h
```

### Using this as a flake input

In another `flake.nix`, you can depend on this flake and reuse the packaged
`onnx2c`:

```nix
{
  inputs.onnx2c-nix.url = "github:Accommodus/onnx2c-nix";

  outputs = { self, nixpkgs, onnx2c-nix, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.example-env = pkgs.mkShell {
        buildInputs = [ onnx2c-nix.packages.${system}.onnx2c ];
      };
    };
}
```

## Using `default.nix` without flakes

`default.nix` imports `<nixpkgs>` and evaluates directly to the finished derivation, so
plain Nix users can build it with:

```bash
# From the repo root
nix-build
# or, explicitly:
nix-build default.nix
```

This creates a `result` symlink:

```bash
./result/bin/onnx2c -h
```

### Reusing the derivation in other expressions

The file `onnx2c-package.nix` exports the underlying function so you can use it
with `pkgs.callPackage` (and override dependencies as needed). Example:

```nix
let
  pkgs = import <nixpkgs> {};
  onnx2c = pkgs.callPackage ./path/to/onnx2c-nix/onnx2c-package.nix {};
in
  onnx2c
```