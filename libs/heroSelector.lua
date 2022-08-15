
HeroSelector = {
    table = nil,
    paladin_btn = nil
}

function HeroSelector.Init()
    HeroSelector.table = Frame("HeroSelector", Frame:GetOriginFrame())
    HeroSelector.InitPaladinSelector()
    HeroSelector.table:SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.3)

    --HeroSelector.Close()
end

function HeroSelector.InitPaladinSelector()
    HeroSelector.paladin_btn = Frame(Frame:GetFrameByName("PaladinButton"))
    local tooltip = Frame("PaladinTooltip", HeroSelector.paladin_btn:GetHandle())
    HeroSelector.paladin_btn:SetTooltip(tooltip)
    tooltip:SetAbsPoint(FRAMEPOINT_CENTER, 0.3, 0.4)
end

function HeroSelector.Close()
    HeroSelector.table:Destroy()
end
