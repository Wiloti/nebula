{ ... }: {
  flake.nixosModules.voidVirtualization = { pkgs, lib, config, ... }: {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
      allowedBridges = [ "virbr1" ];
    };

    programs.virt-manager.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    environment.etc."libvirt/lab-network.xml".text = ''
      <network>
        <name>lab</name>
        <bridge name="virbr1"/>
        <domain name="lab"/>
        <ip address="192.168.100.1" netmask="255.255.255.0">
          <dhcp>
            <range start="192.168.100.100" end="192.168.100.200"/>
          </dhcp>
        </ip>
      </network>
    '';
    environment.etc."libvirt/vms-pool.xml".text = ''
      <pool type="dir">
        <name>vms</name>
        <target>
          <path>/home/wiloti/vms</path>
        </target>
      </pool>
    '';

    virtualisation.containers.enable = true;
    virtualisation = {
      podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      storageDriver = "overlay2";
    };
    environment.systemPackages = with pkgs; [
      podman-compose
      podman-tui
      virtiofsd
      virt-viewer
    ];
  };
}
