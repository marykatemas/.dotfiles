return {
  {
    "folke/snacks.nvim",
    opts = {
      scroll = {
        enabled = false,
      },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            layout = {
              hidden = { "input" },
            },
          },
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
      },
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = [[
                                                                    
      ████ ██████           █████      ██                     
     ███████████             █████                             
     █████████ ███████████████████ ███   ███████████   
    █████████  ███    █████████████ █████ ██████████████   
   █████████ ██████████ █████████ █████ █████ ████ █████   
 ███████████ ███    ███ █████████ █████ █████ ████ █████  
██████  █████████████████████ ████ █████ █████ ████ ██████ 
]],
          keys = {
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            -- {
            --   icon = " ",
            --   key = "c",
            --   desc = "Config",
            --   action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            -- },
            -- { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            -- { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            -- { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            -- { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.dashboard.pick('projects')" },
            { key = "k", action = ":lua Snacks.dashboard.pick('keymaps')", hidden = true },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 0, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { text = "[k]eymaps or <leader>sk", align = "center", padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections = opts.sections or {}
      opts.sections.lualine_z = {
        {
          function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
              return "No LSP"
            end

            local names = vim.tbl_map(function(client)
              return client.name
            end, clients)

            return table.concat(names, ", ")
          end,
        },
      }
    end,
  },
  -- {
  --   "folke/noice.nvim",
  --   opts = {
  --     presets = {
  --       bottom_search = false,
  --     },
  --   },
  -- },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
    },
  },
}
