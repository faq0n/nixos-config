{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./programs.nix
    ./editor.nix
    ./networking.nix
    ./ssh.nix
    ./git.nix
    ./zsh.nix
  ];
}
