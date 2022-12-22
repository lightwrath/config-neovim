require('nvim-treesitter.configs').setup({
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true,
    addition_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  }
})
