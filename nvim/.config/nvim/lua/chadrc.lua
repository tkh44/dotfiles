-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "doomchad",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

-- Statusline: rounded separators match the doomchad aesthetic
M.ui = {
  statusline = {
    separator_style = "round",
  },
  tabufline = {
    enabled = false,
  },
}

return M
