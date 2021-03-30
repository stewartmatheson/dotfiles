local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local volume_widget = wibox.widget({
    type = "textbox",
    name = "tb_volume",
	widget = wibox.widget.textbox
})

local GET_VOLUME_COMMAND = "amixer sget Master"

local function update_volume(widget, stdout)
    if (stdout ~= nil) then
        local current_volume = tonumber(string.match(stdout, "(%d?%d?%d)%%"))
        widget.text = current_volume
    end
end

local function factory(theme)
    awful.widget.watch(GET_VOLUME_COMMAND, 1,  update_volume, volume_widget)
    volume_widget.font = theme.font

    local keys = gears.table.join(
        awful.key({}, "#123", function ()
            awful.spawn("amixer set Master 5%+")
            update_volume(volume_widget)
        end),

        awful.key({}, "#122", function ()
            awful.spawn("amixer set Master 5%-")
            update_volume(volume_widget)
        end)
    )
    return { widget = volume_widget, keys = keys }
end

return factory
