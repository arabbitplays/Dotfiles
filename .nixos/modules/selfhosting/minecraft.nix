{ config, lib, pkgs, ... }:

let
    cfg = config.minecraftModule;
in
{
    options.minecraftModule = {
        enable = lib.mkEnableOption "Minecraft module";
    };

    config = lib.mkIf cfg.enable {
        system.activationScripts.minecraftModule = {
            text = ''
                echo "activating Minecraft Module"
            '';
        };

        nixpkgs.config.allowBroken = true;

        services.minecraft-server = {
            enable = true;
            eula = true;
            declarative = true;

            #package = pkgs.minecraftServers.vanilla-1-20;
            #dataDir = "/var/lib/minecraft";

            serverProperties = {
                gamemode = "creative";
                level-seed = "7445395903252703439";
            };

            whitelist = {

            };
        };
        
        environment.systemPackages = with pkgs; [

        ];
    };
}