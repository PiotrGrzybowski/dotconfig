local builtin = require('telescope.builtin')
require('telescope').load_extension('media_files')


vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>fi', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>fb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>fc', builtin.git_commits, {})
