local P = {}
keymaps = P
-- maps.lua

-- leader
vim.g.mapleader = ' '

-- key mapper
local map_key = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

-- shortcuts
map_key('n', '<leader>q', '<Cmd>q<CR>')
map_key('n', '<leader>w', '<Cmd>w<CR>')

-- nerdTREE
map_key('n', '<C-p>', '<Cmd>NERDTreeToggle<CR>')
map_key('n', '<S-p>', '<Cmd>NERDTreeFind<CR>')
vim.api.nvim_set_var('NERDTreeQuitOnOpen', 1)

-- Telescope
map_key('n', '<leader>p', ':lua require"telescope.builtin".find_files()<CR>')
map_key('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
map_key('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
map_key('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')

-- Buffers
map_key('n', '<leader><esc>', ':nohlsearch<cr>')
map_key('n', '<leader>n', ':bnext<cr>')
map_key('n', '<leader>b', ':bprev<cr>')

-- Java
function P.map_java_keys(bufnr)
  map_lsp_keys()

  local spring_boot_run = 'mvn spring-boot:run -Dspring-boot.run.profiles=local'
  local command = ':lua require("toggleterm").exec("' .. spring_boot_run .. '")<CR>'
  map_key('n', '<leader>sr', command)
  map_key('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
  map_key('n', '<leader>jc', ':lua require("jdtls").compile("incremental")')
end

return P
