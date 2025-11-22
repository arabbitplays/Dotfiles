{ lib, config, pkgs, ... }:

let
    module_dir = ../modules;
in
{
    imports =
        [ # Include the results of the hardware scan.
        ../hardware-configuration.nix
        "${module_dir}/base.nix"
        "${module_dir}/bluetooth.nix"
        "${module_dir}/desktop.nix"
        "${module_dir}/users.nix"
        "${module_dir}/shell.nix"
        "${module_dir}/steam.nix"
        "${module_dir}/networking.nix"
        "${module_dir}/user-programs.nix"
        "${module_dir}/minecraft.nix"

        "${module_dir}/areas.nix"    
        "${module_dir}/selfhosting.nix"          
        ];

  programmingModule.enable = true;
  musicModule.enable = true;
  artModule.enable = true;
  postgresModule.enable = true;

  hypr-desktop.enable = true;
  networking.hostName = lib.mkForce "nix-desktop"; # Override your hostname.

  environment.systemPackages = with pkgs; [
    jetbrains.webstorm
    jetbrains.idea-community
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
