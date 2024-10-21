{
  config,
  pkgs,
  username,
  ...
}: {
  # Add user to libvirtd group
  users.users.${username}.extraGroups = ["libvirtd"];

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    virglrenderer # For 3D acceleration in VMs
    qemu # Machine emulator and virtualizer
    spice # Remote computing solution
    spice-gtk # GTK client and libraries for SPICE remote desktop servers
    spice-protocol # SPICE protocol headers
    virt-manager # Desktop user interface for managing virtual machines
    virt-viewer # Graphical viewer for the guest OS display
    win-spice # Windows guest agent for SPICE protocol
    win-virtio # Windows guest drivers for QEMU virtual machines
    OVMF # UEFI firmware for QEMU
    adwaita-icon-theme
  ];

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_full;
        runAsRoot = false;
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
        # Enable VirtIO-FS for better shared folder performance
        verbatimConfig = ''
          user = "${config.users.users.fredamaral.name}"
          group = "kvm"
          cgroup_device_acl = [
              "/dev/null", "/dev/full", "/dev/zero",
              "/dev/random", "/dev/urandom",
              "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
              "/dev/rtc","/dev/hpet"
          ]
        '';
      };
    };

    docker = {
      enable = true;
      rootless.enable = true;
      rootless.setSocketVariable = true;
      # autoPrune.enable = true;
    };

    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}
