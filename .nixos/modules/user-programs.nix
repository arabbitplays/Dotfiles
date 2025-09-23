{ lib, config, pkgs, ... }:

{
    programs.firefox.enable = true;
    #services.onedrive.enable = true;

    environment.systemPackages = with pkgs; [
        git
        jetbrains.clion
        linuxPackages_latest.perf
        perf-tools
        tracy
        vscode
        obsidian
        thunderbird
        discord
        signal-desktop
        spotify
        prismlauncher
        scribus
        opentabletdriver
        krita
        libresprite
        obs-studio
    ];

    fonts.packages = with pkgs; [
        lexend
        nerd-fonts.zed-mono
        montserrat
        texlivePackages.playfair
    ];

    # allow perf to collect information without root priviledges
    boot.kernel.sysctl = {
        "kernel.perf_event_paranoid" = 1;
        "kernel.kptr_restrict" = 0;
    };
}