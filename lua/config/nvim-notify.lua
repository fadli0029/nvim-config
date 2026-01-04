local nvim_notify = require("notify")
nvim_notify.setup {
  stages = "fade_in_slide_out",
  timeout = 1500,
  background_colour = "#0A0A0C",
  max_width = 80,
  render = "wrapped-compact",
}
vim.notify = nvim_notify
