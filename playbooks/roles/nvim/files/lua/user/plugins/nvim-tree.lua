---@type LazySpec
return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  -- for all available options, refer to `:help nvim-tree-opts`
  opts = {
    auto_reload_on_write = false,
    disable_netrw = true,
    sync_root_with_cwd = true,
    view = {
      centralize_selection = true,
    },
    renderer = {
      full_name = true,
      indent_width = 1,
      special_files = {},
      highlight_git = true,
      highlight_diagnostics = true,
      root_folder_label = ":t",
    },
    update_focused_file = {
      enable = true,
    },
    diagnostics = {
      enable = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.WARN,
        max = vim.diagnostic.severity.ERROR,
      },
    },
    filters = {
      custom = { "^\\.git$" },
    },
    actions = {
      open_file = {
        quit_on_open = true,
        resize_window = false,
        window_picker = {
          enable = true,
          picker = "default",
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        },
      },
      remove_file = {
        close_window = false,
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
    require("which-key").register({
      ["<leader>e"] = { require("nvim-tree.api").tree.toggle, "Toggle explorer" },
    })

    local api = require("nvim-tree.api")
    local Event = api.events.Event
    api.events.subscribe(Event.TreeOpen, function()
      vim.wo.statuscolumn = ""
    end)
    api.events.subscribe(Event.NodeRenamed, function(args)
      local ts_clients = vim.lsp.get_active_clients({ name = "tsserver" })
      for _, ts_client in ipairs(ts_clients) do
        ts_client.request("workspace/executeCommand", {
          command = "_typescript.applyRenameFile",
          arguments = {
            {
              sourceUri = vim.uri_from_fname(args.old_name),
              targetUri = vim.uri_from_fname(args.new_name),
            },
          },
        })
      end
    end)
  end,
}
