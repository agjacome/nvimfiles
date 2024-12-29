return {
    "theprimeagen/harpoon",
    event = "VeryLazy",
    config = function()
        require("harpoon").setup()

        local marks = require("harpoon.mark")
        local ui    = require("harpoon.ui")

        vim.keymap.set("n", "<leader>ha", marks.add_file,       Opts("Harpoon - Add file"))
        vim.keymap.set("n", "<leader>hj", ui.nav_next,          Opts("Harpoon - Go up"))
        vim.keymap.set("n", "<leader>hk", ui.nav_prev,          Opts("Harpoon - Go down"))
        vim.keymap.set("n", "<leader>hl", ui.toggle_quick_menu, Opts("Harpoon - Toggle Menu"))

        vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, Opts("Harpoon - Goto 1"))
        vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, Opts("Harpoon - Goto 2"))
        vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, Opts("Harpoon - Goto 3"))
        vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, Opts("Harpoon - Goto 4"))
        vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end, Opts("Harpoon - Goto 5"))
        vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end, Opts("Harpoon - Goto 6"))
        vim.keymap.set("n", "<leader>7", function() ui.nav_file(7) end, Opts("Harpoon - Goto 7"))
        vim.keymap.set("n", "<leader>8", function() ui.nav_file(8) end, Opts("Harpoon - Goto 8"))
        vim.keymap.set("n", "<leader>9", function() ui.nav_file(9) end, Opts("Harpoon - Goto 9"))
    end
}
