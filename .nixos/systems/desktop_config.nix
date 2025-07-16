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
        ];

  hypr-desktop.enable = true;
  networking.hostName = lib.mkForce "nix-desktop"; # Override your hostname.

  programs.firefox.enable = true;
  #services.onedrive.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    jetbrains.clion
    vscode
    obsidian
    thunderbird
    discord
    mattermost
    signal-desktop
    spotify
  ];

  fonts.packages = with pkgs; [
    lexend
    nerd-fonts.zed-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
