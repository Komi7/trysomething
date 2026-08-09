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
    ./DisplayManager.nix
    ./ld.nix
  ];

  # ============================================================
  # System hostname and time
  # ============================================================

  networking.hostName = hostname;
  networking.domain = "";
  networking.search = [];

  time.timeZone = "Asia/Dhaka";

  i18n.defaultLocale = "en_US.UTF-8";


  # ============================================================
  # Boot
  # ============================================================

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;


  # ============================================================
  # Networking
  # ============================================================

  networking.networkmanager.enable = true;

  programs.nix-ld.enable = true;


  # ============================================================
  # mDNS / hostname discovery
  # ============================================================

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


  # ============================================================
  # Audio
  # ============================================================

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };


  # ============================================================
  # Graphics - Intel
  # ============================================================

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


  # ============================================================
  # Hyprland / XWayland
  #
  # Keep Hyprland's native Wayland session.
  # XWayland is useful as a fallback for applications that
  # don't work correctly with native Wayland.
  # ============================================================

  programs.hyprland.xwayland.enable = true;


  # ============================================================
  # XDG Desktop Portal
  #
  # Hyprland provides ScreenCast/InputCapture.
  # GTK is included for the generic portal functionality.
  #
  # Do NOT replace the Hyprland portal with GTK globally.
  # ============================================================

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];

    config = {
      Hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
    };
  };


  # ============================================================
  # System services
  # ============================================================

  services.thermald.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;


  # ============================================================
  # User account
  # ============================================================

  users.users.${username} = {
    isNormalUser = true;

    home = "/home/${username}";

    description = "${username}";

    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "input"
      "audio"
    ];

    shell = pkgs.fish;
  };


  # ============================================================
  # System packages
  # ============================================================

  environment.systemPackages = with pkgs; [

    # ----------------------------------------------------------
    # Core utilities
    # ----------------------------------------------------------

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


    # ----------------------------------------------------------
    # Development
    # ----------------------------------------------------------

    gcc
    gnumake
    pkg-config


    # ----------------------------------------------------------
    # Polkit agent for Hyprland
    # ----------------------------------------------------------

    lxqt.lxqt-policykit


    # ----------------------------------------------------------
    # Bluetooth
    # ----------------------------------------------------------

    bluez
    bluez-tools
    blueman


    # ----------------------------------------------------------
    # Keyboard backlight
    # ----------------------------------------------------------

    brightnessctl
    acpi


    # ----------------------------------------------------------
    # Volume / media
    # ----------------------------------------------------------

    pamixer
    playerctl


    # ----------------------------------------------------------
    # Screenshots
    # ----------------------------------------------------------

    grim
    slurp


    # ----------------------------------------------------------
    # Audio GUI
    # ----------------------------------------------------------

    pavucontrol


    # ----------------------------------------------------------
    # Fonts
    # ----------------------------------------------------------

    jetbrains-mono
    nerd-fonts.jetbrains-mono

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji


    # ----------------------------------------------------------
    # System monitoring
    # ----------------------------------------------------------

    lm_sensors


    # ----------------------------------------------------------
    # Thunar
    # ----------------------------------------------------------

    gvfs
    udisks
    thunar-volman
    tumbler
    file-roller


    # ----------------------------------------------------------
    # Applications
    # ----------------------------------------------------------

    firefox
    alacritty
    rofi
    dunst
    thunar


    # ----------------------------------------------------------
    # X11 / XWayland
    # ----------------------------------------------------------

    xwayland
    xorg.xdpyinfo


    # ----------------------------------------------------------
    # Deskflow
    #
    # Nixpkgs Deskflow 1.26.0
    # ----------------------------------------------------------

    deskflow


    # ----------------------------------------------------------
    # Deskflow Wayland dependencies
    # ----------------------------------------------------------

    libei
    libportal


    # ----------------------------------------------------------
    # Cachix
    # ----------------------------------------------------------

    cachix


    # ----------------------------------------------------------
    # YouTube / media
    # ----------------------------------------------------------

    yt-dlp
    ffmpeg
    feh
  ];


  # ============================================================
  # Fish
  # ============================================================

  programs.fish.enable = true;


  # ============================================================
  # Environment variables
  # ============================================================

  environment.variables = {
    EDITOR = "nvim";
  };


  # ============================================================
  # Nix settings
  # ============================================================

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    auto-optimise-store = true;

    substituters = [
      "https://cache.nixos.org"
      "https://komi7.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "komi7.cachix.org-1:NsBPk8UBIBBaDuax0VWe6zfYwHoBI1/PJ40EBzWD895I="
    ];
  };


  # ============================================================
  # Insecure packages
  # ============================================================

  nixpkgs.config.permittedInsecurePackages = [
    "electron-40.10.5"
    "electron-39.8.10"
  ];


  # ============================================================
  # Nix garbage collection
  # ============================================================

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };


  # ============================================================
  # Maintenance
  # ============================================================

  services.fstrim.enable = true;
  services.fwupd.enable = true;


  # ============================================================
  # Unfree packages
  # ============================================================

  nixpkgs.config.allowUnfree = true;


  # ============================================================
  # NixOS state version
  # ============================================================

  system.stateVersion = "25.11";
}
