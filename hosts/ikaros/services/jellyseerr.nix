{...}: {
  virtualisation.oci-containers.containers.jellyseerr = {
    image = "fallenbagel/jellyseerr:2.5.1";
    ports = ["5055:5055"];
    environment = {
      LOG_LEVEL = "debug";
      TZ = "Europe/Sofia";
    };
    volumes = [
      "/mnt/data/jellyseerr:/app/config"
    ];
  };
}
