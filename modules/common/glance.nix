{ ... }: {
    flake.nixosModules.commonGlance = { pkgs, lib, ... }: {
        services.glance = {

            enable = true;
            settings = {
                server = {
                    host = "127.0.0.2";
                    port = 8080;
                };
                theme = {
                    background-color = "240 13 14";
                    primary-color = "51 33 68";
                    negative-color = "358 100 68";
                    contrast-multiplier = 1.2;
                };
                branding = {
                    custom-footer = "<p>Wiloti's Abyss</p>";
                    hide-footer = false;
                };
                pages = [
                    {
                        name = "Japan 🇯🇵";
                        slug = "japan";
                        desktop-navigation-width = "wide";
                        columns = [
                            {
                                size = "full";
                                widgets = [
                                    {
                                        type = "group";
                                        widgets = map
                                            ({ name, id }: {
                                                type = "videos";
                                                title = name;
                                                include-shorts = false;
                                                style = "horizontal-cards";
                                                limit = 6;
                                                channels = [ id ];
                                            }
                                        )
                                        [
                                            { name = "凪"; id = "UCbn-_A-tv1UsVYsgxbUU1Ow"; }
                                            { name = "Archipel"; id = "UC3zoY9LapZERsN7caDKqz0w"; }
                                        ];
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
