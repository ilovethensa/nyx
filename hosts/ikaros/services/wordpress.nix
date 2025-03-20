{pkgs, ...}: {
  services.wordpress-new = {
    webserver = "caddy";
    sites."theholytachanka.com" = {
      database.createLocally = true;
      virtualHost.addSSL = true;
      themes = {
        inherit (pkgs.wordpressPackages.themes) twentytwentythree;
      };
      plugins = {
        inherit (pkgs.wordpressPackages.plugins) antispam-bee opengraph;
      };
      settings = {
        WP_DEFAULT_THEME = "twentytwentytwo";
        WP_SITEURL = "https://theholytachanka.com";
        WP_HOME = "https://theholytachanka.com";
        WP_DEBUG = true;
        WP_DEBUG_DISPLAY = true;
        AUTOMATIC_UPDATER_DISABLED = true;
      };
    };
  };
  services.mysql.dataDir = "/mnt/data/mysql";
}
