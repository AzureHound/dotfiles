{ config, ... }:

{
  services.auto-cpufreq = {
    inherit (config.pixel.profiles.laptop) enable;

    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };

      charger = {
        governor = "powersave";
        turbo = "auto";
      };
    };
  };
}
