-- link
-- - url
--   - <https://github.com/hrsh7th/nvim-cmp>
--   - <https://www.youtube.com/watch?v=jjtxxWkL4po>
-- - retrievd: 2026-02-19

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

local result = packer.startup(function(use)
    -- -- (karlr 2026-02-19): DEPRECATED
    -- use ('neovim/nvim-lspconfig')

    use ('hrsh7th/cmp-nvim-lsp')
    use ('hrsh7th/cmp-buffer')
    use ('hrsh7th/cmp-path')
    use ('hrsh7th/cmp-cmdline')
    use ('hrsh7th/nvim-cmp')

    -- -- For vsnip users.
    -- use ('hrsh7th/cmp-vsnip')
    -- use ('hrsh7th/vim-vsnip')

    -- -- For luasnip users.
    use ('L3MON4D3/LuaSnip')
    use ('saadparwaiz1/cmp_luasnip')

    -- -- For mini.snippets users.
    -- use ('echasnovski/mini.snippets')
    -- use ('abeldekat/cmp-mini-snippets')

    -- -- For ultisnips users.
    -- use ('SirVer/ultisnips')
    -- use ('quangnguyen30192/cmp-nvim-ultisnips')

    -- -- For snippy users.
    -- use ('dcampos/nvim-snippy')
    -- use ('dcampos/cmp-snippy')
end)

-- Set up nvim-cmp.
local cmp = require('cmp')

-- link: IvanHerm - Neovim Tutorial - CMP aka Completion
-- - url: <https://www.youtube.com/watch?v=jjtxxWkL4po>
-- - retrieved: 2026-02-19
local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

      -- For `mini.snippets` users:
      -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      -- insert({ body = args.body }) -- Insert at cursor
      -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
      -- require("cmp.config").set_onetime({ sources = {} })
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    ['<Tab'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_next_item(select_opts)
        else
          fallback()
        end
      end,
      {'l', 's'}
    ),

    ['<S-Tab'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item(select_opts)
        else
          fallback()
        end
      end,
      {'l', 's'}
    ),

    ['<C-j>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.scroll_docs(4)
        else
          fallback()
        end
      end
    ),

    ['<C-k>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.scroll_docs(-4)
        else
          fallback()
        end
      end
    ),
  }),

  sources = cmp.config.sources({
    -- -- (karlr 2026-02-19): I'd keep an eye out for this one.
    -- -- It could be annoying.
    { name = 'path' },

    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 3 },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip', keyword_length = 2 }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
  }),

  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = '[LSP]',
        luasnip = '[SNIP]',
        buffer = '[SNIP]',
        path = '[PATH]',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end
  }
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
)
equire("cmp_git").setup() ]]--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

return result

