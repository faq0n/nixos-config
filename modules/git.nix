{secrets, ...}: {
  programs.git = {
    enable = true;
    extraConfig = {
      url = {
        #"https://oauth2:${secrets.github.oauth_token}@github.com" = {
        #  insteadOf = "https://github.com";
        #};
        "https://oauth2:${secrets.gitlab.oauth_token}@gitlab.com" = {
          insteadOf = "https://gitlab.com";
        };
      };
    };
  };
}
