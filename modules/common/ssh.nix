let 
  # ssh
  SSH_PORT = 2222;
  ALLOWED_SSH_KEY_TYPES = [
    # ssh-ed25519
    "curve25519-sha256"
    "curve25519-sha256@libssh.org"
	  ];
in
{
  ### ssh
  services.openssh = {
    # ssh is enabled by default
    enable = true;
    ports = [ SSH_PORT ];

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      KexAlgorithms = ALLOWED_SSH_KEY_TYPES;
    };
  };
  programs.ssh = {
    extraConfig = "
      Host manatee
        Hostname 152.53.132.54
        Port 2222
        User faq0n
      Host menticare
        Hostname 152.53.249.159
	User faq0n
    ";
    startAgent = true;
  };
}
