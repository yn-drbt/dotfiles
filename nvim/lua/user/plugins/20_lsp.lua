-- dotfiles/nvim/lua/user/plugins/20_lsp.lua

return {
  -- LSP インストーラ
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- mason と lspconfig を繋ぐ
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },

  -- LSP 本体
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- (補完機能から capabilities をもらうため)
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSPがアタッチされた時の共通設定 (キーマップなど)
      local on_attach = function(client, bufnr)
        local bufmap = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = "LSP: " .. desc })
        end
        
        bufmap("n", "K", vim.lsp.buf.hover, "Hover")
        bufmap("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        bufmap("n", "<leader>e", vim.diagnostic.open_float, "Show Diagnostics")
      end

      -- mason-lspconfig に、インストール済みLSPサーバーをセットアップするよう指示
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          -- ここで各LSPサーバーに共通設定を渡す
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
      })
      
      -- (推奨) よく使うLSPサーバーを自動インストール
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "tsserver", "bashls", "dockerls", "jsonls" }
      })
    end,
  },
}
