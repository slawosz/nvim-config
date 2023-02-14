require('plugins')
require('impatient')

vim.g.mapleader = ","

vim.cmd([[
  colorscheme NeoSolarized
  " set background=light
]])

vim.cmd([[
	set tabstop=2
	set shiftwidth=2
	set expandtab
	set smartindent

  set t_Co=256

  set spelllang=en_us
]])

local opt = vim.opt

opt.visualbell = true
opt.number = true -- bool: Show line numbers
opt.relativenumber = false -- bool: Show relative line numbers
opt.scrolloff = 4 -- int:  Min num lines of context
opt.signcolumn = "yes" -- str:  Show the sign column
opt.numberwidth = 4 -- gutter width
opt.cursorline = true -- display cursor line
opt.cursorlineopt = 'number'
opt.autoread = true

vim.cmd([[
set noswapfile
set nobackup
set nowb
]])

-- persistent undo
vim.cmd([[
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile
]])


opt.syntax = "ON" -- str:  Allow syntax highlighting
opt.termguicolors = true -- bool: If term supports ui color then enable

opt.ignorecase = true -- bool: Ignore case in search patterns
opt.smartcase = true -- bool: Override ignorecase if search contains capitals
opt.incsearch = true -- bool: Use incremental search
opt.hlsearch = true -- bool: Highlight search matches

opt.splitright = true -- bool: Place new window to right of current one
opt.splitbelow = true -- bool: Place new window below the current one

-- format on save
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]

-- Vimspector
vim.cmd([[
  let g:vimspector_sidebar_width = 85
  let g:vimspector_bottombar_height = 15
  let g:vimspector_terminal_maxwidth = 70
]])

