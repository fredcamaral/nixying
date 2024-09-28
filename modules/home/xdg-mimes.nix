{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  defaultApps = {
    browser = ["zen.desktop"];
    text = ["org.gnome.TextEditor.desktop"];
    image = ["com.interversehq.qView.desktop"];
    audio = ["mpv.desktop"];
    video = ["mpv.desktop"];
    directory = [
      "nautilus.desktop"
      "org.gnome.Nautilus.desktop"
    ];
    office = ["libreoffice.desktop"];
    pdf = ["okular.desktop"];
    terminal = ["kitty.desktop"];
    archive = ["org.gnome.FileRoller.desktop"];
  };

  mimeMap = {
    text = ["text/plain"];
    image = [
      "image/bmp"
      "image/gif"
      "image/jpeg"
      "image/jpg"
      "image/png"
      "image/svg+xml"
      "image/tiff"
      "image/vnd.microsoft.icon"
      "image/webp"
    ];
    audio = [
      "audio/aac"
      "audio/mpeg"
      "audio/ogg"
      "audio/opus"
      "audio/wav"
      "audio/webm"
      "audio/x-matroska"
    ];
    video = [
      "video/mp2t"
      "video/mp4"
      "video/mpeg"
      "video/ogg"
      "video/webm"
      "video/x-flv"
      "video/x-matroska"
      "video/x-msvideo"
    ];
    directory = ["inode/directory"];
    browser = [
      "text/html"
      "x-scheme-handler/about"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/unknown"
    ];
    office = [
      "application/vnd.oasis.opendocument.text"
      "application/vnd.oasis.opendocument.spreadsheet"
      "application/vnd.oasis.opendocument.presentation"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      "application/msword"
      "application/vnd.ms-excel"
      "application/vnd.ms-powerpoint"
      "application/rtf"
    ];
    pdf = ["application/pdf"];
    terminal = ["terminal"];
    archive = [
      "application/zip"
      "application/rar"
      "application/7z"
      "application/*tar"
    ];
  };

  associations = with lists;
    listToAttrs (
      flatten (mapAttrsToList (key: map (type: attrsets.nameValuePair type defaultApps."${key}")) mimeMap)
    );
in {
  xdg = {
    # Enable XDG Base Directory specification
    enable = true;

    # Force creation of the mimeapps.list file
    configFile."mimeapps.list".force = true;

    mimeApps.enable = true;
    mimeApps.associations.added = associations;
    mimeApps.defaultApplications = associations;

    # Configure XDG user directories
    userDirs = {
      enable = true;

      # Set custom paths for XDG directories
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
    };
  };

  home.packages = with pkgs; [junction];

  home.sessionVariables = {
    # prevent wine from creating file associations
    WINEDLLOVERRIDES = "winemenubuilder.exe=d";
  };
}
