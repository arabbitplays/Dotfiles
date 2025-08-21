{ lib, config, pkgs, ... }:

{
    programs.firefox.enable = true;
    #services.onedrive.enable = true;

    environment.systemPackages = with pkgs; [
        git
        jetbrains.clion
        vscode
        obsidian
        thunderbird
        discord
        mattermost
        signal-desktop
        spotify
        prismlauncher
        scribus
        opentabletdriver
        krita
    ];

    fonts.packages = with pkgs; [
        lexend
        nerd-fonts.zed-mono
        montserrat
        texlivePackages.playfair
    ];
}