{stdenv, fetchurl}:

stdenv.mkDerivation {
  name = "patchelf-0.3";
  src = fetchurl {
    url = http://tarballs.nixos.org/dist/nix/patchelf-0.3/patchelf-0.3.tar.bz2;
    md5 = "20d77052ae559c60e6c5efb6ea95af9b";
  };

  meta = {
    homepage = "http://tarballs.nixos.org/patchelf.html";
    license = "GPL";
    description = "A small utility to modify the dynamic linker and RPATH of ELF executables";
  };
}
