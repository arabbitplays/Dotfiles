{ inputs, lib, config, pkgs, ... }:

{
    options = {
        hypr-desktop.enable 
            = lib.mkEnableOption "enable desktop module";
    };

    config = lib.mkIf config.hypr-desktop.enable {
        # Enable the X11 windowing system.
        services.xserver.enable = true;
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

        # Desktop portal for link opening, screensharing, ...
        xdg.portal.enable = true;
        xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

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
            graphics.enable = true;            
            nvidia.modesetting.enable = true;
        };

        services.xserver.videoDrivers = ["nvidia"];

        hardware.nvidia = {
            # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
            # Enable this if you have graphical corruption issues or application crashes after waking
            # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
            # of just the bare essentials.
            powerManagement.enable = true;

            # Fine-grained power management. Turns off GPU when not in use.
            # Experimental and only works on modern Nvidia GPUs (Turing or newer).
            powerManagement.finegrained = false;

            # Use the NVidia open source kernel module (not to be confused with the
            # independent third-party "nouveau" open source driver).
            # Support is limited to the Turing and later architectures. Full list of 
            # supported GPUs is at: 
            # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
            # Only available from driver 515.43.04+
            open = true;

            # Enable the Nvidia settings menu,
            # accessible via `nvidia-settings`.
            nvidiaSettings = true;

            # Optionally, you may need to select the appropriate driver version for your specific GPU.
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };

        systemd.user.services.desktop-manager = {
            description = "Desktop Manager Daemon";

            wantedBy = [ "default.target" ];
            after = [ "graphical-session.target" ];

            serviceConfig = {
                ExecStart = "${inputs.desktop-manager.packages.${pkgs.stdenv.hostPlatform.system}.desktop-manager}/bin/DesktopManager";
                Restart = "always";
                RestartSec = 2;
                RuntimeDirectory = "desktop-manager";

                Environment = ''
                    PATH=/run/current-system/sw/bin:/run/current-system/sw/sbin:/usr/bin:/bin:${pkgs.coreutils}/bin
                    XDG_RUNTIME_DIR=${builtins.getEnv "XDG_RUNTIME_DIR"}
                    WAYLAND_DISPLAY=${builtins.getEnv "WAYLAND_DISPLAY"}
                '';
            };
        };

        environment.systemPackages = with pkgs; [
            kitty # terminal emulator (for hyprland)
            rofi # launcher
            nemo # file manager
            (waybar.overrideAttrs (oldAttrs: {
            mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
            })) # desktop bar
            dunst # notification deamon
            libnotify # notify dependency
            swww # wallpaper manager
            #(callPackage ./lwp.nix {}) # layered wallpaper engine
            lxqt.lxqt-policykit # authenticaton manager for polkit
            networkmanagerapplet
            wlogout # logout manager
            hyprshot # screenshots
            wl-clipboard # clipboard utility
            wtype # needed for autopasting
            clipse  # clipboard manager
            qimgv # image viewer
            mpv # media player
            brightnessctl # controll brigthness
            pavucontrol # audio controllcd
            zip
            unzip
            xdg-utils # desktop integration for the command line
            pkgs.nix-index # used to find nix packages
            btop # process viewer
            zenith-nvidia
            alsa-utils # utils for sound hardware
            #ntfs3g # file system support
            #exfat # file system support
            usbutils # usb drive utils
            udiskie # disk auto mounter
            udisks # stuff for disk manipulation
            gparted # partition manager
            jmtpfs # phone files access
            qalculate-qt # calculator
            libreoffice
            texliveMedium
            inputs.desktop-manager-cli.packages.${pkgs.stdenv.hostPlatform.system}.desktop-manager-cli
        ];
    };
}
