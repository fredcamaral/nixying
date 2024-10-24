{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull # Wine is a compatibility layer for running Windows applications on Linux
    woeusb # USB image writer
    google-chrome # Google Chrome web browser
    cifs-utils # Utilities for managing CIFS/SMB file systems
    libsForQt5.partitionmanager
    vscode
    mpv # Media player

    # System utilities
    age # Simple, modern file encryption tool
    atac # Advanced top-like utility for system monitoring
    bandwhich # Terminal bandwidth utilization tool
    bash # GNU Bourne-Again Shell
    blueman # Bluetooth manager for GNOME
    curl # Command-line tool for transferring data using various protocols
    du-dust # More intuitive version of du written in Rust
    duf # Disk Usage/Free Utility with colorful output
    fd # Simple, fast alternative to 'find'
    file # Utility to determine file types
    font-manager # Font management application
    gcc # GNU Compiler Collection for various programming languages
    gnumake # Build automation tool
    gparted # Graphical disk partitioning tool
    home-manager # Nix-based user environment management
    hyperfine # Command-line benchmarking tool
    libnotify # Library for sending desktop notifications
    lm_sensors # Tools for reading hardware sensors
    logitech-udev-rules # Udev rules for Logitech devices
    lshw # Hardware lister to provide detailed information on the hardware configuration
    lsof # Utility to list open files
    man-pages # Extra man pages for Linux
    moreutils # Growing collection of the unix tools that nobody thought to write long ago
    ncdu # Disk usage analyzer with ncurses interface
    nmap # Network exploration tool and security scanner
    openssl # Cryptography and SSL/TLS toolkit
    pamixer # PulseAudio command-line mixer
    pciutils # Set of programs for inspecting and manipulating configuration of PCI devices
    pigz # Parallel implementation of gzip for faster compression
    playerctl # Media player controller and library
    ripgrep # Fast search tool (grep replacement)
    solaar # Device manager for Logitech peripherals
    stress # Tool to impose load on and stress test systems
    tldr # Simplified and community-driven man pages
    unrar # Extraction utility for RAR archives
    unzip # Extraction utility for ZIP archives
    usbutils # USB utilities (such as lsusb)
    wget # Network utility to retrieve files from the Web
    xdg-utils # Tools for desktop integration
    zip # Compressor/archiver for creating and modifying ZIP files

    # Development tools
    devenv # Development environment management tool for Nix
    electron_32 # Framework for building cross-platform desktop applications with web technologies
    nix-direnv # Fast loader and flake-aware nix-shell replacement for direnv
    nix-tree # Interactively browse dependency graphs of Nix derivations
    postman # API development environment

    # Terminal utilities
    eza # Modern replacement for ls
    lazydocker # Simple terminal UI for docker commands
    wl-clipboard # Clipboard utilities for Wayland
    yazi # Terminal file manager

    # Graphical applications
    clipman # Clipboard manager
    feh # Lightweight and fast image viewer
    okular # Universal document viewer
    pavucontrol # PulseAudio volume control (GUI)
    qalculate-gtk # Feature-rich desktop calculator
    qview # Minimal image viewer
    todoist-electron # Electron-based Todoist client
    vlc # Multimedia player and framework
    zoom-us # Video conferencing tool

    # Programming languages and runtimes
    python3 # Python programming language interpreter

    # Compression tools
    bzip2 # High-quality data compressor
    bzip3 # Improved compression algorithm

    # Virtualization and containerization
    docker_27 # Platform for developing, shipping, and running applications in containers
    docker-compose

    # File system and storage
    gvfs # Virtual filesystem implementation for GIO
    kio-fuse # FUSE support for KIO

    # Theming and customization
    vimix-icon-theme # Icon theme for Linux

    # Custom inputs
    inputs.alejandra.defaultPackage.${system}
    # inputs.nixvim.packages.${system}
    # inputs.zen-browser.packages.${system}.specific
  ];
}
