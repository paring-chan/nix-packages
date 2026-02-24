{
  stdenv,
  fetchurl,
  dpkg,
  openssl,
  xz,
  nettle,
  gmp,
  bzip2,
  autoPatchelfHook,
}:
stdenv.mkDerivation {
  pname = "proxmox-offline-mirror";
  version = "0.7.3";

  src = fetchurl {
    url = "http://download.proxmox.com/debian/pbs-client/dists/trixie/main/binary-amd64/proxmox-offline-mirror_0.7.3_amd64.deb";
    sha256 = "sha256-aVhe23VW0FZBUnkRg6G1AHBsALMpgOm9RFwgGUBBNOc=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir $out
    cp -r . $out
  '';

  buildInputs = [
    openssl
    xz
    nettle
    gmp
    bzip2
  ];
}
