{
  pkgs,
  inputs,
  username,
  host,
  ...
}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.${username} = {
      isNormalUser = true;
      description = "${username}";
      home = "/home/${username}";
      createHome = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "power"
        "qemu"
        "kvm"
        "libvirtd"
        "docker"
        "networkmanager"
        "qemu-libvirtd"
      ];
      shell = pkgs.zsh;
    };
  };

  security.sudo.wheelNeedsPassword = false;
}
