{ pkgs, ... }: 
{
   environment.etc = {
    # Define an action that will trigger a Ntfy push notification upon the issue of every new ban
    "fail2ban/action.d/ntfy-post.local".text = pkgs.lib.mkDefault (pkgs.lib.mkAfter ''
      [Definition]
      norestored = true # Needed to avoid notification after every restart 
      actionban = curl -H "Title: <ip> has been banned" -d "<name> jail has banned <ip> "https://ntfy.adminforge.de/Fail2BanNotifications"
    '');
    # Defines a filter that detects URL probing by reading the Nginx access log
    "fail2ban/filter.d/nginx-url-probe.local".text = pkgs.lib.mkDefault (pkgs.lib.mkAfter ''
      [Definition]
      failregex = ^<HOST>.*GET.*(matrix/server|\.php|admin|wp\-).* HTTP/\d.\d\" 404.*$
    '');
  };

  services.fail2ban = {
    enable = true;
    ignoreIP = [ "212.110.214.20" ];
    extraPackages = [pkgs.ipset pkgs.curl];
    jails = {
      nginx-limit-req.settings = {
      # Block an IP address if it accesses a non-existent
      # home directory more than 5 times in 10 minutes,
      # since that indicates that it's scanning.
        filter = "nginx-limit-req";
        action = ''iptables-multiport[name=HTTP, port="http,https"]'';
        logpath = "/var/log/nginx/error.log";
        backend = "auto";
        findtime = 600;
        bantime = 600;
        maxretry = 5;
      };
      nginx-url-probe.settings = { 
        enabled = true;
        filter = "nginx-url-probe";
        logpath = "/var/log/nginx/*.log";
        action = ''%(action_)s[blocktype=DROP]
                 ntfy-post
	'';
        backend = "polling"; # Do not forget to specify this if your jail uses a log file
        maxretry = 5; 
        findtime = 600;
      }; 
    };
  };
}
