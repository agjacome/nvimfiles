local M = {}

function M.map_opts(description, buffer)
    return { desc = description, remap = false, silent = true, buffer = buffer }
end

return M
