return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = {
        "bash-language-server",
        "json-lsp",
        "lua-language-server",
        "ruff",
        "basedpyright",
        "shfmt",
        "shellcheck",
        "stylua",
        "tree-sitter-cli",
        "taplo",
        "yaml-language-server",
        "yamlfmt",
        "prettierd",
        "marksman",
        "hadolint",
        "dockerfile-language-server",
      },
      run_on_start = true,
      start_delay = 3000,
      -- auto_update = false,
      -- debounce_hours = 24, -- at least 24 hours between attempts to install/update
    },
  },
}
