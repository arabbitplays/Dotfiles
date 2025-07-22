{ lib, config, pkgs, ... }:

let
    module_dir = ../modules;
in
{
    imports =
        [ # Include the results of the hardware scan.
        ../hardware-configuration.nix
        "${module_dir}/base.nix"
        "${module_dir}/users.nix"
        "${module_dir}/shell.nix"
        "${module_dir}/networking.nix"
        ];

    networking.hostName = lib.mkForce "nix-minimal"; # Override your hostname.

    services.gnome.gnome-keyring.enable = true;

    # enable Sway window manager
    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
    };

    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
        git
        jetbrains.clion
        vscode
        kitty
    ];

    fonts.packages = with pkgs; [
        lexend
        nerd-fonts.zed-mono
    ];
}
