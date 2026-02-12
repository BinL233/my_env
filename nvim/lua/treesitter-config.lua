-- Basic setup
require('nvim-treesitter').install({
  "c", "cpp", "cmake", "comment", "go", "java", "javascript",
  "jsx", "lua", "ledger", "markdown", "markdown_inline",
  "python", "rust", "typescript", "tsx", "vim", "vue", "zsh"
})

require('nvim-treesitter-textobjects').setup{
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  }
}

-- Autocommands
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "cpp", "cmake", "go", "java", "javascript", "javascriptreact", "ledger",
    "lua", "markdown", "python", "rust", "typescript", "typescriptreact", "vue"
  },
  callback = function()
    vim.treesitter.start()
  end,
  group = nvimrc_augroup
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "java", "typescriptreact", "javascriptreact", "python", "vue" },
  callback = function()
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldlevel = 99
  end,
  group = nvimrc_augroup
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascriptreact", "typescriptreact", "vue" },
  callback = function()
    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  end,
  group = nvimrc_augroup
})

-- Toggle mappings
vim.keymap.set('n', '<leader>st', function()
  if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil then
    vim.treesitter.stop()
    vim.print("Turned off treesitter highlighting...")
  else
    vim.treesitter.start()
    vim.print("Turned on treesitter highlighting...")
  end
end, { noremap=true, silent=true, desc="Toggle treesitter highlighting" })

vim.keymap.set('n', '<leader>sT', function()
  local current_indentexpr = vim.bo.indentexpr
  local current_buffer = vim.api.nvim_get_current_buf()
  if current_indentexpr ~= "v:lua.require('nvim-treesitter').indentexpr()" then
    vim.b[current_buffer].rahlir_previous_indentexpr = current_indentexpr
    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    vim.print("Turned on treesitter indent...")
  else
    local previous_indentexpr = vim.b[current_buffer].rahlir_previous_indentexpr
    if previous_indentexpr == nil then
      previous_indentexpr = ""
    end
    vim.bo.indentexpr = previous_indentexpr
    vim.print("Turned off treesitter indent...")
  end
end, { noremap=true, silent=true, desc="Toggle treesitter indent" })

-- Select keymappings
vim.keymap.set({ "x", "o" }, "af", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@function.outer", "textobjects")
end, { desc = "Function outer region" })
vim.keymap.set({ "x", "o" }, "if", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@function.inner", "textobjects")
end, { desc = "Function inner region" })

vim.keymap.set({ "x", "o" }, "ac", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@class.outer", "textobjects")
end, { desc = "Class outer region" })
vim.keymap.set({ "x", "o" }, "ic", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@class.inner", "textobjects")
end, { desc = "Class inner region" })

vim.keymap.set({ "x", "o" }, "aa", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@parameter.outer", "textobjects")
end, { desc = "Parameter outer region" })
vim.keymap.set({ "x", "o" }, "ia", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@parameter.inner", "textobjects")
end, { desc = "Parameter inner region" })

vim.keymap.set({ "x", "o" }, "ak", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@block.outer", "textobjects")
end, { desc = "Block outer region" })
vim.keymap.set({ "x", "o" }, "ik", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@block.inner", "textobjects")
end, { desc = "Block inner region" })

vim.keymap.set({ "x", "o" }, "ai", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@conditional.outer", "textobjects")
end, { desc = "Conditional outer region" })
vim.keymap.set({ "x", "o" }, "ii", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@conditional.inner", "textobjects")
end, { desc = "Conditional inner region" })

vim.keymap.set({ "x", "o" }, "al", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@loop.outer", "textobjects")
end, { desc = "Loop outer region" })
vim.keymap.set({ "x", "o" }, "il", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@loop.inner", "textobjects")
end, { desc = "Loop inner region" })

vim.keymap.set({ "x", "o" }, "a=", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@assignment.outer", "textobjects")
end, { desc = "Assignment outer region" })
vim.keymap.set({ "x", "o" }, "i=", function()
  require('nvim-treesitter-textobjects.select').select_textobject("@assignment.inner", "textobjects")
end, { desc = "Assignment inner region" })

-- Move keymappings
vim.keymap.set({ "n", "x", "o" }, "]m", function()
  require('nvim-treesitter-textobjects.move').goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function" })
vim.keymap.set({ "n", "x", "o" }, "]M", function()
  require('nvim-treesitter-textobjects.move').goto_next_end("@function.outer", "textobjects")
end, { desc = "End of next function" })
vim.keymap.set({ "n", "x", "o" }, "[m", function()
  require('nvim-treesitter-textobjects.move').goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function" })
vim.keymap.set({ "n", "x", "o" }, "[M", function()
  require('nvim-treesitter-textobjects.move').goto_previous_end("@function.outer", "textobjects")
end, { desc = "End of previous function" })

vim.keymap.set({ "n", "x", "o" }, "]]", function()
  require('nvim-treesitter-textobjects.move').goto_next_start("@class.outer", "textobjects")
end, { desc = "Next class" })
vim.keymap.set({ "n", "x", "o" }, "][", function()
  require('nvim-treesitter-textobjects.move').goto_next_end("@class.outer", "textobjects")
end, { desc = "End of next class" })
vim.keymap.set({ "n", "x", "o" }, "[[", function()
  require('nvim-treesitter-textobjects.move').goto_previous_start("@class.outer", "textobjects")
end, { desc = "Previous class" })
vim.keymap.set({ "n", "x", "o" }, "[]", function()
  require('nvim-treesitter-textobjects.move').goto_previous_end("@class.outer", "textobjects")
end, { desc = "End of previous class" })

vim.keymap.set({ "n", "x", "o" }, "]k", function()
  require('nvim-treesitter-textobjects.move').goto_next_start("@block.outer", "textobjects")
end, { desc = "Next block" })
vim.keymap.set({ "n", "x", "o" }, "]K", function()
  require('nvim-treesitter-textobjects.move').goto_next_end("@block.outer", "textobjects")
end, { desc = "End of next block" })
vim.keymap.set({ "n", "x", "o" }, "[k", function()
  require('nvim-treesitter-textobjects.move').goto_previous_start("@block.outer", "textobjects")
end, { desc = "Previous block" })
vim.keymap.set({ "n", "x", "o" }, "[K", function()
  require('nvim-treesitter-textobjects.move').goto_previous_end("@block.outer", "textobjects")
end, { desc = "End of previous block" })

vim.keymap.set({ "n", "x", "o" }, "]a", function()
  require('nvim-treesitter-textobjects.move').goto_next_start("@parameter.outer", "textobjects")
end, { desc = "Next parameter" })
vim.keymap.set({ "n", "x", "o" }, "]A", function()
  require('nvim-treesitter-textobjects.move').goto_next_end("@parameter.outer", "textobjects")
end, { desc = "End of next parameter" })
vim.keymap.set({ "n", "x", "o" }, "[a", function()
  require('nvim-treesitter-textobjects.move').goto_previous_start("@parameter.outer", "textobjects")
end, { desc = "Previous parameter" })
vim.keymap.set({ "n", "x", "o" }, "[A", function()
  require('nvim-treesitter-textobjects.move').goto_previous_end("@parameter.outer", "textobjects")
end, { desc = "End of previous parameter" })
