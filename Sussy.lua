--[[
	Sussy AIO: champion script for Gaming On Steroids
	
	version 1.0
	
	Changelog:
	-- 1.0:	Initial release
]]--
local Version = "1.0"
Callback.Add('Load', function()
    if not FileExist(COMMON_PATH .. "GGPrediction.lua") then
		print('GGPrediction not found! Please download it before using this script.')
		return
	end
    if not FileExist(COMMON_PATH .. "DamageLib.lua") then
		print('DamageLib not found! Please download it before using this script.')
		return
	end
	require('GGPrediction')
	require("DamageLib")
	Champion:Init();
end)

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
	File:WriteSpriteToFile('MenuElement/Sussy.png', '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')	
end
-- Icons end

Menu = {}
do
	function Menu:Init()
		Menu.root = MenuElement({name = "Sussy " .. myHero.charName, id = 'Sussy ' .. myHero.charName, type = _G.MENU, leftIcon = "/Sussy.png"})
		Menu.q = Menu.root:MenuElement({name = 'Q', id = 'q', type = _G.MENU})
		Menu.w = Menu.root:MenuElement({name = 'W', id = 'w', type = _G.MENU})
		Menu.e = Menu.root:MenuElement({name = 'E', id = 'e', type = _G.MENU})
		Menu.r = Menu.root:MenuElement({name = 'R', id = 'r', type = _G.MENU})
		Menu.d = Menu.root:MenuElement({name = 'Drawings', id = 'd', type = _G.MENU})
		Menu.root:MenuElement({name = '', type = _G.SPACE, id = 'VersionSpacer'})
		Menu.root:MenuElement({name = 'Version  ' .. Version, type = _G.SPACE, id = 'VersionNumber'})
	end
end

Spells = {}
do
	function Spells:IsReady(spell)
		return myHero:GetSpellData(spell).currentCd == 0 and myHero:GetSpellData(spell).level > 0 and myHero:GetSpellData(spell).mana <= myHero.mana and Game.CanUseSpell(spell) == 0
	end
end

Orb = {}
do
	function Orb:GetMode()   	
    if _G.SDK then
        return 
		_G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO] and "Combo"
        or 
		_G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS] and "Harass"
        or 
		_G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR] and "Clear"
        or 
		_G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR] and "Clear"
        or 
		_G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LASTHIT] and "LastHit"
        or 
		_G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_FLEE] and "Flee"
		or nil
    
	elseif _G.PremiumOrbwalker then
		return _G.PremiumOrbwalker:GetMode()
	end
	return nil	
	end

	function Orb:GetTarget(range) 
		if _G.SDK then
			if myHero.ap > myHero.totalDamage then
				return _G.SDK.TargetSelector:GetTarget(range, _G.SDK.DAMAGE_TYPE_MAGICAL);
			else
				return _G.SDK.TargetSelector:GetTarget(range, _G.SDK.DAMAGE_TYPE_PHYSICAL);
			end
		elseif _G.PremiumOrbwalker then
			return _G.PremiumOrbwalker:GetTarget(range)
		end	
	end
	
	function Orb:IsEvading()
        if _G.JustEvade and _G.JustEvade:Evading() then
            return true
        end
        if _G.ExtLibEvade and _G.ExtLibEvade.Evading then
            return true
        end
        return false
    end
	
	function Orb:OnPostAttack(fn)
		if _G.SDK then
			return _G.SDK.Orbwalker:OnPostAttack(fn)    
		elseif _G.PremiumOrbwalker then
			return _G.PremiumOrbwalker:OnPostAttack(fn)
		end
	end
end

