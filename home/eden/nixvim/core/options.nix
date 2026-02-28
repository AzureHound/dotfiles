{
  globals = {
    mapleader = " ";
    maplocalleader = "\\";

    # global
    autoformat = true;
    editorconfig = true;
    deprecation_warnings = false;

    # Nav & Roots
    picker = "auto";
    root_spec = [
      "lsp"
      [
        ".git"
        "lua"
      ]
      "cwd"
    ];
    # root_lsp_ignore = [ "copilot" ];

    # Completion
    cmp = "auto";
    # ai_cmp = true;

    # Netrw
    netrw_liststyle = 3;
    netrw_banner = 0;
    netrw_browse_split = 0;
    netrw_winsize = 25;
  };

  opts = {
    # UI
    termguicolors = true;
    background = "dark";
    title = true;
    showtabline = 0;
    cursorline = true;
    number = true;
    relativenumber = true;
    signcolumn = "yes";
    # colorcolumn = "120";
    conceallevel = 2;
    winminwidth = 5;
    winborder = "rounded";
    guicursor = "n-v-c:block-blinkon400-blinkoff400,i-ci-ve:ver25-blinkon400-blinkoff400,r-cr:hor20-blinkon400-blinkoff400,o:hor50-blinkon400-blinkoff400";

    # Symbols & Chars
    list = true;
    listchars = {
      tab = "> ";
      trail = "·";
      space = " ";
      nbsp = "␣";
      extends = "…";
      precedes = "…";
    };

    fillchars = {
      foldopen = "";
      foldclose = "";
      fold = " ";
      foldsep = " ";
      diff = "╱";
      eob = " ";
    };

    # Editor
    encoding = "utf-8";
    fileencoding = "utf-8";
    undofile = true;
    undodir.__raw = ''vim.fn.expand("$HOME") .. "/.local/state/nvim/undodir"'';
    undolevels = 10000;
    updatetime = 200;
    synmaxcol = 240;
    timeout = true;
    timeoutlen = 300;
    autowrite = true;
    confirm = true;
    shortmess = "WIcCF";
    virtualedit = "block";
    clipboard.__raw = "vim.env.SSH_CONNECTION and '' or 'unnamedplus'";

    # Movement & Scrolling
    mouse = "a";
    mousemodel = "extend";
    smoothscroll = true;
    scrolloff = 10;
    sidescrolloff = 8;
    jumpoptions = "view";

    # Tabs & Indentation
    expandtab = true;
    tabstop = 2;
    shiftwidth = 2;
    softtabstop = 2;
    smartindent = true;
    smarttab = true;
    autoindent = true;
    # breakindent = true;
    copyindent = true;
    preserveindent = true;
    shiftround = true;
    backspace = "start,eol,indent";

    # Search
    ignorecase = true;
    smartcase = true;
    hlsearch = true;
    incsearch = true;
    inccommand = "split";

    # Completion
    completeopt = "menu,menuone,noselect";
    infercase = true;
    pumheight = 10;
    pumblend = 0;

    # Windows & Splits
    splitbelow = true;
    splitright = true;
    splitkeep = "screen";

    # Cmdline & Stat
    laststatus = 3;
    statuscolumn = "%!v:lua.require'snacks.statuscolumn'.get()";
    showmode = false;
    ruler = false;
    cmdheight = 0;
    # showcmd = false;
    history = 100;

    # Filesystem & Sessions
    swapfile = false;
    backup = false;
    writebackup = false;
    modeline = true;
    modelines = 100;
    path = [ "**" ];
    wildmode = "longest:full,full";
    wildignore = [ "*/node_modules/*" ];
    sessionoptions = [
      "buffers"
      "curdir"
      "tabpages"
      "winsize"
      "help"
      "globals"
      "skiprtp"
      "folds"
    ];

    # Folds
    foldenable = true;
    # foldmethod = "indent";
    foldmethod = "expr";
    foldexpr = "v:lua.vim.treesitter.foldexpr()";
    foldlevel = 99;
    foldlevelstart = 99;
    foldtext = "";

    # Formatting & Grep
    grepprg = "rg --vimgrep";
    grepformat = "%f:%l:%c:%m";
    formatoptions = "jcroqlnt";
    # formatoptions = "jcroqlntr";
    formatexpr = "v:lua.vim.lsp.formatexpr()";

    # Lang & Wrap
    spelllang = [ "en" ];
    wrap = false;
    linebreak = true;
    # textwidth = 120;
  };
}
