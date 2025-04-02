{...}: {
  virtualisation.oci-containers.containers.qbittorrent = {
    image = "ghcr.io/hotio/qbittorrent";
    ports = [
      "8081:8080"
      "6881:6881"
    ];
    environment = {
      PUID = "1000";
      PGID = "1000";
      UMASK = "002";
      TZ = "Etc/UTC";
      WEBUI_PORTS = "8080/tcp,8080/udp";
    };
    volumes = [
      "/mnt/data/qbittorrent:/config"
      "/mnt:/mnt"
    ];
  };
}