Champion = {}
do
	function Champion:Init()
		-- Vi START
		if myHero.charName == 'Vi' then
			Menu:Init()
			Menu.w:Remove()
			Menu.d:Remove()
			Menu.q_combo = Menu.q:MenuElement({id = 'combo', name = 'Combo', value = true})
			Menu.q_harass = Menu.q:MenuElement({id = 'harass', name = 'Harass', value = false})
			Menu.q_charge = Menu.q:MenuElement({id = 'qcharge', name = 'Min charge time', value = 0, min = 0, max = 1.25, step = 0.05})
			Menu.q_pred = Menu.q:MenuElement({id = "qpred", name = "Hitchance", value = 1, drop = {"Normal", "High", "Immobile"}})	
			Menu.q_release = Menu.q:MenuElement({id = 'release', name = 'Release near end', value = true})
			
			Menu.e_combo = Menu.e:MenuElement({id = 'combo', name = 'Combo', value = true})
			Menu.e_harass = Menu.e:MenuElement({id = 'harass', name = 'Harass', value = false})
			
			Menu.r_combo = Menu.r:MenuElement({id = 'combo', name = 'Combo', value = true})
			Menu.r_ks = Menu.r:MenuElement({id = 'killsteal', name = 'Killsteal', value = true})
			Menu.r_dist = Menu.r:MenuElement({id = 'dist', name = 'Min distance', value = 400, min = 0, max = 800, step = 25})
			
			local QStartTime = 0
			
			Callback.Add('Tick', function()
				if Orb:IsEvading() or Game.IsChatOpen() or myHero.dead then return end
				local mode = Orb:GetMode()
				
				if Spells:IsReady(_R) then
					if Menu.r_ks:Value() then
						for i = 1, Game.HeroCount() do 
							local hero = Game.Hero(i)
							if hero and hero.team ~= TEAM_ALLY and hero.valid and hero.alive and myHero.pos:DistanceTo(hero.pos) >= Menu.r_dist:Value() then						
								local rdamage = getdmg("R", hero, myHero)
								local hp = hero.health + (2 * hero.hpRegen)
								if hp <= rdamage then
									Control.CastSpell(HK_R, hero)
									return
								end	
							end
						end	
					end
					if mode == "Combo" and Menu.r_combo:Value() and not myHero.activeSpell.valid then
						local target = Orb:GetTarget(800)
						if target and myHero.pos:DistanceTo(target.pos) >= Menu.r_dist:Value() then
							Control.CastSpell(HK_R, target)
							return
						end
					end
				end
				
				
				if (mode == "Combo" and Menu.q_combo:Value()) or (mode == "Harass" and Menu.q_harass:Value()) then
					local target = Orb:GetTarget(1500)
					if target == nil then return end
					if not Spells:IsReady(_Q) and QStartTime > 0 then
						QStartTime = 0
						if Control.IsKeyDown(HK_Q) then
							Control.KeyUp(HK_Q)
						end
						return
					end
					if myHero.activeSpell.valid and myHero.activeSpell.name == "ViQ" then
						if QStartTime == 0 then QStartTime = Game.Timer() end
						local QChargeTime = Game.Timer() - QStartTime
						if QChargeTime >= (Menu.q_charge:Value() - 0.2) then
							local QRange = math.max(250 + (math.min(QChargeTime, 1.25) * 46.5 / 0.125), 250)
							local QGGPrediction = GGPrediction:SpellPrediction({Delay = 0, Radius = 90, Range = QRange, Speed = 1500, Collision = false, Type = GGPrediction.SPELLTYPE_LINE})
							QGGPrediction:GetPrediction(target, myHero)
							if QGGPrediction:CanHit(Menu.q_pred:Value() + 1) then
								Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
								return
							end
							if QChargeTime > 4.35 and Menu.q_release:Value() then
								Control.CastSpell(HK_Q, target.pos)
							end
						end
					elseif Spells:IsReady(_Q) and myHero.pos:DistanceTo(target.pos) <= 1500 then
						Control.KeyDown(HK_Q)
						return
					end
				end
			end)
			Orb:OnPostAttack(function() 
				local mode = Orb:GetMode()
				if Spells:IsReady(_E) and ((mode == "Combo" and Menu.e_combo:Value()) or (mode == "Harass" and Menu.e_harass:Value())) then
					local target = Orb:GetTarget(250)
					if target then
						Control.CastSpell(HK_E)
					end
				end
			end)
		
		print('Sussy '..myHero.charName..' loaded.')
		end
		-- Vi END
	end
end
