{ config, pkgs, username, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.11";
    home.pointerCursor = {
    enable = true;
  };
  
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./fish.nix
    ./git.nix
    ./scripts.nix
    ./vscode.nix
  ];
   

  # Basic home packages
  home.packages = with pkgs; [
    # Terminal
    alacritty
    kitty
    brave
    
    #torrent
    qbittorrent
    
    #fish app
    zoxide
    starship
    
    # Tools
    fd
    bat
    eza
    lsd
    jq
    unzip
    zip
    wget
    curl
    git-lfs
   # noti
    swaynotificationcenter
    libnotify
    # Media
    mpv
    imagemagick
    
    #office
    onlyoffice-desktopeditors
    corefonts
    vista-fonts
    liberation_ttf
    dejavu_fonts
    noto-fonts
    
    # System monitoring
    btop
    htop
    
    # Misc
    tldr
    #photo edit
    gimp
    #notebook
    obsidian
    
    #message_App
    vesktop
    telegram-desktop
    
    #Video edit
    kdePackages.kdenlive
    losslesscut-bin
    google-chrome
    #password_manager
    bitwarden-desktop
    
    # web build
    nodejs
    

  ];
  
  
   xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "inode/directory" = "thunar.desktop";
      "application/x-gnome-saved-search" = "thunar.desktop";
      
       # Set Geany as default for text files
      "text/plain" = "geany.desktop";
      "text/markdown" = "geany.desktop";
      "application/text" = "geany.desktop";
      "application/x-zerosize" = "geany.desktop"; # Handles blank/empty files
      
      
    };
  };
 
  xdg.configFile."mimeapps.list".force = true;
  xdg.dataFile."applications/mimeapps.list".force = true; 

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

  # Home Manager should manage itself
  programs.home-manager.enable = true;
}
