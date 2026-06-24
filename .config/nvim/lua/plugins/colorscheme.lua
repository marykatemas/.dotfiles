local theme = "kanagawa"
local variant = "wave"
local colorscheme = variant ~= "" and (theme .. "-" .. variant) or theme

return {
  { "rebelot/kanagawa.nvim", name = "kanagawa", lazy = true },
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
