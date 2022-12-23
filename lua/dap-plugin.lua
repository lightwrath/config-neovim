local dap = require('dap')

vim.keymap.set('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>')
vim.keymap.set('n', '<leader>b', ':lua require"dap".continue()<CR>')
vim.keymap.set('n', '<leader>d', ':lua require"dapui".toggle()<CR>')

require("dap-vscode-js").setup({
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      name = "Launch file",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      autoAttachChildProcess = true,
      console = 'integratedTerminal',
      protocol = "inspector",
    },
  }
end

require("dapui").setup()
