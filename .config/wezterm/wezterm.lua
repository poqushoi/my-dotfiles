local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Dark+'
-- config.color_scheme = 'ayu'

config.font = wezterm.font_with_fallback {
  {
    family = 'CommitMono Nerd Font',
  },
  {
    family = 'JetBrainsMono Nerd Font',
  },
  {
    family = 'LiterationMono Nerd Font',
  },
  {
    family = 'FiraCode Nerd Font',
  },
  {
    family = 'DejaVuSansMono Nerd Font',
  },
  {
    family = 'Hack Nerd Font',
  },
}

config.font_size = 11

-- disable bar at the top
config.window_decorations = 'RESIZE' -- "TITLE | RESIZE"

config.window_background_opacity = 1.0 -- 0.85

wezterm.on('toggle-opacity', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 1
  else
    overrides.window_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end)

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'q',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = 'q',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
  {
    key = 'o',
    mods = 'LEADER',
    action = wezterm.action.EmitEvent 'toggle-opacity',
  },

  { key = 'UpArrow', mods = 'SHIFT', action = wezterm.action.ScrollToPrompt(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = wezterm.action.ScrollToPrompt(1) },
}

return config
