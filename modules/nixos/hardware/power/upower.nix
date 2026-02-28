{ config, ... }:

{
  services.upower = {
    enable = config.pixel.profiles.laptop.enable;

    percentageLow = 15;
    percentageCritical = 5;
    percentageAction = 3;
    criticalPowerAction = "Hibernate";
  };
}
