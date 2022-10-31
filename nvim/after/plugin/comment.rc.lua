local status, comment = pcall(require, "Comment")
if (not status) then return end

-- Check out the doc - https://github.com/numToStr/Comment.nvim
comment.setup {
  -- For creating comment in jsx, [Document](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
