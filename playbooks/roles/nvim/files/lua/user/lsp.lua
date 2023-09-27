local M = {}

function M.has_capability(capability, filter)
  for _, client in ipairs(vim.lsp.get_active_clients(filter)) do
    if client.supports_method(capability) then
      return true
    end
  end
end

local function add_buffer_autocmd(augroup, bufnr, autocmds)
  if not vim.tbl_islist(autocmds) then
    autocmds = { autocmds }
  end
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
  if not cmds_found or vim.tbl_isempty(cmds) then
    vim.api.nvim_create_augroup(augroup, { clear = false })
    for _, autocmd in ipairs(autocmds) do
      local events = autocmd.events
      autocmd.events = nil
      autocmd.group = augroup
      autocmd.buffer = bufnr
      vim.api.nvim_create_autocmd(events, autocmd)
    end
  end
end

local function del_buffer_autocmd(augroup, bufnr)
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
  if cmds_found then
    vim.tbl_map(function(cmd)
      vim.api.nvim_del_autocmd(cmd.id)
    end, cmds)
  end
end

local format = function(bufnr)
  vim.lsp.buf.format({
    bufnr = bufnr,
    timeout_ms = 5000,
  })
end

---@param bufnr number
local on_lsp_attach = function(client, bufnr)
  local wk = require("which-key")
  wk.register({
    ["[d"] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
    ["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
    ["gl"] = { vim.diagnostic.open_float, "Diagnostic on current line" },
    ["<leader>fd"] = { require("telescope.builtin").diagnostics, "Find diagnostics" },
    ["<leader>li"] = { "<cmd>LspInfo<cr>", "Show lsp information" },
  }, { buffer = bufnr })

  if client.supports_method("textDocument/codeAction") then
    wk.register({
      ["<leader>la"] = { vim.lsp.code_action, "Show lsp code actions" },
    }, { mode = { "n", "v" }, buffer = bufnr })
  end

  if client.supports_method("textDocument/codeLens") then
    local augroup_name = "user_lsp_codelens_refresh"
    add_buffer_autocmd(augroup_name, bufnr, {
      events = { "InsertLeave", "BufEnter" },
      desc = "Refresh lsp codelens",
      callback = function()
        if not M.has_capability("textDocument/codeLens", { bufnr = bufnr }) then
          del_buffer_autocmd(augroup_name, bufnr)
          return
        end
        vim.lsp.codelens.refresh()
      end,
    })
    wk.register({
      l = {
        l = { vim.lsp.codelens.refresh, "Refresh lsp codelens" },
        L = { vim.lsp.codelens.run, "Run lsp codelens" },
      },
    }, { prefix = "<leader>", buffer = bufnr })
  end

  if client.supports_method("textDocument/declaration") then
    wk.register({
      gD = { vim.lsp.buf.declaration, "Declaration of current symbol" },
    }, { buffer = bufnr })
  end

  if client.supports_method("textDocument/definition") then
    wk.register({
      gd = { require("telescope.builtin").lsp_definitions, "Show the definition of current symbol" },
    }, { buffer = bufnr })
  end

  if client.supports_method("textDocument/typeDefinition") then
    wk.register({
      gD = { require("telescope.builtin").lsp_type_definitions, "Definition of current type" },
    })
  end

  if client.supports_method("textDocument/hover") then
    -- TODO: Remove mapping after dropping support for Neovim v0.9, it's automatic
    wk.register({
      K = { vim.lsp.buf.hover, "Hover symbol details" },
    })
  end

  if client.supports_method("textDocument/implementation") then
    wk.register({
      gI = { require("telescope.builtin").lsp_implementations, "Implementation of current symbol" },
    })
  end

  if client.supports_method("textDocument/inlayHint") then
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint(bufnr, true)
    end
  end

  if client.supports_method("textDocument/references") then
    wk.register({
      gr = { require("telescope.builtin").lsp_references, "References of current symbol" },
    })
  end

  if client.supports_method("textDocument/rename") then
    wk.register({
      ["<leader>lr"] = { vim.lsp.buf.rename, "Rename current symbol" },
    })
  end

  if client.supports_method("textDocument/signatureHelp") then
    wk.register({
      ["<leader>lh"] = { vim.lsp.buf.signature_help, "Show signature help" },
    })
  end

  if client.supports_method("textDocument/formatting") then
    local augroup_name = "user_lsp_format"
    add_buffer_autocmd(augroup_name, bufnr, {
      events = "BufWritePre",
      desc = "Autoformat on save",
      callback = function()
        if not M.has_capability("textDocument/formatting", { bufnr = bufnr }) then
          del_buffer_autocmd(augroup_name, bufnr)
        end
        format(bufnr)
      end,
    })
    wk.register({
      lf = {
        function()
          format(bufnr)
        end,
        "Format with lsp",
      },
    }, { prefix = "<leader>", mode = { "n", "v" }, buffer = bufnr })
  end

  if client.supports_method("textDocument/documentHighlight") then
    local augroup_name = "user_lsp_document_highlight"
    add_buffer_autocmd(augroup_name, bufnr, {
      {
        events = { "CursorHold", "CursorHoldI" },
        desc = "Highlight references when cursor holds",
        callback = function()
          if not M.has_capability("textDocument/documentHighlight", { bufnr = bufnr }) then
            del_buffer_autocmd(augroup_name, bufnr)
            return
          end
          vim.lsp.buf.document_highlight()
        end,
      },
      {
        events = { "CursorMoved", "CursorMovedI", "BufLeave" },
        desc = "Clear references when cursor moves",
        callback = function()
          vim.lsp.buf.clear_references()
        end,
      },
    })
  end
end

local get_server_lsp_opts = function(server_name)
  local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
  local server_settings = {}
  if server_name == "jsonls" then
    local schemastore = require("schemastore")
    server_settings = {
      json = {
        schemas = schemastore.json.schemas(),
        validate = { enable = true },
      },
    }
  elseif server_name == "yamlls" then
    local schemastore = require("schemastore")
    server_settings = {
      yaml = {
        schemas = schemastore.yaml.schemas(),
      },
    }
  end

  return {
    capabilities = cmp_capabilities,
    settings = server_settings,
    on_attach = on_lsp_attach,
  }
end

local setup_server_handler = function()
  local lspconfig = require("lspconfig")
  require("mason-lspconfig").setup_handlers({
    function(server_name)
      local server_opts = get_server_lsp_opts(server_name)
      lspconfig[server_name].setup(server_opts)
    end,
  })
end

function M.setup()
  setup_server_handler()
end

return M
