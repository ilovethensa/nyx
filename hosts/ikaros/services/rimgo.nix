{...}: {
  services.rimgo = {
    enable = true;
    settings = {
      ADDRESS = "127.0.0.1";
      PORT = 3000;
    };
  };
}
