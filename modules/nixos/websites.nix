{
  config,
  lib,
  pkgs,
  ...
}: let
  websites = config.websites or {};

  # Filter sites with anubis enabled.
  anubisSites = lib.filterAttrs (_: site: site.anubis) websites;
in {
  options.websites = lib.mkOption {
    type = lib.types.attrsOf (lib.types.attrs {
      root = lib.types.str;
      anubis = lib.types.bool;
    });
    default = {};
    description = "Websites configuration for Anubis or direct reverse proxy.";
  };

  config = lib.mkIf (websites != {}) {
    # Only add Anubis service instances if there's at least one site with anubis enabled.
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

    # For every website, create extraConfig based on whether anubis is enabled.
    websites =
      lib.mapAttrs (domain: site: {
        extraConfig =
          if site.anubis
          then ''
            encode gzip
            reverse_proxy unix/${config.services.anubis.instances.${domain}.settings.BIND}{
              header_up X-Real-Ip {remote_host}
            }
          ''
          else ''
            encode gzip
            reverse_proxy http://${site.root}
          '';
      })
      websites;
  };
}
