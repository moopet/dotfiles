lvim.builtin.telescope.pickers = {
  find_files = {
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.65,
      height = 0.65,
    },
  },
  live_grep = {
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.65,
      height = 0.65,
    },
  },
}

require('telescope').load_extension('aerial')
