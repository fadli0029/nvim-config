require('aside').setup({
  -- Storage configuration
  storage_path = vim.fn.stdpath('data') .. '/aside',

  -- Keybindings
  keymaps = {
    add = '<leader>aa',
    view = '<leader>av',
    delete = '<leader>ad',
    toggle = '<leader>at',
    list = '<leader>al',
  },

  -- UI configuration
  ui = {
    border = 'rounded',
    width = 80,
    height = 20,
  },

  -- Annotation indicators
  indicators = {
    enabled = true,
    style = 'virtual_text',
    icon = '󰍨 ',
    text = ' [note]',
  },

  -- LSP integration
  lsp = {
    hover = true,
  },
})
