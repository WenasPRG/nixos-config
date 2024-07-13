{ config, pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # System Configuration
  system.stateVersion = "24.05";
  time.timeZone = "Europe/Berlin";
  networking = {
    hostName = "xyfr-01";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  # Boot Configuration
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
    efi.canTouchEfiVariables = true;
  };

  # Localization
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # Graphics and Display
  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # Uncomment if needed:
    # xkb.layout = "de";
    # xkb.options = "eurosign:e,caps:escape";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      amdvlk
    ];
  };

  # Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  # Virtualization
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu;
  };

  # System Services
  services.printing.enable = true;
  security.polkit.enable = true;

  # Nix Configuration
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # User Configuration
  users.users.xyfr = {
    isNormalUser = true;
    description = "xyfr";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "realtime" ];
    packages = with pkgs; [];
  };

  # Home Manager Configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "xyfr" = import ./home.nix;
    };
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    # Browsers and Communication
    unstable.firefox-devedition
    chromium
    discord
    whatsapp-for-linux
    tor-browser
    zoom-us

    # Media and Graphics
    spotify
    spotify-cli-linux
    glaxnimate
    kdePackages.kdenlive
    vlc
    obs-studio
    ffmpeg
    pavucontrol
    geogebra6
    gimp

    # Development
    git
    jdk8
    jdk17
    jdk21
    neovim

    # System Utilities
    zip
    rsync
    tree
    wget
    curl
    jq
    ibus
    dbus
    efibootmgr
    gparted
    kitty
    alsa-utils
    fastfetch

    # Virtualization
    libvirt
    virt-manager
    qemu
    swtpm

    # Wine
    wineWowPackages.unstableFull
    wineWowPackages.stagingFull

    # Miscellaneous
    bitwarden-desktop
    ventoy
    onlyoffice-bin_latest
    blueman
    bluez
    bluez-tools
    qbittorrent

    # Fonts
    corefonts
    vistafonts
  ];

  # GNOME Configuration
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-terminal
    epiphany
    geary
    evince
    totem
  ]) ++ (with pkgs.gnome; [
    gnome-music
    tali
    iagno
    hitori
    atomix
  ]);
}
