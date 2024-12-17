return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		"mustache/vim-mustache-handlebars",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.solargraph.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ember.setup({
				capabilities = capabilities,
				cmd = { "ember-language-server", "--stdio" },
				filetypes = { "handlebars", "html.handlebars", "hbs", "html.hbs", "javascript" },
			})
            require("rust-tools").setup({
                server = {
                    on_attach = function(_, bufnr)
                        local opts = { noremap = true, silent = true }
                        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
                        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
                    end,
                    capabilities = capabilities,
                },
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
            })
			vim.keymap.set("n", "I", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
    {
        "simrat39/rust-tools.nvim",
        lazy = true, 
    }
}
