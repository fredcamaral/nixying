{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    networkmanagerapplet
    font-manager
    okular
    clipman # clipboard manager
    kdePackages.kdenlive
    cliphist # clipboard manager
    eza # ls replacement
    entr # perform action when file change
    fd # find replacement
    ffmpeg
    file # Show file information
    gtrash # rm replacement, put deleted files in system trash
    hexdump
    imv # image viewer
    killall
    lazygit
    lazydocker
    libnotify
    man-pages # extra man pages
    openssl
    onefetch # fetch utility for git repo
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
    bleachbit # cache cleaner
    libreoffice
    nix-prefetch-github
    pavucontrol # pulseaudio volume controle (GUI)
    qalculate-gtk # calculator
    vlc
    python3
    age # Tool for encrypting files
    go # Go programming language
    go-tools # Go programming language
    gopls # Go programming language
    cmake # Cross-platform make
    pigz # Parallel implementation of gzip for faster compression
    unrar # Extraction utility for RAR archives
    unzip # Extraction utility for ZIP archives
    zip # Compressor/archiver for creating and modifying ZIP files
    devenv # Development environment management tool for Nix
    electron # Framework for building cross-platform desktop applications with web technologies
    gcc # GNU Compiler Collection for various programming languages
    gnumake # Build automation tool
    grex # Command-line tool for generating regular expressions from user-provided test cases
    hyperfine # Command-line benchmarking tool
    nix-direnv # Fast loader and flake-aware nix-shell replacement for direnv
    qbittorrent # Feature-rich BitTorrent client
    zfs # OpenZFS implementation for Linux
    zfsnap # Automatic snapshot manager for ZFS
    zfstools # Additional utilities for OpenZFS administration
    logitech-udev-rules # Udev rules for Logitech devices
    solaar # Device manager for Logitech peripherals
    feh # Lightweight and fast image viewer
    ffmpeg # Complete solution to record, convert and stream audio and video
    curl # Command-line tool for transferring data using various protocols
    ethtool # Utility for controlling network drivers and hardware
    nmap # Network exploration tool and security scanner
    tcpdump # Powerful command-line packet analyzer
    nix-tree # Interactively browse dependency graphs of Nix derivations
    nixpkgs-fmt # Nix code formatter for nixpkgs
    calibre # E-book management application
    bash # GNU Bourne-Again Shell
    lsof # Utility to list open files
    stress # Tool to impose load on and stress test systems
    du-dust # More intuitive version of du written in Rust
    duf # Disk Usage/Free Utility with colorful output
    fd # Simple, fast alternative to 'find'
    file # Utility to determine file types
    gparted # Graphical disk partitioning tool
    iotop # I/O monitoring tool
    lm_sensors # Tools for reading hardware sensors
    lshw # Hardware lister to provide detailed information on the hardware configuration
    neofetch # Fast, highly customizable system info script
    pciutils # Set of programs for inspecting and manipulating configuration of PCI devices
    smartmontools # Tools for monitoring and controlling S.M.A.R.T. enabled hard drives
    usbutils # USB utilities (such as lsusb)
    gvfs # Virtual filesystem implementation for GIO
    kio-fuse # FUSE support for KIO
    pulseaudioFull # Sound server for POSIX and Win32 systems
    vimix-icon-theme # Icon theme for Linux
    wirelesstools # Tools for setting up wireless networking
    bandwhich # Terminal bandwidth utilization tool
    code2prompt # Generate command descriptions for AI assistants
    eva # Simple calculator REPL
    fio # Flexible I/O Tester for benchmarking and stress-testing
    moreutils # Growing collection of the unix tools that nobody thought to write long ago
    sd # Intuitive find & replace CLI tool
    docker_27 # Platform for developing, shipping, and running applications in containers
    kubectl # Command-line tool for controlling Kubernetes clusters
    kubernetes-helm # Package manager for Kubernetes
    minikube # Tool that makes it easy to run Kubernetes locally

    inputs.alejandra.defaultPackage.${system}
    inputs.zen-browser.packages."${system}".specific
  ];
}
