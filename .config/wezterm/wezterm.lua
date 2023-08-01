local wezterm = require("wezterm")

return {
  -- window appearance
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  window_padding = {
    left = "1cell",
    right = "1cell",
    top = "2cell",
    bottom = "0.5cell",
  },
  initial_cols = 80,
  initial_rows = 48,

  -- cursor
  default_cursor_style = "BlinkingBlock",
  cursor_blink_rate = 200,
  animation_fps = 60,

  -- font
  font = wezterm.font("Berkeley Mono", { weight = "Regular", stretch = "Normal", style = "Normal" }),
  font_size = 12.0,
  unicode_version = 14,

  -- color
  -- https://wezfurlong.org/wezterm/colorschemes/index.html
  -- color_scheme = "Vacuous 2 (terminal.sexy)",
  -- color_scheme = "VisiBone (terminal.sexy)",
  color_scheme = "vulcan (base16)",
  -- color_scheme = "SleepyHollow",
  -- color_scheme = "Mashup Colors (terminal.sexy)",
}
