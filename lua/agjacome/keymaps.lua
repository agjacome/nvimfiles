-- leaders
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- disabled
vim.keymap.set("n", "q:",      "<nop>", Opts("Disabled"))
vim.keymap.set("n", "q/",      "<nop>", Opts("Disabled"))
vim.keymap.set("n", "q?",      "<nop>", Opts("Disabled"))
vim.keymap.set("n", "Q",       "<nop>", Opts("Disabled"))
vim.keymap.set("n", "<left>",  "<nop>", Opts("Disabled"))
vim.keymap.set("n", "<right>", "<nop>", Opts("Disabled"))
vim.keymap.set("n", "<up>",    "<nop>", Opts("Disabled"))
vim.keymap.set("n", "<down>",  "<nop>", Opts("Disabled"))

-- navigation
vim.keymap.set("n", "<tab>",   ":bnext<cr>",     Opts("Next buffer"))
vim.keymap.set("n", "<s-tab>", ":bprevious<cr>", Opts("Previous buffer"))

-- diagnostics
vim.keymap.set("n", "gl", vim.diagnostic.open_float, Opts("Show line diagnostics"))
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,  Opts("Go to previous diagnostic"))
vim.keymap.set("n", "]d", vim.diagnostic.goto_next,  Opts("Go to next diagnostic"))

-- quickfix
vim.api.nvim_create_autocmd("BufReadPost", {
    group   = vim.api.nvim_create_augroup("quickfix", {}),
    pattern = "quickfix",
    command = "nnoremap <buffer> <cr> <cr>"
})

-- custom
vim.keymap.set("n", "<leader>X", "<cmd>source %<cr>", Opts("Source current file"))
vim.keymap.set("v", "<leader>X", ":lua<cr>", Opts("Source current selection"))
vim.keymap.set("n", "<leader>D", '"=strftime("%Y-%m-%d %H:%M")<cr>p', Opts("Insert current datetime"))
vim.keymap.set("n", "<leader><cr>", function() vim.o.hlsearch = not vim.o.hlsearch end, Opts("Toggle search highlight"))

local tmux_session = function()
    if vim.env.TMUX then
        vim.fn.system("tmux split-window -v -l 20 tmux-session")
    else
        print("Not in a tmux session")
    end
end

vim.keymap.set("n", "<c-t>", tmux_session, Opts("Tmux session"))
