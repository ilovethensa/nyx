{pkgs, ...}: let
  wordpress-activitypub = pkgs.stdenv.mkDerivation rec {
    name = "activitypub";
    version = "5.5.0";
    src = pkgs.fetchzip {
      url = "https://downloads.wordpress.org/plugin/${name}.${version}.zip";
      hash = "sha256-t54YfwXVLfvOJwW84p6zTu9dDpjss5PPgHHZvYUXgg8=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };
  wordpress-quotes-llama = pkgs.stdenv.mkDerivation rec {
    name = "quotes-llama";
    version = "3.1.1";
    src = pkgs.fetchzip {
      url = "https://downloads.wordpress.org/plugin/${name}.${version}.zip";
      hash = "sha256-jsl87E38hDO90JgbbWfSrb8gIJYi5ZY+T1g1murZRew=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };

  wordpress-webfinger = pkgs.stdenv.mkDerivation rec {
    name = "webfinger";
    version = "3.2.7";
    src = pkgs.fetchzip {
      url = "https://downloads.wordpress.org/plugin/${name}.${version}.zip";
      hash = "sha256-4zd8o6+zv7ywoD931ktR8k187VvDSYqVWTAbRaoZsDM=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };
  wordpress-norrsken = pkgs.stdenv.mkDerivation rec {
    name = "norrsken";
    version = "1.0.8";
    src = pkgs.fetchzip {
      url = "https://downloads.wordpress.org/theme/${name}.${version}.zip";
      hash = "sha256-47U386H8UrPbHKy2XKOEz2hGaPUV84k+XXfhnjfv+bY=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };
  wordpress-stockpack = pkgs.stdenv.mkDerivation rec {
    name = "stockpack";
    version = "3.4.6";
    src = pkgs.fetchzip {
      url = "https://downloads.wordpress.org/plugin/${name}.${version}.zip";
      hash = "sha256-/v/MzHDLAKQXPTAU2BTXbDNOT7kyLVWfbuwE5N2m8KQ=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };
in {
  imports = [
    ../../../modules/nixos/wordpress-new.nix
  ];
  services.wordpress-new = {
    webserver = "caddy";
    sites."theholytachanka.com" = {
      database.createLocally = true;
      virtualHost.addSSL = true;
      themes = {
        inherit wordpress-norrsken;
      };
      plugins = {
        inherit wordpress-activitypub wordpress-stockpack wordpress-webfinger wordpress-quotes-llama;
      };
      settings = {
        WP_DEFAULT_THEME = "norrsken";
        WP_SITEURL = "https://theholytachanka.com";
        WP_HOME = "https://theholytachanka.com";
        AUTOMATIC_UPDATER_DISABLED = true;
      };
    };
  };
  services.mysql.dataDir = "/mnt/data/mysql";
}
