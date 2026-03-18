let
  DEFAULT_USER_NAME = "user";
  DEFAULT_USER_PASSWORD = "12345";
  DEFAULT_SSH_AUTHORIZED_KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDeX0mc1+RIlnMJR9RmzmFsL0bOiJOiemPFuDWBrkdP7";
in
{
  ### users
  users = {
    users = {
      "${DEFAULT_USER_NAME}" = {
        initialPassword = DEFAULT_USER_PASSWORD;
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          DEFAULT_SSH_AUTHORIZED_KEY
        ];
      };
    };
    extraUsers = {
      # disable password login for root
      root = {
        password = "";
      };
    };

    groups = {
      "${DEFAULT_USER_NAME}" = {
        members = [
          DEFAULT_USER_NAME
        ];
      };
    };
    extraGroups = {
      "wheel" = {
        members = [
          DEFAULT_USER_NAME
        ];
      };
    };
  };
}
