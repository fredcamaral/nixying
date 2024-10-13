{
  pkgs,
  host,
  ...
}: {
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    nameservers = ["8.8.8.8" "8.8.4.4" "1.1.1.1"];
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443 59010 59011 631 7100 7000 7001];
      allowedUDPPorts = [59010 59011 631 5353 7011 6001 6000];
    };

    # wireless = {
    #   enable = true;
    #   networks = {
    #     "network" = {
    #       psk = "pwd";
    #     };
    #   };
    # };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
