vim.api.nvim_create_user_command('ChatGPTEnable', function()
    local status_ok, chatgpt = pcall(require, 'chatgpt')

    if not status_ok then
        return
    end

    chatgpt.setup({
        api_key_cmd = 'pass keys/api/openai'
    })
end, { })
