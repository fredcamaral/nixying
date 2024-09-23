{...}: {
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    openssh.enable = true;
    printing.enable = true;

    # Enable Tailscale VPN
    # tailscale = {
    #   enable = true;
    #   authKeyFile = config.age.secrets.megaman-tailscale-auth.path;
    # };

    # navidrome = {
    #   enable = true;
    #   openFirewall = true;
    #   settings = {
    #     Port = 4533;
    #     MusicFolder = "/media/limbo/music";
    #     DataFolder = "/media/limbo/navidrome/data";
    #     CacheFolder = "/media/limbo/navidrome/cache";
    #     EnableExternalServices = true;
    #   };
    # };
  };
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';
}
