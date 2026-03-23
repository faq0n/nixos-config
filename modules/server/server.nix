# https://nixos.wiki/wiki/Nginx
{
  imports = [
    ./fail2ban.nix
  ];

  services.nginx = {
    enable = true;

    virtualHosts = {
      # prevent access host IP
      # use domain access instead
      "0.0.0.0" = {
        addSSL = false;
        enableACME = false;

        extraConfig = ''
          deny all;
        '';
      };

      # # main domain (entrypoint)
      # "nix-host" = {
      #   addSSL = false;
      #   enableACME = false;

      # All serverAliases will be added as extra domain names on the certificate.
      #serverAliases = [ "www.mentica.re" ];
      #   locations."/" = {
      #    root = "/var/www";
      #   };
      #   extraConfig = ''
      #     proxy_pass_header Authorization;
      #   '';

      #   basicAuth = {
      #     admin = "admin";
      #   };
      # };
    };
  };
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "faqun+acme@mailbox.org";
}
