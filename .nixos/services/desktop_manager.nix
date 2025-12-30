{ pkgs }:

pkgs.stdenv.mkDerivation {
    pname = "DesktopMangager";
    version = "1.0.0";

    src = pkgs.fetchgit {
        url = "https://github.com/arabbitplays/Desktop-Manager";
        sha256 = "v+WyuhtZfkkxlMVA0STiWNY83Vn1kCEi9j2k+kgzBXk=";
    };

    nativeBuildInputs = with pkgs; [ meson ninja pkg-config ];
    buildInputs = with pkgs; [ python3 ];

    # buildPhase = ''
    #     meson setup builddir --prefix=$out
    #     meson compile -C builddir
    # '';

    installPhase = '' # optional
        mkdir -p $out
        cp ./DesktopManager $out/app
    '';
}
