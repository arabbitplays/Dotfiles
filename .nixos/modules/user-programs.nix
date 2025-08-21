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
        libresprite
    ];

    fonts.packages = with pkgs; [
        lexend
        nerd-fonts.zed-mono
    ];
}