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
        obs-ndi
      ];
    };
  };

  home.packages = with pkgs; [
    scrcpy # Display and control your Android device
    uxplay # Airplay screen mirroring
    v4l-utils # For webcam control
    guvcview # Webcam tuning
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gstreamer
    gst_all_1.gst-vaapi
    kdenlive
    ffmpeg
    gimp
    inkscape
  ];
}
