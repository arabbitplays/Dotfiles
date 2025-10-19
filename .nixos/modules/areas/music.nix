{ config, lib, pkgs, ... }:

let
    cfg = config.musicModule;
in
{
    options.musicModule = {
        enable = lib.mkEnableOption "Music module";
    };

    config = lib.mkIf cfg.enable {
        system.activationScripts.musicModule = {
            text = ''
                echo "activating Music Module"
            '';
        };

        environment.systemPackages = with pkgs; [
            vital # wavetable synth
            cowsay
        ];
    };
}
