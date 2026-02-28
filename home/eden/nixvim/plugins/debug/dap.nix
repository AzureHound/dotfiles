{
  plugins = {
    dap = {
      enable = true;
      lazyLoad.settings.cmd = [
        "DapContinue"
        "DapToggleBreakpoint"
        "DapNew"
        "DapRestartFrame"
      ];
    };
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>db";
      action.__raw = "function() require('dap').toggle_breakpoint() end";
      options.desc = "Breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dc";
      action.__raw = "function() require('dap').continue() end";
      options.desc = "Continue";
    }
  ];
}
