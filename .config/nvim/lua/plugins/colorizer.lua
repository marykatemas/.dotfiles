return {
  "catgoose/nvim-colorizer.lua",
  event = { "BufReadPre" },
  opts = {
    options = {
      filetypes = { "*" },
      parsers = {
        hex = {
          default = true,
        },
        css = true,
      },
      display = {
        mode = "virtualtext",
      },
    },
  },
}
