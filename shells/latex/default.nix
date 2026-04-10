 let
#  nixpkgs = fetchTarball"https://github.com/NixOS/nixpkgs/tarball/nixos-25.11";
   pkgs = import <nixpkgs> {};
 in

 pkgs.mkShellNoCC {
   packages = with pkgs; [
     
     # Editor 
     textadept
     zathura

     # Latex Environment
     texliveBasic
     tex-fmt
     texinfo
     libertine
     lato

     # Tooling 
     pandoc
   ];


   GREETING = "Hello, to LaTeX!";
   shellHook = ''
     echo $GREETING
     texlua --credits
   '';
 }
