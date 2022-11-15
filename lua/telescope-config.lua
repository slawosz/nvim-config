require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "^./.git/",
      "^./target/",
      "LICENSE*"
    },
    layout_strategy = 'vertical',
    layout_config = { height = 0.95, width = 0.95 },
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
      sort_mru = true,
    },
  },
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg", "ppm", "pdf" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
  },
}
-- load extension to support preview of media files
-- require('telescope').load_extension('media_files');
-- Get fzf loaded and working with extension
require('telescope').load_extension('fzf')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- map("n", "<C-p>", ":lua require('telescope.builtin').find_files()<cr>")
-- -- map("n", "<leader>fm", ":Telescope media_files<cr>")
-- map("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>")
-- map("n", "<leader>b", ":lua require('telescope.builtin').buffers({ sort_lastused = true})<cr>")
-- map("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<cr>")
-- map("n", "<leader>fd", ":lua require('telescope.builtin').diagnostics()<cr>")
-- map("n", "<leader>fs", ":lua require('telescope.builtin').lsp_workspace_symbols()<cr>")
-- map("n", "<leader>fr", ":lua require('telescope.builtin').lsp_references()<cr>")
-- map("n", "<leader>fi", ":lua require('telescope.builtin').lsp_implementations()<cr>")
-- map("n", "<leader>fl", ":lua require('telescope.builtin').treesitter()<cr>")
-- map("n", "<leader>fk", ":lua require('telescope.builtin').keymaps()<cr>")
-- 
-- map("n", "<leader>fc", ":lua require('telescope.builtin').commands()<cr>")
-- map("n", "<leader>fch", ":lua require('telescope.builtin').command_history()<cr>")
-- map("n", "<leader>fsh", ":lua require('telescope.builtin').search_history()<cr>")
-- map("n", "<leader>fmp", ":lua require('telescope.builtin').man_pages()<cr>")
-- map("n", "<leader>fgc", ":lua require('telescope.builtin').git_commits()<cr>")
-- map("n", "<leader>fgb", ":lua require('telescope.builtin').git_branches()<cr>")
