{ lib
, fetchPypi
, buildPythonPackage
, isPy27
, isPy3k
, numpy
, imagecodecs-lite
, enum34 ? null
, futures ? null
, pathlib ? null
, pytest
}:

buildPythonPackage rec {
  pname = "tifffile";
  version = "2021.6.14";

  src = fetchPypi {
    inherit pname version;
    sha256 = "a2f83d82800a8d83cbd04340f9d65a6873a970874947a6b823b1b1238e84cba6";
  };

  patches = lib.optional isPy27 ./python2-regex-compat.patch;

  # Missing dependencies: imagecodecs, czifile, cmapfile, oiffile, lfdfiles
  # and test data missing from PyPI tarball
  doCheck = false;

  checkInputs = [
    pytest
  ];

  checkPhase = ''
    pytest
  '';

  propagatedBuildInputs = [
    numpy
  ] ++ lib.optionals isPy3k [
    imagecodecs-lite
  ] ++ lib.optionals isPy27 [
    futures
    enum34
    pathlib
  ];

  meta = with lib; {
    description = "Read and write image data from and to TIFF files.";
    homepage = "https://www.lfd.uci.edu/~gohlke/";
    maintainers = [ maintainers.lebastr ];
    license = licenses.bsd3;
  };
}
