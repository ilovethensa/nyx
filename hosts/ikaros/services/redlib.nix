{...}: {
  services.redlib = {
    enable = true;
    openFirewall = true;
    address = "127.0.0.1";
    settings = {
      REDLIB_DEFAULT_USE_HLS = "on";
      BANNER = "Hosted in bulgarian with <3";
      ROBOTS_DISABLE_INDEXING = "on";
      BLUR_SPOILER = "on";
    };
  };
}
