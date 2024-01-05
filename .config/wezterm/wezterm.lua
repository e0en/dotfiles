local wezterm = require("wezterm")

if wezterm.target_triple == "aarch64-apple-darwin" then
  config = {
    -- window appearance
    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = false,
    window_decorations = "INTEGRATED_BUTTONS|RESIZE",
    window_padding = {
      left = "0cell",
      right = "0cell",
      top = "0cell",
      bottom = "0cell",
    },
    initial_cols = 80,
    initial_rows = 48,

    -- cursor
    default_cursor_style = "BlinkingBlock",
    cursor_blink_rate = 200,
    animation_fps = 60,

    font_size = 12.0,
  }
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
  config = {
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    font_size = 10.0,
  }
else
  config = {}
end

-- https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = "ayu"
config.font = wezterm.font("Berkeley Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.unicode_version = 1

return config
