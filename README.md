# NixOS Flake Configuration

A modern NixOS system configuration (flake) and Home Manager setup for a Lenovo ThinkPad T470s running Hyprland. This repository contains system-level NixOS modules and user-level Home Manager configs targeted at a single machine/user (see `flake.nix` for hostname/user values).

## Features

- **Flake-based configuration** — reproducible NixOS + Home Manager setup
- **Home Manager** — user packages and dotfiles
- **Hyprland** — Wayland tiling window manager configuration (system + user)
- **Intel GPU** — Intel-specific graphics settings and packages
- **Bluetooth & Backlight** — blueman, bluez and ThinkPad keyboard backlight support
- **ThinkPad T470s** — hardware helpers via `nixos-hardware`

## Structure

Repository top-level layout (exact):

```
.
├── flake.nix                 # Flake entry: builds nixosConfigurations and devShell
├── flake.lock                # Flake inputs lockfile
├── nixos/                    # System-level NixOS modules and configs
│   ├── configuration.nix     # Main system configuration (imports modules below)
│   ├── hyprland.nix          # System-level Hyprland/WM settings
│   ├── bluetooth.nix         # Bluetooth service config
│   ├── keyboard-backlight.nix# Keyboard backlight helpers
│   ├── hardware-configuration.nix # Hardware config (regenerate per-machine)
│   └── ...                   # other supporting NixOS modules
├── home/                     # Home Manager configs (per-user)
│   ├── home.nix              # Home Manager entry point (imports others)
│   ├── hyprland.nix          # User-level Hyprland config & keybindings
│   ├── waybar.nix            # Waybar config for Hyprland
│   ├── fish.nix              # fish shell config
│   ├── git.nix               # git user config (set your email here)
│   ├── wallpapers/           # Wallpaper assets used by hyprpaper
│   └── ...
├── result                    # symlink (build artifact)
└── README.md
```

**Notes:**
- The flake defines `nixosConfigurations.${hostname}` and a devShell; username and hostname are set in `flake.nix` (default: `shousuke` / `komi`). Change them in the flake or override when building if you want a different target.
- `hardware-configuration.nix` is machine-specific and should be regenerated on each target machine.

## Quick start (from a clone)

1. Clone into your preferred location (example: `~/.config/nixos`):

```bash
git clone https://github.com/komi7/trysomething ~/.config/nixos
cd ~/.config/nixos
```

2. Generate hardware configuration on the target machine and save it under `nixos/` in this repo (run on the machine you will install):

```bash
sudo nixos-generate-config --show-hardware-config > ./nixos/hardware-configuration.nix
# Edit UUIDs and other machine-specific settings in nixos/hardware-configuration.nix
```

3. Edit user values and git/email before applying:
- `home/git.nix` — set your `userEmail`
- `flake.nix` — change `username` / `hostname` if desired

4. Test the build without switching, then switch:

```bash
sudo nixos-rebuild test --flake .#komi
# When happy:
sudo nixos-rebuild switch --flake .#komi
```

If you cloned to `/etc/nixos` use that path instead; replace `.#komi` with a different flake output if you rename the hostname in `flake.nix`.

## Common commands

```bash
# Update flake inputs
nix flake update

# Enter developer shell
nix develop

# Format nix files
nixpkgs-fmt .

# Build the system to verify it builds (CI-friendly):
# nix build .#nixosConfigurations.komi.config.system.build.toplevel
```

## Troubleshooting hints

- Bluetooth: `systemctl status bluetooth`, `bluetoothctl scan on`, `lsmod | grep bluetooth`
- Keyboard backlight: `brightnessctl -l`, `lsmod | grep thinkpad_acpi`, check `/sys/class/leds/` or `/sys/class/backlight/`
- Displays: `hyprctl monitors`, inspect `home/hyprland.nix` monitor settings
- Audio: `pavucontrol`, `systemctl --user status pipewire`

## Recommendations & small fixes I applied

- README typos corrected (e.g., `brignessctl` → `brightnessctl`) and instruction paths clarified.
- Confirm `system.stateVersion` (in `nixos/configuration.nix`) vs `home.stateVersion` (`home/home.nix`) — keep them aligned with your target NixOS release for predictable behavior.
- Consider adding a top-level `LICENSE` file (README declares MIT but no LICENSE file exists) and a small CI workflow to run `nix flake check` / `nix build` on pushes/PRs.

## License

MIT (add a LICENSE file at the repo root if you want an explicit license file)

---

If you want, I can now:
- commit this updated README (I will) — or open a PR instead if you prefer review;
- add a LICENSE file with the MIT text;
- add a simple GitHub Actions workflow that runs `nix flake check` and `nix build .#nixosConfigurations.komi.config.system.build.toplevel` on pushes and PRs.

Which of these should I do next?