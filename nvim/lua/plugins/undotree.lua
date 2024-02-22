return  {
    'mbbill/undotree',
    config = function ()
        vim.keymap.set('n', '<Leader>u', vim.cmd.UndotreeToggle, { silent = true })
    end
}
