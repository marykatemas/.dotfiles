local theme = "tokyonight"
local variant = ""
local colorscheme = variant ~= "" and (theme .. "-" .. variant) or theme

return {
  { "folke/tokyonight.nvim", name = "tokyonight", lazy = true },
  -- { "", name = "", lazy = true },
  -- { "", name = "", lazy = true },
  -- { "", name = "", lazy = true },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorscheme,
    },
  },
}
