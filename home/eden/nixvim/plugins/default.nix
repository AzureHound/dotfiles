{
  imports = [
    ./coding
    ./debug
    ./editor
    ./git
    ./lang
    ./term
    ./theme
  ];

  enableMan = false;
  plugins.lz-n.enable = true;

  extraConfigLuaPre = ''
    _G.root_cache = {}

    -- root detect
    function root_detect(buf)
      buf = buf or vim.api.nvim_get_current_buf()
      local bufname = vim.api.nvim_buf_get_name(buf)
      if bufname == "" then return { vim.uv.cwd() } end
      local bufpath = vim.fs.normalize(bufname)
      local roots = {}
      local clients = vim.lsp.get_clients({ bufnr = buf })
      for _, client in pairs(clients) do
        local workspace = client.config.workspace_folders
        for _, ws in pairs(workspace or {}) do
          roots[#roots + 1] = vim.uri_to_fname(ws.uri)
        end
        if client.root_dir then roots[#roots + 1] = client.root_dir end
      end

      local patterns = { ".git", "lua", "package.json", "flake.nix" }
      local found = vim.fs.find(patterns, { path = bufpath, upward = true })[1]
      if found then roots[#roots + 1] = vim.fs.dirname(found) end
      roots = vim.tbl_filter(function(p)
        return bufpath:find(vim.fs.normalize(p), 1, true) == 1
      end, roots)
      if #roots == 0 then return { vim.uv.cwd() } end
      table.sort(roots, function(a, b) return #a > #b end)
      return roots
    end

    function root_get(opts)
      opts = opts or {}
      local buf = opts.buf or vim.api.nvim_get_current_buf()
      if _G.root_cache[buf] then return _G.root_cache[buf] end
      local roots = root_detect(buf)
      _G.root_cache[buf] = roots[1]
      return roots[1]
    end

    -- git
    function root_git()
      local root = root_get()
      local git_root = vim.fs.find(".git", { path = root, upward = true })[1]
      return git_root and vim.fs.dirname(git_root) or root
    end
  '';

  autoCmd = [
    {
      event = [
        "LspAttach"
        "BufWritePost"
        "DirChanged"
        "BufEnter"
      ];
      group = "RootCache";
      callback.__raw = "function(event) _G.root_cache[event.buf] = nil end";
    }
  ];

  autoGroups.RootCache.clear = true;

  userCommands.RootInfo = {
    command.__raw = "function() print('Project Root: ' .. root_get()) end";
    desc = "Show root directory for current buffer";
  };
}
