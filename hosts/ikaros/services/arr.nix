{...}: {
  virtualisation.oci-containers.containers.sonarr = {
    image = "ghcr.io/hotio/sonarr";
    ports = ["8989:8989"];
    environment = {
      PUID = "1000";
      PGID = "1000";
      UMASK = "002";
      TZ = "Etc/UTC";
    };
    volumes = [
      "/mnt/data/sonarr:/config"
      "/mnt:/mnt"
    ];
  };

  virtualisation.oci-containers.containers.radarr = {
    image = "ghcr.io/hotio/radarr";
    ports = ["7878:7878"];
    environment = {
      PUID = "1000";
      PGID = "1000";
      UMASK = "002";
      TZ = "Etc/UTC";
    };
    volumes = [
      "/mnt/data/radarr:/config"
      "/mnt:/mnt"
    ];
  };

  virtualisation.oci-containers.containers.prowlarr = {
    image = "ghcr.io/hotio/prowlarr";
    ports = ["9696:9696"];
    environment = {
      PUID = "1000";
      PGID = "1000";
      UMASK = "002";
      TZ = "Etc/UTC";
    };
    volumes = [
      "/mnt/data/prowlarr:/config"
    ];
  };

  virtualisation.oci-containers.containers.bazarr = {
    image = "ghcr.io/hotio/bazarr";
    ports = ["6767:6767"];
    environment = {
      PUID = "1000";
      PGID = "1000";
      UMASK = "002";
      TZ = "Etc/UTC";
      WEBUI_PORTS = "6767/tcp,6767/udp";
    };
    volumes = [
      "/mnt/data/bazarr:/config"
      "/mnt:/mnt"
    ];
  };
}
