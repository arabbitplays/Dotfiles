{ config, lib, pkgs, ... }:

let
    cfg = config.artModule;
in
{
    options.artModule = {
        enable = lib.mkEnableOption "Art module";
    };

    config = lib.mkIf cfg.enable {
        system.activationScripts.artModule = {
            text = ''
                echo "activating Art Module"
            '';
        };

        environment.systemPackages = with pkgs; [
            opentabletdriver
            krita
            libresprite
        ];
    };
}
