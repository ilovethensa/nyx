{pkgs, ...}: {
  users.users = {
    tht = {
      isNormalUser = true;
      extraGroups = ["wheel" "adbusers" "dialout" "docker"];
      packages = with pkgs; [tree];
      initialPassword = "DupeDupe123";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILgNqC86NUI2Mct4NTrkuSroDUGXUBPqVrY38ARwiSlf tht"];
      shell = pkgs.fish;
    };
    root.initialPassword = "DupeDupe123";
  };
  users.mutableUsers = false;
  programs.fish.enable = true;
}
