call plug#begin('~/.local/share/nvim/plugged')
" colorschemes
Plug 'catppuccin/nvim'
Plug 'navarasu/onedark.nvim'
Plug 'tomasiser/vim-code-dark'
Plug 'marko-cerovac/material.nvim'
Plug 'sainnhe/sonokai'
Plug 'nvimdev/zephyr-nvim'
Plug 'NTBBloodbath/doom-one.nvim'
Plug 'rebelot/kanagawa.nvim'
" lsp-zero setup
Plug 'neovim/nvim-lspconfig'                           " Required
Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
Plug 'williamboman/mason-lspconfig.nvim'               " Optional

" Autocompletion
Plug 'hrsh7th/nvim-cmp'     " Required
Plug 'hrsh7th/cmp-nvim-lsp' " Required
Plug 'hrsh7th/cmp-buffer'   " Optional
Plug 'L3MON4D3/LuaSnip'     " Required

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
" other
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-surround'
Plug 'rktjmp/lush.nvim'
Plug 'lervag/vimtex'
Plug 'tpope/vim-repeat'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

" For 'numToStr/Comment.nvim' plugin
lua require('Comment').setup()

" snippets
lua require("luasnip.loaders.from_snipmate").lazy_load({ paths = {"~/.config/nvim/snippets"} })

" nvim-cmp, cmp-buffer
lua << EOF
local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
  }),
  sources = {
    {
      name = 'buffer',
      option = {
        get_bufnrs = function() return vim.api.nvim_list_bufs() end
      }
    }
  }
})
EOF

" telescope
lua << EOF
require('telescope').setup({
  defaults = { mappings = { i = {
    ['<CR>'] = require('telescope.actions').select_tab
  } } },
})
EOF

" lua-line
lua << EOF
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'auto',

    component_separators = '',
    section_separators = '',
  },

  sections = {
    lualine_x = { 
      { 'encoding' },
      { 'fileformat' },
      { 'filetype', icon_only = true }
    },
    lualine_y = { { '%c', icon = '' } },
    lualine_z = { { '%l/%L', icon = { '', align = 'right' } } },
  }
})
EOF

" lsp-zero config
lua << EOF
local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false
})

lsp.ensure_installed({
  'flake8', 'tsserver', 'jedi_language_server'
})

lsp.setup_nvim_cmp({
  select_behavior = 'insert'
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
EOF
