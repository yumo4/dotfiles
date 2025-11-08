{
  stdenv,
  lib,
  appimageTools,
  fetchurl,
}: let
  pname = "helium-browser";
  version = "0.6.3.1";

  architectures = {
    "x86_64-linux" = {
      arch = "x86_64";
      hash = "sha256-N7JpLLOdsnYuzYreN1iaHI992MR2SuXTmXHfa6fd1UU=";
    };
    "aarch64-linux" = {
      arch = "arm64";
      hash = "sha256-PLACEHOLDER";
    };
  };

  src = fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-${architectures.${stdenv.hostPlatform.system}.arch}.AppImage";
    sha256 = architectures.${stdenv.hostPlatform.system}.hash;
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname src version;
  };
in
  appimageTools.wrapType2 {
    inherit pname src version;

    extraInstallCommands = ''
      mkdir -p $out/share/applications
      mkdir -p $out/share/icons/hicolor/256x256/apps

      cp ${appimageContents}/helium.desktop $out/share/applications/helium-browser.desktop
      sed -i 's|Exec=.*|Exec=helium-browser|g' $out/share/applications/helium-browser.desktop
      sed -i 's|Icon=.*|Icon=helium-browser|g' $out/share/applications/helium-browser.desktop

      cp ${appimageContents}/usr/share/icons/hicolor/256x256/apps/helium.png $out/share/icons/hicolor/256x256/apps/helium-browser.png 2>/dev/null || \
      cp ${appimageContents}/helium.png $out/share/icons/hicolor/256x256/apps/helium-browser.png 2>/dev/null || true
    '';

    meta = {
      description = "Privacy-focused web browser";
      homepage = "https://github.com/imputnet/helium-linux";
      platforms = lib.attrNames architectures;
      mainProgram = "helium-browser";
    };
  }
