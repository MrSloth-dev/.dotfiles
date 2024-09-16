local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("IosevkaTerm Nerd Font")
config.font_size = 19
config.enable_tab_bar = false

config.window_decorations = "TITLE | RESIZE"
config.color_scheme = "Gruvbox Dark (Gogh)"
config.window_background_opacity = 0.9
config.window_padding = {
	left = 2,
	right = 0,
	top = 0,
	bottom = 0,
}
config.cursor_blink_rate = 800

return config
