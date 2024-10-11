{
  config,
  pkgs,
  ...
}: {
  # Your existing configuration...

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      epson-escpr # Driver for Epson printers
      hplip # Driver for HP printers
      gutenprint # Additional high-quality printer drivers
    ];
    browsing = true;
    defaultShared = true;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  # Enable HPLIP for extended HP printer functionality
  services.hplip.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [631];
    allowedUDPPorts = [631];
  };
}
