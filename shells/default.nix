 let
   # pkgs ? import <nixpkgs> { config = {}; overlays = []; };
   pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/f8062ac096b268957e41ddfc25fb4eada4d30440.tar.gz") {};
 in

 pkgs.mkShellNoCC {
   packages = with pkgs; [
     cowsay
     lolcat
     nodejs
     jq

   ];

   GREETING = "Hello, to Nix!";
   shellHook = ''
     echo $GREETING | cowsay | lolcat
     ssh-add $HOME/.ssh/id_lynx
   '';
 }
