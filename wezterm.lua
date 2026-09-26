local wezterm = require("wezterm")

local config = wezterm.config_builder()

local function scheme_for_appearance(a)
  return a:find("Dark") and "Everforest Dark (Gogh)"
    or "Everforest Light (Gogh)"
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 14.0
config.line_height = 1.1

config.window_background_opacity = 0.95
config.macos_window_background_blur = 30

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

return config
