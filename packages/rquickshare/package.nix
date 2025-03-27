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
  pname = "rquickshare";
  version = "0.11.5";

  src = fetchurl {
    url = "https://github.com/Martichou/rquickshare/releases/download/v0.11.5/r-quick-share-main_v${version}_glibc-2.39_amd64.deb";
    hash = "sha256-SQhed+NRvK3LCv93B9NxQ17BzVpAmh4Ubiz4JPSP8Yk=";
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
    wrapProgram $out/bin/rquickshare --prefix LD_LIBRARY_PATH : ${libraryPath}
  '';
}
