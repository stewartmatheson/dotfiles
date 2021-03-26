local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local volume_widget = wibox.widget({
    type = "textbox",
    name = "tb_volume",
    align = "right",
	widget = wibox.widget.textbox
})

local function get_volume()
	local fd = io.popen("amixer sget Master")
	local status = fd:read("*all")
	fd:close()

	local volume_value = tonumber(string.match(status, "(%d?%d?%d)%%")) / 100
	status = string.match(status, "%[(o[^%]]*)%]")
	local interpol_colour = "blue"--string.format("%.2x%.2x%.2x", ir, ig, ib)

	if string.find(status, "on", 1, true) then
		return "<span background='#"..interpol_colour.."'>"..volume_value.."</span>"
	else
		return "<span color='red' background='#"..interpol_colour.."'>"..volume_value.."</span>"
	end
end

local function update_volume(widget)
	widget.text = get_volume()
end

local function init ()
    update_volume(volume_widget)

    gears.timer {
        timeout = 1,
        call_now = true,
        autostart = true,
        callback = function ()
            update_volume(volume_widget)
        end
    }
end

local function bind()
    return gears.table.join(
        awful.key({}, "#122", function ()
            awful.spawn("amixer set Master 5%+")
            update_volume(volume_widget)
        end),

        awful.key({}, "#123", function ()
            awful.spawn("amixer set Master 5%-")
            update_volume(volume_widget)
        end)
    )

end

return { widget = volume_widget, init = init, bind = bind }
