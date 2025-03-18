{
  config,
  pkgs,
  ...
}: {
  virtualisation.oci-containers.containers.rgit = {
    image = "ghcr.io/w4/rgit:nightly";
    ports = ["3333:8000"];
    volumes = [
      "/mnt/data/git:/git"
    ];
    environment = {
      PUID = "1000";
      PGID = "1000";
      UMASK = "002";
      TZ = "Etc/UTC";
    };
    autoStart = true; # Ensure the container starts automatically
    cmd = [
      "[::]:8000"
      "/git"
      "-d"
      "/tmp/rgit-cache.db"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
  ];
  users.users.git = {
    isSystemUser = true;
    #isNormalUser = true;
    group = "git";
    home = "/mnt/data/git";
    createHome = true;
    shell = "${pkgs.git}/bin/git-shell";
    openssh.authorizedKeys.keys = [
      # FIXME: Add pubkeys of authorized users
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbJFaxCSeIfKppbqL5TXXxGLFtlbShkzj+IlRx2g1l0 tht@viper"
    ];
  };

  users.groups.git = {};

  services.openssh = {
    enable = true;
    extraConfig = ''
      Match user git
        AllowTcpForwarding no
        AllowAgentForwarding no
        PasswordAuthentication no
        PermitTTY no
        X11Forwarding no
    '';
  };
}
