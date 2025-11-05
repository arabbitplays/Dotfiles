{ config, lib, pkgs, ... }:

let
    cfg = config.postgresModule;
in
{
    options.postgresModule = {
        enable = lib.mkEnableOption "PostgreSQL module";
    };

    config = lib.mkIf cfg.enable {
        system.activationScripts.postgresModule = {
            text = ''
                echo "activating PostgreSQL Module"
            '';
        };

        services.postgresql = {
            enable = true;
            ensureDatabases = [ "gamify-life" ];
            authentication = pkgs.lib.mkOverride 10 ''
                #type database  DBuser  auth-method
                local all all trust
                host  all all 127.0.0.1/32 trust
                host  all all ::1/128 trust
            '';
        };

        environment.systemPackages = with pkgs; [
            dbeaver-bin
        ];
    };
}
