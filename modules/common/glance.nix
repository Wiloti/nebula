{ ... }: {
    flake.nixosModules.commonGlance = { pkgs, lib, ... }: {
        services.glance = {

            enable = true;
            settings = {
                server = {
                    host = "0.0.0.0";
                    port = 8080;
                };
                pages = [
                    {
                        name = "Videos";
                        slug = "videos";
                        desktop-navigation-width = "wide";
                        head-widgets = [
                            {
                                type = "twitch-channels";
                                channels = [
                                    "shisheyu"
                                    "zerator"
                                    "otplol_"
                                    "mistermv"
                                    "hackthebox"
                                    "thelaluka"
                                    "rootme_org"
                                ];
                                hide-header = true;
                                collapse-after = 1;
                                style = "horizontal-cards";
                            }
                        ];

                        columns = [
                            {
                                size = "full";
                                widgets = [
                                    {
                                        type = "videos";
                                        title = "凪";
                                        limit = 6;
                                        include-shorts = false;
                                        style = "horizontal-cards";
                                        channels = [ "UCbn-_A-tv1UsVYsgxbUU1Ow" ];
                                    }
                                    {
                                        type = "videos";
                                        title = "Archipel";
                                        limit = 6;
                                        include-shorts = false;
                                        style = "horizontal-cards";
                                        channels = [ "UC3zoY9LapZERsN7caDKqz0w" ];
                                    }
                                ];
                            }
                        ];
                    }
                ];
            };
        };
    };
}
