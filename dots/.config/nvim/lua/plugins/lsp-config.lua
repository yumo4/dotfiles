return {
  "neovim/nvim-lspconfig", -- or just a simple plugin spec
  dependencies = {
    "saghen/blink.cmp",
    "j-hui/fidget.nvim",
    opts = {},
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- lsp rename -> quickfixlist
        -- Override the rename handler to track changes
        if client then
          local original_rename = vim.lsp.handlers["textDocument/rename"]
          vim.lsp.handlers["textDocument/rename"] = function(err, result, ctx, config)
            -- Call original handler first
            original_rename(err, result, ctx, config)

            if result and result.changes then
              local current_buf = vim.api.nvim_get_current_buf()
              local current_uri = vim.uri_from_bufnr(current_buf)
              local modified = {}

              for uri, edits in pairs(result.changes) do
                if #edits > 0 then
                  local filepath = vim.uri_to_fname(uri)
                  local message = uri == current_uri and "Renamed" or "Reference updated"
                  table.insert(modified, { filename = filepath, lnum = 1, col = 1, text = message })
                end
              end

              if #modified > 1 then
                -- Sort: "Renamed here" first, then "Reference updated"
                table.sort(modified, function(a, b)
                  if a.text == "Renamed here" then
                    return true
                  end
                  if b.text == "Renamed here" then
                    return false
                  end
                  return a.filename < b.filename -- Alphabetical for the rest
                end)
                vim.fn.setqflist(modified)
                vim.cmd("copen")
                vim.cmd.wincmd("p")
              end
            end
          end
        end

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
        client = vim.lsp.get_client_by_id(event.data.client_id)
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

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- C/C++
    vim.lsp.config.clangd = {
      cmd = { "clangd" },
      filetypes = { "c", "cpp" },
      capabilities = capabilities,
    }

    -- Go
    vim.lsp.config.gopls = {
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      capabilities = capabilities,
      settings = {
        gopls = {
          formatting = {
            gofumpt = true,
          },
        },
      },
    }

    -- Python
    vim.lsp.config.pyright = {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      capabilities = capabilities,
    }

    -- TypeScript
    vim.lsp.config.ts_ls = {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      capabilities = capabilities,
      settings = {
        typescript = {
          preferences = {
            importModuleSpecifierFormat = "es2020",
          },
        },
      },
    }

    -- LaTeX
    -- vim.lsp.config.texlab = {
    -- 	cmd = { "texlab" },
    vim.lsp.config.ltex = {
      cmd = { "ltex-ls" },
      filetypes = { "tex", "plaintex", "bib" },
      capabilities = capabilities,
    }

    -- Java
    vim.lsp.config.jdtls = {
      cmd = { "jdtls" },
      filetypes = { "java" },
      capabilities = capabilities,
    }

    -- Nix
    -- vim.lsp.config.nil_ls = {
    --   cmd = { "nil" },
    vim.lsp.config.nixd = {
      cmd = { "nixd" },
      filetypes = { "nix" },
      capabilities = capabilities,
    }

    -- HTML
    vim.lsp.config.html = {
      cmd = { "vscode-html-language-server", "--stdio" },
      capabilities = capabilities,
      filetypes = { "html", "htm" },
      settings = {
        html = {
          format = {
            enable = false, -- Let Prettier handle formatting
          },
        },
      },
    }

    -- CSS
    vim.lsp.config.cssls = {
      cmd = { "vscode-css-language-server", "--stdio" },
      capabilities = capabilities,
      filetypes = { "css", "scss", "less" },
      settings = {
        css = {
          format = {
            enable = false, -- Let Prettier handle formatting
          },
          lint = {
            unknownAtRules = "ignore", -- Avoid conflicts with CSS frameworks
          },
        },
        scss = {
          format = {
            enable = false,
          },
        },
        less = {
          format = {
            enable = false,
          },
        },
      },
    }

    -- PHP
    -- vim.lsp.config.intelephense = {
    --   cmd = { "intelephense", "--stdio" },
    vim.lsp.config.phpactor = {
      cmd = { "phpactor", "language-server" },
      filetypes = { "php" },
      root_markers = { "composer.json", ".git", "index.php" },
      capabilities = capabilities,
    }
    vim.lsp.config.sqls = {
      cmd = { "sqls" },
      filetypes = { "sql", "mysql" },
      root_markers = { "config.yml" },
      settings = {},
    }
    -- QML
    vim.lsp.config.qmlls = {
      cmd = { "qmlls" },
      filetypes = { "qml" },
      capabilities = capabilities,
      settings = {
        qml = {
          -- Suppress warnings about unknown imports
          disableWarnings = false,
          -- Set import paths for Quickshell and Qt
          importPaths = {
            vim.fn.expand("$QML2_IMPORT_PATH"),
          },
        },
      },
      root_markers = { "shell.qml", ".git" },
      -- Ignore warnings that are hard to resolve
      handlers = {
        ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
          if result and result.diagnostics then
            -- Filter out some common false positives
            result.diagnostics = vim.tbl_filter(function(diagnostic)
              local message = diagnostic.message
              -- Suppress Quickshell import warnings
              if message:match("Cannot find module") or message:match("Unexpected token") then
                return false
              end
              return true
            end, result.diagnostics)
          end
          return vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        end,
      },
    }

    -- Lua
    vim.lsp.config.lua_ls = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      capabilities = capabilities,
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
    }
    vim.lsp.enable({
      "clangd",
      "gopls",
      "pyright",
      "ts_ls",
      "ltex",
      -- "texlab",
      "jdtls",
      -- "nil_ls",
      "nixd",
      "html",
      "cssls",
      "phpactor",
      -- "intelephense",
      "lua_ls",
      "qmlls",
      "sqls",
    })
  end,
}
