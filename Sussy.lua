--[[
	Sussy AIO: champion script for Gaming On Steroids
	
	version 1.18
	
	Changelog:
	-- 1.19: Added Blitzcrank
	-- 1.18: Added Kennen
	-- 1.17: Added Rumble
	-- 1.16: Added Darius, Garen R KS
	-- 1.15: Added Zac
	-- 1.14: Added Jax
	-- 1.13: Added Rammus
	-- 1.12: Added Teemo
	-- 1.11: Added Garen
	-- 1.10: Added Trundle
	-- 1.9: Added Dr Mundo
	-- 1.8: Added Nautilus
	-- 1.7:	Added Zilean
	-- 1.6:	Added Renata
	-- 1.5:	Added Pyke
	-- 1.4:	Added Amumu
	-- 1.3:	Added Tahm Kench
	-- 1.2:	Added Braum
	-- 1.1:	Added Shaco
	-- 1.0:	Initial release
]] --
local Version = "1.19"
local LoadTime = 0
require("GGPrediction")
require("DamageLib")
require("MapPositionGOS")
require("2DGeometry")
Callback.Add(
    "Load",
    function()
        if not FileExist(COMMON_PATH .. "GGPrediction.lua") then
            print("GGPrediction not found! Please download it before using this script.")
            return
        end
        if not FileExist(COMMON_PATH .. "DamageLib.lua") then
            print("DamageLib not found! Please download it before using this script.")
            return
        end
        if not FileExist(COMMON_PATH .. "MapPositionGOS.lua") then
            print("MapPositionGOS not found! Please download it before using this script.")
            return
        end
        if not FileExist(COMMON_PATH .. "2DGeometry.lua") then
            print("MapPositionGOS not found! Please download it before using this script.")
            return
        end
        LoadTime = Game.Timer()
        Champion:Init()
    end
)

