local status_ok, smooth_cursor = pcall(require, 'smoothcursor')

if status_ok then
    smooth_cursor.setup({
        autostart = false,
        fancy = { enable = true }
    })
end
