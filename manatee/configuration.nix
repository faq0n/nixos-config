{ pkgs ? import <nixpkgs> {}, ... }:

let
  NIXOS_VERSION = "25.11";
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules/networking.nix
    ./modules/users.nix
    ./modules/ssh.nix
    ./modules/nginx.nix
    ./modules/zsh.nix
    ./modules/security.nix

    ./modules/container.nix
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
