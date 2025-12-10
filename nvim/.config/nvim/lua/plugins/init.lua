return {
  -- Telescope: configure find_files to include .cursor directory
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = {
          "node_modules/",
          ".git/",
          "dist/",
          "build/",
        },
      },
      pickers = {
        find_files = {
          -- Include gitignored files but use file_ignore_patterns above
          hidden = true,
          find_command = {
            "fd",
            "--type", "f",
            "--hidden",
            "--no-ignore-vcs",  -- Include gitignored files
            "--exclude", "node_modules",
            "--exclude", ".git",
            "--exclude", "dist",
            "--exclude", "build",
            "--exclude", ".next",
            "--exclude", "coverage",
          },
        },
      },
    },
  },

  -- NvimTree: show gitignored files
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
        ignore = false, -- show gitignored files
      },
      filters = {
        dotfiles = false,
        git_ignored = false, -- show gitignored files
      },
    },
  },

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
