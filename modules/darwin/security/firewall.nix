{
  networking.applicationFirewall = {
    enable = true;
    blockAllIncoming = false;

    allowSignedApp = false;
    allowSigned = true;

    # Apple menu > System Preferences > Security and firewall
    # Drops incoming requests via ICMP [ Default = 0 ].
    enableStealthMode = true;
  };
}
