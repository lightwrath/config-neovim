local builtin = require('telescope.builtin')

vim.g.mapleader = " "
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

vim.keymap.set('n', '<leader>f', builtin.git_files, {})

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
