{ lib, config, pkgs, ... }:

{
    users.users.oschdi = {
    isNormalUser = true;
    description = "Jakob Ostermann";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

}
