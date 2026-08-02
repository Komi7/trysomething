# NixOS Flake Configuration

A modern NixOS system configuration using Flakes and Home Manager for a Lenovo ThinkPad T470s with Hyprland window manager.

## Features

- **Flake-based configuration** - Modern, reproducible NixOS setup
- **Home Manager** - User-level package and dotfile management
- **Hyprland** - Wayland tiling window manager
- **Intel GPU** - Optimized for Intel integrated graphics
- **Bluetooth Support** - Full Bluetooth connectivity with blueman GUI
- **Keyboard Backlight** - Control keyboard backlight brightness
- **ThinkPad T470s** - Hardware-specific optimizations via nixos-hardware

## Structure

```
.
├── flake.nix                 # Flake configuration
├── nixos/
│   ├── configuration.nix     # System configuration
│   ├── hyprland.nix          # Hyprland setup
│   ├── bluetooth.nix         # Bluetooth configuration
│   ├── keyboard-backlight.nix # Keyboard backlight setup
│   └── hardware-configuration.nix  # Hardware config (regenerate after install)
├── home/
│   ├── home.nix              # Home Manager entry point
│   ├── hyprland.nix          # Hyprland user config
│   ├── zsh.nix               # Zsh shell configuration
│   └── git.nix               # Git configuration
└── README.md
```

## Prerequisites

1. Fresh NixOS installation on ThinkPad T470s
2. Git installed
3. This repository cloned to `~/.config/nixos` or `/etc/nixos`

## Initial Setup

### 1. Generate Hardware Configuration

After booting into NixOS:

```bash
# Run this from your clone root (e.g. ~/.config/nixos or /etc/nixos)
sudo nixos-generate-config --show-hardware-config > ./nixos/hardware-configuration.nix
```

Update the UUID placeholders in `nixos/hardware-configuration.nix` with your actual UUIDs:

```bash
blkid
```

### 2. Update Git Email

Edit `home/git.nix` and change the email to your actual email:

```nix
userEmail = "your-actual-email@example.com";
```

### 3. Build and Switch

```bash
cd ~/.config/nixos
sudo nixos-rebuild switch --flake .#komi
```

## Feature Configuration

### Bluetooth

**Status:**
- Bluetooth is enabled and starts at boot
- Blueman provides a GUI for managing Bluetooth devices
- Devices can be connected via `bluetoothctl` or GUI tools

**Commands:**
```bash
# View Bluetooth devices
bluetoothctl devices

# Pair a device
bluetoothctl pair <device_address>

# Connect to device
bluetoothctl connect <device_address>
```

### Keyboard Backlight

**Status:**
- Keyboard backlight is controlled via ThinkPad ACPI module
- Use Hyprland hotkeys or `brightnessctl` command

**Hotkeys in Hyprland:**
- `Fn + PageUp` - Increase keyboard brightness
- `Fn + PageDown` - Decrease keyboard brightness

**Commands:**
```bash
# Check available backlight devices
brightnessctl -l

# Increase keyboard backlight by 10%
brightnessctl -d '*::kbd_backlight' set +10%

# Decrease keyboard backlight by 10%
brightnessctl -d '*::kbd_backlight' set 10%-

# Set to specific value (0-100)
brightnessctl -d '*::kbd_backlight' set 50
```

## Customization

### Adding Packages

Add packages to:
- **System-wide**: `nixos/configuration.nix` → `environment.systemPackages`
- **User packages**: `home/home.nix` → `home.packages`

### Hyprland Configuration

Edit keybindings and settings in `home/hyprland.nix`:
- Monitor configuration
- Keybindings (search for `bind = [ ... ]`)
- Appearance (gaps, borders, animations)

### Shell Configuration

Customize shell settings in `home/zsh.nix`:
- Aliases
- Plugins
- History settings

## Useful Commands

```bash
# Rebuild and switch to new configuration
sudo nixos-rebuild switch --flake .#komi

# Test new configuration without switching
sudo nixos-rebuild test --flake .#komi

# Rollback to previous generation
sudo nixos-rebuild --rollback

# Update flake inputs
nix flake update

# Enter development shell
nix develop

# Format nix files
nixpkgs-fmt .
```

## Troubleshooting

### Bluetooth not working
- Ensure Bluetooth is enabled: `systemctl status bluetooth`
- Check if device is visible: `bluetoothctl scan on`
- Check kernel modules: `lsmod | grep bluetooth`

### Keyboard backlight not working
- Check available devices: `brightnessctl -l`
- Verify ThinkPad ACPI module: `lsmod | grep thinkpad_acpi`
- Check sysfs path: `ls /sys/class/leds/` or `ls /sys/class/backlight/`

### Display issues
- Check monitor configuration in `home/hyprland.nix`
- Run `hyprctl monitors` to see detected monitors

### GPU acceleration not working
- Verify Intel drivers are loaded: `glxinfo | grep "OpenGL"`
- Check `nixos/hyprland.nix` for GPU settings

### Sound issues
- Use `pavucontrol` to check audio settings
- Verify pipewire is running: `systemctl --user status pipewire`

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Flakes Documentation](https://nixos.wiki/wiki/Flakes)
- [ThinkPad ACPI](https://www.kernel.org/doc/html/latest/admin-guide/laptops/thinkpad-acpi.html)

## License

MIT
