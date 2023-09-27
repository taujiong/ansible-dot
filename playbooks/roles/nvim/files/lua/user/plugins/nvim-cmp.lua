---@diagnostic disable: missing-fields
---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
  },
  -- for all available options, refer to `:help cmp-config`
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    ---@type cmp.ConfigSchema
    return {
      completion = {
        autocomplete = { "InsertEnter", "TextChanged", },
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = {
        { name = "nvim_lsp", priority = 1000, },
        { name = "luasnip",  priority = 750, },
        { name = "emoji",    priority = 700, },
        { name = "path",     priority = 650, },
        { name = "calc",     priority = 500, },
        { name = "buffer",   priority = 250, },
      },
      mapping = cmp.mapping.preset.insert({
        ["<c-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, }),
        ["<c-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, }),
        ["<c-space>"] = cmp.mapping.complete(),
        ["<c-c>"] = cmp.mapping.abort(),
        ["<cr>"] = cmp.mapping.confirm({ select = true, }),
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
        fields = { "kind", "menu", "abbr", },
        format = function(_, item)
          local icons = require("user.icons").Kinds
          if icons[item.kind] then
            item.kind = icons[item.kind]
          end
          return item
        end,
      },
      experimental = {
        ghost_text = true,
      },
    }
  end,
}
