{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../nix/users.nix
    ../../nix/common.nix
    ../../nix/boot.nix
    ../../nix/comin.nix
    ./persist.nix
    ./services/caddy.nix
    ./services/postgres.nix
    ./services/n8n.nix
    ./services/homeassistant.nix
    ./services/jellyfin.nix
    ./services/qbittorrent.nix
    ./services/arr.nix
    ./services/jellyseerr.nix
    ./services/redlib.nix
    ./services/rimgo.nix
    ./services/invidious.nix
    ./services/rgit.nix
    ./services/miniflux.nix
  ];

  networking = {
    hostName = "ikaros";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time.timeZone = "Europe/Sofia";

  virtualisation.oci-containers.backend = "docker";

  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "yes";
  };

  system.stateVersion = "24.11";
}
