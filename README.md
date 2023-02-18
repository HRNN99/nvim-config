## Install markdown-preview
add plugin in `~/.local/share/nvim/site/pack/packer/start/` directory:

``` bash
cd ~/.local/share/nvim/site/pack/packer/start/
git clone https://github.com/iamcco/markdown-preview.nvim.git
cd markdown-preview.nvim
yarn install
yarn build
```
Please make sure that you have installed `node.js` and `yarn`.
Open `nvim` and run `:PackerInstall` to make it workable
