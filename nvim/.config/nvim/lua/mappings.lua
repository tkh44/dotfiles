require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Recent files (like WebStorm Cmd+E)
map("n", "<leader>e", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- Grep selected text in visual mode
map("v", "<leader>fw", function()
  local text = vim.getVisualSelection()
  require("telescope.builtin").live_grep({ default_text = text })
end, { desc = "Live grep selection" })

-- Grep word under cursor (normal mode)
map("n", "<leader>*", function()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").live_grep({ default_text = word })
end, { desc = "Live grep word under cursor" })

-- Helper function to get visual selection
function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})
  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- TypeScript specific mappings
-- Auto-import: use code action (leader+ca shows all, or use specific import action)
map("n", "<leader>i", function()
  vim.lsp.buf.code_action({
    apply = true,
    filter = function(action)
      return action.title:match("Add import") or action.title:match("Import")
    end,
  })
end, { desc = "Auto import" })

-- Add all missing imports
map("n", "<leader>ai", function()
  vim.lsp.buf.code_action({
    apply = true,
    filter = function(action)
      return action.title:match("Add all missing imports")
    end,
  })
end, { desc = "Add all missing imports" })

-- Organize imports (remove unused, sort)
map("n", "<leader>oi", function()
  vim.lsp.buf.code_action({
    apply = true,
    filter = function(action)
      return action.title:match("Organize imports")
    end,
  })
end, { desc = "Organize imports" })

-- ESLint fix all (manual trigger)
map("n", "<leader>lf", function()
  vim.cmd("EslintFixAll")
end, { desc = "ESLint fix all" })

-- Git blame
map("n", "<leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Git blame line" })

map("n", "<leader>gB", function()
  require("gitsigns").blame()
end, { desc = "Git blame buffer (full file)" })

-- Toggle inline blame (shows at end of current line)
map("n", "<leader>gt", function()
  require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle inline git blame" })

-- Reload Neovim config
map("n", "<leader>rr", function()
  vim.cmd("source $MYVIMRC")
  vim.notify("Config reloaded!", vim.log.levels.INFO)
end, { desc = "Reload config" })
