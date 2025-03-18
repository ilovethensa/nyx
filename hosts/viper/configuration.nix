{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../../nix/users.nix
    ../../nix/common.nix
    ../../nix/boot.nix
    ../../nix/comin.nix
  ];

  networking = {
    hostName = "viper";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time.timeZone = "Europe/Sofia";

  hardware.pulseaudio.enable = false;
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };
  security.sudo.wheelNeedsPassword = false;

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      # Import your home-manager configuration
      tht = import ../../home/tht;
    };
  };

  boot.initrd.kernelModules = ["amdgpu"];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    videoDrivers = ["amdgpu"];
  };
  services.xserver.excludePackages = [pkgs.xterm];
  environment.gnome.excludePackages = with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    gnome-characters
    gnome-music
    gnome-tour
    hitori # sudoku game
    iagno # go game
    tali # poker game
    yelp # help browser
    gnome-shell-extensions # gnome extensions
  ];

  documentation.enable = false;

  hardware.graphics = {
    enable32Bit = true;
    enable = true;
  };
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    android-udev-rules
  ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  system.stateVersion = "24.11";
}
