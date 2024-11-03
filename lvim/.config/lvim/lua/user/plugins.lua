-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  { "akinsho/git-conflict.nvim" },
  { "jose-elias-alvarez/typescript.nvim" },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  { "christoomey/vim-tmux-navigator" },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end
  },
  { "Exafunction/codeium.vim" },
  { "sindrets/diffview.nvim" },
}
