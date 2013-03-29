local screen = require("screen")
local naughty = require("naughty")
local awful = require("awful")
awful.tag = require("awful.tag")

izanagi = {}

function notify(text)
   naughty.notify({ title = "Izanagi", text = text})
end

function izanagi.get_mode(promptbox)
   awful.prompt.run({ prompt = "Izanagi mode: " },
		    promptbox[mouse.screen].widget,
		    izanagi.run_mode)

end

function izanagi.run_mode (modename)
   local err
   local success

   success, err = pcall(require, "modes." .. string.lower(modename))
   if success then
      notify("'" .. string.lower(modename) .. "' is loaded")
      izanagi.go_for(mode)
   else
      notify("Can't find '" .. string.lower(modename) .. "' module")
      notify("Error: " .. err)

   end

end


function izanagi.go_for(mode)
   local s = mouse.screen
   local tags = awful.tag.gettags(s)
   for _, tag in pairs() do

      awful.tag.delete(tag)
   end
end