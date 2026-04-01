return {
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      cmd = "NvimTreeToggle",
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
            highlight_git = true,
            icons = {
              show = {
                git = true,
              },
            },
          },
          filters = {
            dotfiles = false,
            git_ignored = false, 
          },
          git = {
            enable = true,
            ignore = false,
            timeout = 200,
          },
        }
      end,
    },
}
