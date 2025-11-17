{
  description = "Flake for the onnx2c compiler";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        onnx2c = pkgs.callPackage ./default.nix {
          protobuf = pkgs.protobuf_21;
        };
      in
      rec {
        packages = {
          onnx2c = onnx2c;
          default = onnx2c;
        };

        apps = {
          onnx2c = {
            type = "app";
            program = "${onnx2c}/bin/onnx2c";
          };
          default = apps.onnx2c;
        };

        defaultPackage = packages.default;
        defaultApp = apps.default;
      });
}
