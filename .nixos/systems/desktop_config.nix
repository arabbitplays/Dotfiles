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
        "${module_dir}/users.nix"
        "${module_dir}/shell.nix"
        "${module_dir}/steam.nix"
        "${module_dir}/networking.nix"
        "${module_dir}/user-programs.nix"
        "${module_dir}/minecraft.nix"
        ];

  hypr-desktop.enable = true;
  networking.hostName = lib.mkForce "nix-desktop"; # Override your hostname.

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
