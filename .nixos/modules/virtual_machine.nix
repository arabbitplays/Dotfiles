
{ config, lib, pkgs, ... }:

let
    cfg = config.virtualMachineModule;
in
{
    options.virtualMachineModule = {
        enable = lib.mkEnableOption "Virtual Machine Module";
    };

    config = lib.mkIf cfg.enable {
        system.activationScripts.artModule = {
            text = ''
                echo "activating Virtual Machine Module"
            '';
        };

        virtualisation.virtualbox.host = {
            enable = true;
            enableExtensionPack = true;
        };

        users.users.oschdi = {
            isNormalUser = true;
            extraGroups = [ 
                "wheel"       # Für sudo-Rechte
                "vboxusers"   # WICHTIG: Erlaubt VirtualBox den Zugriff auf USB-Sticks
            ];
        };
    };
}
