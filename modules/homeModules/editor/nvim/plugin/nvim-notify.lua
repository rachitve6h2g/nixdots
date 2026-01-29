local notify = require("notify")

notify.setup({
  background_color = "NotfiyBackground",
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "",
    WARN = "",
  },
  position = "top_right",
  render = "compact",
  stages = "fade_in_slide_out",
  timeout = 1000,
})
vim.notify = notify.notify
