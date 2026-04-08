{ pkgs, ... }:
{
   environment.systemPackages = with pkgs; [
     # add packages according to alphabet
     bash-git-prompt
  ];

  programs = {
    bash = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

  };


}
