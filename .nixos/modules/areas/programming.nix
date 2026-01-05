{ config, lib, pkgs, inputs, ... }:

let
    cfg = config.programmingModule;
in
{
    options.programmingModule = {
        enable = lib.mkEnableOption "Programming module";
    };

    config = lib.mkIf cfg.enable {
        system.activationScripts.artModule = {
            text = ''
                echo "activating Programming Module"
            '';
        };

        environment.systemPackages = with pkgs; [
            git
            jetbrains.clion
            jetbrains.pycharm
            perf
            perf-tools
            tracy
            gcc
            vscode
            binutils # objdump and co
            socat # unix socket utility
        ];
    };
}
