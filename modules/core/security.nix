{...}: {
  security.rtkit.enable = true;
  security.sudo.enable = true;
  security.pam.zfs.enable = true;
  security.pam.services.hyprlock = {};
}
