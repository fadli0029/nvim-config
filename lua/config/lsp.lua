local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local utils = require("utils")

-- Create user command to copy diagnostics to clipboard
vim.api.nvim_create_user_command('CopyDiagnostic', function()
  local diagnostics = vim.diagnostic.get(0, {lnum = vim.api.nvim_win_get_cursor(0)[1]-1})
  if #diagnostics > 0 then
    vim.fn.setreg('+', diagnostics[1].message)
    vim.notify("Diagnostic copied to clipboard")
  else
    vim.notify("No diagnostic at cursor position")
  end
end, {})

-- set quickfix list from diagnostics in a certain buffer, not the whole workspace
local set_qflist = function(buf_num, severity)
  local diagnostics = nil
  diagnostics = diagnostic.get(buf_num, { severity = severity })

  local qf_items = diagnostic.toqflist(diagnostics)
  vim.fn.setqflist({}, ' ', { title = 'Diagnostics', items = qf_items })

  -- open quickfix by default
  vim.cmd[[copen]]
end

-- LSP attach handler using the new LspAttach autocmd
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Mappings.
    local map = function(mode, l, r, opts)
      opts = opts or {}
      opts.silent = true
      opts.buffer = bufnr
      keymap.set(mode, l, r, opts)
    end

    map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
    map("n", "<C-]>", vim.lsp.buf.definition)
    map("n", "gD", function()
      vim.cmd("vsplit")
      vim.lsp.buf.definition()
    end, { desc = "go to definition (vsplit)" })
    map("n", "<leader>gd", function()
      vim.cmd("split")
      vim.lsp.buf.definition()
    end, { desc = "go to definition (split)" })
    map("n", "K", vim.lsp.buf.hover)
    map("n", "<C-k>", vim.lsp.buf.signature_help)
    map("n", "<space>rn", vim.lsp.buf.rename, { desc = "rename symbol" })
    map("n", "gr", vim.lsp.buf.references, { desc = "show references" })
    map("n", "[d", diagnostic.goto_prev, { desc = "previous diagnostic" })
    map("n", "]d", diagnostic.goto_next, { desc = "next diagnostic" })
    map("n", "<space>qw", diagnostic.setqflist, { desc = "workspace diagnostics to qf" })
    map("n", "<space>qb", function() set_qflist(bufnr) end, { desc = "buffer diagnostics to qf" })
    map("n", "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })
    map("n", "<space>wl", function()
      vim.print(vim.lsp.buf.list_workspace_folders())
    end, { desc = "list workspace folder" })

    -- Set some key bindings conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
      -- Use clang-format for C/C++, LSP formatter for others
      if vim.bo.filetype == 'cpp' or vim.bo.filetype == 'c' then
        map("n", "<space>f", function()
          local file = vim.fn.expand('%:p')
          -- Use project .clang-format if exists, else global
          local project_config = vim.fn.findfile('.clang-format', '.;')
          local style = project_config ~= '' and 'file' or ('file:' .. vim.fn.expand('~/Scripts/.clang-format'))
          vim.cmd('silent !clang-format -i -style=' .. style .. ' ' .. file)
          vim.cmd('edit!')
        end, { desc = "format code with clang-format" })
      else
        map("n", "<space>f", vim.lsp.buf.format, { desc = "format code" })
      end
    end

    api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local float_opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "always",
          prefix = " ",
        }

        if not vim.b.diagnostics_pos then
          vim.b.diagnostics_pos = { nil, nil }
        end

        local cursor_pos = api.nvim_win_get_cursor(0)
        if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
            and #diagnostic.get() > 0
        then
          diagnostic.open_float(nil, float_opts)
        end

        vim.b.diagnostics_pos = cursor_pos
      end,
    })

    if client.server_capabilities.documentHighlightProvider then
      vim.cmd([[
        hi! link LspReferenceRead Visual
        hi! link LspReferenceText Visual
        hi! link LspReferenceWrite Visual
      ]])

      local gid = api.nvim_create_augroup("lsp_document_highlight", { clear = true })
      api.nvim_create_autocmd("CursorHold" , {
        group = gid,
        buffer = bufnr,
        callback = function ()
          lsp.buf.document_highlight()
        end
      })

      api.nvim_create_autocmd("CursorMoved" , {
        group = gid,
        buffer = bufnr,
        callback = function ()
          lsp.buf.clear_references()
        end
      })
    end

    if vim.g.logging_level == "debug" then
      local msg = string.format("Language server %s started!", client.name)
      vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
    end
  end,
})

-- Capabilities (for nvim-cmp and nvim-ufo)
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- LSP Server Configurations using native vim.lsp.config (Neovim 0.11+)

-- Ruff (Python linter/formatter)
if vim.fn.executable("ruff") == 1 then
  vim.lsp.config.ruff = {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', 'setup.py', 'setup.cfg', '.git' },
    capabilities = capabilities,
    settings = {
      args = {},
    },
  }
  vim.lsp.enable('ruff')
else
  vim.notify("`ruff` binary not found, skipping ruff", vim.log.levels.WARN)
end

-- LTeX (LaTeX/Markdown grammar checker)
if utils.executable("ltex-ls") then
  vim.lsp.config.ltex = {
    cmd = { 'ltex-ls' },
    filetypes = { 'text', 'plaintex', 'tex', 'markdown' },
    root_markers = { '.git', '.latexmkrc', 'latexmkrc', '.texliverc' },
    capabilities = capabilities,
    settings = {
      ltex = {
        language = "en",
      },
    },
  }
  vim.lsp.enable('ltex')
end

-- Clangd (C/C++)
-- Uses clangd-wrapper which enables --experimental-modules-support
-- only when .clangd-modules marker file exists in project root
if utils.executable("clangd") then
  vim.lsp.config.clangd = {
    cmd = { 'clangd-wrapper' },
    filetypes = { 'c', 'cpp', 'cc', 'objc', 'objcpp' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt', '.clangd', '.git' },
    capabilities = capabilities,
  }
  vim.lsp.enable('clangd')
end

-- Vim Language Server
if utils.executable("vim-language-server") then
  vim.lsp.config.vimls = {
    cmd = { 'vim-language-server', '--stdio' },
    filetypes = { 'vim' },
    root_markers = { '.git' },
    capabilities = capabilities,
  }
  vim.lsp.enable('vimls')
else
  vim.notify("vim-language-server not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- Bash Language Server
if utils.executable("bash-language-server") then
  vim.lsp.config.bashls = {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'sh', 'bash' },
    root_markers = { '.git' },
    capabilities = capabilities,
  }
  vim.lsp.enable('bashls')
end

-- Lua Language Server
if utils.executable("lua-language-server") then
  vim.lsp.config.lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
  vim.lsp.enable('lua_ls')
end

-- global config for diagnostic
diagnostic.config {
  underline = false,
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.INFO] = "■",
      [vim.diagnostic.severity.HINT] = "◆",
    },
  },
  severity_sort = true,
}

-- Change border of documentation hover window
lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
