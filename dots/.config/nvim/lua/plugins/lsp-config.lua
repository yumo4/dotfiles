-- NOTE: not having `Mason` leads to lsp's not working on non nixos distros

return { -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    -- Useful status updates for LSP
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    -- This function gets run when an LSP attaches to a particular buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        -- Create a function for easier mapping
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Jump to the definition of the word under your cursor
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

        -- Find references for the word under your cursor
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under your cursor
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

        -- Fuzzy find all the symbols in your current document
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

        -- Fuzzy find all the symbols in your current workspace
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- Rename the variable under your cursor
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Opens a popup that displays documentation about the word under your cursor
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- Goto Declaration
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Setup highlight references
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- Get LSP capabilities from blink.cmp
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Define servers configuration
    local servers = {
      -- c
      clangd = {},
      -- go
      gopls = {
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        settings = {
          formatting = {
            gofumpt = true,
          },
        },
      },
      -- python
      pyright = {},
      -- typescript
      ts_ls = {},
      -- latex
      ltex = {},
      texlab = {},
      -- java
      jdtls = {},
      -- java-language-server = {},
      -- nix
      nil_ls = {},
      -- html
      html = {},
      -- css
      cssls = {},

      -- lua
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            completion = {
              callSnippet = "Replace",
            },
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Setup each server
    for server_name, server_settings in pairs(servers) do
      server_settings.capabilities = require("blink.cmp").get_lsp_capabilities(server_settings.capabilities)
      require("lspconfig")[server_name].setup(server_settings)
    end
  end,
}
