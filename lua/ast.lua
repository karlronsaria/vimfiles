-- treesitter
require'nvim-treesitter.configs'.setup {
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: Set to false if you don't have `tree-sitter`
  -- CLI installed
  auto_install = true,

  -- List of parser to ignore installing (or "all")
  ignore_install = { },

  highlight = {
    enable = true,

    disable = { },

    -- Use a function for more flexibility, e.g. to disable slow treesitter
    -- highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB

      local ok, stats = pcall(
        vim.loop.fs_stat,
        vim.api.nvim_buf_get_name(buf)
      )

      return ok and stats and stats.size > max_filesize
    end,

    -- Setting this will run `:h syntax` and tree-sitter at the same time.
    -- Set this if you depend on 'syntax' being enabled (like for
    -- indentation).
    -- Using this optioni may slow down your editor, and you may see some
    -- duplicate highlights.
    -- Instead of a boolean, it can be a list of languages.
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true, -- Default is disabled anyway
  },

  ensure_installed = {
    "c"
  },
}

-- -- (karlr 2023_12_07): I don't know if I like auto-folding.
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- lsp
require'mason'.setup {
    ui = {
        icons = {
            package_installed = "☝️ 😊",
            package_pending = "⏳",
            package_uninstalled = "✋😣",

        }
    }
}
