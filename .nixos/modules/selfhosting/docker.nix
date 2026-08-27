{ config, lib, pkgs, ... }:

let
    cfg = config.dockerModule;
in
{
    options.dockerModule = {
        enable = lib.mkEnableOption "Docker module";
    };

    config = lib.mkIf cfg.enable {
        system.activationScripts.dockerModule = {
            text = ''
                echo "activating Docker Module"
            '';
        };

        virtualisation.docker.enable = true;
        virtualisation.docker.package = pkgs.docker_29;
        users.users.oschdi.extraGroups = [ "docker" ];
        
        environment.systemPackages = with pkgs; [
        ];
    };
}
