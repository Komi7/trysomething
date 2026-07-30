{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      # C/C++ runtime
      stdenv.cc.cc
      zlib

      # GLib / GTK
      glib
      gtk3
      gdk-pixbuf
      cairo
      pango
      atk
      krb5

      # X11
      libX11
      libXext
      libXrender
      libXi
      libXrandr
      libXcursor
      libXfixes
      libXinerama
      libxcb
      libXcomposite
      libXdamage
      libXdmcp

      # Wayland
      wayland
      libxkbcommon

      # OpenGL
      libGL
      libGLU
      mesa

      # Fonts
      fontconfig
      freetype

      # SSL / Certificates
      openssl
      cacert

      # Audio
      alsa-lib
      pulseaudio

      # Misc
      dbus
      expat
      nspr
      nss
      libdrm

      # Multimedia
      ffmpeg

      # USB
      libusb1
    ];
  };

  environment.variables = {
    SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    REQUESTS_CA_BUNDLE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    CURL_CA_BUNDLE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
  };
}