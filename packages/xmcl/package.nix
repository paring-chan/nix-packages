{
  stdenv,
  fetchurl,
  electron_33,
  bash,
  makeDesktopItem,
}:
let
  pname = "xmcl";
  version = "0.49.3";
  src = fetchurl {
    url = "https://github.com/Voxelum/x-minecraft-launcher/releases/download/v${version}/xmcl-${version}-x64.tar.xz";
    hash = "sha256-Vi32PXgwjuCpIjuvFQ4ToAiqdidHWk/o4BD9dCYRDgA=";
  };
  desktopEntry = makeDesktopItem {
    name = "xmcl";
    desktopName = "X Minecraft Launcher";
    exec = "xmcl %f";
    terminal = false;
  };
in
stdenv.mkDerivation {
  inherit src pname version;
  buildInputs = [
    electron_33
  ];

  installPhase = ''
    mkdir -p $out/etc/xmcl
    mkdir -p $out/share/applications
    cp resources/app.asar $out/etc/xmcl/app.asar
    mkdir -p $out/bin
    echo '#!${bash}/bin/bash' > $out/bin/xmcl
    echo "${electron_33}/bin/electron $out/etc/xmcl/app.asar \$@" >> $out/bin/xmcl
    cp ${desktopEntry}/share/applications/${pname}.desktop $out/share/applications/${pname}.desktop
    chmod +x $out/bin/xmcl
  '';
}
