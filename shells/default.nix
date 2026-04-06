 let
   nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.11";
   pkgs = import nixpkgs { config = {}; overlays = []; };
 in

 pkgs.mkShellNoCC {
   packages = with pkgs; [
     cowsay
     lolcat
     nodejs
     jq
     net-tools
   ];

   GREETING = "Hello, to Nix!";
   shellHook = ''
     echo $GREETING | cowsay | lolcat
     eval $(ssh-agent)
     ssh-add $HOME/.ssh/id_lynx
   '';
 }
