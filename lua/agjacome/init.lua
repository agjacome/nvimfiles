Opts = function(description, buffer)
    return { desc = description, remap = false, silent = true, buffer = buffer }
end

require('agjacome.options')
require('agjacome.commands')
require('agjacome.keymaps')
require('agjacome.plugins')
