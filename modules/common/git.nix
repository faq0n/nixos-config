{secrets, ...}: {
  programs.git = {
    enable = true;
    config = {
      url = {
        #"https://oauth2:${secrets.github.oauth_token}@github.com" = {
        #  insteadOf = "https://github.com";
        #};
        "https://fq1rex:${secrets.gitlab.access_token}@gitlab.com" = {
          insteadOf = "https://gitlab.com";
        };
      };
    };
  };
}
