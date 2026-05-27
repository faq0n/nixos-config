#-----------------------------
#    _   _ _       ___  ____
#   | \ | (_)_  __/ _ \/ ___|
#   |  \| | \ \/ / | | \___ \
#   | |\  | |>  <| |_| |___) |
#   |_| \_|_/_/\_\\___/|____/
#
#-----------------------------

{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    # Hardware of current machine
    ./hardware-configuration.nix
  ];

  #############################################################################
  # NIX Options
  # Overlays
  # Nixpkgs configuration
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      inxi = pkgs.inxi.override { withRecommends = true; };
    };
  };
  # Nix configuration
  nix = {
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      substituters = [
        "https://nix-community.cachix.org/"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  #############################################################################
  # BOOT Options
  # Use latest ZFS linux kernel
  # Kernel parameters and modules
  #############################################################################
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "rd.systemd.show_status=auto"
    "rd.udev.log_level=3"
    #"i915.force_probe=!56a1"
  ];
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = false;
  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 7;
    };
    efi.canTouchEfiVariables = true;
  };
  boot.supportedFilesystems = {
    f2fs = true;
    ntfs = true;
  };
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  #############################################################################
  # NETWORKING Options
  networking.hostName = "ursus";
  networking.hostId = "3803798b";
  # Network configuration
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = lib.mkDefault false;
      plugins = with pkgs; [
        networkmanager-l2tp
        networkmanager-openvpn
      ];
    };
  };
  services.mozillavpn.enable = true;
  programs.nm-applet.enable = true;
  #############################################################################
  # LOCALE Settings
  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };
  time.timeZone = "Europe/Berlin";
  #############################################################################
  # X Options
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Display manager
  services.displayManager = {
    gdm = {
      enable = true;
    };
  };
  # Desktop environment
  services.desktopManager.gnome.enable = true;
  # Window managers
  services.xserver.windowManager = {
    qtile = {
      enable = true;
      # package = inputs."qtile-flake".packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
  xdg.portal.configPackages = lib.mkIf (!config.services.desktopManager.gnome.enable) [
    pkgs.xdg-desktop-portal-gtk
  ];
  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb,de";
    model = "pc105";
  };
  #############################################################################
  # Printing options
  services.printing = {
    enable = true;
    drivers = [
      pkgs.brlaser
      pkgs.hplipWithPlugin
    ];
  };
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  programs.system-config-printer.enable = true;
  # Scanners
  hardware.sane.enable = true;
  #############################################################################
  # Hardware support
  hardware.onlykey.enable = true;
  hardware.openrazer = {
    enable = true;
    users = [ "faqun" ];
    syncEffectsEnabled = true;
    devicesOffOnScreensaver = true;
  };
  #############################################################################
  security.sudo.wheelNeedsPassword = false;
  # Security token
  security.polkit.enable = true;
  # User account and configuration
  users.users.faq0n = {
    isNormalUser = true;
    home = "/home/faq0n";
    initialHashedPassword = "$y$j9T$9.BTpP4Ool9fvpzy.rURH0$2mWQXd752oFtwHzKFUqdc/TbGqerpMdbwcmTMtenj4.";
    createHome = true;
    extraGroups = [
      "wheel"
      "disks"
      "audio"
      "input"
      "docker"
      "adbusers"
      "networkmanager"
      "systemd-journal"
      "video"
    ];
  };

  # Global packages, minimal to avoid polluting environment
  environment.systemPackages = with pkgs; [

    # Terminal and CLI utilities
    acpi
    binutils
    coreutils
    xkblayout-state
    curl
    android-tools
    file
    nvme-cli
    killall
    playerctl
    pciutils
    unrar
    unzip
    usbutils
    wget
    which
    wlr-which-key
    wlr-randr

    # General utilities
    simple-scan

    element-desktop
    # Text processor and office
    thunderbird
    libreoffice
    softmaker-office-nx
    # Applauncher
    rofi
    # Downloader
    nextcloud-client
    qbittorrent
    # Terminal stuff
    camset
    memtester
    libmtp
    usbutils

    # Python Global Environment (here to avoid environment clashes)
    (
      let
        my-python-packages =
          python-packages: with python-packages; [
            # Language server protocol
            black
            # Documentation
            mkdocs
            # Linters
            mypy
            pylint
            # utilities
            libsecret
            # Dependencies
            pickleshare
          ];
        python-with-my-packages = python3.withPackages my-python-packages;
      in
      python-with-my-packages
    )
  ];

  programs.firefox.enable = true;
  programs.thunar.enable = true;
  # Enable coding tools
  programs.direnv.enable = true;
  programs.vscode.enable = true;
  #############################################################################
  # Enable gaming
  programs.steam.enable = true;
  programs.steam = {
    gamescopeSession.enable = true;
    remotePlay.openFirewall = false;
    extest.enable = true;
    localNetworkGameTransfers.openFirewall = false;
  };

  # Use Flatpak, just in case
  services.flatpak.enable = true;
  #############################################################################
  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome
    liberation_ttf
    noto-fonts
    noto-fonts-color-emoji
    source-code-pro
    nerd-fonts.fira-code
  ];

  #############################################################################
  # Virtualization setup, only docker at the moment
  virtualisation = {
    docker = {
      enable = true;
    };
  };
  #############################################################################
  # Audio options
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  #############################################################################
  # Additional services
  # Gnome apps configuration
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = !config.services.gnome.gnome-keyring.enable;
  services.dbus = {
    enable = true;
    packages = [
      pkgs.dconf
      pkgs.seahorse
      pkgs.gnome2.GConf
    ];
  };
  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID"; # this is what was missing
  system.stateVersion = "25.11";
}
