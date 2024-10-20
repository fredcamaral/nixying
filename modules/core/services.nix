{
  host,
  config,
  pkgs,
  ...
}: {
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    openssh.enable = true;
    blueman.enable = true;
    devmon.enable = true;
    locate.enable = true;
    locate.localuser = null;
    printing = {
      enable = true;
      drivers = with pkgs; [
        epson-escpr # Driver for Epson printers
        hplip # Driver for HP printers
        gutenprint # Additional high-quality printer drivers
      ];
      browsing = true;
      defaultShared = true;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish.enable = true;
    };

    #tailscale = {
    #  enable = true;
    #  authKeyFile =
    #    if (host == "megaman")
    #    then config.age.secrets.megaman-tailscale-auth.path
    #    else config.age.secrets.bomberman-tailscale-auth.path;
    #};
  };
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';
}
