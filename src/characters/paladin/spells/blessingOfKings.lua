---@author meiso

function Paladin.RemoveBlessingOfKings(unit, stat)
    if BuffSystem.IsBuffOnHero(unit, Spells.paladin.blessing_of_kings) then
        unit:AddStr(-stat[1])
        unit:AddAgi(-stat[2])
        unit:AddInt(-stat[3])
        BuffSystem.RemoveBuffFromHero(unit, Spells.paladin.blessing_of_kings)
    end
end

function Paladin.BlessingOfKings()
    BuffSystem.logger:Info("Blessing of kings...")
    local unit = Unit(GetSpellTargetUnit())
    local timer = Timer(600.)
    BuffSystem.RegisterHero(unit)

    if BuffSystem.IsBuffOnHero(unit, Spells.paladin.blessing_of_kings) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, Spells.paladin.blessing_of_kings)
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
    BuffSystem.AddBuffToHero(unit, Spells.paladin.blessing_of_kings, remove_buff)
    timer:SetFunc(remove_buff)
    timer:Start()
    BuffSystem.logger:Info("...cast!")
end

function Paladin.IsBlessingOfKings()
    return Spells.paladin.blessing_of_kings:SpellCasted()
end

function Paladin.InitBlessingOfKings(player)
    local event = EventsPlayer(player)
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsBlessingOfKings)
    event:AddAction(Paladin.BlessingOfKings)
end
