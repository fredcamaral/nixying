{...}: {
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.hyprlock = {};
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.sudo.wheelNeedsPassword = false;
}
