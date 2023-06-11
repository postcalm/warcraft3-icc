---@author meiso

function Paladin.RemoveBlessingOfKings(unit, stat)
    if BuffSystem.IsBuffOnHero(unit, blessing_of_kings) then
        unit:AddStr(-stat[1])
        unit:AddAgi(-stat[2])
        unit:AddInt(-stat[3])
        BuffSystem.RemoveBuffFromHero(unit, blessing_of_kings)
    end
end

function Paladin.BlessingOfKings()
    local unit = Unit(GetSpellTargetUnit())
    local timer = Timer(600.)
    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, blessing_of_kings) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, blessing_of_kings)
    end

    --массив с доп. статами
    local stat = {
        R2I(unit:GetStr() * 0.1),
        R2I(unit:GetAgi() * 0.1),
        R2I(unit:GetInt() * 0.1),
    }
    --бафаем цель
    unit:AddStr(stat[1])
    unit:AddAgi(stat[2])
    unit:AddInt(stat[3])

    local remove_buff = function()
        Paladin.RemoveBlessingOfKings(unit, stat)
        timer:Destroy()
    end
    BuffSystem.AddBuffToHero(unit, blessing_of_kings, remove_buff)
    timer:SetFunc(remove_buff)
    timer:Start()
end

function Paladin.IsBlessingOfKings()
    return blessing_of_kings:SpellCasted()
end

function Paladin.InitBlessingOfKings()
    blessing_of_kings:Init()
    Paladin.hero:SetAbilityManacost(blessing_of_kings:GetId(), 6)
    Paladin.hero:SetAbilityCooldown(blessing_of_kings:GetId(), 1.5)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfKings)
    event:AddAction(Paladin.BlessingOfKings)
end
