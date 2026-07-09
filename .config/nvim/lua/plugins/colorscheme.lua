local theme = "oxocarbon"
local variant = ""
local colorscheme = variant ~= "" and (theme .. "-" .. variant) or theme

return {
  { "nyoom-engineering/oxocarbon.nvim", name = "oxocarbon", lazy = true },
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
