{self, inputs, ... }: {
	flake.nixosModules.voidNetworking = {pkgs, lib, ... }: {
		networking = {
			hostName = "void";
			networkmanager = {
				enable = true;
				dns = "systemd-resolved";
			};
			nameservers = [ "9.9.9.9#dns.quad9.net" "149.112.112.112#dns.quad9.net" ];

			firewall = {
				enable = true;
				allowPing = true;
				# allowTCPPorts = [ ... ];
				# allowUDPPorts = [ .. ];
				logRefusedConnections = true;
				logRefusedPackets = true;

			};

			nftables = {
				enable = true;
			};
            bridges.br0.interfaces = [ "enp34s0" ];
            interfaces.br0.useDHCP = true;
            interfaces.enp34s0.useDHCP = false;
		};

		services.resolved = {
			enable = true;
			settings.Resolve = {
				DNSOverTLS= "true";
				DNSSEC = "true";
				FallbackDNS = [ "9.9.9.9#dns.quad9.net" "149.112.112.112#dns.quad9.net" ];
			};
		};

		boot.kernel.sysctl = {
			"net.ipv4.conf.all.rp_filter" = 1;
			"net.ipv4.conf.default.rp_filter" = 1;
			"net.ipv4.icmp_echo_ignore_broadcasts" = 1;
		};
	};
}
