return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save enabled
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Treesitter with TypeScript/React support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "markdown",
        "markdown_inline",
        "go",
        "gomod",
        "gosum",
        "gowork",
      },
    },
  },

  -- Auto-close and auto-rename JSX tags
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "xml",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Better TypeScript error display (optional but nice)
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = {},
  },
}
