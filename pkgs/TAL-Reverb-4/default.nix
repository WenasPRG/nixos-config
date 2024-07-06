{ lib, stdenv, fetchFromGitHub, cmake, php, perl, git, pkg-config, gtk3, alsaLib, jack2, libX11 }:

stdenv.mkDerivation {
  pname = "TAL-Reverb-4";
  version = "4.0.4";

  src = fetchzip {
    url = "https://tal-software.com/downloads/plugins/TAL-Reverb-4_64_linux.zip";
    sha256 = "1fjv2nszq9hnrm5lv25qq27szcvpds1hr3ls3h0kalypj78ap3dh";
  };

  buildInputs = [ alsaLib jack2 libX11 php perl git pkg-config gtk3 ];

  buildPhase = ''
    # I have no clue what to put in here
    echo "Build phase not needed"
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r * $out/bin
  '';
}
	
