# Nix <3

This repo serves me to begin an oneclick installation of my nixos-config on a new machine.

## To do
 
[ ] Add git hooks before rebooting to a new install that saves changes in the git repository

## Retrieve and Deploy 
Install with the following command for an existing host for a flake repo deployment:
```
sudo nix run --extra-experimental-features 'nix-command flakes' "github:nix-community/disko#disko-install -- --flake "gitlab:faq0n/nixos-config#oneclick --disk $DISK
```

### In case of a changed partition layout:
```
curl https://raw.githubusercontent.com/nix-community/disko/master/example/hybrid.nix -o /tmp/disko-config.nix
```

***Caution: Running the following command, will format existing disks with the retrieved partition layout

```
export NIX_CONFIG="experimental-features = nix-command flakes"
sudo nix \
  run github:nix-community/disko -- \
  --mode disko /tmp/disko-config.nix
```

Then, to create an according [hardware-configuration.nix]:
```
sudo nixos-generate-config --no-filesystems --root /mnt
```

Setup a flake and adjust the FIXME's with your values.
```
nix flake init -t github:misterio77/nix-starter-config#minimal
```

Now you can configure your [configuration.nix] to your liking before proceeding:
```
mv /tmp/disko-config.nix configuration.nix flake.nix /mnt/etc/nixos
```

Lastly, perform installation in the final step:
```
sudo nixos-install --root /mnt --flake '/mnt/etc/nixos#nixos'
```

## Host specific configuration

More manual approach to install:

```
git clone https://gitlab.com/faq0n/nixos-config.git
cd nixos-config
sudo nixos-install --flake .#HOSTNAME
```

Set root password and reboot...
