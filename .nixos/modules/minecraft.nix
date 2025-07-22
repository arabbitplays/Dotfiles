{ pkgs, lib, ... }: 

{
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
}