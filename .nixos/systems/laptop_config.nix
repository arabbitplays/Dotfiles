{ lib, config, pkgs, ... }:
let
    module_dir = ../modules;
in
{
  imports =
      [ # Include the results of the hardware scan.
      ../hardware-configuration.nix
      "${module_dir}/base.nix"
      "${module_dir}/desktop.nix"
      "${module_dir}/bluetooth.nix"
      "${module_dir}/users.nix"
      "${module_dir}/shell.nix"
      "${module_dir}/steam.nix"
      "${module_dir}/user-programs.nix"
      "${module_dir}/networking.nix"

      "${module_dir}/areas.nix" 
      "${module_dir}/selfhosting.nix"          
      ];

  musicModule.enable = true;
  postgresModule.enable = true;
  
  hypr-desktop.enable = true;
  networking.hostName = lib.mkForce "nix-laptop"; # Override your hostname.

  # Energy efficiency
  powerManagement.enable = true;  
  services.tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 20;

        #Optional helps save long term battery health
        #START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
        #STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

        };
  };


  environment.systemPackages = with pkgs; [
    anki
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
