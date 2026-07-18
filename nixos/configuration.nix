{ config, pkgs, username, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
    ./bluetooth.nix
    ./keyboard-backlight.nix
    ./kde.nix
    ./stylix.nix
    ./power.nix
    ./laptop.nix
  ];

  # System hostname and time
  networking.hostName = hostname;
  networking.domain = "";
  networking.search = [];
  time.timeZone = "Asia/Dhaka";
  i18n.defaultLocale = "en_US.UTF-8";

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Use latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.networkmanager.enable = true;
  programs.nix-ld.enable = true;
  
  # Enable mDNS for hostname resolution
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Audio
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # Graphics - Intel GPU
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva-utils
    ];
  };
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
  };

  # Systemd for temperature monitoring
  services.thermald.enable = true;
  services.udisks2.enable = true;  #thunar service
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  # User account
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "docker" "input" "audio" ];
    shell = pkgs.fish;
  };

  # Packages - Core System
  environment.systemPackages = with pkgs; [
    # Core utilities
    git
    curl
    wget
    vim
    neovim
    htop
    tree
    fzf
    ripgrep
    tmux
    geany 
    # Development
    gcc
    gnumake
    pkg-config
  # Polkit agent for Hyprland
    lxqt.lxqt-policykit
    # Bluetooth
    bluez
    bluez-tools
    blueman
    
    # Keyboard backlight
    brightnessctl
    acpi
    
    # Volume and Media Control (REQUIRED for Hyprland bindings)
    pamixer
    playerctl
    
    # Screenshot utilities (REQUIRED for Hyprland bindings)
    grim
    slurp
    
    # Audio control GUI
    pavucontrol
    
    # Fonts for Waybar icons and terminals
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    
    # System monitoring
    lm_sensors
    
    
    #thunar req package
    gvfs
    udisks
    thunar-volman
    tumbler
    file-roller
    
    # Applications
    firefox
    alacritty
    rofi
    dunst
    thunar
  ];

  # Shell
  programs.fish.enable = true;

  # Locale
  environment.variables = {
    EDITOR = "nvim";
 #   QT_QPA_PLATFORMTHEME = "kde";
  };
   
nix.settings = {
  experimental-features = [ "nix-command" "flakes" ];
  auto-optimise-store = true;
};
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
};
services.fstrim.enable = true;
services.fwupd.enable = true;
  # NixOS settings
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.11";
}
