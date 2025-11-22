{ config, lib, pkgs, ... }:

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
            jetbrains.pycharm-community
            perf
            perf-tools
            tracy
            gcc
            vscode
            neovim
            ripgrep # better grep used by the neovim setup
            vimPlugins.lazy-nvim
        ];
    };
}
