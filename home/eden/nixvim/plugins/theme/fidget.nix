{
  plugins.fidget = {
    enable = true;
    settings = {
      progress = {
        ignore_done_already = true;
        ignore_empty_message = true;
      };
      notification = {
        configs = {
          default = {
            name = "";
            icon = "";
            group = "Notifications";
          };
        };
        window.winblend = 0;
      };
    };
  };
}
