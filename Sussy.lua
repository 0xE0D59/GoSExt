--[[
	Sussy AIO: champion script for Gaming On Steroids
	
	version 1.5
	
	Changelog:
	-- 1.5:	Added Pyke
	-- 1.4:	Added Amumu
	-- 1.3:	Added Tahm Kench
	-- 1.2:	Added Braum
	-- 1.1:	Added Shaco
	-- 1.0:	Initial release
]]--
local Version = "1.4"
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
							if hero and hero.team ~= myHero.team and hero.valid and hero.alive and myHero.pos:DistanceTo(hero.pos) >= Menu.r_dist:Value() then						
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
					elseif Spells:IsReady(_Q) and myHero.pos:DistanceTo(target.pos) <= 850 then
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
		
		-- Shaco START
		if myHero.charName == 'Shaco' then
			Menu:Init()
			Menu.q:Remove()
			Menu.w:Remove()
			Menu.r:Remove()
			Menu.d:Remove()
								
			Menu.e_ks_enabled = Menu.e:MenuElement({id = 'ekillsteal', name = 'Killsteal', value = true})
			Menu.e_ks_backstab = Menu.e:MenuElement({id = 'ekillstealbackstab', name = 'Include Backstab', value = true})
			Menu.e_ks_collector = Menu.e:MenuElement({id = 'ekillstealcollector', name = 'Include Collector', value = true})
			
			Callback.Add('Tick', function()
				if not Menu.e_ks_enabled:Value() or not Spells:IsReady(_E) or Orb:IsEvading() or Game.IsChatOpen() or myHero.dead then return end
				
				local basedmg = 45
				local lvldmg = 25 * myHero:GetSpellData(_E).level
				local statdmg = myHero.ap * 0.55 + myHero.bonusDamage * 0.7
				local edmg = basedmg + lvldmg + statdmg
				if edmg < 50 then
					return
				end
				local behindDmg = 15 + (35 / 17 * (myHero.levelData.lvl - 1)) + myHero.ap * 0.1
				for i = 1, Game.HeroCount() do 
					local hero = Game.Hero(i)
					if hero and hero.team ~= myHero.team and hero.valid and hero.alive and myHero.pos:DistanceTo(hero.pos) <= 625 then
						local health = hero.health + (2 * hero.hpRegen)
						local extraDamage = 0
						if Menu.e_ks_backstab:Value() and not _G.SDK.ObjectManager:IsFacing(hero, myHero) then
							extraDamage = extraDamage + behindDmg
						end
						local dmg = _G.SDK.Damage:CalculateDamage(myHero, hero, DAMAGE_TYPE_MAGICAL, edmg + extraDamage)
						local hpPercent = health / hero.maxHealth
						if hpPercent < 0.3 then	dmg = dmg * 1.5 end
						if health > 1 then 
							if health < dmg then
								Control.CastSpell(HK_E, hero)
								return
							end
							if ((health - dmg) / hero.maxHealth) <= 0.05 and Menu.e_ks_collector:Value() and _G.SDK.ItemManager:HasItem(unit, 6676) then
								Control.CastSpell(HK_E, hero)
							end
						end
					end
				end
				
			end)
		
			print('Sussy '..myHero.charName..' loaded.')
		end
		-- Shaco END
		
		-- Braum START
		if myHero.charName == 'Braum' then
			Menu:Init()
			Menu.w:Remove()
			Menu.e:Remove()
			Menu.r:Remove()
			Menu.d:Remove()

			Menu.q_combo = Menu.q:MenuElement({id = 'combo', name = 'Combo', value = true})
			Menu.q_harass = Menu.q:MenuElement({id = 'harass', name = 'Harass', value = true})
			Menu.q_killsteal = Menu.q:MenuElement({id = 'killsteal', name = 'Killsteal', value = true})
			Menu.q_range = Menu.q:MenuElement({id = "qrange", name = "Q Range", value = 950, min = 50, max = 1000, step = 50})
			Menu.q_hitchance = Menu.q:MenuElement({id = 'hitchance', name = 'Hitchance', value = 1, drop = {'normal', 'high', 'immobile'}})

			Callback.Add('Tick', function()
				if not Spells:IsReady(_Q) or Orb:IsEvading() or Game.IsChatOpen() or myHero.dead then return end

				local QRange = Menu.q_range:Value()
				local QGGPrediction = GGPrediction:SpellPrediction({Delay = 0.25, Radius = 70, Range = QRange, Speed = 1700, Type = GGPrediction.SPELLTYPE_LINE, Collision = true, MaxCollision = 0, CollisionTypes = {GGPrediction.COLLISION_MINION}})
				if Menu.q_killsteal:Value() then					
					for i = 1, Game.HeroCount() do 
						local hero = Game.Hero(i)
						local qdamage = getdmg("Q", hero, myHero)
						if hero and hero.team ~= myHero.team and hero.valid and hero.alive and hero.health <= qdamage and myHero.pos:DistanceTo(hero.pos) <= QRange then		
							QGGPrediction:GetPrediction(hero, myHero)
							if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
								Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
								return
							end
						end
					end
				end

				local mode = Orb:GetMode()
				if not((mode == "Combo" and Menu.q_combo:Value()) or (mode == "Harass" and Menu.q_harass:Value())) then
					return
				end				
				local target = Orb:GetTarget(QRange)
				if target and target.valid and target.alive then
					QGGPrediction:GetPrediction(target, myHero)
					if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
						Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
						return
					end
				end
			end)

			print('Sussy '..myHero.charName..' loaded.')
		end
		-- Braum END		
		
		-- Tahm Kench START
		if myHero.charName == 'TahmKench' then
			Menu:Init()
			Menu.w:Remove()
			Menu.e:Remove()

			Menu.q_combo = Menu.q:MenuElement({id = 'combo', name = 'Combo', value = true})
			Menu.q_harass = Menu.q:MenuElement({id = 'harass', name = 'Harass', value = true})
			Menu.q_hitchance = Menu.q:MenuElement({id = 'hitchance', name = 'Hitchance', value = 1, drop = {'normal', 'high', 'immobile'}})
				
			Menu.r_combo = Menu.r:MenuElement({id = 'combo', name = 'Combo', value = true})
				
			Menu.q_range = Menu.d:MenuElement({id = 'qrange', name = 'Q Range', value = true})
			Menu.r_range = Menu.d:MenuElement({id = 'rrange', name = 'R Range', value = false})
			
			local DEVOUR_BUFF_NAME = 'tahmkenchpdevourable'
			local Q_RANGE_COLOR = Draw.Color(190, 50, 205, 50)
			local R_RANGE_COLOR = Draw.Color(190, 0, 0, 205)

			Callback.Add('Tick', function()
				if Orb:IsEvading() or Game.IsChatOpen() or myHero.dead then return end
				local mode = Orb:GetMode()

				if Spells:IsReady(_R) and Menu.r_combo:Value() and mode == "Combo" then					
					for i = 1, Game.HeroCount() do 
						local hero = Game.Hero(i)
						if hero and hero.team ~= myHero.team and hero.valid and hero.alive and myHero.pos:DistanceTo(hero.pos) <= 250 then
							local rbuff = _G.SDK.BuffManager:GetBuff(hero, DEVOUR_BUFF_NAME)
							if rbuff and rbuff.count >= 1 then
								Control.CastSpell(HK_R, hero)
								return
							end
						end
					end
				end

				local target = Orb:GetTarget(900)
				local QGGPrediction = GGPrediction:SpellPrediction({Delay = 0.25, Radius = 70, Range = 900, Speed = 2800, Type = GGPrediction.SPELLTYPE_LINE, Collision = true, MaxCollision = 0, CollisionTypes = {GGPrediction.COLLISION_MINION}})
				if Spells:IsReady(_Q) and target and ((mode == "Combo" and Menu.q_combo:Value()) or (mode == "Harass" and Menu.q_harass:Value())) then
					QGGPrediction:GetPrediction(target, myHero)
					if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
						Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
						return
					end
				end
			end)
			
			Callback.Add('Draw', function()
				if Menu.q_range:Value() and Spells:IsReady(_Q) then
					Draw.Circle(myHero.pos, 900, 1, Q_RANGE_COLOR)
				end
				if Menu.r_range:Value() and Spells:IsReady(_R) then
					Draw.Circle(myHero.pos, 275, 1, R_RANGE_COLOR)
				end
			end)

			print('Sussy '..myHero.charName..' loaded.')
		end
		-- Tahm Kench END
		
		-- Pyke START
		if myHero.charName == 'Pyke' then
			Menu:Init()
			Menu.w:Remove()
			Menu.e:Remove()

			Menu.q_auto = Menu.q:MenuElement({id = 'qauto', name = 'Auto-pull', value = true})
			Menu.q_hitchance = Menu.q:MenuElement({id = 'qhitchance', name = 'Hitchance', value = 1, drop = {'Normal', 'High', 'Immobile'}})
				
			Menu.r_ks = Menu.r:MenuElement({id = 'rks', name = 'Killsteal', value = true})
			Menu.r_hitchance = Menu.r:MenuElement({id = 'rhitchance', name = 'Hitchance', value = 1, drop = {'Normal', 'High', 'Immobile'}})
			
			Menu.q_range = Menu.d:MenuElement({id = 'qrange', name = 'Q Range', value = true})
			Menu.r_range = Menu.d:MenuElement({id = 'rrange', name = 'R Range', value = false})
			
			local QStartTime = -1

			Callback.Add('Tick', function()
				if Orb:IsEvading() or Game.IsChatOpen() or myHero.dead then return end
				if not Spells:IsReady(_Q) then QStartTime = -1 end
				if Spells:IsReady(_R) and Menu.r_ks:Value() then
					
					local LvL = myHero.levelData.lvl
					local Dmg1 = ({250, 250, 250, 250, 250, 250, 290, 330, 370, 400, 430, 450, 470, 490, 510, 530, 540, 550})[LvL]
					local Dmg2 = 0.8 * myHero.bonusDamage + 1.5 * myHero.armorPen
					local RDmg = 0

					if Dmg1 ~= nill then
						RDmg = Dmg1 + Dmg2
					else
						RDmg = Dmg2
					end
					
					for i = 1, Game.HeroCount() do 
						local hero = Game.Hero(i)
						if hero and hero.team ~= myHero.team and hero.valid and hero.alive and myHero.pos:DistanceTo(hero.pos) <= 900 and hero.health <= RDmg then
							local RPrediction = GGPrediction:SpellPrediction({Delay = 0.5, Radius = 250, Range = 750, Speed = 1000, Collision = false, Type = GGPrediction.SPELLTYPE_CIRCLE})
							RPrediction:GetPrediction(hero, myHero)
							if RPrediction:CanHit(Menu.r_hitchance:Value() + 1) then	
								Control.CastSpell(HK_R, RPrediction.CastPosition)
								return
							end	
						end
					end
				end
				
				if Spells:IsReady(_Q) and Menu.q_auto:Value() then	
					if myHero.activeSpell.valid and myHero.activeSpell.name == "PykeQ" then
					
						if QStartTime == -1 then QStartTime = Game.Timer() end
						local qChargeDuration = Game.Timer() - QStartTime
						if qChargeDuration > 3 then return end						
						local range = math.max(math.min(qChargeDuration, 1.25) * 880, 400)
						local selected = _G.SDK.TargetSelector.Selected
						
						if range > 400 then
							if selected and selected.team ~= myHero.team and selected.valid and selected.alive and selected.visible and myHero.pos:DistanceTo(selected.pos) <= 3000 then
								local QPrediction = GGPrediction:SpellPrediction({Delay = 0.25, Radius = 55, Range = range, Speed = 1700, Type = GGPrediction.SPELLTYPE_LINE, Collision = true, MaxCollision = 0, CollisionTypes = {GGPrediction.COLLISION_MINION}})
								QPrediction:GetPrediction(selected, myHero)
								if QPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
									Control.CastSpell(HK_Q, QPrediction.CastPosition)
									return
								end
							else
								for i = 1, Game.HeroCount() do
									local hero = Game.Hero(i)
									if hero and hero.team ~= myHero.team and hero.valid and hero.alive and hero.visible and myHero.pos:DistanceTo(hero.pos) <= (range+100) then 
										local QPrediction = GGPrediction:SpellPrediction({Delay = 0.25, Radius = 55, Range = range, Speed = 1700, Type = GGPrediction.SPELLTYPE_LINE, Collision = true, MaxCollision = 0, CollisionTypes = {GGPrediction.COLLISION_MINION}})
										QPrediction:GetPrediction(hero, myHero)
										if QPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
											Control.CastSpell(HK_Q, QPrediction.CastPosition)
											return
										end	
									end
								end
							end
						end
					end
				end	
			end)
			
			Callback.Add('Draw', function()
				if Menu.q_range:Value() and Spells:IsReady(_Q) then					
					Draw.Circle(myHero.pos, 1100, Draw.Color(255, 255, 255, 100))
				end				
				if Menu.r_range:Value() and Spells:IsReady(_R) then					
					Draw.Circle(myHero.pos, 750, Draw.Color(255, 0, 0, 100))
				end
			end)

			print('Sussy '..myHero.charName..' loaded.')
		end
		-- Pyke END
		
		-- Amumu START
		if myHero.charName == 'Amumu' then
			Menu:Init()

			Menu.q_combo = Menu.q:MenuElement({id = 'combo', name = 'Combo', value = true})			
			Menu.q_harass = Menu.q:MenuElement({id = 'harass', name = 'Harass', value = false})	
			Menu.q_killsteal = Menu.q:MenuElement({id = 'combo', name = 'Killsteal', value = true})				
			Menu.q_range = Menu.q:MenuElement({id = "qrange", name = "Q Range", value = 1000, min = 25, max = 1100, step = 25})
			Menu.q_hitchance = Menu.q:MenuElement({id = 'hitchance', name = 'Hitchance', value = 1, drop = {'Normal', 'High', 'Immobile'}})
			
			Menu.w:Remove()			
			--[[
			Menu.w_combo = Menu.w:MenuElement({id = 'combo', name = 'Combo', value = true})			
			Menu.w_harass = Menu.w:MenuElement({id = 'harass', name = 'Harass', value = false})			
			Menu.w_waveclear = Menu.w:MenuElement({id = 'clear', name = 'Clear', value = false})
			Menu.w_jungle = Menu.w:MenuElement({id = 'clear', name = 'Jungle', value = false})
			]]--

			Menu.e_combo = Menu.e:MenuElement({id = 'combo', name = 'Combo', value = true})			
			Menu.e_harass = Menu.e:MenuElement({id = 'harass', name = 'Harass', value = false})			
			Menu.e_waveclear = Menu.e:MenuElement({id = 'clear', name = 'Clear', value = false})
			Menu.e_jungle = Menu.e:MenuElement({id = 'clear', name = 'Jungle', value = false})	

			Menu.r_combo = Menu.r:MenuElement({id = 'combo', name = 'Combo', value = true})	
			Menu.r_combo_targets = Menu.r:MenuElement({id = "combotargets", name = "Combo Min Targets", value = 2, min = 1, max = 5, step = 1})
			Menu.r_auto = Menu.r:MenuElement({id = 'auto', name = 'Auto', value = true})	
			Menu.r_auto_targets = Menu.r:MenuElement({id = "Auto min targets", name = "Auto Min Targets", value = 3, min = 1, max = 5, step = 1})		
				
			Menu.q_rangedraw = Menu.d:MenuElement({id = 'qrangedraw', name = 'Q Range', value = true})
			Menu.r_range = Menu.d:MenuElement({id = 'rrange', name = 'R Range', value = false})
			
			local QGGPrediction = GGPrediction:SpellPrediction({Delay = 0.25, Radius = 80, Range = 1100, Speed = 2000, Type = GGPrediction.SPELLTYPE_LINE, Collision = true, MaxCollision = 0, CollisionTypes = {GGPrediction.COLLISION_MINION}})

			Callback.Add('Tick', function()
				if Orb:IsEvading() or Game.IsChatOpen() or myHero.dead or myHero.isChanneling then return end
				local mode = Orb:GetMode()

				if Spells:IsReady(_R) then
					if ((mode == "Combo" and Menu.r_combo:Value()) or Menu.r_auto:Value()) then
						local count = 0
						for i = 1, Game.HeroCount() do 
							local hero = Game.Hero(i)
							if hero and hero.team ~= myHero.team and hero.valid and hero.alive and myHero.pos:DistanceTo(hero.pos) <= 550 then		
								count = count + 1
							end
						end
						local minTargets = Menu.r_auto_targets:Value()
						if mode == "Combo" and Menu.r_combo:Value() then minTargets = Menu.r_combo_targets:Value() end
						if count >= minTargets then
							Control.CastSpell(HK_R)
							return
						end
					end
				end
				
				if Spells:IsReady(_Q) then
					if Menu.q_killsteal:Value() then
						local count = 0
						for i = 1, Game.HeroCount() do 
							local hero = Game.Hero(i)
							if hero and hero.team ~= myHero.team and hero.valid and hero.alive and myHero.pos:DistanceTo(hero.pos) <= 1050 then		
								local qdamage = getdmg("Q", hero, myHero)
								if qdamage > hero.health + (2 * hero.hpRegen) then
									QGGPrediction.Range = 1050
									QGGPrediction:GetPrediction(hero, myHero)
									if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
										Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
										return
									end
								end
							end
						end
					end
					if (mode == "Combo" and Menu.q_combo:Value()) or (mode == "Harass" and Menu.q_harass:Value()) then
						QGGPrediction.Range = Menu.q_range:Value()					
						local target = Orb:GetTarget(QGGPrediction.Range)
						if target then
							QGGPrediction:GetPrediction(target, myHero)
							if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
								Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
								return
							end
						end
					end
				end
				
				if Spells:IsReady(_E) then
					if (mode == "Combo" and Menu.e_combo:Value()) or (mode == "Harass" and Menu.e_harass:Value()) then
						local target = Orb:GetTarget(300)
						if target then
							Control.CastSpell(HK_E)
							return
						end
					end
					
					if mode == "Clear" and (Menu.e_jungle:Value() or Menu.e_waveclear:Value()) then
						for i = 1, Game.MinionCount() do
							local minion = Game.Minion(i)
							if ((Menu.e_jungle:Value() and minion.team == 300) or ((Menu.e_waveclear:Value() and minion.team == 300 - myHero.team))) and minion.valid and minion.alive and minion.pos:DistanceTo(myHero.pos) <= 325 then
								Control.CastSpell(HK_E)
								return
							end
						end
					end
				end
			end)
			
			Callback.Add('Draw', function()
				if Menu.q_rangedraw:Value() and Spells:IsReady(_Q) then					
					Draw.Circle(myHero.pos, Menu.q_range:Value(), Draw.Color(255, 255, 255, 100))
				end				
				if Menu.r_range:Value() and Spells:IsReady(_R) then					
					Draw.Circle(myHero.pos, 550, Draw.Color(255, 0, 0, 100))
				end
			end)

			print('Sussy '..myHero.charName..' loaded.')
		end
		-- Amumu END
	end
end
