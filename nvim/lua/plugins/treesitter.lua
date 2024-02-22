return {
    -- treesitter
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            auto_install = true,
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
 }
