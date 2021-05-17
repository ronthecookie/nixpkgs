{stdenv, fetchurl, x11, SDL, mesa, openal}:

stdenv.mkDerivation {
  name = "quake3-icculus-1.33pre526";
  src = fetchurl {
    url = http://tarballs.nixos.org/quake3-icculus-r526.tar.bz2;
    md5 = "63429347b918052c27cdb5c1d15939ad";
  };
  builder = ./builder.sh;
  buildInputs = [x11 SDL mesa openal];
}
