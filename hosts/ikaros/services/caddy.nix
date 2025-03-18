{pkgs, ...}: {
  services.caddy = {
    enable = true;
    virtualHosts = {
      "theholytachanka.com".extraConfig = ''
        encode gzip
        file_server
        root * /var/www/theholytachanka.com/
      '';
      "pwned.page".extraConfig = ''
        encode gzip
        file_server
        root * /var/www/pwned.page/
      '';
      "automate.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:5678
      '';
      "smarthome.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:8123
      '';
      "request.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:5055
      '';
      "lr.pwned.page".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:8080
      '';
      "rimgo.pwned.page".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:3000
      '';
      "watch.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:8096
      '';
      "yt.pwned.page".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:1234
      '';
      "notes.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:6806
      '';
      "git.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:3333
      '';
      "rss.theholytachanka.com".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:8082
      '';
    };
  };
}
