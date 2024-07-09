{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
    efi.canTouchEfiVariables = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    
    extraPackages = with pkgs; [
      mesa
      rocm-opencl-icd
      amdvlk
    ];
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu;

  services.xserver.videoDrivers = ["amdgpu"];

  networking.hostName = "xyfr-01"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.polkit.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # General utilities
    zip
    rsync
    tree
    wget
    curl
    jq
    jdk8
    jdk17
    jdk21
    ibus

    # Media
    vlc
    obs-studio
    ffmpeg
    pavucontrol
    geogebra6
    gimp
    davinci-resolve

    # Communication
    bitwarden-desktop
    discord
    whatsapp-for-linux
    tor-browser
    zoom-us

    # System tools
    dbus
    efibootmgr
    gparted
    neovim
    kitty
    firefox
    chromium

    # Fonts
    corefonts
    vistafonts

    # Virtualization
    libvirt
    virt-manager
    qemu
    swtpm

    # Development
    git
    reaper
    yabridge
    yabridgectl
    linvstmanager
    alsa-utils
    wineWowPackages.unstableFull
    wineWowPackages.stagingFull

    # Miscellaneous
    modrinth-app
    ani-cli
    fastfetch
    ventoy
    yacreader
    mangal
    calibre
    onlyoffice-bin_latest
    blueman
    bluez
    bluez-tools
    qbittorrent
    copyq
    normcap
  ];


  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-music
    gnome-terminal
    epiphany # web browser
    geary # email reader
    evince # document viewer
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "de";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  # If you want to use JACK applications, uncomment this
    jack.enable = true;
   };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xyfr = { 
    isNormalUser = true;
    description = "xyfr"; 
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "realtime" ]; 
    packages = with pkgs; [ 
      vim 
      neovim 
      firefox
    ];
  }; 

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { 
      "xyfr" = import ./home.nix;
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?

}
