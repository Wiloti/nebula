{ ... }: {
    flake.nixosModules.voidGraphic = {pkgs, lib, ... }: {
        hardware = {
            graphics = {
                enable = true;
                enable32Bit = true;
                extraPackages = with pkgs; [
                    nvidia-vaapi-driver
                ];
            };

            nvidia = {
                modesetting.enable = true;
                powerManagement.enable = false;
                open = true;
                nvidiaSettings = false;
            };
        };

        services = {
            xserver.videoDrivers = ["nvidia"];
            pipewire.wireplumber.extraConfig."50-nvidia-hdmi" = {
                "monitor.alsa.rules" = [{
                    matches = [{ "device.name" = "alsa_card.pci-0000_26_00.1"; }];
                    actions.update-props = {
                        "api.acp.auto-profile" = false;
                        "device.profile" = "output:hdmi-stereo-extra1";
                    };
                }];
            };
        };

    };
}
