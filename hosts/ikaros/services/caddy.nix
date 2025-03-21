{pkgs, ...}: {
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
        reverse_proxy http://localhost:8080

        @robot {
            header User-Agent *bot*
            header User-Agent *spider*
            header User-Agent *ai*
            header_regexp ua (?i)(AdsBot-Google|Amazonbot|anthropic-ai|Applebot|Applebot-Extended|AwarioRssBot|AwarioSmartBot|Bytespider)
            not path /robots.txt
        }
        handle @robot {
            file_server {
                root /mnt/data/Backup
            }
            rewrite * /capital.txt
        }
      '';
      "pwned.page".extraConfig = ''
        encode gzip
        file_server
        root * /var/www/pwned.page/

        @robot {
            header User-Agent *bot*
            header User-Agent *spider*
            header User-Agent *ai*
            header_regexp ua (?i)(AdsBot-Google|Amazonbot|anthropic-ai|Applebot|Applebot-Extended|AwarioRssBot|AwarioSmartBot|Bytespider)
            not path /robots.txt
        }
        handle @robot {
            file_server {
                root /mnt/data/Backup
            }
            rewrite * /capital.txt
        }
      '';
      "rimgo.pwned.page".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:3000

        @robot {
            header User-Agent *bot*
            header User-Agent *spider*
            header User-Agent *ai*
            header_regexp ua (?i)(AdsBot-Google|Amazonbot|anthropic-ai|Applebot|Applebot-Extended|AwarioRssBot|AwarioSmartBot|Bytespider)
            not path /robots.txt
        }
        handle @robot {
            file_server {
                root /mnt/data/Backup
            }
            rewrite * /capital.txt
        }
      '';
      "yt.pwned.page".extraConfig = ''
        encode gzip
        reverse_proxy http://localhost:1234

        @robot {
            header User-Agent *bot*
            header User-Agent *spider*
            header User-Agent *ai*
            header_regexp ua (?i)(AdsBot-Google|Amazonbot|anthropic-ai|Applebot|Applebot-Extended|AwarioRssBot|AwarioSmartBot|Bytespider)
            not path /robots.txt
        }
        handle @robot {
            file_server {
                root /mnt/data/Backup
            }
            rewrite * /capital.txt
        }
      '';
    };
  };
}
