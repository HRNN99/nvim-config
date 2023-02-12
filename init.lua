-- let in nvim conf = vim.api.nvim_set_var('var', 'value')
--                  = vim.g['some#var'] = 'value'
-- set in nvim conf = vim.opt.(etc)
--
-- imports
require('keymaps')
require('basic')
-- require("mason").setup()
-- local nvim_lsp = require'lspconfig' 


local packer = require'packer'
local util = require'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'morhetz/gruvbox'-- themes
  use 'lukas-reineke/indent-blankline.nvim' -- indent
  use 'tpope/vim-commentary' --comments
  use 'windwp/nvim-autopairs' --autopairs
  use 'max397574/better-escape.nvim' --scape from modes with jj or jk
  use 'romgrk/barbar.nvim' -- file name and icon
  use 'nvim-tree/nvim-web-devicons' -- icons
  use 'nvim-telescope/telescope.nvim' --find files
  use 'nvim-lua/plenary.nvim' --telescope dep
  use 'nvim-lua/popup.nvim' -- telescope dep
  use 'vim-airline/vim-airline' -- show status bar
  use 'airblade/vim-gitgutter' --show git modifications
  use 'preservim/nerdtree' -- file explorer
  use 'ThePrimeagen/vim-be-good' -- vim practice
    -- LSP java
  -- use "williamboman/mason.nvim"
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'mfussenegger/nvim-jdtls'
end
)

vim.cmd("colorscheme gruvbox")
o.background = 'dark'

-- indent config
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

-- vim-comentary config
require("nvim-autopairs").setup{}

-- better-scape config
require("better_escape").setup {
    mapping = {"jk", "jj"}, -- a table with mappings to use
    timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
}

-- TreeSettter Config
local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = {"lua", "c", "json", "html", "javascript", "java", "markdown", "dockerfile"},
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true }
}


-- LSP config
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
