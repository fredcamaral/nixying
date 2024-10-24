{pkgs, ...}: let
  # Wallpaper and theme related
  wall-change = pkgs.writeShellScriptBin "wall-change" (builtins.readFile ./scripts/wall-change.sh);
  wallpaper-picker = pkgs.writeShellScriptBin "wallpaper-picker" (builtins.readFile ./scripts/wallpaper-picker.sh);

  # Media and background processes
  runbg = pkgs.writeShellScriptBin "runbg" (builtins.readFile ./scripts/runbg.sh);
  music = pkgs.writeShellScriptBin "music" (builtins.readFile ./scripts/music.sh);
  lofi = pkgs.writeScriptBin "lofi" (builtins.readFile ./scripts/lofi.sh);

  # Git utilities
  git-pull-all = pkgs.writeScriptBin "git-pull-all" (builtins.readFile ./scripts/git-pull-all.sh);
  git-pull-all-conc = pkgs.writeScriptBin "git-pull-all-conc" (builtins.readFile ./scripts/git-pull-all-conc.sh);
  git-stats = pkgs.writeScriptBin "git-stats" (builtins.readFile ./scripts/git-stats.sh);
  git-standup = pkgs.writeScriptBin "git-standup" (builtins.readFile ./scripts/git-standup.sh);

  # System utilities
  waybar-restart = pkgs.writeScriptBin "waybar-restart" (builtins.readFile ./scripts/waybar-restart.sh);
  system-health = pkgs.writeScriptBin "system-health" (builtins.readFile ./scripts/system-health.sh);
  code-backup = pkgs.writeScriptBin "code-backup" (builtins.readFile ./scripts/code-backup.sh);

  # UI toggles
  toggle_blur = pkgs.writeScriptBin "toggle_blur" (builtins.readFile ./scripts/toggle_blur.sh);
  toggle_oppacity = pkgs.writeScriptBin "toggle_oppacity" (builtins.readFile ./scripts/toggle_oppacity.sh);
  toggle_waybar = pkgs.writeScriptBin "toggle_waybar" (builtins.readFile ./scripts/toggle_waybar.sh);

  # System information
  maxfetch = pkgs.writeScriptBin "maxfetch" (builtins.readFile ./scripts/maxfetch.sh);

  # File operations
  compress = pkgs.writeScriptBin "compress" (builtins.readFile ./scripts/compress.sh);
  extract = pkgs.writeScriptBin "extract" (builtins.readFile ./scripts/extract.sh);

  # System management
  shutdown-script = pkgs.writeScriptBin "shutdown-script" (builtins.readFile ./scripts/shutdown-script.sh);
  show-keybinds = pkgs.writeScriptBin "show-keybinds" (builtins.readFile ./scripts/keybinds.sh);
  vm-start = pkgs.writeScriptBin "vm-start" (builtins.readFile ./scripts/vm-start.sh);

  # Misc utilities
  ascii = pkgs.writeScriptBin "ascii" (builtins.readFile ./scripts/ascii.sh);
  record = pkgs.writeScriptBin "record" (builtins.readFile ./scripts/record.sh);

  # Power management
  rofi-power-menu = pkgs.writeScriptBin "rofi-power-menu" (builtins.readFile ./scripts/rofi-power-menu.sh);
  power-menu = pkgs.writeScriptBin "power-menu" (builtins.readFile ./scripts/power-menu.sh);
in {
  home.packages = with pkgs; [
    wall-change
    wallpaper-picker
    runbg
    music
    lofi
    waybar-restart
    git-pull-all
    git-pull-all-conc
    git-stats
    git-standup
    toggle_blur
    toggle_oppacity
    toggle_waybar
    maxfetch
    compress
    extract
    shutdown-script
    show-keybinds
    vm-start
    ascii
    record
    system-health
    code-backup
    rofi-power-menu
    power-menu
  ];
}
