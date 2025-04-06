{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../../modules/nixos/anubis.nix
  ];
  services.anubis = {
    defaultOptions = {
      user = "caddy";
      settings = {
        DIFFICULTY = 5;
        SERVE_ROBOTS_TXT = true;
      };
    };
    instances = {
      libreddit.settings.TARGET = "http://localhost:8080";
      rimgo.settings.TARGET = "http://localhost:3000";
      invidious.settings.TARGET = "http://localhost:1234";
    };
  };
  services.caddy = {
    enable = true;
    virtualHosts = {
      "automate.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:5678
      '';
      "git.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:3333
      '';
      "notes.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:6806
      '';
      "request.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:5055
      '';
      "rss.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:8082
      '';
      "smarthome.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:8123
      '';
      "watch.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:8096
      '';
      "lr.pwned.page".extraConfig = ''
        encode gzip
        reverse_proxy unix/${config.services.anubis.instances.libreddit.settings.BIND}{
          header_up X-Real-Ip {remote_host}
        }
      '';
      "pwned.page".extraConfig = ''
        encode gzip
        file_server
        root * /var/www/pwned.page/
      '';
      "rimgo.pwned.page".extraConfig = ''
        encode gzip
        reverse_proxy unix/${config.services.anubis.instances.rimgo.settings.BIND}{
          header_up X-Real-Ip {remote_host}
        }
      '';
      "yt.pwned.page".extraConfig = ''
        encode gzip
        reverse_proxy unix/${config.services.anubis.instances.invidious.settings.BIND} {
          header_up X-Real-Ip {remote_host}
        }
      '';
      "192.168.1.111".extraConfig = ''
        encode gzip
        file_server {
          root /var/www/status
        }
      '';
    };
  };
  systemd.services.goaccess = {
    description = "GoAccess Real-Time Log Analyzer";
    after = ["network.target" "caddy.service"];
    wants = ["caddy.service"];
    serviceConfig = {
      ExecStart = "${pkgs.goaccess}/bin/goaccess /var/log/caddy/*.log -o /var/www/status/index.html --log-format=CADDY --real-time-html";
      Restart = "always";
      User = "root";
      Group = "root";
    };
  };
}
