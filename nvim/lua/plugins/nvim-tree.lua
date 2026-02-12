return {
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup {
          sort = {
            sorter = "case_sensitive",
          },
          view = {
            width = "20%",
          },
          renderer = {
            group_empty = true,
          },
          filters = {
            dotfiles = false,
            git_ignored = false, 
            custom = { ".DS_Store" }
          },
          git = {
            enable = true,
            ignore = false,
          },
        }
      end,
    },
}
