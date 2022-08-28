
HeroSelector = {
    table = nil,
    paladin = nil,
    priest = nil,
    hero = nil,
}

function HeroSelector.Init()
    HeroSelector.table = Frame("HeroSelector")
    HeroSelector.table:SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.3)

    HeroSelector.InitPaladinSelector()
    HeroSelector.InitPriestSelector()
end

function HeroSelector.InitPaladinSelector()
    HeroSelector.paladin = Frame(Frame:GetFrameByName("Paladin_Button"))
    local tooltip_title = "Паладин"
    --TODO: поправить описание
    --TODO: вынести куда-нить
    local tooltip_context = "Паладины бьются с врагом лицом к лицу, "..
            "полагаясь на тяжелые доспехи и навыки целительства. "..
            "Прочный щит или двуручное оружие — не столь важно, чем владеет паладин. "..
            "Он сумеет не только защитить соратников от вражеских когтей и клинков, "..
            "но и удержит группу на ногах при помощи исцеляющих заклинаний."
    HeroSelector.paladin:SetTooltip(tooltip_title, tooltip_context)
    HeroSelector.CreateDialog(HeroSelector.paladin)
end

function HeroSelector.InitPriestSelector()
    HeroSelector.priest = Frame(Frame:GetFrameByName("Priest_Button"))
    local tooltip_title = "Жрец"
    local tooltip_context = "Жрецы могут задействовать мощную целительную магию, "..
            "чтобы спасти себя и своих спутников. Им подвластны и сильные "..
            "атакующие заклинания, но физическая слабость и отсутствие прочных "..
            "доспехов заставляют жрецов бояться сближения с противником. "..
            "Опытные жрецы используют боевые и контролирующие способности, "..
            "не допуская гибели членов отряда."
    HeroSelector.priest:SetTooltip(tooltip_title, tooltip_context)
    HeroSelector.CreateDialog(HeroSelector.priest)
end

function HeroSelector.CreateDialog(hero)
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
                print(GetTriggerPlayer())
                print(GetLocalPlayer())
                HeroSelector.hero = split(hero:GetName(), "_")[1]
                HeroSelector.hero = HeroSelector.hero:lower()
                print(HeroSelector.hero)
                HeroSelector.CreateHero()
                HeroSelector.Close()
            end
            confirm:Destroy()
        end)
    end)
end

function HeroSelector.CreateHero()
    local playerid = GetConvertedPlayerId(GetTriggerPlayer())
    local unit = Unit(GetTriggerPlayer(), HEROES[HeroSelector.hero], Location(-60., -750.))
    udg_My_hero[playerid] = unit:GetId()
    SaveSystem.AddHeroAbilities(HeroSelector.hero)
end

function HeroSelector.Close()
    HeroSelector.table:Destroy()
end
