local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- =========================================================
-- 1. VISUALS
-- =========================================================
config.font = wezterm.font("MesloLGL Nerd Font")
config.color_scheme = "dank-theme"
config.window_background_opacity = 0.90
config.macos_window_background_blur = 10

-- Remove native tab bar settings so the plugin can take over
-- config.use_fancy_tab_bar = true
-- config.tab_bar_at_bottom = true
-- config.hide_tab_bar_if_only_one_tab = true

-- =========================================================
-- 2. PLUGINS
-- =========================================================

-- Plugin: Smart Splits
-- Allows seamless navigation between Wezterm panes and Neovim splits using Ctrl+h/j/k/l
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config)

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
	position = "bottom",
	max_width = 32,
	padding = {
		left = 1,
		right = 1,
		tabs = {
			left = 0,
			right = 2,
		},
	},
	separator = {
		space = 1,
		left_icon = wezterm.nerdfonts.fa_long_arrow_right,
		right_icon = wezterm.nerdfonts.fa_long_arrow_left,
		field_icon = wezterm.nerdfonts.indent_line,
	},
	modules = {
		tabs = {
			active_tab_fg = 4,
			inactive_tab_fg = 6,
			new_tab_fg = 2,
		},
		workspace = {
			enabled = true,
			icon = wezterm.nerdfonts.cod_window,
			color = 8,
		},
		leader = {
			enabled = true,
			icon = wezterm.nerdfonts.oct_rocket,
			color = 2,
		},
		zoom = {
			enabled = false,
			icon = wezterm.nerdfonts.md_fullscreen,
			color = 4,
		},
		pane = {
			enabled = true,
			icon = wezterm.nerdfonts.cod_multiple_windows,
			color = 7,
		},
		username = {
			enabled = true,
			icon = wezterm.nerdfonts.fa_user,
			color = 6,
		},
		hostname = {
			enabled = true,
			icon = wezterm.nerdfonts.cod_server,
			color = 8,
		},
		clock = {
			enabled = true,
			icon = wezterm.nerdfonts.md_calendar_clock,
			format = "%H:%M",
			color = 5,
		},
		cwd = {
			enabled = true,
			icon = wezterm.nerdfonts.oct_file_directory,
			color = 7,
		},
		spotify = {
			enabled = false,
			icon = wezterm.nerdfonts.fa_spotify,
			color = 3,
			max_width = 64,
			throttle = 15,
		},
	},
})

-- =========================================================
-- 3. ZELLIJ EMULATION (Keys)
-- =========================================================

config.disable_default_key_bindings = true

return config
