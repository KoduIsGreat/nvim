local go = require("go")
go.setup()
vim.keymap.set("n","<leader>Gtf",":GoTestFunc<CR>")
vim.keymap.set("n","<leader>Gv",":GoVet<CR>")
