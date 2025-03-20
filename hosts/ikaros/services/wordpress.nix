{pkgs, ...}: {
  services.wordpress.sites."192.168.1.111" = {
    themes = {
      inherit (pkgs.wordpressPackages.themes) twentytwentythree;
    };
    plugins = {
      inherit (pkgs.wordpressPackages.plugins) antispam-bee opengraph;
    };
  };
  services.mysql.dataDir = "/mnt/data/mysql";
}
