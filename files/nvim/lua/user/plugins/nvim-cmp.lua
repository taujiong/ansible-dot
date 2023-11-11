---@diagnostic disable: missing-fields
---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    {
      "L3MON4D3/LuaSnip",
      build = vim.fn.has("win32") == 0
          and "echo 'jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
        or nil,
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
      end,
    },
  },
  event = { "InsertEnter" },
  -- for all available options, refer to `:help cmp-config`
  opts = function()
    local cmp = require("cmp")
    local cmp_types = require("cmp.types")
    local luasnip = require("luasnip")

    ---@type cmp.ConfigSchema
    return {
      enabled = function()
        return vim.g.cmp_enabled
      end,
      completion = {
        autocomplete = {
          cmp_types.cmp.TriggerEvent.InsertEnter,
          cmp_types.cmp.TriggerEvent.TextChanged,
        },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "emoji", priority = 700 },
        { name = "path", priority = 650 },
        { name = "calc", priority = 500 },
        { name = "buffer", priority = 250 },
      },
      mapping = cmp.mapping.preset.insert({
        ["<c-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<c-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<c-space>"] = cmp.mapping.complete(),
        ["<c-c>"] = cmp.mapping.abort(),
        ["<cr>"] = cmp.mapping.confirm({ select = true }),
        ["<tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end),
        ["<s-tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end),
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          local icons = require("user.icons").LspKind
          if icons[item.kind] then
            item.kind = icons[item.kind]
          end
          item.menu = entry.source.name
          return item
        end,
      },
      experimental = {
        ghost_text = false,
      },
    }
  end,
}
