let
  pkgs = import <nixpkgs> {};
in
pkgs.callPackage ./onnx2c-package.nix {
  protobuf = pkgs.protobuf_21;
}
