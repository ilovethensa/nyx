{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    dataDir = "/mnt/data/postgres";
    ensureDatabases = ["n8n" "general"];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host  all       all     127.0.0.1/32   trust
      host  all       all     ::1/128        trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE USER n8n WITH PASSWORD 'n8n';

      CREATE DATABASE n8n OWNER n8n;

      CREATE DATABASE general OWNER n8n;

      GRANT ALL PRIVILEGES ON DATABASE n8n TO n8n;
      GRANT ALL PRIVILEGES ON DATABASE general TO n8n;

    '';
  };
}
