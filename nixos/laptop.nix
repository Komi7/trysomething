{ pkgs, ... }:

{
  # Intel thermal management
  services.thermald.enable = true;

  # Laptop hardware keys and sensors
  hardware.sensor.iio.enable = true;

  environment.systemPackages = with pkgs; [
    lm_sensors
  ];

}
