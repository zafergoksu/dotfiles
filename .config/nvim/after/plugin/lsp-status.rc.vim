
lua << EOF
local lsp_status = require('lsp-status')

lsp_status.config({
    status_symbol = 'lsp_status:',
    indicator_errors = 'Error',
    indicator_warnings = 'Warning',
    indicator_info = 'Info',
    indicator_hint = 'Hint',
    indicator_ok = 'Ok',
})
EOF
