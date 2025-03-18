{...}: {
  virtualisation.oci-containers.containers.jellyfin = {
    image = "ghcr.io/hotio/jellyfin";
    ports = ["8096:8096"];
    environment = {
      PUID = "1000";
      PGID = "1000";
      UMASK = "002";
      TZ = "Etc/UTC";
    };
    volumes = [
      "/mnt/data/jellyfin:/config"
      "/mnt/:/mnt"
    ];
    extraOptions = ["--device=/dev/dri:/dev/dri"];
  };
}
