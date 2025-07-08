{ lib, config, pkgs, ... }:

{
    options = {
        hypr-desktop.enable 
            = lib.mkEnableOption "enable desktop module";
    };

    config = lib.mkIf config.hypr-desktop.enable {
        # Enable the X11 windowing system.
        #services.xserver.enable = true;
        services.displayManager.gdm = {
            enable = true;
            wayland = true;
        };

        # auto mounting of usb drives
        services.gvfs.enable = true;
        services.udisks2.enable = true;

        programs.hyprland = {
            enable = true;
            xwayland.enable = true;
        };

        # default applications for the file manager
        #xdg.portal = {
        #    enable = true;
        #    config = {
        #        hyprland = {
        #            default = [
        #                "hyprland"
        #                "kde"
        #            ];
        #        };
        #    };
        #    configPackages = with pkgs; [
        #        xdg-desktop-portal-hyprland
        #        kdePackages.xdg-desktop-portal-kde
        #    ];
        #};
        
        environment.sessionVariables = {
            WLR_NO_HARDWARE_CURSORS = "1";
            NISOS_OZONE_WL = "1";
        };

        hardware = {
            # enable opengl
            graphics.enable = true;            
            nvidia.modesetting.enable = true;
        };

        hardware.nvidia = {
            # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
            # Enable this if you have graphical corruption issues or application crashes after waking
            # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
            # of just the bare essentials.
            powerManagement.enable = false;

            # Fine-grained power management. Turns off GPU when not in use.
            # Experimental and only works on modern Nvidia GPUs (Turing or newer).
            powerManagement.finegrained = false;

            # Use the NVidia open source kernel module (not to be confused with the
            # independent third-party "nouveau" open source driver).
            # Support is limited to the Turing and later architectures. Full list of 
            # supported GPUs is at: 
            # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
            # Only available from driver 515.43.04+
            open = false;

            # Enable the Nvidia settings menu,
            # accessible via `nvidia-settings`.
            nvidiaSettings = true;

            # Optionally, you may need to select the appropriate driver version for your specific GPU.
            package = config.boot.kernelPackages.nvidiaPackages.latest;
        };

        environment.systemPackages = with pkgs; [
            kitty # terminal emulator (for hyprland)
            rofi-wayland # launcher
            nemo # file manager
            (waybar.overrideAttrs (oldAttrs: {
            mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
            })) # desktop bar
            dunst # notification deamon
            libnotify # notify dependency
            swww # wallpaper manager
            lxqt.lxqt-policykit # authenticaton manager for polkit
            networkmanagerapplet
            wlogout # logout manager
            hyprshot # screenshots
            wl-clipboard # clipboard utility
            wtype # needed for autopasting
            clipse  # clipboard manager
            qimgv # image viewer
            brightnessctl # controll brigthness
            pavucontrol # audio controllcd
            zip
            unzip
            xdg-utils # desktop integration for the command line
            pkgs.nix-index # used to find nix packages
            htop # process viewer
            #ntfs3g # file system support
            #exfat # file system support
            usbutils # usb drive utils
            udiskie # disk auto mounter
            udisks # stuff for disk manipulation
            jmtpfs # phone files access
        ];
    };
}