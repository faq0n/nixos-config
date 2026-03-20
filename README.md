# Nix <3

This repo serves me to begin an oneclick installation of my nixos-config on a new machine.

## To do
[ ] Create a template for a disk partioning layout instead of fallback to single-disk-ext4 
[ ] Add git hooks before rebooting to a new install that saves changes in the git repository

## Test and Deploy 
Install with the following command for an existing host for a flake repo deployment:
```
  sudo nix run --extra-experimental-features 'nix-command flakes' "github:nix-community/disko#disko-install -- --flake "gitlab:faq0n/nixos-config#oneclick --disk $DISK
```

## Use specific configuration

More manual approach to change defaults:
```
git clone https://gitlab.com/faq0n/nixos-config.git
cd nixos-config
sudo nixos-install --flake .#HOSTNAME
```

Set root password and reboot...
