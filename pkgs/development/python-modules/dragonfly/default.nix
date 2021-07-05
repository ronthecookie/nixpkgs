{ lib
, buildPythonPackage
, fetchFromGitHub
, decorator
, packaging
, pynput
, regex
, lark-parser
, enum34
, pyperclip
, six
, requests
, psutil
, json-rpc
, werkzeug
, pytestCheckHook
, kaldi-active-grammar
, sounddevice
, webrtcvad
, setuptools
}:

buildPythonPackage rec {
  pname = "dragonfly";
  version = "0.32.0";
  # format = "wheel";

  src = fetchFromGitHub {
    owner = "dictation-toolbox";
    repo = pname;
    rev = version;
    sha256 = "BUbIhc8as/DVx8/4VeQS9emOLGcWFujNCxesSEEBqKQ=";
  };

  patchPhase = ''
    substituteInPlace setup.py --replace 'lark-parser == 0.8.*' 'lark-parser'
  '';

  propagatedBuildInputs = [
    decorator
    packaging
    pynput
    regex
    lark-parser
    enum34
    pyperclip
    six
    requests
    psutil
    json-rpc
    werkzeug
    # Kaldi engine:
    kaldi-active-grammar
    sounddevice
    webrtcvad
    setuptools # needs pkg_resources at runtime
  ];

  # Too many tests fail because of the unusual environment or
  # because of the missing dependencies for some of the engines.
  doCheck = false;

  meta = with lib;
    {
      description = "Speech recognition framework allowing powerful Python-based scripting";
      homepage = "https://github.com/dictation-toolbox/dragonfly";
      license = licenses.lgpl3;
      maintainers = with maintainers; [ ronthecookie ];
    };
}
