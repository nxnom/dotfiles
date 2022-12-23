local status, theme = pcall(require, "github-theme")
if (not status) then return end
--[[
theme.setup({
  theme_style = "dark",
  function_style = "italic",

  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  colors = { hint = "orange", error = "#ff0000" },
  dark_sidebar = false,
  hide_inactive_statusline = false,

  -- transparent = true,
  -- Overwrite the highlight groups
  -- overrides = function(c)
  --   return {
  --     htmlTag = { fg = c.red, bg = "#282c34", sp = c.hint, style = "underline" },
  --     DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
  --     -- this will remove the highlight groups
  --     TSField = {},
  --   }
  -- end
}) ]]
