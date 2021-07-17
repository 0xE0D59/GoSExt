--[[
	Sussy Utils: utility script for Gaming On Steroids
	
	version 1.0
	
	Changelog:
	-- 1.0:	Initial release
]]--
local Version = "1.0"

File = {}
do
	function File:WriteSpriteToFile(path, str)
		path = SPRITE_PATH .. path
		if FileExist(path) then return end
		local output = io.open(path, 'wb')
		output:write(File:Base64Decode(str))
		output:close()
	end
	
	function File:Base64Decode(data)
		local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
		data = string.gsub(data, '[^'..b..'=]', '')
		return (data:gsub('.', function(x)
			if (x == '=') then return '' end
			local r, f = '', (b:find(x) - 1)
			for i = 6, 1, -1 do r = r..(f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0') end return r;
		end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
			if (#x ~= 8) then return '' end
			local c = 0
			for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0) end return string.char(c)
		end))
	end
end

-- Icons start
do
	File:WriteSpriteToFile('MenuElement/SussyUtils.png', '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')	
end
-- Icons end

do
	Menu = {}
	Menu.utils = MenuElement({name = "Sussy Utils", id = 'Sussy ' .. myHero.charName, type = _G.MENU, leftIcon = "/SussyUtils.png"})
	Menu.zhonya = Menu.utils:MenuElement({name = 'Zhonya timers', id = 'zhonya', type = _G.MENU})
	Menu.zhonya_enabled = Menu.zhonya:MenuElement({id = 'enabled', name = 'Enabled', value = true})
	Menu.zhonya_allies = Menu.zhonya:MenuElement({id = 'allies', name = 'Show Allies', value = true, leftIcon = "http://puu.sh/rGoYo/0e0e445743.png"})
	Menu.zhonya_enemies = Menu.zhonya:MenuElement({id = 'enemies', name = 'Show Enemies', value = true, leftIcon = "http://puu.sh/rGoYt/5c99e94d8a.png"})
	Menu.zhonya_player = Menu.zhonya:MenuElement({id = 'player', name = 'Show Me', value = true, leftIcon = "http://puu.sh/rGoYo/0e0e445743.png"})
	Menu.zhonya_size_inner = Menu.zhonya:MenuElement({id = 'sizeInner', name = 'Inner Radius', value = 150, min = 5, max = 600, step = 5})
	Menu.col_inner = Menu.zhonya:MenuElement({id = 'col', name = 'Inner Color', color = Draw.Color(250, 250, 210, 85)})
	Menu.zhonya_size_outer = Menu.zhonya:MenuElement({id = 'sizeOuter', name = 'Outer Radius', value = 400, min = 5, max = 600, step = 5})
	Menu.col_outer = Menu.zhonya:MenuElement({id = 'col', name = 'Outer Color', color = Draw.Color(250, 250, 210, 85)})
	Menu.utils:MenuElement({name = '', type = _G.SPACE, id = 'VersionSpacer'})
	Menu.utils:MenuElement({name = 'Version  ' .. Version, type = _G.SPACE, id = 'VersionNumber'})
	
	local ActiveZhonyas = {}
	local ZhonyaBuffName = "zhonyasringshield"
	Callback.Add('Tick', function()
		if not Menu.zhonya_enabled:Value() then return end
		for i = 1, Game.HeroCount() do 
			local hero = Game.Hero(i)
			local zhonyaBuff = nil
			for i = 0, myHero.buffCount do
				local buff = myHero:GetBuff(i)
				if buff.type == 18 and buff.duration > 0 then
					zhonyaBuff = buff
				end
			end
			if zhonyaBuff then
				local previous = ActiveZhonyas[hero.name]
				local duration = zhonyaBuff.duration
				if previous then
					duration = math.max(previous.Duration, duration)
				end				
				ActiveZhonyas[hero.name] = {Duration = duration, Remaining = zhonyaBuff.duration}
			else
				ActiveZhonyas[hero.name] = nil
			end
		end
	end)
	Callback.Add('Draw', function()
		if not Menu.zhonya_enabled:Value() then return end
		for i = 1, Game.HeroCount() do 
			local hero = Game.Hero(i)
			if (hero.team == myHero.team and Menu.zhonya_allies:Value() and hero ~= myHero) or (hero.team ~= myHero.team and Menu.zhonya_enemies:Value()) or (hero == myHero and Menu.zhonya_player:Value()) then
				local zhonya = ActiveZhonyas[myHero.name]
				if zhonya then
					local t = zhonya.Remaining / zhonya.Duration
					local outerSize = Menu.zhonya_size_inner:Value() * (1 - t) + Menu.zhonya_size_outer:Value() * t
					Draw.Circle(hero, Menu.zhonya_size_inner:Value(), 5, Menu.col_inner:Value())
					Draw.Circle(hero, outerSize, 5, Menu.col_outer:Value())
				end
			end
		end
	end)
	
	print("SussyUtils loaded.")
end