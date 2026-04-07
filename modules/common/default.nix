{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./bash.nix
    ./ssh.nix
    ./git.nix
    ./zsh.nix
  ];
  environment.systemPackages = [ pkgs.helix ];
}
