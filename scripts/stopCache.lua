local maxBytes = mp.get_property("demuxer-max-bytes")
local function stopCache()
	local state = mp.get_property_native("demuxer-cache-state")
	if state and state["cache-end"] and tonumber(state["cache-end"]) > tonumber(mp.get_property("end")) then
		mp.set_property("demuxer-max-bytes",0)
		print("stop")
		mp.unobserve_property(stopCache)
	end
end
local function look()
	if mp.get_property("end") ~= "none" then
		maxBytes = mp.get_property("demuxer-max-bytes")
		mp.observe_property("time-pos", "number", stopCache)
	end
end
look()
mp.add_key_binding("alt+c", "restore", function() mp.set_property("demuxer-max-bytes",maxBytes); print("continue"); end)
mp.add_key_binding("alt+x", "look", look)
