{ lib, stdenv, fetchFromGitHub, rustPlatform, pkg-config, alsaLib, openssl, glib, ffmpeg
, cairo, pango, atk, gdk-pixbuf, gtk3, vulkan-headers, vulkan-loader
, clangStdenv, llvmPackages, clang, clang-tools, libunwind, clang_12, tree }:

with rustPlatform;

buildRustPackage rec {
  pname = "alvr";
  version = "15.1.2";

  src = fetchFromGitHub {
    owner = "alvr-org";
    repo = "ALVR";
    rev = "c8a0fb75c8a947ae7fd6c09ac9f9893d47860000";
    sha256 = "08dq56isi77pbkhwzq1spy6lqvxmaarikj22vaqydg2q4z679j6q";
  };

  patches = [ ./0001-change-alvr-dir-path.patch ./0002-disable-crash-log.patch ./0003-remove-dev-vk-layer-path.patch ];

  cargoSha256 = "1qv4nhv0f1y9ncy0vlkfcp5ci44qsxqrbjhwpdq2jlslqxk0a8nn";

  buildInputs = [
    alsaLib
    openssl
    glib
    ffmpeg
    cairo
    pango
    atk
    gdk-pixbuf
    gtk3
    vulkan-headers
    vulkan-loader
    clang
    libunwind
  ];

  nativeBuildInputs = [ pkg-config clang-tools clang_12 ];

  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";
  cargoBuildFlags = "-p alvr_server -p alvr_launcher -p alvr_vulkan-layer";

  doCheck = false;
  buildType = "debug";

  configurePhase = ''
    substituteInPlace alvr/launcher/res/vrcompositor_launcher_wrapper.sh --replace "REPLACE_THIS_VK_LAYER_PATH" "$out/share/vulkan/explicit_layer.d"
  '';

  installPhase = ''
    installPhaseTarget=target/x86_64-unknown-linux-gnu/$cargoBuildType
    mkdir -p $out/{bin,share/vulkan/explicit_layer.d,share/alvr/bin/linux64,lib}
    cp $installPhaseTarget/alvr_launcher $out/bin

    substituteInPlace alvr/vulkan-layer/layer/alvr_x86_64.json --replace "../../../lib64/" "$out/lib/"
    # This file references lib64 but /pkgs/build-support/setup-hooks/move-lib64.sh will take care of that for us.
    cp alvr/vulkan-layer/layer/alvr_x86_64.json $out/share/vulkan/explicit_layer.d
    cp $installPhaseTarget/libalvr_vulkan_layer.so $out/lib

    cp alvr/xtask/server_release_template/driver.vrdrivermanifest $out/share/alvr
    # SteamVR expects this to be in this relative path for x86_64-linux, which is the only platform ALVR supports
    cp $installPhaseTarget/libalvr_server.so $out/share/alvr/bin/linux64/driver_alvr_server.so

    cp -r alvr/legacy_dashboard $out/share/alvr/dashboard
  '';

  meta = with lib; {
    description = "Stream VR games from your PC to your headset over the network";
    homepage = "https://alvr-org.github.io";
    platforms = [ "x86_64-linux" ];
    license = licenses.mit;
    maintainers = [ maintainers.ronthecookie ];
  };
}
