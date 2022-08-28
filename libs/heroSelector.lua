
HeroSelector = {
    table = nil,
    paladin = nil,
    selected = nil,
}

function HeroSelector.Init()
    HeroSelector.table = Frame("HeroSelector")
    HeroSelector.table:SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.3)

    HeroSelector.InitPaladinSelector()

    HeroSelector.CreateDialog()

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

    --local character = split(HeroSelector.paladin:GetName(), "_")[1]
    --print(character:lower())
end

function HeroSelector.CreateDialog()
    local dialog = EventsFrame(HeroSelector.paladin:GetHandle())
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
                HeroSelector.Close()
            end
            confirm:Destroy()
        end)
    end)
end

function HeroSelector.Close()
    HeroSelector.table:Destroy()
end
