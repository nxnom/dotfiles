local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  'kevinhwang91/promise-async',
  -- favourite nvim plugins
  "metakirby5/codi.vim",
  -- 'jose-elias-alvarez/null-ls.nvim',
  'nvimtools/none-ls.nvim',
  -- { 'mattn/emmet-vim', } -- emmet-vim good but there is emmet-ls(using builtin LSP client)

  -- like Codi but not as good
  -- { 'michaelb/sniprun', run = 'bash ./install.sh' } -- Run code snippets without leaving the editor

  'williamboman/mason.nvim', -- easy LSP, formatter installer
  'williamboman/mason-lspconfig.nvim',

  'nvim-lualine/lualine.nvim', -- Statusline

  -- LSP
  'neovim/nvim-lspconfig', -- LSP
  'glepnir/lspsaga.nvim',  -- Use LSP to use go to def, code action, errors ,etc...
  -- 'hrsh7th/cmp-buffer',    -- nvim-cmp source for buffer words
  'hrsh7th/cmp-nvim-lsp',  -- nvim-cmp source for neovim's built-in LSP
  'hrsh7th/nvim-cmp',      -- Completion
  'L3MON4D3/Luasnip',
  'rafamadriz/friendly-snippets',
  'saadparwaiz1/cmp_luasnip',

  -- 'direnv/direnv.vim', -- direnv support

  'nanotee/sqls.nvim',
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  },
  { 'akinsho/git-conflict.nvim', version = "*",                                                      config = true },

  -- Debuggers
  'mfussenegger/nvim-dap',
  { "rcarriga/nvim-dap-ui",      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  'mxsdev/nvim-dap-vscode-js',

  -- Download and compiled Debuggers excutables
  -- { "microsoft/vscode-js-debug", opt = true, run = "npm install --legacy-peer-deps && npm run compile" }
  -- { "microsoft/vscode-chrome-debug", opt = true, run = "npm install && npm run build" }
  -- { "Dart-Code/Dart-Code", opt = true, run = "npm install && npx webpack --mode production" }
  -- end Debuggers

  {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  },
  'nvim-treesitter/playground',

  -- Auto tag and auto pair
  'windwp/nvim-autopairs',
  'windwp/nvim-ts-autotag',

  'nvim-lua/plenary.nvim',        -- Common utils
  'kyazdani42/nvim-web-devicons', -- File icons

  {
    "ThePrimeagen/harpoon",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    branch = "harpoon2",
    config = true,
  },

  -- Telescope
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-file-browser.nvim',
  -- fzf
  -- { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end, }

  'akinsho/nvim-bufferline.lua',
  -- 'norcalli/nvim-colorizer.lua' -- show color

  -- git
  'lewis6991/gitsigns.nvim',
  'dinhhuy258/git.nvim', -- For git blame & browse

  -- Toggle Comments
  'numToStr/Comment.nvim',
  'JoosepAlviste/nvim-ts-context-commentstring', -- For JSX Comments

  -- Fold Codes
  'kevinhwang91/promise-async',
  'kevinhwang91/nvim-ufo',

  -- Themes
  { "catppuccin/nvim", name = "catppuccin" },

  -- AI
  'github/copilot.vim',

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                          -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },

  -- markdown previewer
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function() vim.fn["mkdp#util#install"]() end,
  -- },
  -- install with yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Highlight, the current code block using treesitter
  -- Amazing plugin
  {
    "folke/twilight.nvim",
    lazy = true,
    config = function()
      require("twilight").setup {}
    end
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }
}

require("lazy").setup(plugins)
