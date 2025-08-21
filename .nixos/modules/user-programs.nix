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
        signal-desktop
        spotify
        prismlauncher
        scribus
<<<<<<< HEAD
        opentabletdriver
        krita
=======
        libresprite
>>>>>>> 0d5e14a144102a2f06c8c65f9a2377d8a603a88b
    ];

    fonts.packages = with pkgs; [
        lexend
        nerd-fonts.zed-mono
        montserrat
        texlivePackages.playfair
    ];
}