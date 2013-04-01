local screen = require("screen")
local naughty = require("naughty")
local awful = require("awful")
awful.util = require("awful.util")
awful.tag = require("awful.tag")
awful.layout = require("awful.layout")

izanagi = {}

izanagi.reserved_tags = 3

function notify(text)
   naughty.notify({ title = "Izanagi", text = text})
end

function izanagi.get_mode(promptbox)
   awful.prompt.run({ prompt = "Izanagi mode: " },
		    promptbox[mouse.screen].widget,
		    izanagi.run_mode)

end

function izanagi.run_mode (modestr)
   local err
   local success

   local modparam = string.split(modestr, " ")
   local modename = modparam[1]

   success, err = pcall(require, "modes." .. string.lower(modename))
   if success then
      notify("'" .. string.lower(modename) .. "' is loaded")
      izanagi.go_for(mode, modparam)
   else
      notify("Can't find '" .. string.lower(modename) .. "' module")
      notify("Error: " .. err)

   end

end


function izanagi.go_for(mode, modparams)
   local config

   if modparams[2] ~= nil then
      config = mode[modparam[1]]
   else
      if mode.default == nil then
	 notify("Error: No default configuration found.")
	 return
      end

      config = mode.default
   end

   if type(config) == "function" then
      config = config(modparams)
   end

   izanagi.prepar_desktop(config)

end

function izanagi.prepar_desktop(config)
   local s = mouse.screen
   local current_tags = awful.tag.gettags(s)
   local tags

   if config.tags ~= nil then
      tags = config.tags

      if tablelen(tags) + izanagi.reserved_tags >= tablelen(current_tags) then
	 local difference = (tablelen(tags) + izanagi.reserved_tags) - tablelen(current_tags)
	 local lasttagnum = tablelen(current_tags)

	 for i=lasttagnum + 1, lasttagnum + difference do
	    local t = awful.tag.new(i, {name = i})
	    awful.tag.setscreen(t, s)
	 end
      end

      local tagnum = 1
      for i, _ in pairs(awful.util.table.keys(tags)) do
	 local name

	 -- set only the name of the tag in the config not the number
	 for j in string.gmatch(_, "%a+$") do name = j end
	 current_tags[tagnum].name = name
	 -- ---------------------------------------

	 -- Setup layout of the tag.
	 if tags[_].layout ~= nil then
	    local layout = require(tags[_].layout)
	    awful.layout.set(layout, current_tags[tagnum])
	 end
	 -- ---------------------------------------

	 tagnum = tagnum + 1
      end

   else
      notify("Warrning: to tags found for this mode")
   end

end

-- Get the number of a table elements
function tablelen(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


-- string split utility
function string.split(s,d)
   local t = {}
   local i = 0
   local f
   local match = '(.-)' .. d .. '()'
   if string.find(s, d) == nil then
      return {s}
   end
   for sub, j in string.gfind(s, match) do
         i = i + 1
         t[i] = sub
         f = j
   end
   if i~= 0 then
      t[i+1]=string.sub(s,f)
   end
   return t
end