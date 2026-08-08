{ ... }: {
  flake.nixosModules.commonGlance = { pkgs, lib, ... }: {

    services.glance = {
      enable = true;

      settings = {

        server = {
          host = "0.0.0.0";
          port = 8080;
        };

        theme = {
          background-color = "220 16 10";
          contrast-multiplier = 1.2;
          primary-color = "114 139 142";
          positive-color = "135 169 135";
          negative-color = "196 116 110";
        };

        pages = [
          {
            name = "VIDEO";
            columns = [
              {
                size = "full";
                widgets = [
                  {
                    type = "rss";
                    title = "Security";
                    limit = 20;
                    collapse-after = 5;
                    cache = "1h";
                    feeds = [
                      {
                        url = "https://feeds.feedburner.com/TheHackersNews";
                        title = "The Hacker News";
                      }
                      {
                        url = "https://www.schneier.com/feed/atom";
                        title = "Schneier on Security";
                      }
                      {
                        url = "https://portswigger.net/research/rss";
                        title = "PortSwigger Research";
                      }
                      {
                        url = "https://research.checkpoint.com/feed";
                        title = "Check Point Research";
                      }
                      {
                        url = "https://www.reddit.com/r/netsec/.rss";
                        title = "r/netsec";
                      }
                    ];
                  }
                ];
              }
              {
                size = "small";
                widgets = [
                  {
                    type = "twitch-channels";
                    channels = [
                    ];
                  }
                ];
              }
            ];
          }
          {
            name = "Videos";
            columns = [
              {
                size = "full";
                widgets = [
                  {
                    type = "videos";
                    title = "YouTube";
                    style = "grid-cards";
                    collapse-after-rows = 3;
                    channels = [
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
