# AIMS

To create a minimal neovim setup that is usable in a typescript project.
Ref: https://github.com/artcodespace/youtube/tree/main/neovim-0.11-setup

# PREREQUISITES

- git (for submodules)
- gcc (for treesitter)
- neovim (0.11)
- fzf
- node
- typescript & language server
- prettier
  OR
- docker to follow along in the nix container (commands can be seen in instructions.md)

# STEPS

- start the nix container
- enable experimental features
- install the required packages
- create the config directory and configuration file
- add a couple of useful keybinds and options
- add the "essential" plugins
  - surround helper (nvim-surround, arguable if essential)
  - formatter (conform.nvim)
  - fuzzy finder (fzf-lua)
  - lsp helper (nvim-lspconfig)
  - syntax tree helper (nvim-treesitter)
- try out a js and ts file to troubleshoot issues
