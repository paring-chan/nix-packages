{
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  webkitgtk_4_1,
  libsoup_3,
  makeWrapper,
  lib,
  libayatana-appindicator,
  openssl,
}:
let
  libraryPath = lib.makeLibraryPath [
    libayatana-appindicator
    webkitgtk_4_1
    libsoup_3
    openssl
  ];
in
stdenv.mkDerivation rec {
  pname = "neohtop";
  version = "1.1.2";

  src = fetchurl {
    url = "https://github.com/Abdenasser/neohtop/releases/download/v${version}/NeoHtop_${version}_x86_64.deb";
    hash = "sha256-06niCR/X6Lshp0Yw8VqVHUTTV+RMN/ytS+mAxrlNets=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    webkitgtk_4_1
  ];

  unpackPhase = ''
    dpkg -x $src unpacked
    cp -r unpacked/* $out/
  '';

  fixupPhase = ''
    wrapProgram $out/bin/NeoHtop --prefix LD_LIBRARY_PATH : ${libraryPath}
  '';
}
