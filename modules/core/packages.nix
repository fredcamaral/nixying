# system/modules/packages.nix
{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bolt # CLI tool for managing NixOS configurations
    blueman
    todoist-electron
    zoom-us
    bzip3
    bzip2
    home-manager
    font-manager
    okular
    clipman # clipboard manager
    eza # ls replacement
    lazygit
    lazydocker
    libnotify
    man-pages # extra man pages
    openssl
    pamixer # pulseaudio command line mixer
    playerctl # controller for media players
    qview # minimal image viewer
    ripgrep # grep replacement
    tldr
    unzip
    wl-clipboard # clipboard utils for wayland (wl-copy, wl-paste)
    wget
    yazi # terminal file manager
    xdg-utils
    libreoffice
    pavucontrol # pulseaudio volume controle (GUI)
    qalculate-gtk # calculator
    vlc
    python3
    age # Tool for encrypting files
    pigz # Parallel implementation of gzip for faster compression
    unrar # Extraction utility for RAR archives
    unzip # Extraction utility for ZIP archives
    zip # Compressor/archiver for creating and modifying ZIP files
    devenv # Development environment management tool for Nix
    electron # Framework for building cross-platform desktop applications with web technologies
    gcc # GNU Compiler Collection for various programming languages
    gnumake # Build automation tool
    hyperfine # Command-line benchmarking tool
    nix-direnv # Fast loader and flake-aware nix-shell replacement for direnv
    qbittorrent # Feature-rich BitTorrent client
    logitech-udev-rules # Udev rules for Logitech devices
    solaar # Device manager for Logitech peripherals
    feh # Lightweight and fast image viewer
    curl # Command-line tool for transferring data using various protocols
    nmap # Network exploration tool and security scanner
    nix-tree # Interactively browse dependency graphs of Nix derivations
    calibre # E-book management application
    bash # GNU Bourne-Again Shell
    lsof # Utility to list open files
    stress # Tool to impose load on and stress test systems
    du-dust # More intuitive version of du written in Rust
    duf # Disk Usage/Free Utility with colorful output
    fd # Simple, fast alternative to 'find'
    file # Utility to determine file types
    gparted # Graphical disk partitioning tool
    lm_sensors # Tools for reading hardware sensors
    lshw # Hardware lister to provide detailed information on the hardware configuration
    neofetch # Fast, highly customizable system info script
    pciutils # Set of programs for inspecting and manipulating configuration of PCI devices
    usbutils # USB utilities (such as lsusb)
    gvfs # Virtual filesystem implementation for GIO
    kio-fuse # FUSE support for KIO
    vimix-icon-theme # Icon theme for Linux
    bandwhich # Terminal bandwidth utilization tool
    moreutils # Growing collection of the unix tools that nobody thought to write long ago
    docker_27 # Platform for developing, shipping, and running applications in containers

    inputs.alejandra.defaultPackage.${system}
    inputs.zen-browser.packages.${system}.specific
    inputs.nixvim.packages.${system}.default
  ];
}
