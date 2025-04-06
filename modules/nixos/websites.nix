{
  config,
  lib,
  pkgs,
  ...
}: let
  # Load Anubis module
  anubisModule = import ./anubis.nix;
  # Get the websites config from the user
  websites = config.websites;
  # Filter out sites with anubis = true
  anubisSites = lib.filterAttrs (_: site: site.anubis) websites;
in {
  imports = [anubisModule];

  options.websites = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        root = lib.mkOption {
          type = lib.types.str;
          description = "Target root address (domain or socket).";
        };
        anubis = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable Anubis reverse proxy for this site.";
        };
        extraConfig = lib.mkOption {
          type = lib.types.lines;
          default = "";
          description = "Additional Caddy configuration.";
        };
      };
    });
    default = {};
    description = "List of websites and reverse proxy settings.";
  };

  config = {
    # Configure Anubis if any sites use it
    services = lib.mkIf (anubisSites != {}) {
      anubis = {
        enable = true;
        instances =
          lib.mapAttrs (domain: site: {
            settings.TARGET = site.root;
          })
          anubisSites;
      };
    };

    # Generate the extraConfig for each website without recursion
    websites =
      lib.mapAttrs (domain: site: {
        extraConfig = lib.mkDefault (
          if site.anubis
          then ''
            encode gzip
            reverse_proxy unix/${"/run/anubis/" + domain + ".sock"} {
              header_up X-Real-Ip {remote_host}
            }
          ''
          else ''
            encode gzip
            reverse_proxy http://${site.root}
          ''
        );
      })
      websites;
  };
}
