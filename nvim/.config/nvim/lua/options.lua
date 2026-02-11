require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Relative line numbers with current line showing absolute number
vim.opt.relativenumber = true
vim.opt.number = true

-- Only use OSC 52 clipboard over SSH, native clipboard locally
if vim.env.SSH_TTY or vim.env.SSH_CLIENT then
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = osc52.paste("+"),
      ["*"] = osc52.paste("*"),
    },
  }
end

vim.opt.clipboard = "unnamedplus"
