- start a nixos container
  - `docker run -it nixos/nix`
- enable flakes
  - `echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf`
- install the packages required
  - `nix profile install nixpkgs#neovim nixpkgs#fzf nixpkgs#nodejs_22 nixpkgs#typescript nixpkgs#nodePackages.typescript-language-server nixpkgs#prettierd nixpkgs#gcc`
- create the config directory
  - `mkdir -p ~/.config/nvim`
- create the init.lua
  - `cd ~/.config/nvim && nvim init.lua`
- change the colourscheme, prove we're reading right
  - vim.cmd('colorscheme habamax') && :source %
  - setup the config update keybind
- add 7 options
  - vim.opt.number = true
  - vim.opt.shiftwidth = 0
  - vim.opt.sidescrolloff = 7
  - vim.opt.softtabstop = 4
  - vim.opt.splitbelow = true
  - vim.opt.splitright = true
  - vim.opt.tabstop = 4 -- best explanation of tab settings
- fix the leader
  - vim.g.mapleader = " "
  - vim.g.maplocalleader = " "
  - vim.keymap.set({ "n", "v" }, " ", "<nop>", { silent = true })
- now add some plugins!
  - create /pack/plugins/start
  - git submodule add <package>
  - do surround, then conform, then fzf, then lsp, then treesitter
  - create test.js, show that it works!

FINAL:

```lua
-- set the leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, " ", "<nop>", { silent = true })

-- set desired options
vim.opt.number = true
vim.opt.shiftwidth = 0
vim.opt.sidescrolloff = 7
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4 -- best explanation of tab settings

-- set custom keybinds
vim.keymap.set('n', '<leader>r', function()
print('updating config')
return '<cmd>source ~/.config/nvim/init.lua<cr>'
end, {expr = true})
vim.keymap.set('n', '<leader>e', '<cmd>Ex<cr>', {silent=true})

-- setup plugins
-- put the submodule in /pack/plugins/start to access the code, then follow plugin readme
require('nvim-surround').setup()
require('conform').setup({
formatters_by_ft = {
javascript = {"prettierd"}
},
format_on_save = {
timeout_ms = 500,
lsp_format = 'fallback'
}
})
vim.keymap.set('n', '<leader>f', require('fzf-lua').files)
vim.lsp.enable({"ts_ls"})

local parsers = { "comment", "javascript", "typescript", "vim", "vimdoc" }
require("nvim-treesitter.configs").setup({
ensure_installed = parsers,
highlight = {
enable = true,
additional_vim_regex_highlighting = false,
},
})
```
