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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.polkit.enable = true;

  nixpkgs.config.allowUnfree = true; 
 
  environment.systemPackages = with pkgs; [
    discord
    dbus
    efibootmgr
    tree
    vlc
    copyq
    normcap
    rsync
    bluez
    tor-browser
    blueman
    bluez-tools
    fastfetch
    whatsapp-for-linux
    git
    qbittorrent
    reaper
    gimp
    ventoy  
    mangal
    calibre
    wget
    curl
    kate
    kitty
    firefox
    onlyoffice-bin_latest
    chromium
    neovim
    gparted
  ];

  # Configure keymap in X11
  services.xserver.xkb.layout = "de";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xyfr = { 
    isNormalUser = true;
    description = "xyfr"; 
    extraGroups = [ "networkmanager" "wheel" ]; 
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
