{stdenv, fetchurl, zlib}:

assert zlib != null;

stdenv.mkDerivation {
  name = "libpng-1.2.24";
  src = fetchurl {
    url = http://ftp.rediris.es/mirror/sunfreeware/SOURCES/libpng-1.2.24.tar.gz;
    sha256 = "0jm63ih0665441335l1i55d4j65gc569ppq44xygyn03nyqqm1gi";
  };
  propagatedBuildInputs = [zlib];
  inherit zlib;
}
