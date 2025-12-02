require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Relative line numbers with current line showing absolute number
vim.opt.relativenumber = true
vim.opt.number = true

-- Enable OSC 52 clipboard for SSH sessions (works with Ghostty, iTerm2, etc.)
-- This allows yanking to system clipboard over SSH
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

vim.opt.clipboard = "unnamedplus"
