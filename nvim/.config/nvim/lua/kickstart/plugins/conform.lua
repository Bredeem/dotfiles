return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[C]urrent buffer [F]ormat',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if vim.g.autoformat then
          -- Disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style. You can add additional
          -- languages here or re-enable it for the disabled ones.
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          else
            return {
              timeout_ms = 500,
              lsp_format = 'fallback',
            }
          end
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        svelte = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        json5 = { 'prettier' },
      },
    },
  },
  { -- Assuming you init/setup snacks.nvim in a different file
    'folke/snacks.nvim',
    opts = function()
      vim.g.autoformat = true -- Sets up the default value to be true

      Snacks.toggle
        .new({
          id = 'Format on Save',
          name = 'Format on Save',
          get = function()
            return vim.g.autoformat
          end,
          set = function(_)
            vim.g.autoformat = not vim.g.autoformat
          end,
        })
        :map '<leader>uf'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
