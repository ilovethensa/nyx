{...}: {
  virtualisation.oci-containers.containers.n8n = {
    image = "docker.n8n.io/n8nio/n8n";
    autoStart = true;
    ports = ["5678:5678"];
    environment = {
      DB_TYPE = "postgresdb";
      DB_POSTGRESDB_DATABASE = "n8n";
      DB_POSTGRESDB_HOST = "localhost";
      DB_POSTGRESDB_PORT = "5432"; # Default PostgreSQL port
      DB_POSTGRESDB_USER = "n8n";
      DB_POSTGRESDB_PASSWORD = "n8n";
      N8N_RUNNERS_ENABLED = "true";
      WEBHOOK_URL = "https://automate.theholytachanka.com";
    };
    volumes = [
      "n8n_data:/home/node/.n8n"
    ];
    extraOptions = [
      # Use the host network namespace for all sockets
      "--network=host"
    ];
  };
}
