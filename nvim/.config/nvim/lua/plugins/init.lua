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
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
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
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
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

  -- Seamless navigation between nvim splits and tmux panes (Ctrl-h/j/k/l)
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left (nvim/tmux)" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down (nvim/tmux)" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up (nvim/tmux)" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right (nvim/tmux)" },
    },
  },

  -- Git diff viewer (like WebStorm/IntelliJ)
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Git diff view" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gl", "<cmd>DiffviewFileHistory<cr>", desc = "Git log" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
    },
  },

  -- Croissant-style review comments directly in Neovim
  {
    dir = "/Users/kyehohenberger/instacart/croissant.nvim",
    name = "croissant.nvim",
    lazy = false,
    config = function()
      require("croissant").setup({
        backend = "local",
        default_keymaps = true,
        keymaps = {
          comment = "<leader>mc",
          review = "<leader>mr",
          codex = "<leader>mx",
        },
        prompt = {
          backend = "float",
          float = {
            width = 72,
            border = "rounded",
            title = "Croissant comment",
          },
        },
      })
    end,
  },
}
