{ lib
, buildPythonPackage
, fetchFromGitHub
, pytest
, scikit-build
, cmake
, ush
, requests
, numpy
, cffi
, tree
, openfst
, python
, substituteAll
, callPackage
}:

let
  version = "2.1.0";
  kaldi = callPackage ./fork.nix { };
in
buildPythonPackage rec {
  pname = "kaldi-active-grammar";
  inherit version;

  src = fetchFromGitHub {
    owner = "daanzu";
    repo = pname;
    rev = "v${version}";
    sha256 = "ArbwduoH7mMmIjlFfYAFvcpR39rrkVUJhYEyQzZqsbY=";
  };

  KALDI_BRANCH = "foo";
  KALDIAG_SETUP_RAW = "1";

  patches = [
    ./0001-stub.patch
    ./0002-exec-path.patch
    (substituteAll {
      src = ./0003-ffi-path.patch;
      kaldiFork = "${kaldi}/lib";
    })
  ];

  # scikit-build puts us in the wrong folder. That is bad.
  preBuild = ''
    cd ..
  '';

  buildInputs = [ openfst kaldi ];
  nativeBuildInputs = [ scikit-build cmake ];
  propagatedBuildInputs = [ ush requests numpy cffi ];

  meta = {
    description = "Python Kaldi speech recognition";
    homepage = "https://github.com/daanzu/kaldi-active-grammar";
    license = lib.licenses.agpl3Plus;
    maintainers = with lib.maintainers; [ ronthecookie ];
    # Other platforms are supported upstream.
    platforms = lib.platforms.linux;
  };
}
