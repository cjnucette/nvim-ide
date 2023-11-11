{ pkgs }:
with pkgs.vimPlugins; [
  # deps
  plenary-nvim
  promise-async
  nvim-web-devicons
  mini-nvim
  nvim-notify
  # plugins
  (nvim-treesitter.withPlugins (p: with p; [ lua vim javascript typescript tsx css html json toml rust jq nix ]))
  SchemaStore-nvim
  barbecue-nvim
  bufferline-nvim
  catppuccin-nvim
  cmp-buffer
  cmp-cmdline
  cmp-emoji
  cmp-nvim-lsp
  cmp-path
  cmp_luasnip
  comment-nvim
  conform
  dressing-nvim
  friendly-snippets
  indent-blankline-nvim
  lspkind-nvim
  lualine-lsp-progress
  lualine-nvim
  luasnip
  neo-tree-nvim
  neodev-nvim
  nui-nvim
  nvim-autopairs
  nvim-cmp
  vim-fugitive
  nvim-lspconfig
  nvim-navic
  nvim-ts-context-commentstring
  nvim-ufo
  noice-nvim
  oil-nvim
  package-info-nvim
  statuscol-nvim
  nvim-surround
  telescope-nvim
  telescope-fzf-native-nvim
  toggleterm-nvim
]
