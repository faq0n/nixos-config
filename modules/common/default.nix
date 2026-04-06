{ pkgs, lib, config, ... }:{
   imports = [ 
     ./users.nix
     ./programs.nix

     ./networking.nix
     ./ssh.nix
     ./git.nix
     ./zsh.nix
   ];
}
