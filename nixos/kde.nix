{ config, pkgs, ... }:

{
  # KDE Plasma packages
  environment.systemPackages = with pkgs; [
    # KDE Applications
    kdePackages.dolphin   # File manager
    kdePackages.gwenview  # Image viewer
    kdePackages.okular    # PDF viewer
    kdePackages.ark       # Archive manager
    kdePackages.kcalc     # Calculator
  ];
}