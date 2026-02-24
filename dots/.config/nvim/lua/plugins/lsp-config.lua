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
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
      },
      capabilities = capabilities,
      root_dir = function(bufnr, on_dir)
        -- Find project root
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.find({ "package.json", "tsconfig.json", ".git" }, {
          path = fname,
          upward = true,
        })[1]
        on_dir(root and vim.fs.dirname(root) or vim.fn.getcwd())
      end,
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            -- Use absolute path resolved from project root
            location = vim.fn.fnamemodify(vim.fn.findfile("package.json", ".;"), ":h")
              .. "/node_modules/@vue/language-server",
            languages = { "vue" },
          },
        },
      },
      settings = {
        typescript = {
          preferences = {
            importModuleSpecifierFormat = "es2020",
          },
        },
      },
    }

    -- Vue Language Server (handles CSS/HTML/template)
    vim.lsp.config.vue_ls = {
      cmd = { "vue-language-server", "--stdio" },
      filetypes = { "vue" },
      capabilities = capabilities,
      root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    }

    vim.lsp.config.astro = {
      cmd = { "astro-ls", "--stdio" },
      filetypes = { "astro" },
      capabilities = capabilities,
      root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
      init_options = {
        typescript = {},
      },
    }

    vim.lsp.config.tailwindcss = {
      cmd = { "tailwind-language-server", "--stdio" },
      filetypes = {
        -- html
        "astro",
        "astro-markdown",
        "html",
        "markdown",
        "mdx",
        "php",
        "twig",
        -- css
        "css",
        "less",
        "postcss",
        "sass",
        "scss",
        "stylus",
        -- js
        "javascript",
        "javascriptreact",
        "reason",
        "rescript",
        "typescript",
        "typescriptreact",
        -- mixed
        "vue",
        "svelte",
      },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
      settings = {
        tailwindCSS = {
          validate = true,
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidScreen = "error",
            invalidVariant = "error",
            invalidConfigPath = "error",
            invalidTailwindDirective = "error",
            recommendedVariantOrder = "warning",
          },
          classAttributes = {
            "class",
            "className",
            "class:list",
            "classList",
            "ngClass",
          },
          includeLanguages = {
            templ = "html",
          },
        },
      },
      before_init = function(_, config)
        if not config.settings then
          config.settings = {}
        end
        if not config.settings.editor then
          config.settings.editor = {}
        end
        if not config.settings.editor.tabSize then
          config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
        end
      end,
      workspace_required = true,
      root_dir = function(bufnr, on_dir)
        local root_files = {
          -- Generic
          "tailwind.config.js",
          "tailwind.config.cjs",
          "tailwind.config.mjs",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.cjs",
          "postcss.config.mjs",
          "postcss.config.ts",
          -- Fallback for tailwind v4, where tailwind.config.* is not required anymore
          ".git",
        }
        local fname = vim.api.nvim_buf_get_name(bufnr)
        root_files = util.insert_package_json(root_files, "tailwindcss", fname)
        root_files = util.root_markers_with_field(root_files, { "mix.lock", "Gemfile.lock" }, "tailwind", fname)
        on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
      end,
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
      filetypes = { "html" },
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
      "astro",
      "vue_ls",
      "tailwindcss",
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
