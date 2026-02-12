return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- branch = "master",
    -- "LazyFile" is not a real event. Use these instead:
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
        {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre", -- Load it early enough to show
        config = function()
          require("treesitter-context").setup({
            enable = true,
            max_lines = 3, -- Limits context to 3 lines (good for small screens)
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to show for a single context
            trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded
            mode = 'cursor',  -- Calculate context based on cursor position (smoother)
            separator = nil,
            zindex = 20,
          })
          -- TIP: Context is annoying in Markdown/text files, so we disable it there

          vim.api.nvim_create_autocmd("FileType", {
            pattern = { "markdown", "json", "yaml" },
            callback = function()
              require("treesitter-context").disable()
            end,
          })
        end
      },
    },
  },

  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
