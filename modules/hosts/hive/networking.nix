{ ... }: {
  flake.nixosModules.hiveNetworking = { pkgs, lib, ... }: {
    networking = {
      hostName = "hive";
      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
      };
      nameservers = [
        "9.9.9.9#dns.quad9.net"
        "149.112.112.112#dns.quad9.net"
      ];
      firewall = {
        enable = true;
        allowPing = true;
        logRefusedConnections = true;
      };
      nftables.enable = true;
    };

    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNSOverTLS= "true";
        DNSSEC = "true";
        FallbackDNS = [ "9.9.9.9#dns.quad9.net" "149.112.112.112#dns.quad9.net" ];
      };
    };
  };
}
