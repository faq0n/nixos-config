{ pkgs , ... }:
let
  NIXOS_VERSION = "25.11";
in
{
  imports = [
    ./hardware-configuration.nix
    #  enable sites module 
    ./sites/sites.nix
  ];
  
  system.stateVersion = NIXOS_VERSION;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #boot.isContainer = true;
  boot.loader.systemd-boot.enable = true;
 
  time.timeZone = "Europe/Berlin";
  environment.systemPackages = with pkgs; [
    # utils
    htop
    vim
    git
    nmap
    nettools
    iputils
    unzip
  ];
}
