{
  plugins = {
    overseer = {
      enable = true;
      lazyLoad.settings.cmd = [
        "OverseerOpen"
        "OverseerClose"
        "OverseerToggle"
        "OverseerSaveBundle"
        "OverseerLoadBundle"
        "OverseerDeleteBundle"
        "OverseerRunCmd"
        "OverseerRun"
        "OverseerInfo"
        "OverseerBuild"
        "OverseerQuickAction"
        "OverseerTaskAction"
        "OverseerClearCache"
      ];
    };

    compiler = {
      enable = true;
      lazyLoad.settings = {
        cmd = [
          "CompilerOpen"
          "CompilerRedo"
          "CompilerStop"
          "CompilerToggleResults"
        ];
        before.__raw = ''
          function()
            require('lz.n').trigger_load('overseer.nvim')
          end
        '';
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>R";
        group = "Compiler";
        icon = "";
      }
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>Ro";
      action = "<cmd>CompilerOpen<CR>";
      options.desc = "Compiler Open";
    }
    {
      mode = "n";
      key = "<leader>Rr";
      action = "<cmd>CompilerRedo<CR>";
      options.desc = "Compiler Redo";
    }
    {
      mode = "n";
      key = "<leader>Rs";
      action = "<cmd>CompilerStop<CR>";
      options.desc = "Compiler Stop";
    }
    {
      mode = "n";
      key = "<leader>Rt";
      action = "<cmd>CompilerToggleResults<CR>";
      options.desc = "Compiler Toggle Results";
    }
  ];
}
