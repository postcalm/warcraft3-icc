---@author meiso

function HeroSelector.Init()
    HeroSelector.table = Frame("HeroSelector")
    HeroSelector.table:SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.3)

    HeroSelector.InitPaladinSelector()
    HeroSelector.InitPriestSelector()
    HeroSelector.InitDKSelector()
    HeroSelector.InitDruidSelector()
    HeroSelector.InitShamanSelector()
    HeroSelector.InitWarriorSelector()
    HeroSelector.InitMageSelector()
    HeroSelector.InitRogueSelector()
    HeroSelector.InitWarlockSelector()
    HeroSelector.InitHunterSelector()
end

function HeroSelector.InitPaladinSelector()
    HeroSelector.paladin = Frame(Frame:GetFrameByName("Paladin_Button"))
    HeroSelector.paladin:SetTooltip(paladin_tooltip, paladin_text)
    HeroSelector.ConfirmCharacter(HeroSelector.paladin)
end

function HeroSelector.InitPriestSelector()
    HeroSelector.priest = Frame(Frame:GetFrameByName("Priest_Button"))
    HeroSelector.priest:SetTooltip(priest_tooltip, priest_text)
    HeroSelector.ConfirmCharacter(HeroSelector.priest)
end

function HeroSelector.InitDKSelector()
    HeroSelector.dk = Frame(Frame:GetFrameByName("DeathKnight_Button"))
    HeroSelector.dk:SetTooltip(deathknight_tooltip, deathknight_text)
    HeroSelector.dk:Hide()
    HeroSelector.ConfirmCharacter(HeroSelector.dk)
end

function HeroSelector.InitDruidSelector()
    HeroSelector.druid = Frame(Frame:GetFrameByName("Druid_Button"))
    HeroSelector.druid:SetTooltip(druid_tooltip, druid_text)
    HeroSelector.druid:Hide()
    HeroSelector.ConfirmCharacter(HeroSelector.druid)
end

function HeroSelector.InitShamanSelector()
    HeroSelector.shaman = Frame(Frame:GetFrameByName("Shaman_Button"))
    HeroSelector.shaman:SetTooltip(shaman_tooltip, shaman_text)
    HeroSelector.shaman:Hide()
    HeroSelector.ConfirmCharacter(HeroSelector.shaman)
end

function HeroSelector.InitWarriorSelector()
    HeroSelector.warrior = Frame(Frame:GetFrameByName("Warrior_Button"))
    HeroSelector.warrior:SetTooltip(warrior_tooltip, warrior_text)
    HeroSelector.warrior:Hide()
    HeroSelector.ConfirmCharacter(HeroSelector.warrior)
end

function HeroSelector.InitMageSelector()
    HeroSelector.mage = Frame(Frame:GetFrameByName("Mage_Button"))
    HeroSelector.mage:SetTooltip(mage_tooltip, mage_text)
    HeroSelector.mage:Hide()
    HeroSelector.ConfirmCharacter(HeroSelector.mage)
end

function HeroSelector.InitRogueSelector()
    HeroSelector.rogue = Frame(Frame:GetFrameByName("Rogue_Button"))
    HeroSelector.rogue:SetTooltip(rogue_tooltip, rogue_text)
    HeroSelector.rogue:Hide()
    HeroSelector.ConfirmCharacter(HeroSelector.rogue)
end

function HeroSelector.InitWarlockSelector()
    HeroSelector.warlock = Frame(Frame:GetFrameByName("Warlock_Button"))
    HeroSelector.warlock:SetTooltip(warlock_tooltip, warlock_text)
    HeroSelector.warlock:Hide()
    HeroSelector.ConfirmCharacter(HeroSelector.warlock)
end

function HeroSelector.InitHunterSelector()
    HeroSelector.hunter = Frame(Frame:GetFrameByName("Hunter_Button"))
    HeroSelector.hunter:SetTooltip(hunter_tooltip, hunter_text)
    HeroSelector.hunter:Hide()
    HeroSelector.ConfirmCharacter(HeroSelector.hunter)
end

function HeroSelector.ConfirmCharacter(hero)
    local dialog = EventsFrame(hero:GetHandle())
    dialog:RegisterControlClick()
    dialog:AddAction(function()
        local confirm = Frame("ConfirmCharacter")
        local trig = EventsFrame(confirm:GetHandle())
        trig:RegisterDialogAccept()
        trig:RegisterDialogCancel()
        trig:AddAction(function()
            if dialog:GetEvent() == FRAMEEVENT_DIALOG_ACCEPT then
                dialog:Destroy()
                local naming = Frame("NameSetter")
                local name = Frame(Frame:GetFrameByName("EditBoxText"))
                naming:SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.3)
                naming:SetSize(0.2, 0.03)
                local n_trig = EventsFrame(naming:GetHandle())
                n_trig:RegisterEditBoxEnter()
                n_trig:AddAction(function()
                    local tmp = split(hero:GetName(), "_")[1]
                    HeroSelector.hero = tmp:lower()
                    HeroSelector.AcceptHero(HeroSelector.hero, name:GetTriggerText())
                    naming:Destroy()
                    HeroSelector.Close()
                end)
            end
            confirm:Destroy()
        end)
    end)
end

function HeroSelector.CreateHero()
    local playerid = GetConvertedPlayerId(GetTriggerPlayer())
    local unit = Unit(GetTriggerPlayer(), HEROES[HeroSelector.hero], Location(-60., -750.))
    SaveSystem.hero[playerid] = unit:GetId()
    SaveSystem.InitHero(HeroSelector.hero)
end

function HeroSelector.AcceptHero(hero, name)
    local function check()
        for _, h in pairs(HeroSelector.selected_heroes) do
            if h == hero then
                return true
            end
        end
        return false
    end
    if check() then
        return
    end
    table.insert(HeroSelector.selected_heroes, hero)
    --HeroSelector.CreateHero()
    SaveSystem.InitHero(HeroSelector.hero, name)
end

function HeroSelector.Close()
    HeroSelector.table:Destroy()
end
