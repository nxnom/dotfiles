local status, packer = pcall(require, 'packer')

if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- favourite nvim plugins
  use "metakirby5/codi.vim"             -- The interactive scratchpad.
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  -- end

  -- use { 'mattn/emmet-vim', } -- emmet-vim good but there is emmet-ls(using builtin LSP client)

  -- like Codi but not as good
  -- use { 'michaelb/sniprun', run = 'bash ./install.sh' } -- Run code snippets without leaving the editor

  use 'williamboman/mason.nvim' -- easy LSP, formatter installer
  use 'williamboman/mason-lspconfig.nvim'

  use 'nvim-lualine/lualine.nvim' -- Statusline

  -- LSP
  use 'neovim/nvim-lspconfig' -- LSP
  use 'glepnir/lspsaga.nvim'  -- Use LSP to use go to def, code action, errors ,etc...
  -- use 'hrsh7th/cmp-buffer'    -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp'  -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp'      -- Completion
  use 'L3MON4D3/Luasnip'
  use 'rafamadriz/friendly-snippets'
  use 'saadparwaiz1/cmp_luasnip'

  use 'nanotee/sqls.nvim'
  use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Debuggers
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'mxsdev/nvim-dap-vscode-js'

  -- Download and compiled Debuggers excutables
  use { "microsoft/vscode-js-debug", opt = true, run = "npm install --legacy-peer-deps && npm run compile" }
  use { "microsoft/vscode-chrome-debug", opt = true, run = "npm install && npm run build" }
  use { "Dart-Code/Dart-Code", opt = true, run = "npm install && npx webpack --mode production" }
  -- end Debuggers

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- Auto tag and auto pair
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  use 'nvim-lua/plenary.nvim'        -- Common utils
  use 'kyazdani42/nvim-web-devicons' -- File icons

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  -- fzf
  -- use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end, }

  use 'akinsho/nvim-bufferline.lua'
  -- use 'norcalli/nvim-colorizer.lua' -- show color

  -- git
  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse

  -- Toggle Comments
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- For JSX Comments

  -- Fold Codes
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

  -- Themes
  use { "catppuccin/nvim", as = "catppuccin" }

  -- AI
  use 'github/copilot.vim'

  -- markdown previewer
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Highlight, the current code block using treesitter
  -- Amazing plugin
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {}
    end
  }
end)
