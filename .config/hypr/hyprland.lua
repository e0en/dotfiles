local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "hyprlancher"
local browser = "firefox"

-- cursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- nvidia
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- korean input
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("INPUT_METHOD", "fcitx")
hl.env("XIM", "fcitx")
hl.env("XIM_PROGRAM", "fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "fcitx")

-- start programs
hl.on("hyprland.start", function()
  hl.exec_cmd("fcitx5 -d")
  hl.exec_cmd("1password --silent &")
  hl.exec_cmd("dropbox &")
end)

-- basic looks
hl.config({
  general = {
    border_size = 8,
    gaps_in = 16,
    gaps_out = 32,
    layout = "dwindle",
    resize_on_border = true,
  },
  decoration = {
    blur = {
      enabled = true,
      size = 16,
      noise = 0.2,
      passes = 1,
    },
    shadow = {
      enabled = true,
      range = 20,
      offset = "0 4",
      color = 0x801a1a1a,
    },
  },
  animations = {
    enabled = false,
  },
})

-- key binding
local mainMod = "SUPER"

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(
  mainMod .. " + M",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move active window to a direction
hl.bind(mainMod .. " + SHIFT + " .. "left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + " .. "right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + " .. "up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + " .. "down", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.window_rule({ workspace = 4, match = { class = "steam" } })
hl.window_rule({ float = true, match = { class = "steam" } })
hl.window_rule({ float = true, match = { class = "mpv" } })
hl.window_rule({ workspace = 2, match = { class = "FreeCAD" } })
hl.window_rule({ workspace = 2, match = { class = "PrusaSlicer" } })
