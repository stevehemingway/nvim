local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Add your plugins here
  { "nvim-lua/plenary.nvim" },
  { "lewis6991/gitsigns.nvim" },
  { "windwp/nvim-autopairs" },
  {
    "github/copilot.vim",
    config = function()
      -- Configuration for Copilot goes here
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
	ensure_installed = {"python", "latex",  "markdown", "ledger"},
	highlight = {
	  enable = true,
	},
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").pyright.setup({})
      require("lspconfig").ts_ls.setup({})
    end,
  },
{
"nvimtools/none-ls.nvim",
dependencies = { "nvim-lua/plenary.nvim" },
config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
	sources = {
	    -- Add sources here if needed
	},
    })
end,
},
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" } },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, 
  {
  "kyza0d/vocal.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {}
},
{
  "joshuavial/aider.nvim",
  opts = {
    -- your configuration comes here
    -- if you don't want to use the default settings
    auto_manage_context = true, -- automatically manage buffer context
    default_bindings = true,    -- use default <leader>A keybindings
    debug = false,              -- enable debug logging
  },
}
  })

vim.cmd([[colorscheme zellner]])

-- Additional Neovim settings
-- For example:
-- vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true
-- vim.opt.wrap = false
-- vim.opt.termguicolors = true
-- vim.opt.cursorline = true
-- vim.opt.scrolloff = 8
-- vim.opt.signcolumn = "yes"
-- vim.opt.updatetime = 300
-- vim.opt.clipboard = "unnamedplus"
-- vim.opt.mouse = "a"
-- vim.opt.splitbelow = true
-- vim.opt.splitright = true
-- vim.opt.hidden = true
-- vim.opt.backup = false
-- vim.opt.writebackup = false
-- vim.opt.swapfile = false
-- vim.opt.undofile = true
-- vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
-- vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- vim.opt.shortmess:append("c") -- Don't show completion messages
vim.opt.iskeyword:append("-") -- Treat hyphenated words as a single word
vim.opt.showmode = false -- Don't show mode in the command line

-- Set wrap by default
vim.opt.wrap = true

-- Disable wrap for code files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "lua", "javascript", "go", "c", "cpp", "rust" },
  callback = function()
    vim.opt_local.wrap = false
  end,
})


