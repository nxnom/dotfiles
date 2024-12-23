local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
    initial_mode = "insert",
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '-uu' -- **This is the setting not being respected**
    },
    file_ignore_patterns = {
      ".git/", ".direnv", "node_modules", "build/", "dist/", "yarn.lock", "package-lock.json", ".cache/", ".idea/", "zsh/plugins/", "target/debug", "/log/", ".fvm/flutter_sdk", "ios/Pods", "ios/Podfile.lock", "ios/Pods", ".next/", ".docusaurus", ".turbo/"
    }
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      hidden = true,
      grouped = true,
      initial_mode = "normal",
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

telescope.load_extension("file_browser")

vim.keymap.set('n', '<Leader>ff',
  function()
    builtin.find_files({
      -- cwd = telescope_buffer_dir(),
      hidden = true,
      follow = true,
      respect_gitignore = false,
      find_command = { 'rg', '--no-ignore', '--hidden', '--files', '--ignore-parent' },
    })
  end)
vim.keymap.set('n', '<C-f>', function()
  builtin.live_grep()
end)
vim.keymap.set('n', '<Leader>;;', function()
  builtin.buffers()
end)
vim.keymap.set('n', '<Leader>help', function()
  builtin.help_tags()
end)
vim.keymap.set('n', '<Leader>rs', function()
  builtin.resume()
end)
vim.keymap.set('n', '<Leader>ee', function()
  builtin.diagnostics()
end)
vim.keymap.set("n", "<Leader>sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    initial_mode = "normal",
    -- layout_config = { height = 40 }
  })
end)
