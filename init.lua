vim.opt.shiftwidth = 2
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.path = vim.bo.path .. "**"
vim.opt.wildignore = vim.go.wildignore .. "**/node_modules/**"
vim.opt.wildmenu = true

vim.diagnostic.config({
  virtual_text = false,
})

require("packer").startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {"ray-x/lsp_signature.nvim"}
  use {"jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" }}
  use 'mfussenegger/nvim-dap'
  use({
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    require("lsp_lines").setup()
  end,
})
end)

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {},
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'cmp_tabnine' },
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	max_lines = 1000;
	max_num_results = 20;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	show_prediction_strength = false;
})

require("lspconfig").tsserver.setup {
  capabilities = capabilities
}

local status, treesitterConfigs = pcall(require, "nvim-treesitter.configs")
treesitterConfigs.setup {
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true,
    addition_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  }
}

require("lsp_signature").setup({})

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.diagnostics.eslint,
  }
})

local dap = require('dap')
dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '~/.config/nvim/vscode-firefox-debug/dist/adapter.bundle.js'},
}

dap.configurations.typescript = {
  name = 'Debug with Firefox',
  type = 'firefox',
  request = 'launch',
  reAttach = true,
  url = 'http://localhost:3000',
  webRoot = '${workspaceFolder}',
  firefoxExecutable = '/usr/bin/firefox'
}


