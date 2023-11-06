---@type LazySpec
return {
  "kyazdani42/nvim-tree.lua",
  keys = {
    {
      "<leader>e",
      function()
        require("nvim-tree.api").tree.toggle()
      end,
      desc = "Toggle explorer",
    },
  },
  -- for all available options, refer to `:help nvim-tree-opts`
  opts = {
    auto_reload_on_write = false,
    disable_netrw = true,
    hijack_unnamed_buffer_when_opening = true,
    ui = {
      confirm = {
        default_yes = true,
      },
    },
    renderer = {
      full_name = true,
      indent_width = 1,
      special_files = {},
      highlight_git = true,
      highlight_diagnostics = true,
      root_folder_label = ":t",
      icons = {
        glyphs = {
          git = {
            unstaged = require("user.icons").Heirline.GitChange,
            untracked = require("user.icons").Heirline.GitAdd,
            deleted = require("user.icons").Heirline.GitDelete,
          },
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_root = true,
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
      git_ignored = false,
      custom = { "^\\.git$" },
    },
    actions = {
      change_dir = {
        enable = false,
      },
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

    local api = require("nvim-tree.api")
    local Event = api.events.Event
    api.events.subscribe(Event.NodeRenamed, function(args)
      local ts_clients = vim.lsp.get_clients({ name = "tsserver" })
      for _, ts_client in ipairs(ts_clients) do
        ts_client.request("workspace/executeCommand", {
          command = "_typescript.applyRenameFile",
          arguments = {
            {
              sourceUri = vim.uri_from_fname(args.old_name),
              targetUri = vim.uri_from_fname(args.new_name),
            },
          },
        }, function() end, 0)
      end
    end)
  end,
}
