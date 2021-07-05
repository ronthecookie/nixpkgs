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
, kaldi
, python
, substituteAll
}:

let
  version = "2.1.0";
  kaldiFork = kaldi.overrideAttrs (old: {
    inherit version;
    src = fetchFromGitHub {
      owner = "daanzu";
      repo = "kaldi-fork-active-grammar";
      rev = "kag-v1.5.0";
      sha256 = "sha256-lIfYnGMRHZOd5fy+XEP5SfTqdIW7hM1geu5CY7gT2ng=";
    };
    patches = [ ./0004-fork-cmake.patch ];
  });
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
      kaldiFork = "${kaldiFork}/lib";
    })
  ];

  # scikit-build puts us in the wrong folder. That is bad.
  preBuild = ''
    cd ..
  '';

  buildInputs = [ openfst kaldiFork ];
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
