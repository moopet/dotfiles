-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>

lvim.keys.normal_mode["<leader>d"] = "Oob_get_clean(); echo '<pre>'; var_dump([]); die(__FILE__ . ':' . __LINE__);<esc>F[a"
lvim.keys.normal_mode["<leader>v"] = "B\"wyEOob_get_clean(); echo '<pre>'; var_dump(); die(__FILE__ . ':' . __LINE__);<esc>2F)\"wP"
lvim.keys.normal_mode["<leader>p"] = ":split term://php -a<cr>i"
lvim.keys.normal_mode["<bs>"] = ":nohl<cr>"
lvim.keys.normal_mode["<leader>a"] = ":Telescope aerial<cr>"
-- lvim.keys.normal_mode["<leader>a"] = ":AerialToggle<cr>"
lvim.keys.normal_mode["<leader>r"] = ":Telescope oldfiles<cr>"
lvim.keys.normal_mode["<leader>b/"] = ":Telescope current_buffer_fuzzy_find<cr>"

lvim.keys.normal_mode["gd"] = ":Telescope lsp_definitions<cr>"
lvim.keys.normal_mode["gr"] = ":Telescope lsp_references<cr>"
