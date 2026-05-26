local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.enable_kitty_keyboard = true
config.front_end = "WebGpu"
config.webgpu_power_preference = "LowPower"
config.animation_fps = 60
config.max_fps = 144
config.enable_wayland = true
config.check_for_updates = false

-- config.font = wezterm.font("MesloLGL Nerd Font")
config.font = wezterm.font_with_fallback({
	{
		family = "MesloLGL Nerd Font",
		weight = "Medium",
		harfbuzz_features = {
			"calt=1",
			"liga=1",
			"clig=1",
		},
	},
	"Noto Color Emoji",
})
config.color_scheme = "dank-theme"
config.window_background_opacity = 0.90
config.text_background_opacity = 1.0

-- config.window_decorations = "RESIZE"

config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.disable_default_key_bindings = true

config.keys = {
	-- Allow basic clipboard + zoom only
	{ key = "C", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "V", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

	{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },

	{ key = "F11", action = wezterm.action.ToggleFullScreen },
}

return config
