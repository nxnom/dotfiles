local status, autotag = pcall(require, "nvim-ts-autotag")
if (not status) then return end

autotag.setup({
  opts = {
    enable_close = true,          -- Auto close tags
    enable_rename = true,         -- Auto rename pairs of tags
    enable_close_on_slash = true, -- Auto close tags when typing '/'
  },
})
