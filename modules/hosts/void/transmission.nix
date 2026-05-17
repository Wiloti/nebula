{ self, inputs, ... }: {
  flake.nixosModules.voidTransmission = { pkgs, lib, ... }: {

    services.transmission = {
      enable = true;
      package = pkgs.transmission_4;
      user = "wiloti";
      group = "users";

      settings = {
        download-dir = "/home/wiloti/torrents";
        incomplete-dir = "/home/wiloti/torrents/.incomplete";
        incomplete-dir-enabled = true;
        watch-dir = "/home/wiloti/torrents/.watch";
        watch-dir-enabled = true;
        ratio-limit = 2.5;
        ratio-limit-enabled = true;
        rpc-enabled = true;
        rpc-port = 9091;
        rpc-bind-address = "127.0.0.1";
        rpc-authentication-required = false;
        rpc-whitelist-enabled = true;
        rpc-whitelist = "127.0.0.1";
        peer-limit-global = 200;
        peer-limit-per-torrent = 50;
        speed-limit-down-enabled = false;
        speed-limit-up-enabled = false;
        encryption = 1;
        peer-port-random-on-start = true;
      };
    };
    systemd.tmpfiles.rules = [
      "d /home/wiloti/torrents 0755 wiloti users -"
      "d /home/wiloti/torrents/.incomplete 0755 wiloti users -"
      "d /home/wiloti/torrents/.watch 0755 wiloti users -"
    ];
    environment.systemPackages = with pkgs; [
      tremc
      transmission_4
    ];

  };
}
