{ inputs, lib, config, pkgs, ... }:

let
    module_dir = ../modules;
in
{
    imports =
        [ # Include the results of the hardware scan.
        ../hardware-configuration.nix
        "${module_dir}/base.nix"
        "${module_dir}/bluetooth.nix"
        "${module_dir}/desktop.nix"
        "${module_dir}/users.nix"
        "${module_dir}/shell.nix"
        "${module_dir}/steam.nix"
        "${module_dir}/networking.nix"
        "${module_dir}/user-programs.nix"
        "${module_dir}/nixcats.nix"

        "${module_dir}/areas.nix"    
        "${module_dir}/selfhosting.nix"          
        ];


    programmingModule.enable = true;
    musicModule.enable = true;
    artModule.enable = true;

    postgresModule.enable = true;
    dockerModule.enable = true;
    minecraftModule.enable = true;

    hypr-desktop.enable = true;
    networking.hostName = lib.mkForce "nix-desktop"; # Override your hostname.

    systemd.user.services.desktop-manager = {
        description = "Desktop Manager Daemon";

        wantedBy = [ "default.target" ];
        after = [ "graphical-session.target" ];

        serviceConfig = {
            ExecStart = "${inputs.desktop-manager.packages.${pkgs.stdenv.hostPlatform.system}.desktop-manager}/bin/DesktopManager";
            Restart = "always";
            RestartSec = 2;
            RuntimeDirectory = "desktop-manager";

            Environment = ''
                PATH=/run/current-system/sw/bin:/run/current-system/sw/sbin:/usr/bin:/bin:${pkgs.coreutils}/bin
                XDG_RUNTIME_DIR=${builtins.getEnv "XDG_RUNTIME_DIR"}
                WAYLAND_DISPLAY=${builtins.getEnv "WAYLAND_DISPLAY"}
            '';
        };
    };

    environment.systemPackages = with pkgs; [
        jetbrains.webstorm
        jetbrains.idea
        mongodb-compass
    ];

}
