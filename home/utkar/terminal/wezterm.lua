local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- =========================================================
-- 1. VISUALS
-- =========================================================
config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "dank-theme"
config.window_background_opacity = 0.90
config.macos_window_background_blur = 10

-- Remove native tab bar settings so the plugin can take over
-- config.use_fancy_tab_bar = true
-- config.tab_bar_at_bottom = true
-- config.hide_tab_bar_if_only_one_tab = true

-- Add padding for that "framed" Zellij look
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 0,
}

-- =========================================================
-- 2. PLUGINS
-- =========================================================

-- Plugin: Smart Splits
-- Allows seamless navigation between Wezterm panes and Neovim splits using Ctrl+h/j/k/l
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config)

-- Plugin: Bar (Eye Candy)
-- Provides the status bar. Loaded AFTER colors are set to ensure it picks up the theme.
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
}) -- =========================================================
-- 3. ZELLIJ EMULATION (Keys)
-- =========================================================

-- Set Leader to Ctrl + g (Zellij Default)
config.leader = { key = "g", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- SPLITS: mimic Zellij (- for vertical, \ for horizontal)
	-- Note: In WezTerm "Vertical" means split top/bottom, "Horizontal" means left/right
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "\\",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- CLOSE PANE: Leader + x
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	-- RESIZE MODE: Leader + r (Enters a mode where hjkl resizes panes)
	{
		mods = "LEADER",
		key = "r",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},

	-- SESSION MANAGER: Leader + s (Like Zellij session list)
	{
		mods = "LEADER",
		key = "s",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
}

-- Key Table for Resizing (Active after pressing Leader + r)
config.key_tables = {
	resize_pane = {
		{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

return config
