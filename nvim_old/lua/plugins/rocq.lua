return {
  "whonore/Coqtail",
  ft = "coq", -- Carga el plugin solo para archivos .v de Coq
  dependencies = {
    -- Lazy.nvim instalará automáticamente pynvim si es necesario
  },
  config = function()
    -- Configuración básica opcional de Coqtail
    vim.g.coqtail_auto_start = 0 -- No iniciar automáticamente (0 = no, 1 = sí)
    
    -- Opcional: Especificar la ruta del ejecutable de Coq si no está en PATH
    -- vim.g.coqtail_coq_prog = "coqidetop"
    
    -- Opcional: Configurar atajos de teclado personalizados
    -- vim.api.nvim_set_keymap('n', '<leader>cc', ':CoqStart<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<leader>cn', ':CoqNext<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<leader>cu', ':CoqUndo<CR>', { noremap = true, silent = true })
  end,
}
