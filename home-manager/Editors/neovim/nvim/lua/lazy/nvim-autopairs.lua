return{
  {
    'nvim-autopairs',
    event = "InsertEnter",
    after = function()
      local npairs = require("nvim-autopairs")
      -- local Rule = require('nvim-autopairs.rule')

      npairs.setup({
        check_ts = true,
        enable_check_bracket_line = false, -- don't add pairs if it already has a close pair in the same line
        ts_config = {
          lua = {'string'},
          javascript = {'template_string'},
          java = false, -- don't check treesitter on java
        },
        -- fast_wrap: use <a-e>
        fast_wrap = {},
      })
    end
  }
}
