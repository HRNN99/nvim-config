-- inits
let = vim
set = vim.opt
o = vim.o
bo = vim.bo
wo = vim.wo

-- basic setup
wo.number = true
wo.relativenumber = true
wo.signcolumn = 'yes'
wo.wrap = false

o.syntax = true
o.termguicolors = true
o.smartcase = true
o.signcolumn = 'yes'
o.linespace = 8

--tabs and shifts
o.shiftwidth = 2
o.tabstop = 2
o.softtabstops = 2
o.expandtab = true

o.undodir = vim.fn.stdpath("config") .. '/undodir' -- saves the changes for easy undo/redo them
o.undofile = true
o.incsearch = true -- to mark all ocurrences while searching
o.hidden = true -- Close buffers
o.completeopt = 'menuone,noinsert,noselect'

bo.swapfile = false
bo.autoindent = true
bo.smartindent = true

