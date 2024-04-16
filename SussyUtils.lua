--[[
	Sussy Utils: utility script for Gaming On Steroids
	
	version 1.2
	
	Changelog:
	-- 1.2: Added Profane Hydra usage
	-- 1.1: Added potion handling
	-- 1.0:	Initial release (Zhonya timers)
]]--
local Version = "1.2"

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
	Menu = MenuElement({name = "Sussy Utils", id = 'SussyUtils', type = _G.MENU, leftIcon = "/SussyUtils.png"})
		
	Menu.potter = Menu:MenuElement({name = 'Potions', id = 'su.potter', type = _G.MENU})
	Menu.potter_enabled = Menu.potter:MenuElement({id = "enabled", name = "Enabled", value = true})
    Menu.potter_regular = Menu.potter:MenuElement({id = "regular", name = "Health Potions", value = true, leftIcon = "https://ddragon.leagueoflegends.com/cdn/10.23.1/img/item/2003.png"})
    Menu.potter_cookies = Menu.potter:MenuElement({id = "cookies", name = "Biscuit", value = true, leftIcon = "https://ddragon.leagueoflegends.com/cdn/10.23.1/img/item/2010.png"})
    Menu.potter_refill = Menu.potter:MenuElement({id = "refill", name = "Refillable Potion", value = true, leftIcon = "https://ddragon.leagueoflegends.com/cdn/10.23.1/img/item/2031.png"})
    Menu.potter_corrupt = Menu.potter:MenuElement({id = "corrupt", name = "Corrupting Potion", value = true, leftIcon = "https://ddragon.leagueoflegends.com/cdn/10.23.1/img/item/2033.png"})
    Menu.potter_health = Menu.potter:MenuElement({id = "healthPercent", name = "Use if HP% below:", value = 50, min = 1, max = 100, identifier = "%"})
	
	Menu.zhonya = Menu:MenuElement({name = 'Zhonya timers', id = 'zhonya', type = _G.MENU})
	Menu.zhonya_enabled = Menu.zhonya:MenuElement({id = 'enabled', name = 'Enabled', value = true})
	Menu.zhonya_allies = Menu.zhonya:MenuElement({id = 'allies', name = 'Show Allies', value = true, leftIcon = "http://puu.sh/rGoYo/0e0e445743.png"})
	Menu.zhonya_enemies = Menu.zhonya:MenuElement({id = 'enemies', name = 'Show Enemies', value = true, leftIcon = "http://puu.sh/rGoYt/5c99e94d8a.png"})
	Menu.zhonya_player = Menu.zhonya:MenuElement({id = 'player', name = 'Show Me', value = true, leftIcon = "http://puu.sh/rGoYo/0e0e445743.png"})
	Menu.zhonya_size_inner = Menu.zhonya:MenuElement({id = 'sizeInner', name = 'Inner Radius', value = 150, min = 5, max = 600, step = 5})
	Menu.col_inner = Menu.zhonya:MenuElement({id = 'col', name = 'Inner Color', color = Draw.Color(250, 250, 210, 85)})
	Menu.zhonya_size_outer = Menu.zhonya:MenuElement({id = 'sizeOuter', name = 'Outer Radius', value = 400, min = 5, max = 600, step = 5})
	Menu.col_outer = Menu.zhonya:MenuElement({id = 'col', name = 'Outer Color', color = Draw.Color(250, 250, 210, 85)})
	
	Menu.items = Menu:MenuElement({name = 'Items', id = 'items', type = _G.MENU})
	Menu.items_profane = Menu.items:MenuElement({name = 'Profane Hydra', id = 'profane', type = _G.MENU})
	Menu.items_profaneuse = Menu.items_profane:MenuElement({name = 'Use Profane Hydra', id = 'profaneuse', value = true})
	Menu.items_profaneusecombo = Menu.items_profane:MenuElement({name = 'Only in combo', id = 'profaneusecombo', value = true})
	Menu.items_profaneusebelow = Menu.items_profane:MenuElement({name = 'Only if target below 50% HP', id = 'profaneusebelow', value = true})
	Menu.items_profaneblacklist = Menu.items_profane:MenuElement({name = 'Blacklist', id = 'profaneblacklist', type = _G.MENU})
	Menu.items_profaneblock = Menu.items_profane:MenuElement({name = 'Block if spell ready', id = 'profaneblock', type = _G.MENU})
	Menu.items_profaneblockq = Menu.items_profaneblock:MenuElement({name = 'Block if Q ready', id = 'profaneblockq', value = false})
	Menu.items_profaneblockw = Menu.items_profaneblock:MenuElement({name = 'Block if W ready', id = 'profaneblockw', value = false})
	Menu.items_profaneblocke = Menu.items_profaneblock:MenuElement({name = 'Block if E ready', id = 'profaneblocke', value = false})
	Menu.items_profaneblockr = Menu.items_profaneblock:MenuElement({name = 'Block if R ready', id = 'profaneblockr', value = false})
	
	Menu:MenuElement({name = '', type = _G.SPACE, id = 'VersionSpacer'})
	Menu:MenuElement({name = 'Version  ' .. Version, type = _G.SPACE, id = 'VersionNumber'})
	
	function GetEnemies()
        local enemies = {}
        for i = 1, Game.HeroCount() do
            local hero = Game.Hero(i)
            if hero and hero.team ~= myHero.team then
                table.insert(enemies, hero)
            end
        end
        return enemies
    end
	
	DelayAction(
                function()
                    for i, target in pairs(GetEnemies()) do
                        Menu.items_profaneblacklist:MenuElement(
                            {id = "profaneblacklist_" .. target.charName, name = target.charName, value = false}
                        )
                    end
                end,
                1
            )
	
	ZhonyaTimers = {}
	do
		ZhonyaTimers.ActiveZhonyas = {}
		ZhonyaTimers.Tick = function()
			if not Menu.zhonya_enabled:Value() or myHero.dead or Game.IsChatOpen() then return end
			for i = 1, Game.HeroCount() do 
				local hero = Game.Hero(i)
				local zhonyaBuff = nil
				for i = 0, hero.buffCount do
					local buff = hero:GetBuff(i)
					if buff.type == 18 and buff.duration > 0 then
						zhonyaBuff = buff
					end
				end
				if zhonyaBuff then
					local previous = ZhonyaTimers.ActiveZhonyas[hero.name]
					local duration = zhonyaBuff.duration
					if previous then
						duration = math.max(previous.Duration, duration)
					end				
					ZhonyaTimers.ActiveZhonyas[hero.name] = {Duration = duration, Remaining = zhonyaBuff.duration}
				else
					ZhonyaTimers.ActiveZhonyas[hero.name] = nil
				end
			end		
		end
		ZhonyaTimers.Draw = function()
			if not Menu.zhonya_enabled:Value() or myHero.dead or Game.IsChatOpen() then return end
			for i = 1, Game.HeroCount() do 
				local hero = Game.Hero(i)
				if (hero.team == myHero.team and Menu.zhonya_allies:Value() and hero ~= myHero) or (hero.team ~= myHero.team and Menu.zhonya_enemies:Value()) or (hero == myHero and Menu.zhonya_player:Value()) then
					local zhonya = ZhonyaTimers.ActiveZhonyas[hero.name]
					if zhonya then
						local t = zhonya.Remaining / zhonya.Duration
						local outerSize = Menu.zhonya_size_inner:Value() * (1 - t) + Menu.zhonya_size_outer:Value() * t
						Draw.Circle(hero, Menu.zhonya_size_inner:Value(), 5, Menu.col_inner:Value())
						Draw.Circle(hero, outerSize, 5, Menu.col_outer:Value())
					end
				end
			end
		end
	end
	
	Potter = {}
	do
		Potter.NextTick = 0
		Potter.ItemHotKey = {[ITEM_1] = HK_ITEM_1, [ITEM_2] = HK_ITEM_2,[ITEM_3] = HK_ITEM_3, [ITEM_4] = HK_ITEM_4, [ITEM_5] = HK_ITEM_5, [ITEM_6] = HK_ITEM_6,}
		
		Potter.Tick = function()
			if not Menu.potter_enabled:Value() or Potter.NextTick > Game.Timer() or myHero.dead or Game.IsChatOpen() then return end
			if Potter:IsPlayerAtFountain() then
				NextTick = Game.Timer() + 0.25
				return
			end
			if not Potter:ShouldPlayerDrinkPotion() then
				NextTick = Game.Timer() + 0.25
				return
			end
			local healingBuff = Potter:GetHealingBuff()
			if healingBuff then
				NextTick = Game.Timer() + math.max(1, healingBuff.duration + 0.5)
				return
			end
			local potionSlot = Potter:GetDrinkablePotionSlot()
			if potionSlot then
				Control.CastSpell(Potter.ItemHotKey[potionSlot])
				NextTick = Game.Timer() + 1
				return
			end
			NextTick = Game.Timer() + 0.25
		end
		
		function Potter:IsPlayerAtFountain()
			local blueFountain = Vector(500, 180, 500)
			local redFountain = Vector(14250, 170, 14250)
			local distance = 800
			local pos = myHero.pos
			return pos:DistanceTo(blueFountain) <= distance or pos:DistanceTo(redFountain) <= 800
		end
		
		function Potter:ShouldPlayerDrinkPotion()
			return not myHero.dead and myHero.maxHealth ~= 0 and (myHero.health / myHero.maxHealth) < Menu.potter_health:Value() / 100
		end
		
		function Potter:GetHealingBuff()
			if myHero.dead then return false end
			for i = 0, myHero.buffCount do
				local buff = myHero:GetBuff(i)
				if buff.type == 14 and buff.duration > 0 and (buff.name == "Item2003" or buff.name == "ItemCrystalFlask" or buff.name == "ItemDarkCrystalFlask" or buff.name == "Item2010") then
					return buff
				end
			end
			return nil
		end
		
		function Potter:GetDrinkablePotionSlot()
			for _, j in pairs({ITEM_1, ITEM_2, ITEM_3, ITEM_4, ITEM_5, ITEM_6}) do
				-- Regular Pot
				if Menu.potter_regular:Value() and myHero:GetItemData(j).itemID == 2003 and myHero:GetSpellData(j).currentCd == 0 then return j end
				-- Refillable Pot
				if Menu.potter_refill:Value() and myHero:GetItemData(j).itemID == 2031 and myHero:GetSpellData(j).currentCd == 0 and myHero:GetItemData(j).ammo > 0 then return j end
				-- Corrupting Pot
				if Menu.potter_corrupt:Value() and myHero:GetItemData(j).itemID == 2033 and myHero:GetSpellData(j).currentCd == 0 and myHero:GetItemData(j).ammo > 0 then return j end
				-- Biscuit
				if Menu.potter_cookies:Value() and myHero:GetItemData(j).itemID == 2010 and myHero:GetSpellData(j).currentCd == 0 then return j end
			end
		end
	end
	
	Items = {}
	Items.NextTick = 0
	Items.ProfaneHydraID = 6698
	Items.ItemHotKey = {[ITEM_1] = HK_ITEM_1, [ITEM_2] = HK_ITEM_2,[ITEM_3] = HK_ITEM_3, [ITEM_4] = HK_ITEM_4, [ITEM_5] = HK_ITEM_5, [ITEM_6] = HK_ITEM_6,}
	function Items:GetMode()
        if _G.SDK then
            return _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO] and "Combo" or
                _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS] and "Harass" or
                _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR] and "Clear" or
                _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR] and "Clear" or
                _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LASTHIT] and "LastHit" or
                _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_FLEE] and "Flee" or
                nil
        elseif _G.PremiumOrbwalker then
            return _G.PremiumOrbwalker:GetMode()
        end
        return nil
    end
    function Items:IsCombo()
        if Items:GetMode() == "Combo" then
            return true
        end
        return false
    end
	function Items:GetItemSlot(unit, id)
		for i = ITEM_1, ITEM_7 do
			if unit:GetItemData(i).itemID == id then
				return i
			end
		end
		return 0
	end
	function Items:IsSpellReady(spell)
        return myHero:GetSpellData(spell).currentCd == 0 and myHero:GetSpellData(spell).level > 0 and
            myHero:GetSpellData(spell).mana <= myHero.mana and
            Game.CanUseSpell(spell) == 0
    end
	Items.Tick = function()
		if not Menu.items_profaneuse:Value() or Items.NextTick > Game.Timer() or myHero.dead or Game.IsChatOpen() then Items.NextTick = Game.Timer() + 0.025 return end
		if Menu.items_profaneusecombo:Value() and not Items:IsCombo() then Items.NextTick = Game.Timer() + 0.025 return end
		if not _G.SDK.ItemManager:IsReady(myHero, Items.ProfaneHydraID) then Items.NextTick = Game.Timer() + 0.05 return end
		if Menu.items_profaneblockq:Value() and Items:IsSpellReady(_Q) then Items.NextTick = Game.Timer() + 0.05 return end
		if Menu.items_profaneblockw:Value() and Items:IsSpellReady(_W) then Items.NextTick = Game.Timer() + 0.05 return end
		if Menu.items_profaneblocke:Value() and Items:IsSpellReady(_E) then Items.NextTick = Game.Timer() + 0.05 return end
		if Menu.items_profaneblockr:Value() and Items:IsSpellReady(_R) then Items.NextTick = Game.Timer() + 0.05 return end
		for i = 1, Game.HeroCount() do 
				local hero = Game.Hero(i)
				if (hero.team ~= myHero.team) and not Menu.items_profaneblacklist["profaneblacklist_" .. hero.charName]:Value() and hero.valid and hero.isTargetable and hero.alive and hero.visible and hero.networkID and
                myHero.pos:DistanceTo(hero.pos) <= 425 and hero.health > 0 then
					if Menu.items_profaneusebelow:Value() == false or ((hero.health / hero.maxHealth) < 0.5) then
						local itemSlot = GetItemSlot(myHero, Items.ProfaneHydraID)
						if  itemSlot > 0 then
							Control.CastSpell(Items.ItemHotKey[itemSlot])
							NextTick = Game.Timer() + 0.25
							return
						end
					end	
				end
		end
		
	end
	
	
	
	Callback.Add('Tick', ZhonyaTimers.Tick)
	Callback.Add('Draw', ZhonyaTimers.Draw)
	Callback.Add('Tick', Potter.Tick)
	Callback.Add('Tick', Items.Tick)
	
	print("SussyUtils loaded.")
end