-- search options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- edit options
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.infercase = true
vim.opt.virtualedit = 'all'
vim.opt.hidden = true
vim.opt.switchbuf = 'useopen'
vim.opt.showmatch = true
vim.opt.matchtime = 3
vim.opt.matchpairs:append('<:>')
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.swapfile = false
if vim.fn.has('mac') == 1 then
  vim.opt.undofile = false
end
vim.opt.clipboard:append('unnamedplus')

-- display options
vim.cmd('syntax on')
vim.opt.termguicolors = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.number = true
vim.opt.wrap = true
vim.opt.textwidth = 0
vim.opt.visualbell = true
vim.opt.listchars = {
  tab = '»-',
  trail = '-',
  extends = '»',
  precedes = '«',
  nbsp = '%',
  eol = '↲'
}

