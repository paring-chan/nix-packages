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
  pname = "arnis";
  version = "0.11.5";

  src = fetchurl {
    url = "https://github.com/louis-e/arnis/releases/download/v2.2.1/arnis-linux";
    hash = "sha256-WyOiCosKJ5/D4yXqAmqzZ8w8qP2/6G2LOx7ZTd44CUs=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    webkitgtk_4_1
  ];

  unpackPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/arnis
  '';

  fixupPhase = ''
    chmod +x $out/bin/arnis
    wrapProgram $out/bin/arnis --prefix LD_LIBRARY_PATH : ${libraryPath}
  '';
}
