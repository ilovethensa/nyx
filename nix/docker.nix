{
  pkgs,
  lib,
  ...
}: {
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "daily";
      flags = ["--all"];
    };
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  systemd.timers.update-containers = {
    timerConfig = {
      Unit = "update-containers.service";
      OnCalendar = "daily 04:00";
    };
    wantedBy = ["timers.target"];
  };
  systemd.services.update-containers = {
    serviceConfig = {
      Type = "oneshot";
      ExecStart = lib.getExe (pkgs.writeShellScriptBin "update-containers" ''
        images=$(${pkgs.docker}/bin/docker ps -a --format="{{.Image}}" | sort -u)
        containers=$(${pkgs.docker}/bin/docker ps -q)

        for image in $images; do
          ${pkgs.docker}/bin/docker pull "$image"
        done

        for container in $containers; do
          ${pkgs.docker}/bin/docker restart "$container"
        done
      '');
    };
  };
}
