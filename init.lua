vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.path = vim.bo.path .. "**"
vim.opt.wildignore = vim.go.wildignore .. "**/node_modules/**"
vim.opt.wildmenu = true

vim.diagnostic.config({
  virtual_text = false,
})

require("packer").startup(function()
  use 'wbthomason/packer.nvim'
  use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'mbbill/undotree'
  use {"ray-x/lsp_signature.nvim"}
  use {"jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" }}
  use 'mfussenegger/nvim-dap' -- unused
  use { "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"} } -- unused
  use {
    "microsoft/vscode-js-debug", -- unused
    opt = true,
    run = "npm install --legacy-peer-deps && npm run compile" 
  }
  use {
    "microsoft/vscode-node-debug2", -- unused
    opt = true,
    run = "npm install && NODE_OPTIONS=--no-experimental-fetch npm run build"
  }
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} } -- unused
  use 'nvim-telescope/telescope.nvim'
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }
end)

require('remap-plugin')
require('dap-plugin')
require('lsp-plugin')
require('treesitter-plugin')

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.diagnostics.eslint,
  }
})

