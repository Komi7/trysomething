{ ... }:

{
  programs.ghostty = {
    enable = true;

    enableFishIntegration = true;

    settings = {
      # Font (Stylix also manages this)
      font-family = "JetBrainsMono Nerd Font";

      # Size
      font-size = 14;

      # Window
      background-opacity = 0.90;
      background-blur-radius = 20;

      # Appearance
      window-decoration = false;
      gtk-tabs-location = "hidden";

      # Cursor
      cursor-style = "block";
      cursor-style-blink = true;

      # Scroll
      scrollback-limit = 10000;

      # Better Wayland support
      gtk-single-instance = true;

      # Shell
      shell-integration = "fish";
    };
  };
}