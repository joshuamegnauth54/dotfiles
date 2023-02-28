-- Treesitter configs; partially copied from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Treesitter parsers must be updated when treesitter is updated
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Schrink selection", mode = "x" },
    },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "awk",
        "bash",
        "c",
        "capnp",
        "cmake",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "fish",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "glsl",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "graphql",
        "haskell",
        "help",
        "hlsl",
        "html",
        "java",
        "javascript",
        "json",
        "kotlin",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "meson",
        "nix",
        "python",
        "query",
        "r",
        "regex",
        "ron",
        "rust",
        "rst",
        "scss",
        "sql",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "wgsl",
        "wgsl_bevy",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
      -- nvim-ts-rainbow2
      rainbow = {
          enabled = true
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
      "nvim-treesitter/nvim-treesitter-context",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = true
  },
  {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = { "nvim-treesitter/nvim-treesitter" }
  },
  {
      -- Highlight matching brackets
      -- NOTE: Periodically check this plugin because it's always deprecated for some reason
      "HiPhish/nvim-ts-rainbow2",
      dependencies = { "nvim-treesitter/nvim-treesitter" }
  }
}

