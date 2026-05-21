{ config, lib, pkgs, ... }:{
{
  environment.systemPackages = with pkgs; [
    # add packages according to alphabet
    bash-git-prompt
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

  };

}