-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end
sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = false,
  severity_sort = true,
  float = {
    border = 'single',
    source = 'always',
    header = '',
    prefix = '- ',
  },
})
-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.o.updatetime = 350
opt.signcolumn = 'yes'
vim.cmd([[
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

opt.history = 1000

-- Functional wrapper for mapping custom keybindings
-- mode (as in Vim modes like Normal/Insert mode)
-- lhs (the custom keybinds you need)
-- rhs (the commands or existing keybinds to customise)
-- opts (additional options like <silent>/<noremap>, see :h map-arguments for more info on it)
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Quit buffer
map("n", "qq", ":q<cr>")
map("n", "qa", ":qa<cr>")

-- Window navigation
-- map("n", "<C-j>", "<C-w>j<C-w>")
-- map("n", "<C-h>", "<C-w>h<C-w>")
-- map("n", "<C-k>", "<C-w>k<C-w>")
-- map("n", "<C-l>", "<C-w>l<C-w>")

-- Splits
map('n', '<leader>v', '<cmd>vsp<cr>')
map('i', '<leader>v', '<cmd>vsp<cr>')
map('n', '<leader>s', '<cmd>sp<cr>')
map('i', '<leader>s', '<cmd>sp<cr>')
map('n', 'vv', '<cmd>vsp<cr>')
map('n', 'ss', '<cmd>sp<cr>')

-- Save
vim.cmd([[
noremap  <silent> <C-S> :w<CR>
vnoremap <silent> <C-S> <C-C>:w<CR>
inoremap <silent> <C-S> <Esc>:w<CR>
]])

-- Hop
map("n", "HH", ":HopWord<cr>")
map("n", "HF", ":HopPattern<cr>")
map("n", "HL", ":HopLineStart<cr>")

-- Telescope

-- Trouble
map("n", "<leader>e", ":TroubleToggle<cr>")

-- Nvim Tree
map("n", "<leader>nt", ":NvimTreeToggle<CR>")

-- Tagbar Toggle
-- map('n', "<leader>tt", ":TagbarToggle<CR>");
map('n', "<leader>tt", ":SymbolsOutline<CR>");

-- LSP Navigation
-- Code Actions
map('n', "ca", ":lua vim.lsp.buf.code_action()<CR>")
vim.cmd([[
nnoremap <silent> <c-]>     <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gc        <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gn        <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gs        <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gw        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> ff        <cmd>lua vim.lsp.buf.format()<CR>
]])

vim.cmd([[
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>
]])

-- Ruby lsp
require 'lspconfig'.solargraph.setup {}
require 'lspconfig'.sumneko_lua.setup {}
--require'lspconfig'.typeprof.setup{}

-- Crates Nvim
vim.cmd([[
nnoremap <silent> <leader>ct :lua require('crates').toggle()<cr>
nnoremap <silent> <leader>cr :lua require('crates').reload()<cr>
nnoremap <silent> <leader>cv :lua require('crates').show_versions_popup()<cr>
nnoremap <silent> <leader>cf :lua require('crates').show_features_popup()<cr>
nnoremap <silent> <leader>cd :lua require('crates').show_dependencies_popup()<cr>
nnoremap <silent> <leader>cu :lua require('crates').update_crate()<cr>
vnoremap <silent> <leader>cu :lua require('crates').update_crates()<cr>
nnoremap <silent> <leader>ca :lua require('crates').update_all_crates()<cr>
nnoremap <silent> <leader>cU :lua require('crates').upgrade_crate()<cr>
vnoremap <silent> <leader>cU :lua require('crates').upgrade_crates()<cr>
nnoremap <silent> <leader>cA :lua require('crates').upgrade_all_crates()<cr>
nnoremap <silent> <leader>cH :lua require('crates').open_homepage()<cr>
nnoremap <silent> <leader>cR :lua require('crates').open_repository()<cr>
nnoremap <silent> <leader>cD :lua require('crates').open_documentation()<cr>
nnoremap <silent> <leader>cC :lua require('crates').open_crates_io()<cr>
]])

-- Comment.nvim configuration
-- current line
vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)')
-- vim.keymap.set('n', 'cb', '<Plug>(comment_toggle_blockwise_current)')

-- Toggle in_ VISUAL mode
vim.keymap.set('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)')
-- vim.keymap.set('x', 'cb', '<Plug>(comment_toggle_blockwise_visual)')


-- Lua line
require('lualine').setup {
  options = {
    theme = 'solarized',
    fmt = string.lower,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  }
}

-- Symbols Outline (new tagbar)
require("symbols-outline").setup {
  show_guides = false,
  position = 'left',
  width = 35,
  wrap = false,
  keymaps = { fold = "h", unfold = "l", fold_all = "zM", unfold_all = "zR" },
  symbols = {
    File = { icon = "", hl = "TSURI" },
    Module = { icon = "全", hl = "TSNamespace" },
    Namespace = { icon = "凜", hl = "TSNamespace" },
    Package = { icon = "", hl = "TSNamespace" },
    Class = { icon = "", hl = "TSType" },
    Method = { icon = "", hl = "TSMethod" },
    Property = { icon = "", hl = "TSMethod" },
    Field = { icon = "", hl = "TSField" },
    Constructor = { icon = "", hl = "TSConstructor" },
    Enum = { icon = "", hl = "TSType" },
    Interface = { icon = "ﰮ", hl = "TSType" },
    Function = { icon = "", hl = "TSFunction" },
    Variable = { icon = "", hl = "TSConstant" },
    Constant = { icon = "", hl = "TSConstant" },
    String = { icon = "", hl = "TSString" },
    Number = { icon = "#", hl = "TSNumber" },
    Boolean = { icon = "⊨", hl = "TSBoolean" },
    Array = { icon = "", hl = "TSConstant" },
    Object = { icon = "", hl = "TSType" },
    Key = { icon = "🔐", hl = "TSType" },
    Null = { icon = "ﳠ", hl = "TSType" },
    EnumMember = { icon = "", hl = "TSField" },
    Struct = { icon = "", hl = "TSType" },
    Event = { icon = "🗲", hl = "TSType" },
    Operator = { icon = "+", hl = "TSOperator" },
    TypeParameter = { icon = "", hl = "TSParameter" }
  },
}

-- Better escape
require("better_escape").setup {
  mapping = { "jk", "kj" }, -- a table with mappings to use
  timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
  clear_empty_lines = false, -- clear line after escaping if there is only whitespace
  keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
}


-- Fidget - show status of LSP progress
require "fidget".setup {
  window = {
    relative = "editor",
    blend = 10,
  },
}

-- Hop
require 'hop'.setup {
  keys = 'etovxqpdygfblzhckisuran',
  jump_on_sole_occurrence = false,
}

-- -- Ident Lines
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#2d3033 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#2d3033 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#2d3033 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#2d3033 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#2d3033 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#2d3033 gui=nocombine]]
--
-- require("indent_blankline").setup {
--     use_treesitter = true,
--     use_treesitter_scope = true,
--     show_first_indent_level = true,
--     space_char_blankline = " ",
--     char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--         "IndentBlanklineIndent3",
--         "IndentBlanklineIndent4",
--         "IndentBlanklineIndent5",
--         "IndentBlanklineIndent6",
--     },
-- }

-- Trouble Setup
require('trouble').setup {
  position = "right",
  width = 75,
  padding = true,
  auto_preview = false,
}

