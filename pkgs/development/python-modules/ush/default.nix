{ lib, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "ush";
  version = "3.1.0";
  format = "wheel";

  src = fetchPypi {
    inherit pname version format;
    sha256 = "JB56zVbn4+xeSNG/D3At4qgHYjMM661E1FfPbeXRtbQ=";
  };


  meta = with lib; {
    description = "Powerful API for invoking with external commands";
    homepage = "https://github.com/tarruda/python-ush";
    license = licenses.mit;
    maintainers = with maintainers; [ ronthecookie ];
  };
}
