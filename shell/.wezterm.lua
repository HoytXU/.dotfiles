local wezterm = require 'wezterm'

return {
  hide_mouse_cursor_when_typing = true,
  use_fancy_tab_bar = false,
  window_decorations = "NONE", -- removes title bar
  
  window_background_opacity = 0.9,
  text_background_opacity = 0.9,
  color_scheme = "Catppuccin Mocha",
  window_background_image = wezterm.home_dir .. "/wezterm_background.jpg",
  window_background_image_hsb = {
    brightness = 0.05,
    hue = 1.0,
    saturation = 0.5,
  },

  font = wezterm.font("Hack Nerd Font Mono"),
  font_size = 13.0,
  set_environment_variables = {
    LANG = "en_US.UTF-8",
  },  

  leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    -- Clipboard shortcuts
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },

    -- Split panes using leader
    { key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({}) },
    { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({}) },

    -- Move between panes using leader
    { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },

    -- Close current pane using leader
    { key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
  -- Leader + number: switch tabs (tab indices start at 0)
    { key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
    { key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
    { key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
    { key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
    { key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
    { key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
    { key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
    { key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
    { key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },

  -- Optional: Leader + r to rename current tab
    { key = "r", mods = "LEADER", action = wezterm.action.PromptInputLine {
        description = "Rename Tab",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
        ),
      }
    },
  },
}
