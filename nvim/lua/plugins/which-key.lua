return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      -- ── Groups ────────────────────────────────────────────────────────────
      { "<leader>f", group = "Find" },
      { "<leader>l", group = "LSP" },
      { "g",         group = "Go To" },

      -- ── Window resize ─────────────────────────────────────────────────────
      { "<C-Up>",    desc = "Resize window up",    mode = "n" },
      { "<C-Down>",  desc = "Resize window down",  mode = "n" },
      { "<C-Left>",  desc = "Resize window left",  mode = "n" },
      { "<C-Right>", desc = "Resize window right", mode = "n" },

      -- ── File tree ─────────────────────────────────────────────────────────
      { "<leader>t", desc = "Toggle file tree",    mode = "n" },

      -- ── Diffview ──────────────────────────────────────────────────────────
      { "<leader>d", desc = "Toggle Diffview",     mode = "n" },

      -- ── Telescope ─────────────────────────────────────────────────────────
      { "<leader>ff", desc = "Telescope find files", mode = "n" },
      { "<leader>fg", desc = "Telescope live grep", mode = "n" },
      { "<leader>fb", desc = "Telescope buffers", mode = "n" },
      { "<leader>fh", desc = "Telescope help tags", mode = "n" },

      -- ── Outline ───────────────────────────────────────────────────────────
      { "<leader>o", desc = "Toggle Outline",      mode = "n" },

      -- ── Buffers (barbar) ──────────────────────────────────────────────────
      { "<A-,>", desc = "Previous buffer",         mode = "n" },
      { "<A-.>", desc = "Next buffer",             mode = "n" },
      { "<A-c>", desc = "Close buffer",            mode = "n" },

      -- ── LSP / Go To ───────────────────────────────────────────────────────
      { "gd", desc = "Go to Definition",           mode = "n" },
      { "gb", desc = "Go Back from Definition",    mode = "n" },
      { "gv", desc = "Go to Definition in Split",  mode = "n" },

      -- ── Lspsaga ───────────────────────────────────────────────────────────
      { "<leader>lc", desc = "Lspsaga code_action", mode = "n" },
      { "<leader>li", desc = "Lspsaga incoming_calls", mode = "n" },
      { "<leader>lo", desc = "Lspsaga outgoing_calls", mode = "n" },
      { "<leader>ld", desc = "Lspsaga peek_definition", mode = "n" },
      { "<leader>lt", desc = "Lspsaga term_toggle", mode = "n" },

      -- ── Flash ─────────────────────────────────────────────────────────────
      { "s", desc = "Flash jump",                  mode = { "n", "x", "o" } },
      { "S", desc = "Flash treesitter",            mode = { "n", "x", "o" } },
      { "r", desc = "Remote flash",                mode = "o" },
      { "R", desc = "Treesitter search",           mode = { "o", "x" } },
      { "<C-s>", desc = "Toggle flash search",     mode = "c" },

      -- ── Visual indentation ────────────────────────────────────────────────
      { "<", desc = "Indent left",                 mode = "v" },
      { ">", desc = "Indent right",                mode = "v" },

      -- ── Which-key itself ──────────────────────────────────────────────────
      { "<leader>?", desc = "Buffer local keymaps", mode = "n" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
