
HeroSelector = {
    table = nil,
    paladin_btn = nil
}

function HeroSelector.Init()
    HeroSelector.table = Frame("HeroSelector", Frame:GetOriginFrame())
    HeroSelector.paladin_btn = Frame(Frame:GetFrameByName("PaladinButton"))
    HeroSelector.table:SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.3)

    --HeroSelector.Close()
end

function HeroSelector.Close()
    HeroSelector.table:Destroy()
end
