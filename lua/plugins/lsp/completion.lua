-- completion
return {
  'hrsh7th/nvim-cmp',

  dependencies = {
    -- sources
    'hrsh7th/cmp-nvim-lsp', -- from LSP
    'hrsh7th/cmp-buffer', -- from buffer
    'saadparwaiz1/cmp_luasnip', -- from luasnip for snippets
    'hrsh7th/cmp-cmdline', -- from cmdline
    'hrsh7th/cmp-path', -- from path
    'hrsh7th/cmp-nvim-lua', -- from lua api
    'hrsh7th/cmp-nvim-lsp-document-symbol', -- from textDocument/documentSymbol
    'hrsh7th/cmp-calc', -- from math
    'quangnguyen30192/cmp-nvim-tags', -- from tags
    -- UI
    'hrsh7th/cmp-nvim-lsp-signature-help', -- highlight current arg in function signature
    'onsails/lspkind-nvim', -- icons in completion menu
    'lukas-reineke/cmp-under-comparator', -- sort leading underscores to end of list
  },

  config = function()
    vim.o.completeopt = 'menuone,noinsert,noselect'
    vim.g.completion_enable_fuzzy_match = 1
    vim.g.completion_confirm_key = ''

    local cmp = require('cmp')
    local cmp_context = require('cmp.config.context')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')
    local cmp_under_comparator = require('cmp-under-comparator')

    local function next_item(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end

    local function prev_item(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = {
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ['<C-n>'] = cmp.mapping(next_item, { 'i', 's' }),
        ['<C-p>'] = cmp.mapping(prev_item, { 'i', 's' }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'treesitter' },
        { name = 'luasnip' },
        { name = 'nvim_lsp_document_symbol' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path' },
        { name = 'tags' },
        { name = 'rg' },
        { name = 'calc' },
        { name = 'nvim_lua' },
      }, {
        { name = 'buffer' },
      }),
      enabled = function()
        -- disable completion in comments
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
          return true
        else
          return not cmp_context.in_treesitter_capture("comment")
              and not cmp_context.in_syntax_group("Comment")
        end
      end,
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 70,
        })
      },
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp_under_comparator.under,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
  end,
}
