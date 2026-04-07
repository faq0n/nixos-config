{ secrets, ... }:
{
  programs.git = {
    enable = true;
    config = {
      url = {
        #"https://oauth2:${secrets.github.oauth_token}@github.com" = {
        #  insteadOf = "https://github.com";
        #};
      };
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
