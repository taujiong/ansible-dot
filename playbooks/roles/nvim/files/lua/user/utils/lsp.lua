local M = {}

local function has_capability(capability, filter)
  for _, client in ipairs(vim.lsp.get_clients(filter)) do
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

---@param bufnr number
local function on_lsp_attach(client, bufnr)
  local wk = require("which-key")
  wk.register({
    ["[d"] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
    ["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
    ["gl"] = { vim.diagnostic.open_float, "Diagnostic on current line" },
    ["<leader>fd"] = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      "Find diagnostics",
    },
    ["<leader>li"] = { "<cmd>LspInfo<cr>", "Show lsp information" },
  }, { buffer = bufnr })

  if client.supports_method("textDocument/codeAction") then
    wk.register({
      ["<leader>la"] = { vim.lsp.buf.code_action, "Show lsp code actions" },
    }, { mode = { "n", "v" }, buffer = bufnr })
  end

  if client.supports_method("textDocument/codeLens") then
    local augroup_name = "user_lsp_codelens_refresh"
    add_buffer_autocmd(augroup_name, bufnr, {
      events = { "InsertLeave", "BufEnter" },
      desc = "Refresh lsp codelens",
      callback = function()
        if not has_capability("textDocument/codeLens", { bufnr = bufnr }) then
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
      gd = {
        function()
          require("telescope.builtin").lsp_definitions()
        end,
        "Show the definition of current symbol",
      },
    }, { buffer = bufnr })
  end

  if client.supports_method("textDocument/typeDefinition") then
    wk.register({
      gD = {
        function()
          require("telescope.builtin").lsp_type_definitions()
        end,
        "Definition of current type",
      },
    }, { buffer = bufnr })
  end

  if client.supports_method("textDocument/implementation") then
    wk.register({
      gI = {
        function()
          require("telescope.builtin").lsp_implementations()
        end,
        "Implementation of current symbol",
      },
    }, { buffer = bufnr })
  end

  if client.supports_method("textDocument/inlayHint") then
    ---@diagnostic disable-next-line: undefined-field
    if vim.b.inlay_hints_enabled or (vim.b.inlay_hints_enabled == nil and vim.g.inlay_hints_enabled) then
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint(bufnr, true)
        wk.register({
          ["<leader>uH"] = {
            function()
              require("user.utils.customize").toggle_buffer_inlay_hints(bufnr)
            end,
            "Toggle LSP inlay hints (buffer)",
          },
        })
      end
    end
  end

  if client.supports_method("textDocument/references") then
    wk.register({
      gr = {
        function()
          require("telescope.builtin").lsp_references()
        end,
        "References of current symbol",
      },
    }, { buffer = bufnr })
  end

  if client.supports_method("textDocument/rename") then
    wk.register({
      ["<leader>lr"] = { vim.lsp.buf.rename, "Rename current symbol" },
    }, { buffer = bufnr })
  end

  if client.supports_method("textDocument/signatureHelp") then
    wk.register({
      ["<leader>lh"] = { vim.lsp.buf.signature_help, "Show signature help" },
    }, { buffer = bufnr })
  end

  if client.supports_method("textDocument/documentHighlight") then
    local augroup_name = "user_lsp_document_highlight"
    add_buffer_autocmd(augroup_name, bufnr, {
      {
        events = { "CursorHold", "CursorHoldI" },
        desc = "Highlight references when cursor holds",
        callback = function()
          if not has_capability("textDocument/documentHighlight", { bufnr = bufnr }) then
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

local function get_server_lsp_opts(server_name)
  local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
  local ufo_capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  }
  local capabilities = vim.tbl_deep_extend("keep", lsp_capabilities, cmp_capabilities, ufo_capabilities)

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
    capabilities = capabilities,
    settings = server_settings,
    on_attach = on_lsp_attach,
  }
end

function M.setup_vim_diagnostic()
  local icons = require("user.icons")
  local signs = {
    { name = "DiagnosticSignError", text = icons.Diagnostic.Error, texthl = "DiagnosticSignError" },
    { name = "DiagnosticSignWarn", text = icons.Diagnostic.Warn, texthl = "DiagnosticSignWarn" },
    { name = "DiagnosticSignInfo", text = icons.Diagnostic.Info, texthl = "DiagnosticSignInfo" },
    { name = "DiagnosticSignHint", text = icons.Diagnostic.Hint, texthl = "DiagnosticSignHint" },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, sign)
  end
  vim.diagnostic.config({
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = {
      focused = false,
      border = "rounded",
      source = "always",
    },
  })
end

function M.setup()
  local lspconfig = require("lspconfig")
  require("mason-lspconfig").setup_handlers({
    function(server_name)
      local server_opts = get_server_lsp_opts(server_name)
      lspconfig[server_name].setup(server_opts)
    end,
  })
end

return M
