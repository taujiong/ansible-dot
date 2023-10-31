---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = {
    { "<leader>ft" },
    {
      "<leader>f<cr>",
      function()
        require("telescope.builtin").resume()
      end,
      desc = "Resume previous search",
    },
    {
      "<leader>'",
      function()
        require("telescope.builtin").marks()
      end,
      desc = "Find marks",
    },
    {
      "<leader>fw",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Find words",
    },
    {
      "<leader>fc",
      function()
        require("telescope.builtin").grep_string()
      end,
      desc = "Find word under cursor",
    },
    {
      "<leader>fC",
      function()
        require("telescope.builtin").commands()
      end,
      desc = "Find commands",
    },
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fF",
      function()
        require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
      end,
      desc = "Find all files",
    },
    {
      "<leader>fh",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Find help",
    },
    {
      "<leader>fo",
      function()
        require("telescope.builtin").oldfiles()
      end,
      desc = "Find history",
    },
    {
      "<leader>fv",
      function()
        require("telescope.builtin").vim_options()
      end,
      desc = "Find vim options",
    },
    {
      "<leader>fr",
      function()
        require("telescope.builtin").registers()
      end,
      desc = "Find registers",
    },
    {
      "<leader>fp",
      function()
        require("telescope.builtin").builtin()
      end,
      desc = "Find all pickers",
    },
    {
      "<leader>gb",
      function()
        require("telescope.builtin").git_branches({ use_file_path = true })
      end,
      desc = "Show git branches",
    },
    {
      "<leader>gc",
      function()
        require("telescope.builtin").git_commits({ use_file_path = true })
      end,
      desc = "Show git commits for current repository",
    },
    {
      "<leader>gC",
      function()
        require("telescope.builtin").git_bcommits({ use_file_path = true })
      end,
      desc = "Show git commits for current buffer",
    },
  },
  -- for all available options, refer to `:help telescope.setup`
  opts = function()
    local icons = require("user.icons")
    local actions = require("telescope.actions")
    local trouble = require("trouble.providers.telescope")
    return {
      defaults = {
        prompt_prefix = icons.UI.Selected .. " ",
        selection_caret = icons.UI.Selected .. " ",
        path_display = { "truncate" },
        file_ignore_patterns = { "^.git/", "^node_modules/" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.9,
          height = 0.9,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<c-n>"] = actions.cycle_history_next,
            ["<c-p>"] = actions.cycle_history_prev,
            ["<c-j>"] = actions.move_selection_next,
            ["<c-k>"] = actions.move_selection_previous,
            ["<c-t>"] = trouble.smart_open_with_trouble,
          },
          n = {
            q = actions.close,
            ["<c-t>"] = trouble.smart_open_with_trouble,
          },
        },
      },
      extensions = {
        fzf = {},
      },
    }
  end,
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")

    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      callback = function()
        vim.wo.number = true
        vim.wo.wrap = true
      end,
    })
  end,
}
