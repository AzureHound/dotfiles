{
  plugins.lazygit = {
    enable = true;
    lazyLoad.settings.cmd = [
      "LazyGit"
      "LazyGitConfig"
      "LazyGitCurrentFile"
      "LazyGitFilter"
      "LazyGitFilterCurrentFile"
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>lua Snacks.lazygit()<cr>";
      options.desc = "Lazygit";
    }
    {
      mode = "n";
      key = "<leader>gf";
      action = "<cmd>lua Snacks.lazygit.log_file()<cr>";
      options.desc = "Lazygit Current File History";
    }
  ];
}
