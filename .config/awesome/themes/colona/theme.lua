---------------------------
-- Default awesome theme --
--  modified by colona   --
---------------------------

theme = {}

theme.font          = "sans 8"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "~/.config/awesome/themes/colona/taglist/squarefw.png"
theme.taglist_squares_unsel = "~/.config/awesome/themes/colona/taglist/squarew.png"

theme.tasklist_floating_icon = "~/.config/awesome/themes/colona/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "~/.config/awesome/themes/colona/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "xsetroot -solid black" }

-- You can use your own layout icons like this:
theme.layout_fairh = "~/.config/awesome/themes/colona/layouts/fairhw.png"
theme.layout_fairv = "~/.config/awesome/themes/colona/layouts/fairvw.png"
theme.layout_floating  = "~/.config/awesome/themes/colona/layouts/floatingw.png"
theme.layout_magnifier = "~/.config/awesome/themes/colona/layouts/magnifierw.png"
theme.layout_max = "~/.config/awesome/themes/colona/layouts/maxw.png"
theme.layout_fullscreen = "~/.config/awesome/themes/colona/layouts/fullscreenw.png"
theme.layout_tilebottom = "~/.config/awesome/themes/colona/layouts/tilebottomw.png"
theme.layout_tileleft   = "~/.config/awesome/themes/colona/layouts/tileleftw.png"
theme.layout_tile = "~/.config/awesome/themes/colona/layouts/tilew.png"
theme.layout_tiletop = "~/.config/awesome/themes/colona/layouts/tiletopw.png"
theme.layout_spiral  = "~/.config/awesome/themes/colona/layouts/spiralw.png"
theme.layout_dwindle = "~/.config/awesome/themes/colona/layouts/dwindlew.png"

return theme