-- Nvim Tree Setup
require('nvim-tree').setup {
  sort_by = "case_sensitive",
  view = {
    adaptive_size = false,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
    icons = {
      git_placement = "after",
      glyphs = {
        git = {
          unstaged = "-",
          staged = "s",
          untracked = "u",
          renamed = "r",
          deleted = "d",
          ignored = "i",
        },
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
}

-- Telescope Setup
require('telescope-config')

-- Autopairs Setup
require 'nvim-autopairs'.setup {}

-- Mason Setup
require("mason").setup({
  ui = {
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
  }
})
require("mason-lspconfig").setup()

-- Comment Setup
require('Comment').setup({
  mappings = {
    basic = false,
    extra = false,
    extended = false,
  },
})

-- Crates Nvim
require('crates').setup()

-- LSP Config
local nvim_lsp = require 'lspconfig'

-- Completion

require('lspkind').init({
  -- mode = 'symbol_text'
})


vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 350)

local lspkind = require('lspkind')
-- local cmp = require 'cmp'
local luasnip = require("luasnip")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- cmp.setup({
--   -- Enable LSP snippets
--   snippet = {
--     expand = function(args)
--       -- vim.fn["vsnip#anonymous"](args.body) -- For 'vsnip' users.
--       require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--     end,
--   },
--   mapping = {
--     -- Add tab support
--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       elseif has_words_before() then
--         cmp.complete()
--       else
--         fallback()
--       end
--     end, { "i", "s" }),
-- 
--     ["<S-Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { "i", "s" }),
--     ['<C-w>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm { select = false }
--   },
--   -- Installed sources:
--   sources = {
--     { name = 'path' }, -- file paths
--     { name = 'nvim_lsp', keyword_length = 1, priority = 10 }, -- from language server
--     { name = 'crates', keyword_length = 1, priority = 10 },
--     { name = 'luasnip', keyword_length = 1, priority = 7 }, -- for lua users
--     { name = 'nvim_lsp_signature_help', priority = 8 }, -- display function signatures with current parameter emphasized
--     { name = 'nvim_lua', keyword_length = 1, priority = 8 }, -- complete neovim's Lua runtime API such vim.lsp.*
--     { name = 'buffer', keyword_length = 1, priority = 5 }, -- source current buffer
--     -- { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip
--     { name = 'calc' }, -- source for math calculation
--   },
--   window = {
--     completion = {
--       cmp.config.window.bordered(),
--       col_offset = 3,
--       side_padding = 1,
--     },
--     documentation = cmp.config.window.bordered(),
-- 
--   },
--   formatting = {
--     fields = { 'menu', 'abbr', 'kind' },
--     format = lspkind.cmp_format({
--       mode = 'symbol_text', -- show only symbol annotations
--       maxwidth = 60, -- prevent the popup from showing more than provided characters
--       -- The function below will be called before any actual modifications from lspkind:
--       before = function(entry, vim_item)
--         local menu_icon = {
--           nvim_lsp = 'λ ',
--           luasnip = '⋗ ',
--           buffer = 'Ω ',
--           path = '🖫 ',
--         }
--         vim_item.menu = menu_icon[entry.source.name]
--         return vim_item
--       end,
--     })
-- 
--   },
--   preselect = cmp.PreselectMode.None,
--   confirmation = {
--     get_commit_characters = function(commit_characters)
--       return {}
--     end
--   },
-- })

-- -- `/` cmdline setup.
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })
-- -- `:` cmdline setup.
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })
-- 
-- 
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['rust_analyzer'].setup {
--   capabilities = capabilities
-- }



-- treesitter

require('nvim-treesitter.configs').setup {
  ensure_installed = { "bash", "c", "cmake", "css", "dockerfile", "go", "gomod", "gowork", "hcl", "help", "html",
    "http", "javascript", "json", "make", "markdown", "python", "regex", "ruby", "rust", "toml", "vim", "yaml",
    "zig" },
  auto_install = true,
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<S-Tab>", -- normal mode
      node_incremental = "<Tab>", -- visual mode
      node_decremental = "<S-Tab", -- visual mode
    },
  },
  ident = { enable = true },
  rainbow = {
    enable = true,
  }
}

-- dap

local dap = require('dap')
dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

require("nvim-dap-virtual-text").setup {
  commented = true,
}

local dap, dapui = require "dap", require "dapui"
dapui.setup {} -- use default
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end



-- RUST
-- -------------------------------------
local rt = require("rust-tools")

local extension_path = vim.env.HOME
    .. "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(
      codelldb_path,
      liblldb_path
    ),
  },
})

dap.adapters.ruby = function(callback, config)
  callback {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = "bundle",
      args = { "exec", "rdbg", "-n", "--open", "--port", "${port}",
        "-c", "--", "bundle", "exec", config.command, config.script,
      },
    },
  }
end

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "debug current file",
    request = "attach",
    localfs = true,
    command = "ruby",
    script = "${file}",
  },
  {
    type = "ruby",
    name = "run current spec file",
    request = "attach",
    localfs = true,
    command = "rspec",
    script = "${file}",
  },
}


-- spectre
vim.cmd([[
nnoremap <leader>S <cmd>lua require('spectre').open()<CR>

"search current word
nnoremap <leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <leader>s <esc>:lua require('spectre').open_visual()<CR>
"  search in current file
nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>
" run command :Spectre
]])

require("luasnip.loaders.from_vscode").lazy_load()
require('coc')