File = {}
do
    function File:WriteSpriteToFile(path, str)
        path = SPRITE_PATH .. path
        if FileExist(path) then
            return
        end
        local output = io.open(path, "wb")
        output:write(File:Base64Decode(str))
        output:close()
    end

    function File:Base64Decode(data)
        local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        data = string.gsub(data, "[^" .. b .. "=]", "")
        return (data:gsub(
            ".",
            function(x)
                if (x == "=") then
                    return ""
                end
                local r, f = "", (b:find(x) - 1)
                for i = 6, 1, -1 do
                    r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
                end
                return r
            end
        ):gsub(
            "%d%d%d?%d?%d?%d?%d?%d?",
            function(x)
                if (#x ~= 8) then
                    return ""
                end
                local c = 0
                for i = 1, 8 do
                    c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
                end
                return string.char(c)
            end
        ))
    end
end

-- Icons start
do
    File:WriteSpriteToFile(
        "MenuElement/Sussy.png",
        "iVBORw0KGgoAAAANSUhEUgAAADgAAAA3CAMAAABuDnn5AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAB/lBMVEUAAAAdIRwyLhMlJBQpJxUsKhU5Lwo0LQ0xLxo6NBNmWBa9ohXKrBTCpRWbhRpUSRQ+OhsVGxxLQhWVfRjUuhPt0hH84w353hD12xDlzxyklTJuYSIzNylzYxs0NSMbIyMaJCdTTCJFOg1dUhuFcyJpXCJLRBsfIBZRRxiBbRvMshSskxZEPBR3aBuzkxUWGRVUSxuiihXdwhKQdhhuYBuSdxXy1hCNehteURMkJh1rXBu3oBm8mxSFcRplVQ+LcxXSsxP73A1jVRnlyhILDg4nKR5ZThqqkxhxXhTbvRP22g+zmhYiHgyFcRecghbjxRKCbRbFqhQ7OiI/ORdrWxXJnxRBPRzqzRGqlRfksQ6nihdBPiOrjBXlshKbfhYsLBtjVBSLdRpLRyMdHRT61A31xAz0uwz1yww7Nhru0Q/4zQ0bGg3bqxKhhBjrtQ6IbxZ7byqupDruuQ4eKSwZHhsoNjciLjBEQiH4vQzEnBQVHiFNZGl5m6KLr7ZtjZQzPTnTpRI3TFCBoqml0dqfytNPa3FZUygSFRRZdHmbw8xzkpk7UFNHSTAQFxktREg2R0lMRBofLjB+ahb01A7VqhK7lhRaTRR5ZhrMohOxjhR0YxYzMh25lRijhRXerQ/hrxEtKAyUfBZYTyB5ZhUOEQ4NEhMJDhI5MQ4hKir///8aCBLZAAAAAXRSTlMAQObYZgAAAAFiS0dEqScPBgQAAAAJcEhZcwAAAMgAAADIAGP6560AAAAHdElNRQflBxARBTbHTQOFAAAAAW9yTlQBz6J3mgAAABBjYU52AAAAOAAAADgAAAAAAAAAAJuleyQAAANuSURBVEjHlZaJVxJRFMbH1ApcGWCGLHLLNVlEBXHJAEPNHQLDALdhKEMwXEjLIstos8g0ycgytfozGx4jDjgzDN/hHM65M7/53nLfuxeC2JV1LjsnJzv3/AUoI13k8fPygQoKi4q5UoIsWCgSI3Ghkksll4uYX74ivVpaVl5Rea2quqa2rl6CUCQRX5c2MHg0yOSVCmVjvUjV1NxSr0ZShKo0rTSYQtvW3tF5o+umWqfS6AsNKHJWajncncrdMvaoRL3l7YRPX1ttnhqh1e1+ZQo3IBWhhsHeoWEUMdSNjEoQBqH9piTOrFEhSN4dy5AwX6UZHEaYpdZYKVx54RgRuyu1WcalldI+hE0q/ilXLQT71X7P7nA4JxpRVhDNn0yAsjEQEk9ND8mbRsboAR0Q8VF15wzJVRSQzwwlMn2diBbDMBeOEz83hiCj90lw6kEiO9QiA63bLMGQmtWJq0gwzaQQFDvFCLncPblx0M4O6tx4igq0gHs4zgrqXKkc7jECcGZOrM7ED8e9PpCxpdPz848kGXC4vyWL4BYWy5aWAyKGpH6M02mFyIHVpSdP1549z+c6P6AgH1p9sf7y1frG63h+6rhxeBCGQm/err17/6EdLCzmQjlxMXDz48anZYXPhaGxfU4G3TgjGCbm+DkEQVtefPYL8Z6LOtZZRg7fhsmkC++Q2URxxJg54BjPAX0wFcRcbODXxFW16wWgLv3CgKE2J85yQwRE3Fz8cDyScIQmtmwghDHmGVVDOaf3TqDFGycxLI0dkas+6g1ZbMG5aju5Eow4uILfFpNAk50j591LBiG+jRtoMaXUD7PTy4Vz1H1PrVhhTusTgc+UyAEhB0uHj6YbMLNY+smPRnNpqrJ1jtHSsfPDE/vf36NtA2B6S//P6IgenCCH8BctuHjgpztF47KA0hk7Bl67lb7x6DZ6zrh1HLRqQ78tsU32R80hhk6nZieJ2o84D+HQEQTpweRXYCYOUkgTGesPdsjbwtnHR7E4AIOTIebmKrB/wsmNPJ7ipK0hQMf2ruKYGTSdjNXWGqI0Q8btFWm59g9L7/dXflIfwtTwjNWUVbbA2jXOkRviU1Cjm+nbzV4PeehCmTW3UCAavx6UGXKQtssby2g7L1MQ2tv3RH2HcGnGoHJ30roqyJyDBP8EgrQv/Qdimk0sL5VTgQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMS0wNy0xNlQxNzowNTo1NCswMDowMD9HLcMAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjEtMDctMTZUMTc6MDU6NTMrMDA6MDCLvavxAAAAAElFTkSuQmCC"
    )
end
-- Icons end

Menu = {}
do
    function Menu:Init()
        Menu.root =
            MenuElement(
            {
                name = "Sussy " .. myHero.charName,
                id = "Sussy " .. myHero.charName,
                type = _G.MENU,
                leftIcon = "/Sussy.png"
            }
        )
        Menu.q = Menu.root:MenuElement({name = "Q", id = "q", type = _G.MENU})
        Menu.w = Menu.root:MenuElement({name = "W", id = "w", type = _G.MENU})
        Menu.e = Menu.root:MenuElement({name = "E", id = "e", type = _G.MENU})
        Menu.r = Menu.root:MenuElement({name = "R", id = "r", type = _G.MENU})
        Menu.d = Menu.root:MenuElement({name = "Drawings", id = "d", type = _G.MENU})
        Menu.root:MenuElement({name = "", type = _G.SPACE, id = "VersionSpacer"})
        Menu.root:MenuElement({name = "Version  " .. Version, type = _G.SPACE, id = "VersionNumber"})
    end
end

Spells = {}
do
    Spells.InterruptableSpells = {
        ["CaitlynAceintheHole"] = true,
        ["Crowstorm"] = true,
        ["DrainChannel"] = true,
        ["GalioIdolOfDurand"] = true,
        ["ReapTheWhirlwind"] = true,
        ["KarthusFallenOne"] = true,
        ["KatarinaR"] = true,
        ["LucianR"] = true,
        ["AlZaharNetherGrasp"] = true,
        ["Meditate"] = true,
        ["MissFortuneBulletTime"] = true,
        ["AbsoluteZero"] = true,
        ["PantheonRJump"] = true,
        ["PantheonRFall"] = true,
        ["ShenStandUnited"] = true,
        ["Destiny"] = true,
        ["UrgotSwap2"] = true,
        ["VelkozR"] = true,
        ["InfiniteDuress"] = true,
        ["XerathLocusOfPower2"] = true
    }

    function Spells:IsReady(spell)
        return myHero:GetSpellData(spell).currentCd == 0 and myHero:GetSpellData(spell).level > 0 and
            myHero:GetSpellData(spell).mana <= myHero.mana and
            Game.CanUseSpell(spell) == 0
    end

    function Spells:IsNotReady(spell)
        if not Spells:IsReady(spell) then
            return true
        end
        return false
    end

    function Spells:CreateLinePoly(pos)
        local startPos = myHero.pos
        local endPos = pos
        local width = 10
        local c1 = startPos + Vector(Vector(endPos) - startPos):Perpendicular():Normalized() * width
        local c2 = startPos + Vector(Vector(endPos) - startPos):Perpendicular2():Normalized() * width
        local c3 = endPos + Vector(Vector(startPos) - endPos):Perpendicular():Normalized() * width
        local c4 = endPos + Vector(Vector(startPos) - endPos):Perpendicular2():Normalized() * width
        local poly = Polygon(c1, c2, c3, c4)
        return poly
    end

    function Spells:LineCollidesTerrain(linePoly)
        for i, lineSegment in ipairs(linePoly:__getLineSegments()) do
            if MapPosition:intersectsWall(lineSegment) then
                return true
            end
        end
        return false
    end
end

Orb = {}
do
    function Orb:GetMode()
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

    function Orb:IsCombo()
        if Orb:GetMode() == "Combo" then
            return true
        end
        return false
    end

    function Orb:IsHarass()
        if Orb:GetMode() == "Harass" then
            return true
        end
        return false
    end

    function Orb:IsClear()
        if Orb:GetMode() == "Clear" then
            return true
        end
        return false
    end

    function Orb:IsLastHit()
        if Orb:GetMode() == "LastHit" then
            return true
        end
        return false
    end

    function Orb:IsFlee()
        if Orb:GetMode() == "Flee" then
            return true
        end
        return false
    end

    function Orb:GetTarget(range)
        if _G.SDK then
            if myHero.ap > myHero.totalDamage then
                return _G.SDK.TargetSelector:GetTarget(range, _G.SDK.DAMAGE_TYPE_MAGICAL)
            else
                return _G.SDK.TargetSelector:GetTarget(range, _G.SDK.DAMAGE_TYPE_PHYSICAL)
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

    function Orb:IsImmortal(target, isAttack)
        return _G.SDK.ObjectManager:IsHeroImmortal(target, isAttack)
    end

    function Orb:OnPostAttack(fn)
        if _G.SDK then
            return _G.SDK.Orbwalker:OnPostAttack(fn)
        elseif _G.PremiumOrbwalker then
            return _G.PremiumOrbwalker:OnPostAttack(fn)
        end
    end

    function Orb:OnPreAttack(fn)
        if _G.SDK then
            return _G.SDK.Orbwalker:OnPreAttack(fn)
        elseif _G.PremiumOrbwalker then
            return _G.PremiumOrbwalker:OnPreAttack(fn)
        end
    end
end

Champion = {}
do
    function Champion:IsValid(unit)
        if
            unit and unit.valid and unit.isTargetable and unit.alive and unit.visible and unit.networkID and
                unit.health > 0
         then
            return true
        end
        return false
    end

    function Champion:IsValidEnemy(unit)
        if unit and unit.team ~= myHero.team and Champion:IsValid(unit) then
            return true
        end
    end

    function Champion:IsValidAlly(unit)
        if unit and unit.team == myHero.team and Champion:IsValid(unit) then
            return true
        end
    end

    function Champion:IsRecalling(unit)
        if unit and unit.valid then
            local buffCount = unit.buffCount
            for i = 1, buffCount do
                local buff = unit:GetBuff(i)
                if buff.count > 0 and buff.name == "recall" and Game.Timer() < buff.expireTime then
                    return true
                end
            end
        end
        return false
    end

    function Champion:HealthPercent(unit)
        if unit then
            return 100 * unit.health / unit.maxHealth
        end
        return 0
    end

    function Champion:ManaPercent(unit)
        if unit then
            return 100 * unit.mana / unit.maxMana
        end
        return 0
    end

    function Champion:IsPlayerAtFountain()
        local blueFountain = Vector(500, 180, 500)
        local redFountain = Vector(14250, 170, 14250)
        local distance = 800
        local pos = myHero.pos
        return pos:DistanceTo(blueFountain) <= distance or pos:DistanceTo(redFountain) <= 800
    end

    function Champion:MyHeroNotReady()
        return myHero.dead or Game.IsChatOpen() or Orb:IsEvading() or myHero.isChanneling or
            Champion:IsRecalling(myHero) or
            Champion:IsPlayerAtFountain(myHero)
    end

    function Champion:GetEnemies()
        local enemies = {}
        for i = 1, Game.HeroCount() do
            local hero = Game.Hero(i)
            if hero and hero.team ~= myHero.team then
                table.insert(enemies, hero)
            end
        end
        return enemies
    end

    function Champion:GetValidEnemies(pos, range)
        local enemies = {}
        for i = 1, Game.HeroCount() do
            local hero = Game.Hero(i)
            if hero and Champion:IsValidEnemy(hero) and pos:DistanceTo(hero.pos) <= range then
                table.insert(enemies, hero)
            end
        end
        return enemies
    end

    function Champion:GetAllies()
        local enemies = {}
        for i = 1, Game.HeroCount() do
            local hero = Game.Hero(i)
            if hero and hero.team == myHero.team then
                table.insert(enemies, hero)
            end
        end
        return enemies
    end

    function Champion:GetValidAllies(pos, range)
        local enemies = {}
        for i = 1, Game.HeroCount() do
            local hero = Game.Hero(i)
            if hero and Champion:IsValidAlly(hero) and pos:DistanceTo(hero.pos) <= range then
                table.insert(enemies, hero)
            end
        end
        return enemies
    end

    function Champion:GetValidEnemiesCount(pos, range)
        local count = 0
        for i = 1, Game.HeroCount() do
            local hero = Game.Hero(i)
            if hero and Champion:IsValidEnemy(hero) and pos:DistanceTo(hero.pos) <= range then
                count = count + 1
            end
        end
        return count
    end

    function Champion:GetValidAlliesCount(pos, range)
        local count = 0
        for i = 1, Game.HeroCount() do
            local hero = Game.Hero(i)
            if hero and Champion:IsValidAlly(hero) then
                count = count + 1
            end
        end
        return count
    end

    function Champion:HasZileanBomb(unit)
        local name = "ZileanQEnemyBomb"
        for i = 0, unit.buffCount do
            local buff = unit:GetBuff(i)
            if buff and buff.count > 0 and buff.name == name then
                return true
            end
        end
        return false
    end

    function Champion:Init()
        -- Vi START
        if myHero.charName == "Vi" then
            Menu:Init()
            Menu.w:Remove()
            Menu.d:Remove()
            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = false})
            Menu.q_auto = Menu.q:MenuElement({id = "auto", name = "Auto-release", value = false})
            Menu.q_charge =
                Menu.q:MenuElement(
                {id = "qcharge", name = "Min charge time", value = 0, min = 0, max = 1.25, step = 0.05}
            )
            Menu.q_pred =
                Menu.q:MenuElement({id = "qpred", name = "Hitchance", value = 1, drop = {"Normal", "High", "Immobile"}})
            Menu.q_release = Menu.q:MenuElement({id = "release", name = "Release near end", value = true})

            Menu.e_combo = Menu.e:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.e_harass = Menu.e:MenuElement({id = "harass", name = "Harass", value = false})

            Menu.r_combo = Menu.r:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.r_ks = Menu.r:MenuElement({id = "killsteal", name = "Killsteal", value = true})
            Menu.r_dist =
                Menu.r:MenuElement({id = "dist", name = "Min distance", value = 400, min = 0, max = 800, step = 25})

            local QStartTime = 0
            local NextQStart = Game.Timer()

            Callback.Add(
                "Tick",
                function()
                    if
                        myHero.dead or Game.IsChatOpen() or Orb:IsEvading() or Champion:IsRecalling(myHero) or
                            Champion:IsPlayerAtFountain(myHero)
                     then
                        return
                    end
                    local mode = Orb:GetMode()

                    if Spells:IsReady(_R) then
                        if Menu.r_ks:Value() then
                            for i = 1, Game.HeroCount() do
                                local hero = Game.Hero(i)
                                if
                                    hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                        myHero.pos:DistanceTo(hero.pos) >= Menu.r_dist:Value()
                                 then
                                    local rdamage = getdmg("R", hero, myHero)
                                    local hp = hero.health + (2 * hero.hpRegen)
                                    if hp <= rdamage then
                                        Control.CastSpell(HK_R, hero)
                                        return
                                    end
                                end
                            end
                        end
                        if Orb:IsCombo() and Menu.r_combo:Value() and not myHero.activeSpell.valid then
                            local target = Orb:GetTarget(800)
                            if target and myHero.pos:DistanceTo(target.pos) >= Menu.r_dist:Value() then
                                Control.CastSpell(HK_R, target)
                                return
                            end
                        end
                    end

                    if
                        (Orb:IsCombo() and Menu.q_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value()) or
                            Menu.q_auto:Value()
                     then
                        local target = Orb:GetTarget(1500)
                        if target == nil then
                            return
                        end
                        if not Spells:IsReady(_Q) and QStartTime > 0 then
                            QStartTime = 0
                            if Control.IsKeyDown(HK_Q) then
                                Control.KeyUp(HK_Q)
                            end
                            return
                        end
                        if myHero.activeSpell.valid and myHero.activeSpell.name == "ViQ" then
                            if QStartTime == 0 then
                                QStartTime = Game.Timer()
                            end
                            local QChargeTime = Game.Timer() - QStartTime
                            if QChargeTime >= (Menu.q_charge:Value() - 0.2) then
                                local QRange = math.max(250 + (math.min(QChargeTime, 1.25) * 46.5 / 0.125), 250)
                                local QGGPrediction =
                                    GGPrediction:SpellPrediction(
                                    {
                                        Delay = 0,
                                        Radius = 90,
                                        Range = QRange,
                                        Speed = 1500,
                                        Collision = false,
                                        Type = GGPrediction.SPELLTYPE_LINE
                                    }
                                )
                                QGGPrediction:GetPrediction(target, myHero)
                                if QGGPrediction:CanHit(Menu.q_pred:Value() + 1) then
                                    Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                    return
                                end
                                if QChargeTime > 3.8 and Menu.q_release:Value() then
                                    Control.CastSpell(HK_Q, target.pos)
                                end
                            end
                        elseif
                            (Orb:IsCombo() and Menu.q_combo:Value()) or
                                (Orb:IsHarass() and Menu.q_harass:Value()) and Spells:IsReady(_Q) and
                                    myHero.pos:DistanceTo(target.pos) <= 850
                         then
                            if NextQStart > Game.Timer() then
                                return
                            end
                            if Control.IsKeyDown(HK_Q) then
                                Control.KeyUp(HK_Q)
                            else
                                Control.KeyDown(HK_Q)
                            end
                            NextQStart = Game.Timer() + 0.25
                        end
                    end
                end
            )
            Orb:OnPostAttack(
                function()
                    if
                        Spells:IsReady(_E) and
                            ((Orb:IsCombo() and Menu.e_combo:Value()) or (Orb:IsHarass() and Menu.e_harass:Value()))
                     then
                        local target = Orb:GetTarget(300)
                        if target then
                            Control.CastSpell(HK_E)
                        end
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Vi END

        -- Shaco START
        if myHero.charName == "Shaco" then
            Menu:Init()
            Menu.q:Remove()
            Menu.w:Remove()
            Menu.r:Remove()
            Menu.d:Remove()

            Menu.e_ks_enabled = Menu.e:MenuElement({id = "ekillsteal", name = "Killsteal", value = true})
            Menu.e_ks_backstab =
                Menu.e:MenuElement({id = "ekillstealbackstab", name = "Include Backstab", value = true})
            Menu.e_ks_collector =
                Menu.e:MenuElement({id = "ekillstealcollector", name = "Include Collector", value = true})

            Callback.Add(
                "Tick",
                function()
                    if not Spells:IsReady(_E) or Champion:MyHeroNotReady() then
                        return
                    end

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
                        if Champion:IsValidEnemy(hero) and myHero.pos:DistanceTo(hero.pos) <= 625 then
                            local health = hero.health + (2 * hero.hpRegen)
                            local extraDamage = 0
                            if Menu.e_ks_backstab:Value() and not _G.SDK.ObjectManager:IsFacing(hero, myHero) then
                                extraDamage = extraDamage + behindDmg
                            end
                            local dmg =
                                _G.SDK.Damage:CalculateDamage(myHero, hero, DAMAGE_TYPE_MAGICAL, edmg + extraDamage)
                            local hpPercent = health / hero.maxHealth
                            if hpPercent < 0.3 then
                                dmg = dmg * 1.5
                            end
                            if health > 1 then
                                if health < dmg then
                                    Control.CastSpell(HK_E, hero)
                                    return
                                end
                                if
                                    ((health - dmg) / hero.maxHealth) <= 0.05 and Menu.e_ks_collector:Value() and
                                        _G.SDK.ItemManager:HasItem(myHero, 6676)
                                 then
                                    Control.CastSpell(HK_E, hero)
                                end
                            end
                        end
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Shaco END

        -- Braum START
        if myHero.charName == "Braum" then
            Menu:Init()
            Menu.w:Remove()
            Menu.e:Remove()
            Menu.r:Remove()
            Menu.d:Remove()

            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = true})
            Menu.q_killsteal = Menu.q:MenuElement({id = "killsteal", name = "Killsteal", value = true})
            Menu.q_range =
                Menu.q:MenuElement({id = "qrange", name = "Q Range", value = 950, min = 50, max = 1000, step = 50})
            Menu.q_hitchance =
                Menu.q:MenuElement(
                {id = "hitchance", name = "Hitchance", value = 1, drop = {"normal", "high", "immobile"}}
            )

            Callback.Add(
                "Tick",
                function()
                    if not Spells:IsReady(_Q) or Champion:MyHeroNotReady() then
                        return
                    end

                    local QRange = Menu.q_range:Value()
                    local QGGPrediction =
                        GGPrediction:SpellPrediction(
                        {
                            Delay = 0.25,
                            Radius = 70,
                            Range = QRange,
                            Speed = 1700,
                            Type = GGPrediction.SPELLTYPE_LINE,
                            Collision = true,
                            MaxCollision = 0,
                            CollisionTypes = {GGPrediction.COLLISION_MINION, GGPrediction.COLLISION_YASUOWALL}
                        }
                    )
                    if Menu.q_killsteal:Value() then
                        for i = 1, Game.HeroCount() do
                            local hero = Game.Hero(i)
                            local qdamage = getdmg("Q", hero, myHero)
                            if
                                hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                    hero.health <= qdamage and
                                    myHero.pos:DistanceTo(hero.pos) <= QRange
                             then
                                QGGPrediction:GetPrediction(hero, myHero)
                                if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                                    Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                    return
                                end
                            end
                        end
                    end

                    local mode = Orb:GetMode()
                    if not ((Orb:IsCombo() and Menu.q_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value())) then
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
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Braum END

        -- Tahm Kench START
        if myHero.charName == "TahmKench" then
            Menu:Init()
            Menu.w:Remove()
            Menu.e:Remove()

            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = true})
            Menu.q_hitchance =
                Menu.q:MenuElement(
                {id = "hitchance", name = "Hitchance", value = 1, drop = {"normal", "high", "immobile"}}
            )

            Menu.r_combo = Menu.r:MenuElement({id = "combo", name = "Combo", value = true})

            Menu.q_range = Menu.d:MenuElement({id = "qrange", name = "Q Range", value = true})
            Menu.r_range = Menu.d:MenuElement({id = "rrange", name = "R Range", value = false})

            local DEVOUR_BUFF_NAME = "tahmkenchpdevourable"
            local Q_RANGE_COLOR = Draw.Color(190, 50, 205, 50)
            local R_RANGE_COLOR = Draw.Color(190, 0, 0, 205)

            Callback.Add(
                "Tick",
                function()
                    if Champion:MyHeroNotReady() then
                        return
                    end
                    local mode = Orb:GetMode()

                    if Spells:IsReady(_R) and Menu.r_combo:Value() and Orb:IsCombo() then
                        for i = 1, Game.HeroCount() do
                            local hero = Game.Hero(i)
                            if
                                hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                    myHero.pos:DistanceTo(hero.pos) <= 250
                             then
                                local rbuff = _G.SDK.BuffManager:GetBuff(hero, DEVOUR_BUFF_NAME)
                                if rbuff and rbuff.count >= 1 then
                                    Control.CastSpell(HK_R, hero)
                                    return
                                end
                            end
                        end
                    end

                    local target = Orb:GetTarget(900)
                    local QGGPrediction =
                        GGPrediction:SpellPrediction(
                        {
                            Delay = 0.25,
                            Radius = 70,
                            Range = 900,
                            Speed = 2800,
                            Type = GGPrediction.SPELLTYPE_LINE,
                            Collision = true,
                            MaxCollision = 0,
                            CollisionTypes = {GGPrediction.COLLISION_MINION, GGPrediction.COLLISION_YASUOWALL}
                        }
                    )
                    if
                        Spells:IsReady(_Q) and target and
                            ((Orb:IsCombo() and Menu.q_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value()))
                     then
                        QGGPrediction:GetPrediction(target, myHero)
                        if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                            Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                            return
                        end
                    end
                end
            )

            Callback.Add(
                "Draw",
                function()
                    if Menu.q_range:Value() and Spells:IsReady(_Q) then
                        Draw.Circle(myHero.pos, 900, 1, Q_RANGE_COLOR)
                    end
                    if Menu.r_range:Value() and Spells:IsReady(_R) then
                        Draw.Circle(myHero.pos, 275, 1, R_RANGE_COLOR)
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Tahm Kench END

        -- Pyke START
        if myHero.charName == "Pyke" then
            Menu:Init()
            Menu.w:Remove()
            Menu.e:Remove()

            Menu.q_auto = Menu.q:MenuElement({id = "qauto", name = "Auto-pull", value = true})
            Menu.q_hitchance =
                Menu.q:MenuElement(
                {id = "qhitchance", name = "Hitchance", value = 1, drop = {"Normal", "High", "Immobile"}}
            )

            Menu.r_ks = Menu.r:MenuElement({id = "rks", name = "Killsteal", value = true})
            Menu.r_hitchance =
                Menu.r:MenuElement(
                {id = "rhitchance", name = "Hitchance", value = 1, drop = {"Normal", "High", "Immobile"}}
            )
            Menu.r_targets = Menu.r:MenuElement({id = "PykeRTargets", name = "Use on: ", type = MENU})
            DelayAction(
                function()
                    for i, target in pairs(Champion:GetEnemies()) do
                        Menu.r_targets:MenuElement(
                            {id = "PykeR_" .. target.charName, name = target.charName, value = true}
                        )
                    end
                end,
                1
            )

            Menu.q_range = Menu.d:MenuElement({id = "qrange", name = "Q Range", value = true})
            Menu.r_range = Menu.d:MenuElement({id = "rrange", name = "R Range", value = false})

            local QStartTime = -1
            local NextRTime = 0

            Callback.Add(
                "Tick",
                function()
                    if
                        myHero.dead or Game.IsChatOpen() or Orb:IsEvading() or Champion:IsRecalling(myHero) or
                            Champion:IsPlayerAtFountain(myHero)
                     then
                        return
                    end
                    if not Spells:IsReady(_Q) then
                        QStartTime = -1
                    end
                    if NextRTime < Game.Timer() and Menu.r_ks:Value() and Spells:IsReady(_R) then
                        local LvL = myHero.levelData.lvl
                        local Dmg1 =
                            ({250, 250, 250, 250, 250, 250, 290, 330, 370, 400, 430, 450, 470, 490, 510, 530, 540, 550})[
                            LvL
                        ]
                        local Dmg2 = 0.8 * myHero.bonusDamage + 1.5 * myHero.armorPen
                        local RDmg = 0

                        if Dmg1 ~= nill then
                            RDmg = Dmg1 + Dmg2
                        else
                            RDmg = Dmg2
                        end

                        local validEnemies = Champion:GetValidEnemies(myHero.pos, 900)
                        for i = 1, #validEnemies do
                            local hero = validEnemies[i]
                            if
                                hero and hero.health <= RDmg and Champion:IsValidEnemy(hero) and
                                    Menu.r_targets["PykeR_" .. hero.charName]:Value()
                             then
                                local RPrediction =
                                    GGPrediction:SpellPrediction(
                                    {
                                        Delay = 0.5,
                                        Radius = 200,
                                        Range = 750,
                                        Speed = 1000,
                                        Collision = false,
                                        Type = GGPrediction.SPELLTYPE_CIRCLE
                                    }
                                )
                                RPrediction:GetPrediction(hero, myHero)
                                if RPrediction:CanHit(Menu.r_hitchance:Value() + 1) then
                                    NextRTime = Game.Timer() + 0.7
                                    Control.CastSpell(HK_R, RPrediction.CastPosition)
                                    return
                                end
                            end
                        end
                    end

                    if Spells:IsReady(_Q) and Menu.q_auto:Value() then
                        if myHero.activeSpell.valid and myHero.activeSpell.name == "PykeQ" then
                            if QStartTime == -1 then
                                QStartTime = Game.Timer()
                            end
                            local qChargeDuration = Game.Timer() - QStartTime
                            if qChargeDuration > 3 then
                                return
                            end
                            local range = math.max(math.min(qChargeDuration, 1.25) * 880, 400)
                            local selected = _G.SDK.TargetSelector.Selected

                            if range > 400 then
                                if
                                    selected and selected.team ~= myHero.team and selected.valid and selected.alive and
                                        selected.visible and
                                        myHero.pos:DistanceTo(selected.pos) <= 3000
                                 then
                                    local QPrediction =
                                        GGPrediction:SpellPrediction(
                                        {
                                            Delay = 0.25,
                                            Radius = 55,
                                            Range = range,
                                            Speed = 1700,
                                            Type = GGPrediction.SPELLTYPE_LINE,
                                            Collision = true,
                                            MaxCollision = 0,
                                            CollisionTypes = {
                                                GGPrediction.COLLISION_MINION,
                                                GGPrediction.COLLISION_YASUOWALL
                                            }
                                        }
                                    )
                                    QPrediction:GetPrediction(selected, myHero)
                                    if QPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                                        Control.CastSpell(HK_Q, QPrediction.CastPosition)
                                        return
                                    end
                                else
                                    for i = 1, Game.HeroCount() do
                                        local hero = Game.Hero(i)
                                        if
                                            hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                                hero.visible and
                                                myHero.pos:DistanceTo(hero.pos) <= (range + 100)
                                         then
                                            local QPrediction =
                                                GGPrediction:SpellPrediction(
                                                {
                                                    Delay = 0.25,
                                                    Radius = 55,
                                                    Range = range,
                                                    Speed = 1700,
                                                    Type = GGPrediction.SPELLTYPE_LINE,
                                                    Collision = true,
                                                    MaxCollision = 0,
                                                    CollisionTypes = {
                                                        GGPrediction.COLLISION_MINION,
                                                        GGPrediction.COLLISION_YASUOWALL
                                                    }
                                                }
                                            )
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
                end
            )

            Callback.Add(
                "Draw",
                function()
                    if Menu.q_range:Value() and Spells:IsReady(_Q) then
                        Draw.Circle(myHero.pos, 1100, Draw.Color(255, 255, 255, 100))
                    end
                    if Menu.r_range:Value() and Spells:IsReady(_R) then
                        Draw.Circle(myHero.pos, 750, Draw.Color(255, 0, 0, 100))
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Pyke END

        -- Amumu START
        if myHero.charName == "Amumu" then
            Menu:Init()

            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = false})
            Menu.q_killsteal = Menu.q:MenuElement({id = "combo", name = "Killsteal", value = true})
            Menu.q_range =
                Menu.q:MenuElement({id = "qrange", name = "Q Range", value = 1000, min = 25, max = 1100, step = 25})
            Menu.q_hitchance =
                Menu.q:MenuElement(
                {id = "hitchance", name = "Hitchance", value = 1, drop = {"Normal", "High", "Immobile"}}
            )

            Menu.w:Remove()
            --
            --[[
			Menu.w_combo = Menu.w:MenuElement({id = 'combo', name = 'Combo', value = true})			
			Menu.w_harass = Menu.w:MenuElement({id = 'harass', name = 'Harass', value = false})			
			Menu.w_waveclear = Menu.w:MenuElement({id = 'clear', name = 'Clear', value = false})
			Menu.w_jungle = Menu.w:MenuElement({id = 'clear', name = 'Jungle', value = false})
			]] Menu.e_combo =
                Menu.e:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.e_harass = Menu.e:MenuElement({id = "harass", name = "Harass", value = false})
            Menu.e_waveclear = Menu.e:MenuElement({id = "clear", name = "Clear", value = false})
            Menu.e_jungle = Menu.e:MenuElement({id = "clear", name = "Jungle", value = false})

            Menu.r_combo = Menu.r:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.r_combo_targets =
                Menu.r:MenuElement(
                {id = "combotargets", name = "Combo Min Targets", value = 2, min = 1, max = 5, step = 1}
            )
            Menu.r_auto = Menu.r:MenuElement({id = "auto", name = "Auto", value = true})
            Menu.r_auto_targets =
                Menu.r:MenuElement(
                {id = "Auto min targets", name = "Auto Min Targets", value = 3, min = 1, max = 5, step = 1}
            )

            Menu.q_rangedraw = Menu.d:MenuElement({id = "qrangedraw", name = "Q Range", value = true})
            Menu.r_range = Menu.d:MenuElement({id = "rrange", name = "R Range", value = false})

            local QGGPrediction =
                GGPrediction:SpellPrediction(
                {
                    Delay = 0.25,
                    Radius = 80,
                    Range = 1100,
                    Speed = 2000,
                    Type = GGPrediction.SPELLTYPE_LINE,
                    Collision = true,
                    MaxCollision = 0,
                    CollisionTypes = {GGPrediction.COLLISION_MINION, GGPrediction.COLLISION_YASUOWALL}
                }
            )

            Callback.Add(
                "Tick",
                function()
                    if Champion:MyHeroNotReady() then
                        return
                    end
                    local mode = Orb:GetMode()

                    if Spells:IsReady(_R) then
                        if ((Orb:IsCombo() and Menu.r_combo:Value()) or Menu.r_auto:Value()) then
                            local count = 0
                            for i = 1, Game.HeroCount() do
                                local hero = Game.Hero(i)
                                if
                                    hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                        myHero.pos:DistanceTo(hero.pos) <= 550
                                 then
                                    count = count + 1
                                end
                            end
                            local minTargets = Menu.r_auto_targets:Value()
                            if Orb:IsCombo() and Menu.r_combo:Value() then
                                minTargets = Menu.r_combo_targets:Value()
                            end
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
                                if
                                    hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                        myHero.pos:DistanceTo(hero.pos) <= 1050
                                 then
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
                        if (Orb:IsCombo() and Menu.q_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value()) then
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
                        if (Orb:IsCombo() and Menu.e_combo:Value()) or (Orb:IsHarass() and Menu.e_harass:Value()) then
                            local target = Orb:GetTarget(300)
                            if target then
                                Control.CastSpell(HK_E)
                                return
                            end
                        end

                        if mode == "Clear" and (Menu.e_jungle:Value() or Menu.e_waveclear:Value()) then
                            for i = 1, Game.MinionCount() do
                                local minion = Game.Minion(i)
                                if
                                    ((Menu.e_jungle:Value() and minion.team == 300) or
                                        (Menu.e_waveclear:Value() and minion.team == 300 - myHero.team)) and
                                        minion.valid and
                                        minion.alive and
                                        minion.pos:DistanceTo(myHero.pos) <= 325
                                 then
                                    Control.CastSpell(HK_E)
                                    return
                                end
                            end
                        end
                    end
                end
            )

            Callback.Add(
                "Draw",
                function()
                    if Menu.q_rangedraw:Value() and Spells:IsReady(_Q) then
                        Draw.Circle(myHero.pos, Menu.q_range:Value(), Draw.Color(255, 255, 255, 100))
                    end
                    if Menu.r_range:Value() and Spells:IsReady(_R) then
                        Draw.Circle(myHero.pos, 550, Draw.Color(255, 0, 0, 100))
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Amumu END

        -- DrMundo START
        if myHero.charName == "DrMundo" then
            Menu:Init()

            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = false})
            Menu.q_killsteal = Menu.q:MenuElement({id = "combo", name = "Killsteal", value = true})
            Menu.q_range =
                Menu.q:MenuElement({id = "qrange", name = "Q Range", value = 1000, min = 25, max = 1000, step = 25})
            Menu.q_hitchance =
                Menu.q:MenuElement(
                {id = "hitchance", name = "Hitchance", value = 1, drop = {"Normal", "High", "Immobile"}}
            )

            Menu.e_combo = Menu.e:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.e_harass = Menu.e:MenuElement({id = "harass", name = "Harass", value = false})

            Menu.w:Remove()
            Menu.r:Remove()

            Menu.q_rangedraw = Menu.d:MenuElement({id = "qrangedraw", name = "Q Range", value = true})

            local QGGPrediction =
                GGPrediction:SpellPrediction(
                {
                    Delay = 0.25,
                    Radius = 60,
                    Range = 1000,
                    Speed = 2000,
                    Type = GGPrediction.SPELLTYPE_LINE,
                    Collision = true,
                    MaxCollision = 0,
                    CollisionTypes = {GGPrediction.COLLISION_MINION, GGPrediction.COLLISION_YASUOWALL}
                }
            )

            Callback.Add(
                "Tick",
                function()
                    if Champion:MyHeroNotReady() then
                        return
                    end
                    local mode = Orb:GetMode()

                    if Spells:IsReady(_Q) then
                        if Menu.q_killsteal:Value() then
                            local count = 0
                            for i = 1, Game.HeroCount() do
                                local hero = Game.Hero(i)
                                if
                                    hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                        myHero.pos:DistanceTo(hero.pos) <= 1050
                                 then
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
                        if (Orb:IsCombo() and Menu.q_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value()) then
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
                end
            )

            Callback.Add(
                "Draw",
                function()
                    if Menu.q_rangedraw:Value() and Spells:IsReady(_Q) then
                        Draw.Circle(myHero.pos, Menu.q_range:Value(), Draw.Color(255, 255, 255, 100))
                    end
                end
            )

            Orb:OnPostAttack(
                function()
                    local mode = Orb:GetMode()
                    if
                        Spells:IsReady(_E) and
                            ((Orb:IsCombo() and Menu.e_combo:Value()) or (Orb:IsHarass() and Menu.e_harass:Value()))
                     then
                        local target = Orb:GetTarget(300)
                        if target then
                            Control.CastSpell(HK_E)
                        end
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- DrMundo END

        -- Nautilus START
        if myHero.charName == "Nautilus" then
            Menu:Init()

            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = false})
            Menu.q_killsteal = Menu.q:MenuElement({id = "combo", name = "Killsteal", value = true})
            Menu.q_range =
                Menu.q:MenuElement({id = "qrange", name = "Q Range", value = 1050, min = 25, max = 1122, step = 25})
            Menu.q_hitchance =
                Menu.q:MenuElement(
                {id = "hitchance", name = "Hitchance", value = 1, drop = {"Normal", "High", "Immobile"}}
            )

            Menu.w:Remove()
            Menu.e:Remove()
            Menu.r:Remove()

            Menu.q_rangedraw = Menu.d:MenuElement({id = "qrangedraw", name = "Q Range", value = true})

            local QGGPrediction =
                GGPrediction:SpellPrediction(
                {
                    Delay = 0.25,
                    Radius = 90,
                    Range = 1122,
                    Speed = 2000,
                    Type = GGPrediction.SPELLTYPE_LINE,
                    Collision = true,
                    MaxCollision = 0,
                    CollisionTypes = {GGPrediction.COLLISION_MINION, GGPrediction.COLLISION_YASUOWALL}
                }
            )

            Callback.Add(
                "Tick",
                function()
                    if not Spells:IsReady(_Q) or Champion:MyHeroNotReady() then
                        return
                    end
                    local mode = Orb:GetMode()

                    if Spells:IsReady(_Q) then
                        if Menu.q_killsteal:Value() then
                            local count = 0
                            for i = 1, Game.HeroCount() do
                                local hero = Game.Hero(i)
                                if
                                    hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                        myHero.pos:DistanceTo(hero.pos) <= 1050
                                 then
                                    local qdamage = getdmg("Q", hero, myHero)
                                    if qdamage > hero.health + (2 * hero.hpRegen) then
                                        QGGPrediction.Range = 925
                                        QGGPrediction:GetPrediction(hero, myHero)
                                        if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                                            local QLine = Spells:CreateLinePoly(QGGPrediction.CastPosition)
                                            if not Spells:LineCollidesTerrain(QLine) then
                                                Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                                return
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        if (Orb:IsCombo() and Menu.q_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value()) then
                            QGGPrediction.Range = Menu.q_range:Value()
                            local target = Orb:GetTarget(QGGPrediction.Range)
                            if target then
                                QGGPrediction:GetPrediction(target, myHero)
                                if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                                    local QLine = Spells:CreateLinePoly(QGGPrediction.CastPosition)
                                    if not Spells:LineCollidesTerrain(QLine) then
                                        Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                        return
                                    end
                                end
                            end
                        end
                    end
                end
            )

            Callback.Add(
                "Draw",
                function()
                    if Menu.q_rangedraw:Value() and Spells:IsReady(_Q) then
                        local range = Menu.q_range:Value()
                        Draw.Circle(myHero.pos, range, Draw.Color(255, 255, 255, 100))
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Nautilus END

        -- Renata START
        if myHero.charName == "Renata" then
            Menu:Init()
            Menu.r:Remove()

            Menu.q_combo = Menu.q:MenuElement({id = "qcombo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "qharass", name = "Harass", value = true})
            Menu.q_killsteal = Menu.q:MenuElement({id = "qkillsteal", name = "Killsteal", value = true})
            Menu.q_range =
                Menu.q:MenuElement({id = "qrange", name = "Q Range", value = 900, min = 50, max = 900, step = 25})
            Menu.q_hitchance =
                Menu.q:MenuElement(
                {id = "qhitchance", name = "Hitchance", value = 1, drop = {"normal", "high", "immobile"}}
            )
            Menu.q_interrupt = Menu.q:MenuElement({id = "qinterrupt", name = "Interrupt", value = true})

            Menu.w_auto = Menu.w:MenuElement({id = "wauto", name = "Auto use", value = true})
            Menu.w_hp = Menu.w:MenuElement({id = "whp", name = "HP% below", value = 20, min = 0, max = 100, step = 1})
            Menu.w_enemies =
                Menu.w:MenuElement({id = "wenemies", name = "Enemies nearby", value = 1, min = 1, max = 5, step = 1})
            Menu.w_targets = Menu.w:MenuElement({id = "renatawtargers", name = "Use on: ", type = MENU})
            DelayAction(
                function()
                    for i, target in pairs(Champion:GetAllies()) do
                        Menu.w_targets:MenuElement(
                            {id = "RenataW_" .. target.charName, name = target.charName, value = true}
                        )
                    end
                end,
                1
            )

            Menu.e_combo = Menu.e:MenuElement({id = "ecombo", name = "Combo", value = true})
            Menu.e_harass = Menu.e:MenuElement({id = "eharass", name = "Harass", value = true})
            Menu.e_killsteal = Menu.e:MenuElement({id = "ekillsteal", name = "Killsteal", value = true})
            Menu.e_range =
                Menu.e:MenuElement({id = "erange", name = "Q Range", value = 800, min = 50, max = 800, step = 25})
            Menu.e_hitchance =
                Menu.e:MenuElement(
                {id = "ehitchance", name = "Hitchance", value = 1, drop = {"normal", "high", "immobile"}}
            )
            Menu.q_rangedraw = Menu.d:MenuElement({id = "qrangedraw", name = "Q Range", value = false})
            Menu.w_rangedraw = Menu.d:MenuElement({id = "wrangedraw", name = "W Range", value = false})
            Menu.e_rangedraw = Menu.d:MenuElement({id = "erangedraw", name = "E Range", value = false})
            Menu.r_rangedraw = Menu.d:MenuElement({id = "rrangedraw", name = "R Range", value = false})

            local NextQCast = 0

            Callback.Add(
                "Tick",
                function()
                    if Champion:MyHeroNotReady() then
                        return
                    end
                    local QRange = Menu.q_range:Value()
                    local WRange = 800
                    local ERange = Menu.e_range:Value()
                    local QGGPrediction =
                        GGPrediction:SpellPrediction(
                        {
                            Delay = 0.25,
                            Radius = 70,
                            Range = QRange,
                            Speed = 1450,
                            Type = GGPrediction.SPELLTYPE_LINE,
                            Collision = true,
                            MaxCollision = 0,
                            CollisionTypes = {GGPrediction.COLLISION_MINION, GGPrediction.COLLISION_YASUOWALL}
                        }
                    )
                    local EGGPrediction =
                        GGPrediction:SpellPrediction(
                        {
                            Delay = 0.25,
                            Radius = 200,
                            Range = ERange,
                            Speed = 1450,
                            Type = GGPrediction.SPELLTYPE_LINE,
                            Collision = false
                        }
                    )
                    local validEnemies = Champion:GetValidEnemies(myHero.pos, 1200)
                    local validAllies = Champion:GetValidAllies(myHero.pos, 1200)

                    if Spells:IsReady(_W) and Menu.w_auto:Value() then
                        local minHP = Menu.w_hp:Value()
                        for i = 1, #validAllies do
                            local hero = validAllies[i]
                            if myHero.pos:DistanceTo(hero.pos) <= WRange + 25 then
                                if
                                    Menu.w_targets["RenataW_" .. hero.charName]:Value() and
                                        Champion:HealthPercent(hero) <= minHP and
                                        Champion:GetValidEnemiesCount(hero.pos, 800)
                                 then
                                    Control.CastSpell(HK_W, hero)
                                    return
                                end
                            end
                        end
                    end

                    if Spells:IsReady(_Q) and Menu.q_interrupt:Value() and Game.Timer() > NextQCast then
                        for i = 1, #validEnemies do
                            local hero = validEnemies[i]
                            local spell = hero.activeSpell
                            if
                                hero and spell and spell.valid and myHero.pos:DistanceTo(hero.pos) <= 1000 and
                                    Spells.InterruptableSpells[spell.name] and
                                    spell.castEndTime - Game.Timer() > 0.33
                             then
                                QGGPrediction:GetPrediction(hero, myHero)
                                if QGGPrediction:CanHit(2) then
                                    NextQCast = Game.Timer() + 2
                                    Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                    return
                                end
                            end
                        end
                    end

                    if Spells:IsReady(_E) and Menu.e_killsteal:Value() then
                        for i = 1, #validEnemies do
                            local hero = validEnemies[i]
                            -- local edamage = getdmg("E", hero, myHero) -- TODO Return to DamageLib after its updated
                            local edamageraw = 35 + (30 * myHero:GetSpellData(_E).level) + (myHero.ap * 0.55)
                            local edamage = _G.SDK.Damage:CalculateDamage(myHero, hero, DAMAGE_TYPE_MAGICAL, edamageraw)
                            local distance = myHero.pos:DistanceTo(hero.pos)
                            if hero.health <= edamage and distance <= ERange + 100 then
                                if distance <= 350 then
                                    EGGPrediction.Delay = 0.25
                                else
                                    EGGPrediction.Delay = 0.65
                                end
                                EGGPrediction:GetPrediction(hero, myHero)
                                if EGGPrediction:CanHit(Menu.e_hitchance:Value() + 1) then
                                    Control.CastSpell(HK_E, EGGPrediction.CastPosition)
                                    return
                                end
                            end
                        end
                    end
                    if Spells:IsReady(_Q) and Menu.q_killsteal:Value() and Game.Timer() > NextQCast then
                        for i = 1, #validEnemies do
                            local hero = validEnemies[i]
                            -- local qdamage = getdmg("E", hero, myHero) -- TODO Return to DamageLib after its updated
                            local qdamageraw = 35 + (45 * myHero:GetSpellData(_Q).level) + (myHero.ap * 0.8)
                            local qdamage = _G.SDK.Damage:CalculateDamage(myHero, hero, DAMAGE_TYPE_MAGICAL, qdamageraw)
                            if hero.health <= qdamage and myHero.pos:DistanceTo(hero.pos) <= QRange + 100 then
                                QGGPrediction:GetPrediction(hero, myHero)
                                if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                                    NextQCast = Game.Timer() + 2
                                    Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                    return
                                end
                            end
                        end
                    end

                    local mode = Orb:GetMode()
                    local target = Orb:GetTarget(1200)
                    if target then
                        if
                            Spells:IsReady(_Q) and
                                ((Orb:IsCombo() and Menu.q_combo:Value()) or
                                    (Orb:IsHarass() and Menu.q_harass:Value())) and
                                Game.Timer() > NextQCast
                         then
                            if target and Champion:IsValidEnemy(target) then
                                QGGPrediction:GetPrediction(target, myHero)
                                if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                                    NextQCast = Game.Timer() + 2
                                    Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                    return
                                end
                            end
                        end

                        if
                            target and Spells:IsReady(_E) and
                                ((Orb:IsCombo() and Menu.e_combo:Value()) or
                                    (Orb:IsHarass() and Menu.e_harass:Value()))
                         then
                            if target and Champion:IsValidEnemy(target) then
                                EGGPrediction:GetPrediction(target, myHero)
                                if EGGPrediction:CanHit(Menu.e_hitchance:Value() + 1) then
                                    Control.CastSpell(HK_E, EGGPrediction.CastPosition)
                                    return
                                end
                            end
                        end
                    end
                end
            )

            Callback.Add(
                "Draw",
                function()
                    local QRange = Menu.q_range:Value()
                    local WRange = 800
                    local ERange = Menu.e_range:Value()
                    local RRange = 2000
                    if Menu.q_rangedraw:Value() and Spells:IsReady(_Q) then
                        Draw.Circle(myHero.pos, QRange, Draw.Color(200, 230, 250, 100))
                    end
                    if Menu.w_rangedraw:Value() and Spells:IsReady(_W) then
                        Draw.Circle(myHero.pos, WRange, Draw.Color(200, 255, 255, 255))
                    end
                    if Menu.e_rangedraw:Value() and Spells:IsReady(_E) then
                        Draw.Circle(myHero.pos, ERange, Draw.Color(200, 0, 255, 255))
                    end
                    if Menu.r_rangedraw:Value() and Spells:IsReady(_R) then
                        Draw.Circle(myHero.pos, RRange, Draw.Color(200, 255, 0, 0))
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Renata END

        -- Renata START
        if myHero.charName == "Zilean" then
            Menu:Init()

            Menu.q_combo = Menu.q:MenuElement({id = "qcombo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "qharass", name = "Harass", value = true})
            Menu.q_killsteal = Menu.q:MenuElement({id = "qkillsteal", name = "Killsteal", value = true})
            Menu.q_range =
                Menu.q:MenuElement({id = "qrange", name = "Range", value = 900, min = 25, max = 900, step = 25})
            Menu.q_hitchance =
                Menu.q:MenuElement(
                {id = "qhitchance", name = "Hitchance", value = 1, drop = {"normal", "high", "immobile"}}
            )
            Menu.q_autoboom = Menu.q:MenuElement({id = "qautoboom", name = "Auto if has bomb", value = true})
            Menu.q_autoboom_slowed =
                Menu.q:MenuElement({id = "qautoboom_slowed", name = "Auto on slowed", value = true})
            Menu.q_autoimmobile = Menu.q:MenuElement({id = "qimmobile", name = "Auto on immobile", value = true})
            Menu.q_disableattack =
                Menu.q:MenuElement({id = "qdisableattack", name = "Disable attack if ready", value = true})

            Menu.w_reset = Menu.w:MenuElement({id = "w_reset", name = "Use to reset Q", value = true})

            Menu.e_auto = Menu.e:MenuElement({id = "eauto", name = "Auto peel", value = true})
            Menu.e_range =
                Menu.e:MenuElement({id = "erange", name = "Range", value = 300, min = 50, max = 600, step = 25})
            Menu.e_mana =
                Menu.e:MenuElement({id = "emana", name = "Min Mana", value = 30, min = 1, max = 100, step = 1})
            Menu.e_targets = Menu.e:MenuElement({id = "Targets", name = "Use on: ", type = MENU})
            DelayAction(
                function()
                    for i, target in pairs(Champion:GetEnemies()) do
                        Menu.e_targets:MenuElement(
                            {id = "ZileanE_" .. target.charName, name = target.charName, value = true}
                        )
                    end
                end,
                1
            )

            Menu.r_auto = Menu.r:MenuElement({id = "rauto", name = "Auto R", value = true})
            Menu.r_hp = Menu.r:MenuElement({id = "rhppercent", name = "HP %", value = 20, min = 1, max = 100, step = 1})
            Menu.r_enemies =
                Menu.r:MenuElement({id = "renemies", name = "Enemies around", value = 1, min = 0, max = 5, step = 1})
            Menu.r_targets = Menu.r:MenuElement({id = "Targets", name = "Use on: ", type = MENU})
            DelayAction(
                function()
                    for i, target in pairs(Champion:GetAllies()) do
                        Menu.r_targets:MenuElement(
                            {id = "ZileanR_" .. target.charName, name = target.charName, value = true}
                        )
                    end
                end,
                1
            )

            Menu.q_rangedraw = Menu.d:MenuElement({id = "qrangedraw", name = "Q Range", value = false})
            Menu.e_rangedraw = Menu.d:MenuElement({id = "erangedraw", name = "E Range", value = false})
            Menu.r_rangedraw = Menu.d:MenuElement({id = "rrangedraw", name = "R Range", value = false})

            if _G.SDK then
                _G.SDK.Orbwalker:CanAttackEvent(
                    function()
                        if
                            Menu.q_disableattack:Value() and
                                ((_G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO] and "Combo") or
                                    (_G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS] and "Harass")) and
                                myHero:GetSpellData(_Q).currentCd <= 1
                         then
                            return false
                        end
                        return true
                    end
                )
            end

            local NextQCast = Game.Timer()
            local NextECast = Game.Timer()
            local NextRCast = Game.Timer()

            Callback.Add(
                "Tick",
                function()
                    if Champion:MyHeroNotReady() then
                        return
                    end
                    local QRange = Menu.q_range:Value()
                    local ERange = Menu.e_range:Value()
                    local RRange = 925
                    local QCost = 55 + myHero:GetSpellData(_W).level * 5
                    local WCost = 35
                    local ECost = 50
                    local WQCost = WCost + QCost
                    local QCooldown = myHero:GetSpellData(_Q).currentCd
                    local CanWQ =
                        Menu.w_reset:Value() and Spells:IsReady(_W) and myHero.mana >= WQCost and not Spells:IsReady(_Q) and
                        QCooldown >= 1
                    local QHitChance = Menu.q_hitchance:Value() + 1
                    local QGGPrediction =
                        GGPrediction:SpellPrediction(
                        {
                            Delay = 0.8,
                            Radius = 160,
                            Range = QRange,
                            Speed = math.huge,
                            Type = GGPrediction.SPELLTYPE_LINE,
                            Collision = true,
                            MaxCollision = 0,
                            CollisionTypes = {GGPrediction.COLLISION_YASUOWALL}
                        }
                    )
                    local validEnemies = Champion:GetValidEnemies(myHero.pos, 1200)
                    local validAllies = Champion:GetValidAllies(myHero.pos, 1200)

                    if Menu.r_auto:Value() and Spells:IsReady(_R) and NextRCast < Game.Timer() then
                        local rhp = Menu.r_hp:Value()
                        local enemyCount = Menu.r_enemies:Value()
                        for i = 1, #validAllies do
                            local hero = validAllies[i]
                            if
                                Champion:HealthPercent(hero) <= rhp and myHero.pos:DistanceTo(hero.pos) <= RRange and
                                    Menu.r_targets["ZileanR_" .. hero.charName]:Value() and
                                    Champion:GetValidEnemiesCount(hero.pos, 800) >= enemyCount
                             then
                                Control.CastSpell(HK_R, hero)
                                NextRCast = Game.Timer() + 0.25
                                return
                            end
                        end
                    end

                    if
                        Menu.e_auto:Value() and Spells:IsReady(_E) and NextECast < Game.Timer() and
                            Champion:ManaPercent(myHero) >= Menu.e_mana:Value()
                     then
                        for i = 1, #validEnemies do
                            local hero = validEnemies[i]
                            if
                                hero.ms >= 300 and myHero.pos:DistanceTo(hero.pos) <= ERange and
                                    Menu.e_targets["ZileanE_" .. hero.charName]:Value()
                             then
                                Control.CastSpell(HK_E, hero)
                                NextECast = Game.Timer() + 0.25
                                return
                            end
                        end
                    end

                    if Spells:IsReady(_Q) or CanWQ and NextQCast < Game.Timer() then
                        if Menu.q_killsteal:Value() then
                            for i = 1, #validEnemies do
                                local hero = validEnemies[i]
                                local damage = getdmg("Q", hero, myHero)
                                if damage >= hero.health then
                                    QGGPrediction:GetPrediction(hero, myHero)
                                    if QGGPrediction:CanHit(QHitChance) then
                                        if CanWQ and not Spells:IsReady(_Q) then
                                            Control.CastSpell(HK_W)
                                        end
                                        Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                        NextQCast = Game.Timer() + 0.2
                                        return
                                    end
                                end
                            end
                        end
                        if Menu.q_autoimmobile:Value() then
                            for i = 1, #validEnemies do
                                local hero = validEnemies[i]
                                QGGPrediction:GetPrediction(hero, myHero)
                                if QGGPrediction:CanHit(4) then
                                    if CanWQ and not Spells:IsReady(_Q) then
                                        Control.CastSpell(HK_W)
                                    end
                                    Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                    NextQCast = Game.Timer() + 0.1
                                    return
                                end
                            end
                        end
                        for i = 1, #validEnemies do
                            local hero = validEnemies[i]
                            if
                                (Menu.q_autoboom:Value() and Champion:HasZileanBomb(hero)) or
                                    (Menu.q_autoboom_slowed:Value() and hero.ms <= 300)
                             then
                                QGGPrediction:GetPrediction(hero, myHero)
                                if QGGPrediction:CanHit(2) then
                                    if CanWQ and not Spells:IsReady(_Q) then
                                        Control.CastSpell(HK_W)
                                    end
                                    Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                    NextQCast = Game.Timer() + 0.1
                                    return
                                end
                            end
                        end
                        local mode = Orb:GetMode()
                        local target = Orb:GetTarget(1200)
                        if
                            target and
                                ((Orb:IsCombo() and Menu.q_combo:Value()) or
                                    (Orb:IsHarass() and Menu.q_harass:Value())) and
                                Champion:IsValidEnemy(target)
                         then
                            QGGPrediction:GetPrediction(target, myHero)
                            if QGGPrediction:CanHit(QHitChance) then
                                if CanWQ and not Spells:IsReady(_Q) then
                                    Control.CastSpell(HK_W)
                                end
                                Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                NextQCast = Game.Timer() + 0.2
                                return
                            end
                        end
                    end
                end
            )

            Callback.Add(
                "Draw",
                function()
                    local QRange = 900
                    local ERange = 600
                    local RRange = 900
                    if Menu.q_rangedraw:Value() and Spells:IsReady(_Q) then
                        Draw.Circle(myHero.pos, QRange, Draw.Color(200, 255, 0, 0))
                    end
                    if Menu.e_rangedraw:Value() and Spells:IsReady(_E) then
                        Draw.Circle(myHero.pos, ERange, Draw.Color(200, 0, 255, 255))
                    end
                    if Menu.r_rangedraw:Value() and Spells:IsReady(_R) then
                        Draw.Circle(myHero.pos, RRange, Draw.Color(200, 255, 255, 255))
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Renata END

        -- Trundle START
        if myHero.charName == "Trundle" then
            Menu:Init()
            Menu.w:Remove()
            Menu.e:Remove()
            Menu.r:Remove()
            Menu.d:Remove()

            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = false})

            Callback.Add(
                "Tick",
                function()
                end
            )
            Orb:OnPostAttack(
                function()
                    local mode = Orb:GetMode()
                    if
                        Spells:IsReady(_Q) and
                            ((Orb:IsCombo() and Menu.q_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value()))
                     then
                        local target = Orb:GetTarget(325)
                        if target then
                            Control.CastSpell(HK_Q)
                        end
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Trundle END

        -- Garen START
        if myHero.charName == "Garen" then
            Menu:Init()
            Menu.w:Remove()
            Menu.e:Remove()

            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = false})
            Menu.r_killsteal = Menu.r:MenuElement({id = "killsteal", name = "Killsteal", value = true})
            local targetsLoaded = false
            DelayAction(
                function()
                    Menu.r_targets = Menu.r:MenuElement({id = "garenrtargets", name = "Use on: ", type = MENU})
                    for i, target in pairs(Champion:GetEnemies()) do
                        Menu.r_targets:MenuElement(
                            {id = "GarenR_" .. target.charName, name = target.charName, value = true}
                        )
                    end
                    targetsLoaded = true
                end,
                1
            )
            Menu.r_rangedraw = Menu.d:MenuElement({id = "rrangedraw", name = "R Range", value = false})

            local NextRTime = 0.0

            Callback.Add(
                "Tick",
                function()
                    if targetsLoaded and Menu.r_killsteal:Value() and Spells:IsReady(_R) and Game.Timer() > NextRTime then
                        local count = 0
                        for i = 1, Game.HeroCount() do
                            local hero = Game.Hero(i)
                            if
                                hero and hero.team ~= myHero.team and Menu.r_targets["GarenR_" .. hero.charName]:Value() and
                                    hero.valid and
                                    hero.alive and
                                    myHero.pos:DistanceTo(hero.pos) <= 425
                             then
                                local rlevel = myHero:GetSpellData(_R).level
                                local rdamage =
                                    ({150, 300, 450})[rlevel] +
                                    (({25, 30, 35})[rlevel] / 100) * (hero.maxHealth - hero.health)
                                if rdamage > hero.health + (2 * hero.hpRegen) and not Orb:IsImmortal(hero, false) then
                                    print(
                                        "Casting R on " ..
                                            hero.name ..
                                                " - health: " ..
                                                    string.format("%.0f", hero.health) ..
                                                        " damage: " .. string.format("%.0f", rdamage)
                                    )
                                    Control.CastSpell(HK_R, hero)
                                    NextRTime = Game.Timer() + 0.5
                                    return
                                end
                            end
                        end
                    end
                end
            )
            Orb:OnPostAttack(
                function()
                    if
                        Spells:IsReady(_Q) and
                            ((Orb:IsCombo() and Menu.q_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value()))
                     then
                        local target = Orb:GetTarget(325)
                        if target then
                            Control.CastSpell(HK_Q)
                        end
                    end
                end
            )

            Callback.Add(
                "Draw",
                function()
                    local RRange = 400
                    if Menu.r_rangedraw:Value() and Spells:IsReady(_R) then
                        Draw.Circle(myHero.pos, RRange, Draw.Color(200, 255, 255, 255))
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Garen END

        -- Teemo START
        if myHero.charName == "Teemo" then
            Menu:Init()
            Menu.w:Remove()
            Menu.e:Remove()
            Menu.r:Remove()
            Menu.d:Remove()

            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = false})

            Callback.Add(
                "Tick",
                function()
                end
            )
            Orb:OnPostAttack(
                function()
                    local mode = Orb:GetMode()
                    if
                        Spells:IsReady(_Q) and
                            ((Menu.q_combo:Value() and Orb:IsCombo()) or (Menu.q_harass:Value() and Orb:IsHarass()))
                     then
                        local target = Orb:GetTarget(725)
                        if target then
                            Control.CastSpell(HK_Q, target)
                        end
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Teemo END

        -- Rammus START
        if myHero.charName == "Rammus" then
            Menu:Init()
            Menu.q:Remove()
            Menu.r:Remove()

            Menu.d:Remove()

            Menu.w_combo = Menu.w:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.w_harass = Menu.w:MenuElement({id = "harass", name = "Harass", value = false})

            Menu.e_combo = Menu.e:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.e_harass = Menu.e:MenuElement({id = "harass", name = "Harass", value = false})

            Callback.Add(
                "Tick",
                function()
                    local mode = Orb:GetMode()
                    if
                        Spells:IsReady(_E) and
                            ((Menu.e_combo:Value() and Orb:IsCombo()) or (Menu.e_harass:Value() and Orb:IsHarass()))
                     then
                        local target = Orb:GetTarget(250)
                        if target then
                            Control.CastSpell(HK_E, target)
                        end
                    end
                end
            )
            Orb:OnPreAttack(
                function()
                    local mode = Orb:GetMode()
                    if
                        Spells:IsReady(_W) and
                            ((Menu.w_combo:Value() and Orb:IsCombo()) or (Menu.w_harass:Value() and Orb:IsHarass())) and
                            myHero:GetSpellData(_W).name == "DefensiveBallCurl"
                     then
                        local target = Orb:GetTarget(250)
                        if target then
                            Control.CastSpell(HK_W)
                        end
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Rammus END

        -- Jax START
        if myHero.charName == "Jax" then
            Menu:Init()
            Menu.q:Remove()
            Menu.e:Remove()
            Menu.r:Remove()

            Menu.d:Remove()

            Menu.w_combo = Menu.w:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.w_harass = Menu.w:MenuElement({id = "harass", name = "Harass", value = false})

            Orb:OnPostAttack(
                function()
                    local mode = Orb:GetMode()
                    if
                        Spells:IsReady(_W) and
                            ((Menu.w_combo:Value() and Orb:IsCombo()) or (Menu.w_harass:Value() and Orb:IsHarass()))
                     then
                        local target = Orb:GetTarget(300)
                        if target then
                            Control.CastSpell(HK_W)
                        end
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Jax END

        -- Zac START
        if myHero.charName == "Zac" then
            Menu:Init()

            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = true})
            Menu.q_killsteal = Menu.q:MenuElement({id = "combo", name = "Killsteal", value = true})
            Menu.q_range =
                Menu.q:MenuElement({id = "qrange", name = "Q Range", value = 875, min = 25, max = 950, step = 25})
            Menu.q_hitchance =
                Menu.q:MenuElement(
                {id = "hitchance", name = "Hitchance", value = 2, drop = {"Normal", "High", "Immobile"}}
            )

            Menu.w_combo = Menu.w:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.w_harass = Menu.w:MenuElement({id = "harass", name = "Harass", value = true})
            Menu.w_waveclear = Menu.w:MenuElement({id = "clear", name = "Clear", value = true})
            Menu.w_jungle = Menu.w:MenuElement({id = "clear", name = "Jungle", value = true})
            Menu.e:Remove()

            Menu.r_combo = Menu.r:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.r_combo_targets =
                Menu.r:MenuElement(
                {id = "combotargets", name = "Combo Min Targets", value = 2, min = 1, max = 5, step = 1}
            )
            Menu.r_comborange =
                Menu.r:MenuElement(
                {id = "rcomborange", name = "R Combo Range", value = 325, min = 25, max = 450, step = 25}
            )
            Menu.r_auto = Menu.r:MenuElement({id = "auto", name = "Auto", value = true})
            Menu.r_auto_targets =
                Menu.r:MenuElement(
                {id = "Auto min targets", name = "Auto Min Targets", value = 3, min = 1, max = 5, step = 1}
            )
            Menu.r_autorange =
                Menu.r:MenuElement(
                {id = "rautorange", name = "R Auto Range", value = 325, min = 25, max = 450, step = 25}
            )

            Menu.q_rangedraw = Menu.d:MenuElement({id = "qrangedraw", name = "Q Range", value = true})
            Menu.w_rangedraw = Menu.d:MenuElement({id = "wrangedraw", name = "W Range", value = false})
            Menu.e_rangedraw = Menu.d:MenuElement({id = "erangedraw", name = "E Range", value = true})
            Menu.r_rangedraw = Menu.d:MenuElement({id = "rrangedraw", name = "R Range", value = false})

            local QGGPrediction =
                GGPrediction:SpellPrediction(
                {
                    Delay = 0.25,
                    Radius = 80,
                    Range = 950,
                    Speed = 2800,
                    Type = GGPrediction.SPELLTYPE_LINE,
                    Collision = true,
                    MaxCollision = 0,
                    CollisionTypes = {GGPrediction.COLLISION_MINION, GGPrediction.COLLISION_YASUOWALL}
                }
            )
            local ERanges = {1200, 1350, 1500, 1650, 1800}

            Callback.Add(
                "Tick",
                function()
                    if Champion:MyHeroNotReady() then
                        return
                    end
                    local mode = Orb:GetMode()

                    if Spells:IsReady(_R) then
                        if ((Orb:IsCombo() and Menu.r_combo:Value()) or Menu.r_auto:Value()) then
                            local count = 0
                            local range = Menu.r_comborange:Value()
                            local minTargets = Menu.r_auto_targets:Value()
                            if Orb:IsCombo() and Menu.r_combo:Value() then
                                minTargets = Menu.r_combo_targets:Value()
                                range = Menu.r_autorange:Value()
                            end
                            for i = 1, Game.HeroCount() do
                                local hero = Game.Hero(i)
                                if
                                    hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                        myHero.pos:DistanceTo(hero.pos) <= range
                                 then
                                    count = count + 1
                                end
                            end
                            if count >= minTargets then
                                Control.CastSpell(HK_R)
                                return
                            end
                        end
                    end

                    if Spells:IsReady(_W) then
                        if (Orb:IsCombo() and Menu.w_combo:Value()) or (Orb:IsHarass() and Menu.w_harass:Value()) then
                            local target = Orb:GetTarget(350)
                            if target then
                                Control.CastSpell(HK_W)
                                return
                            end
                        end

                        if mode == "Clear" and (Menu.w_jungle:Value() or Menu.w_waveclear:Value()) then
                            for i = 1, Game.MinionCount() do
                                local minion = Game.Minion(i)
                                if
                                    ((Menu.w_jungle:Value() and minion.team == 300) or
                                        (Menu.w_waveclear:Value() and minion.team == 300 - myHero.team)) and
                                        minion.valid and
                                        minion.alive and
                                        minion.pos:DistanceTo(myHero.pos) <= 350
                                 then
                                    Control.CastSpell(HK_W)
                                    return
                                end
                            end
                        end
                    end

                    if Spells:IsReady(_Q) then
                        if Menu.q_killsteal:Value() then
                            local count = 0
                            for i = 1, Game.HeroCount() do
                                local hero = Game.Hero(i)
                                if
                                    hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                        myHero.pos:DistanceTo(hero.pos) <= (QGGPrediction.Range + 100)
                                 then
                                    local qdamage = getdmg("Q", hero, myHero)
                                    if qdamage >= hero.health + (2 * hero.hpRegen) then
                                        QGGPrediction.Range = 945
                                        QGGPrediction:GetPrediction(hero, myHero)
                                        if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                                            Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                            return
                                        end
                                    end
                                end
                            end
                        end
                        if (Orb:IsCombo() and Menu.q_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value()) then
                            QGGPrediction.Range = Menu.q_range:Value()
                            local target = Orb:GetTarget(QGGPrediction.Range + 50)
                            if target then
                                QGGPrediction:GetPrediction(target, myHero)
                                if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                                    Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                    return
                                end
                            end
                        end
                    end
                end
            )

            Callback.Add(
                "Draw",
                function()
                    if Menu.q_rangedraw:Value() and Spells:IsReady(_Q) then
                        Draw.Circle(myHero.pos, Menu.q_range:Value(), Draw.Color(200, 255, 0, 0))
                    end
                    if Menu.w_rangedraw:Value() and Spells:IsReady(_W) then
                        Draw.Circle(myHero.pos, 350, Draw.Color(200, 0, 255, 0))
                    end
                    if Menu.e_rangedraw:Value() and Spells:IsReady(_E) then
                        local erange = ERanges[myHero:GetSpellData(_E).level]
                        Draw.Circle(myHero.pos, erange, Draw.Color(200, 0, 0, 255))
                    end
                    if Menu.r_rangedraw:Value() and Spells:IsReady(_R) then
                        Draw.Circle(myHero.pos, 300, Draw.Color(200, 255, 255, 255))
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Zac END

        -- Darius START
        if myHero.charName == "Darius" then
            Menu:Init()
            Menu.q:Remove()

            Menu.w_combo = Menu.w:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.w_harass = Menu.w:MenuElement({id = "harass", name = "Harass", value = false})
            Menu.e_combo = Menu.e:MenuElement({id = "ecombo", name = "Combo", value = true})
            Menu.e_harass = Menu.e:MenuElement({id = "eharass", name = "Harass", value = false})
            Menu.r_killsteal = Menu.r:MenuElement({id = "killsteal", name = "Killsteal", value = true})
            local targetsLoaded = false
            DelayAction(
                function()
                    Menu.r_targets = Menu.r:MenuElement({id = "dariusrtargets", name = "Use on: ", type = MENU})
                    for i, target in pairs(Champion:GetEnemies()) do
                        Menu.r_targets:MenuElement(
                            {id = "DariusR_" .. target.charName, name = target.charName, value = true}
                        )
                    end
                    targetsLoaded = true
                end,
                1
            )
            Menu.e_rangedraw = Menu.d:MenuElement({id = "erangedraw", name = "E Range", value = false})
            Menu.r_rangedraw = Menu.d:MenuElement({id = "rrangedraw", name = "R Range", value = false})

            local NextRTime = 0.0

            Callback.Add(
                "Tick",
                function()
                    if targetsLoaded and Game.Timer() > NextRTime and Menu.r_killsteal:Value() and Spells:IsReady(_R) then
                        local count = 0
                        for i = 1, Game.HeroCount() do
                            local hero = Game.Hero(i)
                            if
                                hero and hero.team ~= myHero.team and
                                    Menu.r_targets["DariusR_" .. hero.charName]:Value() and
                                    hero.valid and
                                    hero.alive and
                                    myHero.pos:DistanceTo(hero.pos) <= 500
                             then
                                local rlevel = myHero:GetSpellData(_R).level
                                local rstacks = 0
                                local bleedbuff = _G.SDK.BuffManager:GetBuff(hero, "DariusHemo")
                                if bleedbuff and bleedbuff.count > 0 and bleedbuff.duration > 0 then
                                    rstacks = bleedbuff.count
                                end
                                local rdamage =
                                    (({125, 250, 375})[rlevel] + myHero.bonusDamage * 0.75) * (1 + 0.2 * rstacks)
                                if rdamage > hero.health and not Orb:IsImmortal(hero, false) then
                                    print(
                                        "Casting R on " ..
                                            hero.name ..
                                                " - health: " ..
                                                    string.format("%.0f", hero.health) ..
                                                        " damage: " ..
                                                            string.format("%.0f", rdamage) .. " stacks: " .. rstacks
                                    )
                                    Control.CastSpell(HK_R, hero)
                                    NextRTime = Game.Timer() + 0.5
                                    return
                                end
                            end
                        end
                    end

                    if
                        Spells:IsReady(_E) and
                            ((Orb:IsCombo() and Menu.e_combo:Value()) or (Orb:IsHarass() and Menu.e_harass:Value()))
                     then
                        local target = Orb:GetTarget(535)
                        if target then
                            local distanceToTarget = myHero.pos:DistanceTo(target.pos)
                            if distanceToTarget <= 535 and distanceToTarget >= 325 then
                                Control.CastSpell(HK_E, target)
                                return
                            end
                        end
                    end
                end
            )
            Orb:OnPostAttack(
                function()
                    if
                        Spells:IsReady(_W) and
                            ((Orb:IsCombo() and Menu.w_combo:Value()) or (Orb:IsHarass() and Menu.w_harass:Value()))
                     then
                        local target = Orb:GetTarget(325)
                        if target then
                            Control.CastSpell(HK_W)
                        end
                    end
                end
            )

            Callback.Add(
                "Draw",
                function()
                    local ERange = 475
                    local RRange = 475
                    if Menu.e_rangedraw:Value() and Spells:IsReady(_E) then
                        Draw.Circle(myHero.pos, RRange, Draw.Color(200, 255, 0, 0))
                    end
                    if Menu.r_rangedraw:Value() and Spells:IsReady(_R) then
                        Draw.Circle(myHero.pos, RRange, Draw.Color(200, 255, 255, 255))
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Darius END

        -- Rumble START
        if myHero.charName == "Rumble" then
            Menu:Init()

            Menu.e_combo = Menu.e:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.e_harass = Menu.e:MenuElement({id = "harass", name = "Harass", value = false})
            Menu.e_killsteal = Menu.e:MenuElement({id = "combo", name = "Killsteal", value = true})
            Menu.e_range =
                Menu.e:MenuElement({id = "erange", name = "E Range", value = 925, min = 25, max = 950, step = 25})
            Menu.e_hitchance =
                Menu.e:MenuElement(
                {id = "hitchance", name = "Hitchance", value = 1, drop = {"Normal", "High", "Immobile"}}
            )

            Menu.q:Remove()
            Menu.w:Remove()
            Menu.r:Remove()

            Menu.e_rangedraw = Menu.d:MenuElement({id = "erangedraw", name = "E Range", value = true})

            local EGGPrediction =
                GGPrediction:SpellPrediction(
                {
                    Delay = 0.25,
                    Radius = 60,
                    Range = 925,
                    Speed = 2000,
                    Type = GGPrediction.SPELLTYPE_LINE,
                    Collision = true,
                    MaxCollision = 0,
                    CollisionTypes = {GGPrediction.COLLISION_MINION, GGPrediction.COLLISION_YASUOWALL}
                }
            )

            Callback.Add(
                "Tick",
                function()
                    if Champion:MyHeroNotReady() then
                        return
                    end
                    local mode = Orb:GetMode()

                    if Spells:IsReady(_E) then
                        if Menu.e_killsteal:Value() then
                            local count = 0
                            for i = 1, Game.HeroCount() do
                                local hero = Game.Hero(i)
                                if
                                    hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                        myHero.pos:DistanceTo(hero.pos) <= 950
                                 then
                                    local edamage = getdmg("E", hero, myHero)
                                    if edamage > hero.health + (2 * hero.hpRegen) and not Orb:IsImmortal(hero, false) then
                                        EGGPrediction.Range = Menu.e_range:Value()
                                        EGGPrediction:GetPrediction(hero, myHero)
                                        if EGGPrediction:CanHit(Menu.e_hitchance:Value() + 1) then
                                            Control.CastSpell(HK_E, EGGPrediction.CastPosition)
                                            return
                                        end
                                    end
                                end
                            end
                        end
                        if (Orb:IsCombo() and Menu.e_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value()) then
                            EGGPrediction.Range = Menu.e_range:Value()
                            local target = Orb:GetTarget(EGGPrediction.Range)
                            if target then
                                EGGPrediction:GetPrediction(target, myHero)
                                if EGGPrediction:CanHit(Menu.e_hitchance:Value() + 1) then
                                    Control.CastSpell(HK_E, EGGPrediction.CastPosition)
                                    return
                                end
                            end
                        end
                    end
                end
            )

            Callback.Add(
                "Draw",
                function()
                    if Menu.e_rangedraw:Value() and Spells:IsReady(_E) then
                        Draw.Circle(myHero.pos, Menu.e_range:Value(), Draw.Color(255, 255, 255, 100))
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Rumble END

        -- Kennen START
        if myHero.charName == "Kennen" then
            Menu:Init()

            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = false})
            Menu.q_killsteal = Menu.q:MenuElement({id = "combo", name = "Killsteal", value = true})
            Menu.q_range =
                Menu.q:MenuElement({id = "qrange", name = "Q Range", value = 975, min = 25, max = 1050, step = 25})
            Menu.q_hitchance =
                Menu.q:MenuElement(
                {id = "hitchance", name = "Hitchance", value = 1, drop = {"Normal", "High", "Immobile"}}
            )

            Menu.w:Remove()
            Menu.e:Remove()
            Menu.r:Remove()

            Menu.q_rangedraw = Menu.d:MenuElement({id = "qrangedraw", name = "Q Range", value = true})

            local QGGPrediction =
                GGPrediction:SpellPrediction(
                {
                    Delay = 0.25,
                    Radius = 50,
                    Range = 1050,
                    Speed = 1700,
                    Type = GGPrediction.SPELLTYPq_LINE,
                    Collision = true,
                    MaxCollision = 0,
                    CollisionTypes = {GGPrediction.COLLISION_MINION, GGPrediction.COLLISION_YASUOWALL}
                }
            )

            Callback.Add(
                "Tick",
                function()
                    if Champion:MyHeroNotReady() then
                        return
                    end
                    local mode = Orb:GetMode()

                    if Spells:IsReady(_Q) then
                        if Menu.q_killsteal:Value() then
                            local count = 0
                            for i = 1, Game.HeroCount() do
                                local hero = Game.Hero(i)
                                if
                                    hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                        myHero.pos:DistanceTo(hero.pos) <= 1050
                                 then
                                    local qdamage = getdmg("Q", hero, myHero)
                                    if qdamage > hero.health + (2 * hero.hpRegen) and not Orb:IsImmortal(hero, false) then
                                        QGGPrediction.Range = Menu.q_range:Value()
                                        QGGPrediction:GetPrediction(hero, myHero)
                                        if EGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                                            Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                            return
                                        end
                                    end
                                end
                            end
                        end
                        if (Orb:IsCombo() and Menu.q_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value()) then
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
                end
            )

            Callback.Add(
                "Draw",
                function()
                    if Menu.q_rangedraw:Value() and Spells:IsReady(_Q) then
                        Draw.Circle(myHero.pos, Menu.q_range:Value(), Draw.Color(255, 255, 255, 100))
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Rumble END

        -- Blitzcrank START
        if myHero.charName == "Blitzcrank" then
            Menu:Init()

            Menu.q_combo = Menu.q:MenuElement({id = "combo", name = "Combo", value = true})
            Menu.q_harass = Menu.q:MenuElement({id = "harass", name = "Harass", value = false})
            Menu.q_killsteal = Menu.q:MenuElement({id = "combo", name = "Killsteal", value = true})
            Menu.q_range =
                Menu.q:MenuElement({id = "qrange", name = "Q Range", value = 1000, min = 25, max = 1100, step = 25})
            Menu.q_hitchance =
                Menu.q:MenuElement(
                {id = "hitchance", name = "Hitchance", value = 1, drop = {"Normal", "High", "Immobile"}}
            )
            Menu.w:Remove()
            Menu.e_combo = Menu.e:MenuElement({id = "ecombo", name = "Combo", value = true})
            Menu.e_harass = Menu.e:MenuElement({id = "eharass", name = "Harass", value = false})
            Menu.r:Remove()

            Menu.q_rangedraw = Menu.d:MenuElement({id = "qrangedraw", name = "Q Range", value = true})

            local QGGPrediction =
                GGPrediction:SpellPrediction(
                {
                    Delay = 0.25,
                    Radius = 70,
                    Range = 1100,
                    Speed = 1800,
                    Type = GGPrediction.SPELLTYPE_LINE,
                    Collision = true,
                    MaxCollision = 0,
                    CollisionTypes = {GGPrediction.COLLISION_MINION, GGPrediction.COLLISION_YASUOWALL}
                }
            )

            local NextQCast = 0
            local NextECast = 0

            Callback.Add(
                "Tick",
                function()
                    if Champion:MyHeroNotReady() then
                        return
                    end
                    local mode = Orb:GetMode()

                    if Game.Timer() > NextQCast and Spells:IsReady(_Q) then
                        if Menu.q_killsteal:Value() then
                            local count = 0
                            for i = 1, Game.HeroCount() do
                                local hero = Game.Hero(i)
                                if
                                    hero and hero.team ~= myHero.team and hero.valid and hero.alive and
                                        myHero.pos:DistanceTo(hero.pos) <= 1050
                                 then
                                    local qdamage = getdmg("Q", hero, myHero)
                                    if qdamage > hero.health + (2 * hero.hpRegen) then
                                        QGGPrediction.Range = 1050
                                        QGGPrediction:GetPrediction(hero, myHero)
                                        if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                                            Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                            NextQCast = Game.Timer() + 1.0
                                            return
                                        end
                                    end
                                end
                            end
                        end
                        if (Orb:IsCombo() and Menu.q_combo:Value()) or (Orb:IsHarass() and Menu.q_harass:Value()) then
                            QGGPrediction.Range = Menu.q_range:Value()
                            local target = Orb:GetTarget(QGGPrediction.Range)
                            if target then
                                QGGPrediction:GetPrediction(target, myHero)
                                if QGGPrediction:CanHit(Menu.q_hitchance:Value() + 1) then
                                    Control.CastSpell(HK_Q, QGGPrediction.CastPosition)
                                    NextQCast = Game.Timer() + 1.0
                                    return
                                end
                            end
                        end
                    end
                end
            )

            Orb:OnPreAttack(
                function()
                    if
                        Game.Timer() > NextECast and Spells:IsReady(_E) and
                            ((Orb:IsCombo() and Menu.e_combo:Value()) or (Orb:IsHarass() and Menu.e_harass:Value()))
                     then
                        local target = Orb:GetTarget(325)
                        if target then
                            Control.CastSpell(HK_E)
                            NextEast = Game.Timer() + 1.0
                        end
                    end
                end
            )

            Callback.Add(
                "Draw",
                function()
                    if Menu.q_rangedraw:Value() and Spells:IsReady(_Q) then
                        Draw.Circle(myHero.pos, Menu.q_range:Value(), Draw.Color(255, 255, 255, 100))
                    end
                end
            )

            print("Sussy " .. myHero.charName .. " loaded.")
        end
        -- Blitzcrank END
    end
end
