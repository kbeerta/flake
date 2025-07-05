local utils = require("core.utils")

utils.map("n", "<S-l>", "<cmd>bnext<CR>")
utils.map("n", "<S-h>", "<cmd>bprevious<CR>")

utils.map("n", "<esc>", "<cmd>noh<CR>")
