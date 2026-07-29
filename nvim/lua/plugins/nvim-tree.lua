return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        cmd = "NvimTreeToggle",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local documents_icons = require("icons").get("documents")
            local git_icons = require("icons").get("git")

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
                        glyphs = {
                            default = documents_icons.File,
                            symlink = documents_icons.Symlink,
                            git = {
                                unstaged = git_icons.Unstaged,
                                staged = git_icons.Staged,
                                unmerged = git_icons.Unmerged,
                                renamed = git_icons.Rename,
                                untracked = git_icons.Untracked,
                                deleted = git_icons.Remove,
                                ignored = git_icons.Ignore,
                            },
                        },
                        show = {
                            git = true,
                            folder = true,
                            file = true,
                            folder_arrow = true,
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
