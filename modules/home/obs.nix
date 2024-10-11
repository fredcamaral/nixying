{
  config,
  pkgs,
  ...
}: {
  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vkcapture
        obs-gstreamer
        obs-multi-rtmp
      ];
    };
  };

  home.packages = with pkgs; [
    # Tools for iPad integration
    scrcpy # Display and control your Android device

    # Video editing tools
    kdenlive
    ffmpeg

    # Screen recording
    simplescreenrecorder

    # Image editing
    gimp
    inkscape
  ];
}
