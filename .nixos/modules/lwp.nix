{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
    pname = "lwp";
    version = "2.1.2";

    src = fetchurl {
        url = "https://github.com/jszczerbinsky/lwp/releases/download/v${version}/Layered.WallPaper-v${version}-Linux-x86_64.tar.gz ";
        sha256 = "sha256-tLg1olNUKpyZBvCvr7ybCaYEE5DPlIDNP7Mbqnst7sI=";
    };

    dontUnpack = true;

    installPhase = ''
        mkdir -p $out
        tar -xzf $src -C $out
    '';
}
