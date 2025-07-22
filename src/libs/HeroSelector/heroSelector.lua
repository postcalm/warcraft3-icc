---@author meiso

function HeroSelector.Init()
    HeroSelector.logger:Info("Initialize HeroSelector")
    HeroSelector.cache = GameCache("heroslt")
    HeroSelector.table = Frame("HeroSelector")
    HeroSelector.table:SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.3)

    HeroSelector.InitFrameSelector()
end

function HeroSelector.InitFrameSelector()
    for _, item in pairs(HeroSelectorClassDesc) do
        local frame = Frame(Frame:GetFrameByName(item.frame_name))
        frame:SetTooltip(item.tooltip, item.text)
        if item.hide then
            frame:Hide()
        end
        HeroSelector.ConfirmCharacter(frame)
        table.insert(HeroSelector.all_frames, frame)
    end
end

--- Позывает окно подтверждения выбора
---@param hero Frame Фрейм выбранного героя
---@return nil
function HeroSelector.ConfirmCharacter(frame_hero)
    local dialog = EventsFrame(frame_hero:GetHandle())

    local process = function()
        local confirm = Frame("ConfirmCharacter")
        local trig = EventsFrame(confirm:GetHandle())
        trig:RegisterDialogAccept()
        trig:RegisterDialogCancel()
        trig:AddAction(function()
            if dialog:GetEvent() == FRAMEEVENT_DIALOG_ACCEPT then
                dialog:Destroy()
                HeroSelector.table:Hide()
                local naming = Frame("NameSetter")
                local name = Frame(Frame:GetFrameByName("EditBoxText"))
                naming:SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.3)
                naming:SetSize(0.2, 0.03)
                local n_trig = EventsFrame(naming:GetHandle())
                n_trig:RegisterEditBoxEnter()
                n_trig:AddAction(function()
                    HeroSelector.logger:Info("Is local player:", isLocalPlayer())
                    local tmp = split(frame_hero:GetName(), "_")[1]
                    HeroSelector.hero = tmp:lower()
                    HeroSelector.AcceptHero(HeroSelector.hero, name:GetTriggerText())
                    naming:Destroy()
                    HeroSelector.Close()
                end)
            end
            confirm:Destroy()
        end)
    end

    dialog:RegisterControlClick()
    dialog:AddAction(process)
end

function HeroSelector.CreateHero()
    local playerid = GetConvertedPlayerId(GetTriggerPlayer())
    local unit = Unit(GetTriggerPlayer(), HEROES[HeroSelector.hero], Location(-60., -750.))
    SaveSystem.hero[playerid] = unit:GetId()
    SaveSystem.InitHero(HeroSelector.hero)
end

--- Подтверждение выбранного героя
---@param hero string Название выбранного героя (класс)
---@param name string Имя героя
---@return nil
function HeroSelector.AcceptHero(hero, name)
    local player = GetTriggerPlayer()
    local function check()
        for _, h in pairs(HeroSelector.selected_heroes) do
            if h == hero then
                return true
            end
        end
        return false
    end
    local gc_selected = HeroSelector.cache:GetStr("hero", "hc")
    if gc_selected ~= "" then
        table.insert(HeroSelector.selected_heroes, gc_selected)
    end
    if check() then
        HeroSelector.logger:Warning(hero, "is selected")
        return
    end
    table.insert(HeroSelector.selected_heroes, hero)
    HeroSelector.cache:StoreStr(hero, "hero", "hc", true)
    Session.selected_class[player] = hero
    SaveSystem.InitHero(HeroSelector.hero, name, player)
    if HeroSelector.units[player] == nil then
        HeroSelector.units[player] = SaveSystem.player_unit
        Movement.Init(HeroSelector.units[player], player)
    end
    HeroSelector.Close()
end

function HeroSelector.Close()
    if not isLocalPlayer() then
        return
    end
    if HeroSelector.table ~= nil then
        for _, frame in pairs(HeroSelector.all_frames) do
            frame:Destroy()
        end
        HeroSelector.table:Destroy()
    end
end
