{...}: {
  services.miniflux = {
    enable = true;
    createDatabaseLocally = true;
    adminCredentialsFile = "/home/tht/.miniflux-credentials";
    config = {
      CREATE_ADMIN = 1;
      BASE_URL = "https://rss.theholytachanka.com";
      INVIDIOUS_INSTANCE = "https://yt.pwned.page";
      PORT = 8082;
    };
  };
}
