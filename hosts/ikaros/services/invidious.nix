{...}: {
  services.invidious = {
    enable = true;
    address = "127.0.0.1";
    domain = "yt.pwned.page";
    port = 1234;
    sig-helper.enable = true;
    http3-ytproxy.enable = true;
    database.createLocally = true;
  };
}
