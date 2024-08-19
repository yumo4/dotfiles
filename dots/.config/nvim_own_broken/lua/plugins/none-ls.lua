return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
                -- FORMATTER
                --
                -- lua
				null_ls.builtins.formatting.stylua,
                -- js, html, css, md, json, yaml
				null_ls.builtins.formatting.prettier,
                -- c, c++, c#, java
				null_ls.builtins.formatting.astyle,
                -- kotlin
				-- null_ls.builtins.formatting.ktlint,
                -- rust
				-- null_ls.builtins.formatting.rustfmt,
                -- python
				null_ls.builtins.formatting.black,
                -- go
				null_ls.builtins.formatting.gofmt,

                -- DIAGNOSTICS
                --
                -- js
				-- null_ls.builtins.diagnostics.eslint_d,
                -- java, js, python, go
				null_ls.builtins.diagnostics.semgrep,
                -- kotlin
				-- null_ls.builtins.diagnostics.ktlint,

                -- COMPLETION
                --
				null_ls.builtins.completion.spell,
				null_ls.builtins.completion.luasnip,
			},
		})
		-- keybindings
		vim.keymap.set("n", "<leader>df", vim.lsp.buf.format, {})
	end,
}
