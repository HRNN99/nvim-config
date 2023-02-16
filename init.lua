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
  use { -- CMP completion
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip'
    }
  }

    -- LSP java
  -- use "williamboman/mason.nvim"
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'mfussenegger/nvim-jdtls'
  use 'ray-x/lsp_signature.nvim'
  use 'akinsho/toggleterm.nvim'
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
  -- local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Terminal
require('toggleterm').setup()

-- CMP completion
local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },

  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_lenght = 3},
    {name = 'luasnip', keyword_lenght = 2},
  },

  window = {
    documentation = cmp.config.window.bordered()
  },
  mapping = {
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true
      }),
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
      ['<C-j>'] = function(fallback)
        if cmp.visible() then
          cmp.scroll_docs(4)
        else
          fallback()
        end
      end,
      ['<C-k>'] = function(fallback)
        if cmp.visible() then
          cmp.scroll_docs(-4)
        else
          fallback()
        end
      end,
      ['<C-Space>'] = cmp.mapping.complete(),
  }
  })
