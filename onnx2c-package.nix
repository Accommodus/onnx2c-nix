{ lib
, stdenv
, cmake
, pkg-config
, protobuf
, git
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "onnx2c";
  version = "0.0.1";

  src = fetchFromGitHub {
rev = "64efc86e172128a79e73bb8673c38e51aee31ecc";
    owner = "kraiskil";
    repo = "onnx2c";
    sha256 = "sha256-ALajneiJnmTsaNTEsVX5WtWZLvu5KuA0pBZqDY7PBG0=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake pkg-config git ];
  buildInputs = [ protobuf ];

  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];
  enableParallelBuilding = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp ./onnx2c $out/bin/
    runHook postInstall
  '';

  checkPhase = ''
    make test
  '';

  meta = with lib; {
    description = "Open Neural Network Exchange to C compiler";
    longDescription = ''
      Onnx2c is a ONNX to C compiler. It will read an ONNX file, and generate C code to be included in your project. Onnx2c's target is "Tiny ML", meaning running the inference on microcontrollers.
    '';
    homepage = "https://github.com/kraiskil/onnx2c";
    license = {
      shortName = "ONNX2C-LICENSE";
      fullName = "ONNX2C custom redistribution license";
      url = "https://github.com/kraiskil/onnx2c/blob/master/LICENSE.txt";
      free = true;
      redistributable = true;
    };
    mainProgram = "onnx2c";
  };
}
