-- with insert mode
vim.keymap.set('i', '{', '{}<Left>', { noremap = true })
vim.keymap.set('i', '[', '[]<Left>', { noremap = true })
vim.keymap.set('i', '(', '()<Left>', { noremap = true })
vim.keymap.set('i', '"', '""<Left>', { noremap = true })
vim.keymap.set('i', "'", "''<Left>", { noremap = true })

vim.keymap.set('i', 'jj', '<ESC>', { noremap = true })
vim.keymap.set('t', 'jj', '<C-\\><C-n>', { noremap = true })

-- with normal mode
vim.keymap.set('n', '<Tab>', '%', { noremap = true })

-- with visual mode
vim.keymap.set('v', '<Tab>', '%', { noremap = true })

-- ctags
vim.keymap.set('n', '<C-]>', 'g<C-]>', { noremap = true })

-- window split and move
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })
vim.keymap.set('n', '<C-x>', '<C-w>x', { noremap = true })

-- window size change
vim.keymap.set('n', '<S-Left>', '<C-w><', { noremap = true })
vim.keymap.set('n', '<S-Right>', '<C-w>>', { noremap = true })
vim.keymap.set('n', '-', '<C-w>-', { noremap = true })
vim.keymap.set('n', '+', '<C-w>+', { noremap = true })

-- no high-light
vim.keymap.set('n', '<silent> <Esc><Esc>', ':nohlsearch<CR>', { noremap = true, silent = true })

