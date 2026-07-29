{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;

    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd start-hyprland";
      user = "greeter";
    };
  };

  environment.systemPackages = with pkgs; [
    tuigreet
  ];
}