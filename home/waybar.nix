{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.85);
        color: #cdd6f4;
        border-bottom: 1px solid rgba(205, 214, 244, 0.2);
      }

      #workspaces button {
        transition: all 0.2s ease;
      }
     
     #workspaces button.empty {
        opacity: 0.4;
      }
      #workspaces button {
        padding: 3px 8px;
        margin: 3px;
        border-radius: 6px;
        background: rgba(69,71,90,0.5);
        color: #a6adc8;
      }

      #workspaces button.active {
        background: #89b4fa;
        color: #1e1e2e;
        font-weight: bold;
      }

      #workspaces button:hover {
        background: #585b70;
        color: #cdd6f4;
      }

      #window {
        padding: 0 10px;
        color: #cdd6f4;
      }

      #clock {
        color: #89dceb;
        font-weight: bold;
        padding: 0 15px;
      }

      #cpu {
        color: #f38ba8;
      }

      #memory {
        color: #fab387;
      }

      #temperature {
        color: #f9e2af;
      }

      #network {
        color: #a6e3a1;
      }

      #battery {
        color: #a6e3a1;
      }

      #battery.warning {
        color: #fab387;
      }

      #battery.critical {
        color: #f38ba8;
      }

      #pulseaudio {
        color: #f5c2e7;
      }
      
      #custom-power {
    color: #f38ba8;
    padding: 0 10px;
    margin-right: 6px;
    border-radius: 8px;
    transition: all 0.2s ease;
}

#custom-power:hover {
    background: #f38ba8;
    color: #1e1e2e;
}
      
      #tray {
        padding: 0 10px;
      }

      #custom-separator {
        color: #45475a;
        padding: 0 5px;
      }
      
      #cpu,
#memory,
#temperature,
#network,
#bluetooth,
#battery,
#backlight,
#pulseaudio {
  padding: 0 8px;
}
      
    '';

    settings = {
      mainBar = {

        layer = "top";
        position = "top";

        height = 32;
        spacing = 5;
        margin = "0";

        modules-left = [
          "hyprland/workspaces"
          "custom/separator"
          "hyprland/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "custom/weather"
          "cpu"
          "memory"
          "temperature"
          "network"
          "bluetooth"
          "battery"
          "backlight"
          "pulseaudio"
          "custom/power"
          "tray"
        ];


        "hyprland/workspaces" = {
          format = "{name}";
          all-outputs = true;

          persistent-workspaces = {
            "*" = 5;
          };
        };


        "hyprland/window" = {
          format = "{title}";
          max-length = 50;
        };

        clock = {
          format = "󰥔 {:%I:%M:%S %p}";
          format-alt = "󰃭 {:%A %d %B %Y}";
          interval = 1;
      #    tooltip = true
      tooltip-format = "<big>{:%A}</big>\n{:%d %B %Y}";
      
        };


        cpu = {
          format = "󰻠 {usage}%";
          interval = 2;
          tooltip = true;
        };


        memory = {
          format = "󰍛 {used:0.1f}G";
          interval = 5;
          tooltip = true;
        };


        temperature = {
           hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
           format = "󰔏 {temperatureC}°C";
           critical-threshold = 80;
        };


        network = {
          format-wifi = "󰤨 {essid} ({signalStrength}%)";
          format-ethernet = "󰈀 Ethernet";
          format-disconnected = "󰤭 Offline";
          interval = 5;
        };


        bluetooth = {
          format = "󰂯";
          format-connected = "󰂯 {num_connections}";
          format-disabled = "󰂲";
          on-click = "blueman-manager";
        };


        battery = {
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          tooltip = true;
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];

          interval = 5;
        };


        backlight = {
          format = "󰃞 {percent}%";
          scroll-step = 5;
        };


        pulseaudio = {
          format = "{icon} {volume}%";

          format-muted = "󰖁 Muted";

          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };

          on-click = "pavucontrol";
        };


        "custom/separator" = {
          format = "│";
        };

       "custom/power" = {
          format = "";
         tooltip = "Power";
        on-click = "powermenu";
       };
        
        "custom/weather" = {
        format = "󰖐 {}";
        exec = "curl -s 'wttr.in/Bogra?format=%t'";
        interval = 1800; 
        };
         
        tray = {
          icon-size = 16;
          spacing = 10;
        };
      };
    };
  };


  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    blueman
    pavucontrol
  ];
}
