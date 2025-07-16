{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/base.nix
      ./modules/desktop.nix
      ./modules/users.nix
      ./modules/shell.nix
      ./modules/steam.nix
      ./modules/networking.nix
    ];

  hypr-desktop.enable = true;

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
