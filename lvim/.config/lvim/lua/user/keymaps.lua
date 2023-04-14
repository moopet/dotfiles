-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<leader>d"] = "Oob_get_clean(); echo '<pre>'; var_dump([]); die(__FILE__ . ':' . __LINE__);<esc>F[a"
lvim.keys.normal_mode["<leader>v"] = "B\"wyEOob_get_clean(); echo '<pre>'; var_dump(); die(__FILE__ . ':' . __LINE__);<esc>2F)\"wP"
lvim.keys.normal_mode["<leader>p"] = ":split term://php -a<cr>i"
lvim.keys.normal_mode["<bs>"] = ":nohl<cr>"

-- lvim.keys.terminal_mode["<esc>"] = "<c-\\><c-n>"

-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
