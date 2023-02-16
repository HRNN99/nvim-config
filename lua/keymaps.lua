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

-- Git functions
function git_commit_all()
  vim.ui.input({ prompt = 'Msg: ' }, function(input)
    io.popen("git add . && git commit -am '" .. input .. "'")
  end)
end

function git_commit_push_all()
  vim.ui.input({ prompt = 'Msg: ' }, function(input)
    io.popen("git add . && git commit -am '" .. input .. "' && git push")
  end)
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

-- GIT
map_key('n', '<leader>gc', ':lua git_commit_all()<CR>')
map_key('n', '<leader>gp', ':lua git_commit_push_all()<CR>')

-- Java
map_key('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
map_key('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
map_key('n', '<leader>jc', ':lua require("jdtls").compile("incremental")')
map_key('n', "<leader>ca", ':lua vim.lsp.buf.code_action()<CR>')
map_key('n', "<leader>gd", ':lua vim.lsp.buf.definition()<CR>')
map_key('n', "<leader>gi", ':lua vim.lsp.buf.implementation()<CR>')
map_key('n', "<C-S>f", ':lua vim.lsp.buf.formatting()<CR>')
map_key('n', "<C-S>r", ':lua vim.lsp.buf.rename()<CR>')
map_key('n', "<leader>cr", ':lua require"telescope.builtin".lsp_references()<CR>')
local spring_boot_run = 'mvn spring-boot:run -Dspring-boot.run.profiles=local'
local run= ':lua require("toggleterm").exec("' .. spring_boot_run .. '")<CR>'
local test= ':lua require("toggleterm").exec("' .. 'mvn test' .. '")<CR>'
map_key('n', '<leader>sr', run)
map_key('n', '<leader>st', test)

function P.map_java_keys(bufnr)
  map_lsp_keys()

 

end

return P
