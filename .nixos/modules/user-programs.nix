{ lib, config, pkgs, flakeRoot, ... }:

{
    programs.firefox.enable = true;
    #services.onedrive.enable = true;

    environment.systemPackages = with pkgs; [
        obsidian
        thunderbird
        discord
        signal-desktop
        spotify
        prismlauncher
        scribus
        obs-studio
        drawio
        cmatrix
        pipes
        wget
    ];

    fonts.packages = with pkgs; [
        lexend
        nerd-fonts.zed-mono
        montserrat
        texlivePackages.playfair
        (pkgs.stdenvNoCC.mkDerivation {
            name = "flowstate";
            src = "${flakeRoot}/fonts/flowstate.otf";
            dontUnpack = true;

            installPhase = ''
                mkdir -p $out/share/fonts/opentype
                cp $src $out/share/fonts/opentype/
            '';
        })
        (pkgs.stdenvNoCC.mkDerivation {
            name = "barlow";
            src = "${flakeRoot}/fonts/Barlow.otf";
            dontUnpack = true;

            installPhase = ''
                mkdir -p $out/share/fonts/opentype
                cp $src $out/share/fonts/opentype/
            '';
        })
        (pkgs.stdenvNoCC.mkDerivation {
            name = "hypha";
            src = "${flakeRoot}/fonts/hypha.otf";
            dontUnpack = true;

            installPhase = ''
                mkdir -p $out/share/fonts/opentype
                cp $src $out/share/fonts/opentype/
            '';
        })
        (pkgs.stdenvNoCC.mkDerivation {
            name = "PlantasiaBioma";
            src = "${flakeRoot}/fonts/PlantasiaBioma.otf";
            dontUnpack = true;

            installPhase = ''
                mkdir -p $out/share/fonts/opentype
                cp $src $out/share/fonts/opentype/
            '';
        })
        (pkgs.stdenvNoCC.mkDerivation {
            name = "PlantasiaBioma-Italic";
            src = "${flakeRoot}/fonts/PlantasiaBioma-Italic.otf";
            dontUnpack = true;

            installPhase = ''
                mkdir -p $out/share/fonts/opentype
                cp $src $out/share/fonts/opentype/
            '';
        })

        (pkgs.stdenvNoCC.mkDerivation {
            name = "RegMono";
            src = "${flakeRoot}/fonts/RegMono.otf";
            dontUnpack = true;

            installPhase = ''
                mkdir -p $out/share/fonts/opentype
                cp $src $out/share/fonts/opentype/
            '';
        })
    ];

    # allow perf to collect information without root priviledges
    boot.kernel.sysctl = {
        "kernel.perf_event_paranoid" = 1;
        "kernel.kptr_restrict" = 0;
    };
}
