{ name, ... }:

{
  services.usbguard = {
    enable = true;

    IPCAllowedUsers = [
      "root"
      name
    ];

    # dbus.enable = true;

    rules = ''

    '';
  };
}
