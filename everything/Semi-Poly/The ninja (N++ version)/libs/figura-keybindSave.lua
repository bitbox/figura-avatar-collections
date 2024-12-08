-- Keybind autosave, Script by superpowers04

-- Host-side only script. Return
--  This is a guard clause, it saves cpu time and is neater than using an if statement spanning the entire function, script or scope
if(not host:isHost()) then return end 

-- Call this to save the keybinds manually.
-- Useful if you want to manually save instead of using the tick function 
function saveKeybinds() 
	local keyConfig = config:load('KEYCONFIG') or {} -- Load the KEYCONFIG table from your config, if it's not present, use an empty table
	local count = 0 -- Keep count of the keys we've rebound
	for name,keybind in pairs(keybinds:getKeybinds()) do -- Loop all of through your keybinds
		local key = keybind:getKey() -- Get the key that's bound to this keybind
		-- Check if key is different than the saved one 
		--  We can't use a guard clause here because there's no easy way to skip a specific iteration of a loop in lua sadly
		if key ~= keyConfig[name] then 
			keyConfig[name] = keybind:getKey() -- Set the name of the key's index in keyconfig to the key that's bound
			count = count + 1 -- Add 1 to count
		end
	end
	-- If nothing's changed, return out of the function instead of uselessly saving. A guard clause :3
	if count == 0 then return end

	config:save('KEYCONFIG',keyConfig) -- Save the keys to your config
	--print('Saved ' .. count .. ' keybinds') -- Print that we've done so, this can technically be removed but meh
end

-- Call this to load keybinds manually. Useful if you want to 
function loadKeybinds()
	local keyConfig = config:load('KEYCONFIG') -- Load the key config
	-- Can't iterate on a nil value. Another guard clause :3
	if not keyConfig then return end

	for name,keybind in pairs(keybinds:getKeybinds()) do -- loop through all of your keybinds
		-- Check if key config has this keybind
		--  We can't use a guard clause here because there's no easy way to skip a specific iteration of a loop in lua sadly
		if(keyConfig[name]) then 
			keybind:setKey(keyConfig[name]) -- Set it to the saved key
		end
	end
end
-- Loads the keybinds when the entity is initialised to allow keys to be created
events.entity_init:register(loadKeybinds,'keybindAutoSave.load')

-- Disable the below if you don't want the screen checked every tick

-- Automatically saves the keybinds if the screen has changed out of the keybind screen
local lastScr = "" -- Keep track of the last screen
events.tick:register(function()
	local scr = host:getScreen() -- Grab the current screen
	-- Check if the screens are the same, return if so. no need to compare screens if nothing's changed
	if scr == lastScr then return end
		
	-- Check if lastScr exists, if it does, check for "figura" and "keybindscreen".
	--  This doesn't use the actual id to allow support for both multiloader(0.1.2+) and fabric(0.1.1-) versions of Figura
	--  We check for figura to prevent saving whenever you leave another screen with the `keybindscreen` identifier
	if(lastScr and lastScr:lower():find('figura.-keybindscreen$')) then 
		saveKeybinds() -- Self explanatory
	end
	-- Update lastScr to scr. 
	-- Prevents needing to use find on lastScr every tick for no reason, 
	--  and also prevents saving the keybinds literally every tick
	lastScr = scr
end,'keybindAutoSave.tick')
