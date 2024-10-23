{
  config,
  pkgs,
  lib,
  ...
}: let
  # Substitua com seu usuário
  username = "seu_usuario";
  homeDir = "/home/${username}";

  # Configurações comuns para montagem do rclone
  commonMountOptions = [
    "--vfs-cache-mode full"
    "--vfs-cache-max-age 24h"
    "--vfs-read-ahead 128M"
    "--buffer-size 32M"
    "--dir-cache-time 24h"
    "--timeout 1h"
    "--transfers 4"
    "--checkers 8"
  ];
in {
  # Instala o rclone
  environment.systemPackages = with pkgs; [
    rclone
    fuse
  ];

  # Configuração do rclone
  home-manager.users.${username} = {...}: {
    xdg.configFile."rclone/rclone.conf".text = ''
      # Primeira conta do Google Drive
      [drive1]
      type = drive
      client_id = seu_client_id_1
      client_secret = seu_client_secret_1
      scope = drive
      token = {"access_token":"seu_token_1","token_type":"Bearer","refresh_token":"seu_refresh_token_1","expiry":"data_expiracao_1"}
      team_drive =
      root_folder_id =

      # Segunda conta do Google Drive
      [drive2]
      type = drive
      client_id = seu_client_id_2
      client_secret = seu_client_secret_2
      scope = drive
      token = {"access_token":"seu_token_2","token_type":"Bearer","refresh_token":"seu_refresh_token_2","expiry":"data_expiracao_2"}
      team_drive =
      root_folder_id =
    '';
  };

  # Criação dos diretórios de montagem
  systemd.tmpfiles.rules = [
    "d ${homeDir}/gdrive1 0700 ${username} users -"
    "d ${homeDir}/gdrive2 0700 ${username} users -"
    "d ${homeDir}/.local/share/rclone 0700 ${username} users -"
  ];

  # Serviço para montar o primeiro Google Drive
  systemd.user.services.rclone-mount-drive1 = {
    description = "Mount Google Drive 1 with Rclone";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["default.target"];

    serviceConfig = {
      Type = "simple";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${homeDir}/gdrive1";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount \
          drive1: ${homeDir}/gdrive1 \
          ${lib.concatStringsSep " " commonMountOptions}
      '';
      ExecStop = "${pkgs.fuse}/bin/fusermount -u ${homeDir}/gdrive1";
      Restart = "on-failure";
      RestartSec = "10s";
      Environment = [
        "PATH=${lib.makeBinPath [pkgs.rclone pkgs.fuse]}"
      ];
    };
  };

  # Serviço para montar o segundo Google Drive
  systemd.user.services.rclone-mount-drive2 = {
    description = "Mount Google Drive 2 with Rclone";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["default.target"];

    serviceConfig = {
      Type = "simple";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${homeDir}/gdrive2";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount \
          drive2: ${homeDir}/gdrive2 \
          ${lib.concatStringsSep " " commonMountOptions}
      '';
      ExecStop = "${pkgs.fuse}/bin/fusermount -u ${homeDir}/gdrive2";
      Restart = "on-failure";
      RestartSec = "10s";
      Environment = [
        "PATH=${lib.makeBinPath [pkgs.rclone pkgs.fuse]}"
      ];
    };
  };

  # Serviço de sincronização periódica
  systemd.user.services.rclone-sync = {
    description = "Sync Google Drives with Rclone";
    startAt = "*:0/30"; # A cada 30 minutos

    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeScript "rclone-sync" ''
        #!${pkgs.bash}/bin/bash

        # Sincronização da primeira conta
        ${pkgs.rclone}/bin/rclone sync \
          ${homeDir}/local_pasta1 \
          drive1:pasta1 \
          --log-file=${homeDir}/.local/share/rclone/sync1.log

        # Sincronização da segunda conta
        ${pkgs.rclone}/bin/rclone sync \
          ${homeDir}/local_pasta2 \
          drive2:pasta2 \
          --log-file=${homeDir}/.local/share/rclone/sync2.log
      '';
    };
  };
}
