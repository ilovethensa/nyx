{inputs, ...}: {
  imports = [inputs.impermanence.nixosModules.impermanence];
  environment.persistence."/nix/persist" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/systemd/coredump"
      "/var/lib/docker"
      "/etc/ssh"
      "/var/lib/caddy"
      "/var/www"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
