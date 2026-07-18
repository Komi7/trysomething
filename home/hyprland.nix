{ config, pkgs, ... }:
{
wayland.windowManager.hyprland = {
  enable = true;
  configType = "hyprlang";
  package = pkgs.hyprland;
  systemd.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$term" = "alacritty";
      "$menu" = "rofi -show drun";
      "$browser" = "firefox";
      "$fileManager" = "thunar";

      monitor = [
        # Configure your monitor here
        "eDP-1,1920x1080@60,0x0,1"
      ];

      env = [
        "XCURSOR_SIZE,24"
   #     "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0.0;
        touchpad = {
          natural_scroll = false;
          disable_while_typing = true;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
   #     "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
   #    "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
         shadow = {
    enabled = true;
    range = 4;
    render_power = 3;
 #   color = "rgba(1a1a1aee)";  if want to use add color=lib.mkForce
  };
      };
       
      animations = {
        enabled = true;
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];
        animation = [
          "windows, 1, 10, myBezier"
          "windowsOut, 1, 10, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

  #    dwindle = {
  #      pseudotile = true;
   #     preserve_split = true;
   #   };

  #    master = {
  #      new_is_master = true;
  #    };

 #     gestures = {
  #      workspace_swipe = false;
  #    };

      # Full Keyboard Bindings
      bind = [
        # --- Application Launcher ---
        "$mainMod, Q, exec, $term"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, D, exec, $menu"
        "$mainMod, B, exec, $browser"
        "$mainMod SHIFT, Q, exec, alacritty --floating"
        
        # --- Window Management ---
        "$mainMod, C, killactive, "
  #      "$mainMod, V, togglefloating, "
        "$mainMod, F, fullscreen, 0"
        "$mainMod SHIFT, F, fullscreen, 1"
        "$mainMod, P, pseudo, "
     #   "$mainMod, J, togglesplit, "
        "$mainMod, M, exit, "
        # copy view list
        "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        # --- Focus Navigation ---
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        
        # --- Window Movement ---
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"
        
        # --- Workspace Navigation ---
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        
        # --- Move Window to Workspace ---
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        
        # --- Workspace Cycling ---
        "$mainMod ALT, l, workspace, +1"
        "$mainMod ALT, h, workspace, -1"
        "$mainMod ALT, right, workspace, +1"
        "$mainMod ALT, left, workspace, -1"
        
        # --- Window Resizing ---
        "$mainMod CTRL, left, resizeactive, -20 0"
        "$mainMod CTRL, right, resizeactive, 20 0"
        "$mainMod CTRL, up, resizeactive, 0 -20"
        "$mainMod CTRL, down, resizeactive, 0 20"
        "$mainMod CTRL, h, resizeactive, -20 0"
        "$mainMod CTRL, l, resizeactive, 20 0"
        "$mainMod CTRL, k, resizeactive, 0 -20"
        "$mainMod CTRL, j, resizeactive, 0 20"
        
        # --- Layout Control ---
    #    "$mainMod, R, togglesplit, "
        "$mainMod, S, pseudo, "
        
        # --- Special Keys ---
        "$mainMod, tab, focusurgentorlast"
        "$mainMod, grave, workspace, special"
        "$mainMod SHIFT, grave, movetoworkspace, special"
        "$mainMod, n, togglespecialworkspace, magic"
        "$mainMod SHIFT, n, movetoworkspace, special:magic"
        
        # --- Screenshot & Utilities ---
        ", Print, exec, hyprshot -m region"
        "SHIFT, Print, exec, hyprshot -m window"
        "$mainMod, Print, exec, hyprshot -m output"
        
        # --- Application Menu ---
        "ALT, space, exec, $menu"
        "$mainMod ALT, t, exec, $term"
        "$mainMod ALT, e, exec, $fileManager"
        
        # --- Keyboard Backlight Control - ThinkPad specific ---
        ", XF86KbdBrightnessUp, exec, brightnessctl -d '*::kbd_backlight' set +10%"
        ", XF86KbdBrightnessDown, exec, brightnessctl -d '*::kbd_backlight' set 10%-"
        
        # --- Display Brightness Control ---
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        
        # --- Volume Control ---
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMute, exec, pamixer -t"
        
        # --- Media Control ---
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        
        # --- Hypridle & Lock ---
        "$mainMod SHIFT, L, exec, hyprlock"
        "$mainMod ALT, l, exec, systemctl suspend"
        
        # --- Text Operations ---
        "$mainMod, a, exec, rofi -show window"
        "$mainMod SHIFT, s, exec, grim -g \"$(slurp)\" - | wl-copy"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Scroll through existing workspaces with mainMod + scroll
      binde = [
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Autostart
exec-once = [
  "waybar"
  "hypridle"
  "swaync"

  # clipboard
  "wl-paste --type text --watch cliphist store"
  "wl-paste --type image --watch cliphist store"

  # wallpaper
  "hyprpaper"

  # polkit authentication
  "lxqt-policykit-agent"
];
    };
  };

   #wallpaper
     services.hyprpaper = {
    enable = true;

    settings = {
      preload = [
        "${./wallpapers/wallpaper_miles.jpg}"
      ];

      wallpaper = [
        {
          monitor = "eDP-1";
          path = "${./wallpapers/wallpaper_miles.jpg}";
          fit_mode = "cover";
        }
      ];
    };
  };

 

  # Hypridle (auto-lock) configuration
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        unlock_cmd = "pkill -9 hyprlock";
        before_sleep_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 3000;
          on-timeout = "hyprlock";
        }
      ];
    };
  };
}
