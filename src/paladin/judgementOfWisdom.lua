---@author meiso

function Paladin.RemoveJudgementOfWisdom(target)
    if BuffSystem.IsBuffOnHero(target, judgement_of_wisdom_tr) then
        UnitRemoveAbilityBJ(JUDGEMENT_OF_WISDOM_BUFF, target)
        BuffSystem.RemoveBuffFromHero(target, judgement_of_wisdom_tr)
    end
end

function Paladin.JudgementOfWisdom()
    if GetRandomReal(0., 1.) <= 0.7 then
        Paladin.hero:GainMana { percent = 2 }
        TextTag(Paladin.hero:GetPercentManaOfMax(2), Paladin.hero):Preset("mana")
    end
end

function Paladin.IsJudgementOfWisdomDebuff()
    return Unit(GetEventDamageSource()):HasBuff(JUDGEMENT_OF_WISDOM_BUFF)
end

function Paladin.CastJudgementOfWisdom()
    local target = GetSpellTargetUnit()
    local model = "judgement_impact_chest_blue.mdl"
    local effect = Effect(target, model, "overhead")
    local timer = Timer(20.)

    BuffSystem.RegisterHero(target)
    if BuffSystem.IsBuffOnHero(target, judgement_of_wisdom_tr) then
        BuffSystem.RemoveBuffFromHeroByFunc(target, judgement_of_wisdom_tr)
    end

    local jow_unit = Unit(GetTriggerPlayer(), DUMMY, Paladin.hero:GetLoc())
    jow_unit:AddAbilities(JUDGEMENT_OF_WISDOM)
    jow_unit:CastToTarget("shadowstrike", target)

    local remove_buff = function()
        Paladin.RemoveJudgementOfWisdom(target)
        timer:Destroy()
    end

    BuffSystem.AddBuffToHero(target, judgement_of_wisdom_tr, remove_buff)
    timer:SetFunc(remove_buff)
    timer:Start()
    jow_unit:ApplyTimedLife(2.)
    effect:Destroy()
end

function Paladin.IsJudgementOfWisdom()
    return judgement_of_wisdom_tr:SpellCasted()
end

function Paladin.InitJudgementOfWisdom()
    judgement_of_wisdom_tr:Init()

    local event_ability = EventsPlayer()
    local event_jow = EventsPlayer()

    --событие того, что персонаж использовал способность
    event_ability:RegisterUnitSpellCast()
    event_ability:AddCondition(Paladin.IsJudgementOfWisdom)
    event_ability:AddAction(Paladin.CastJudgementOfWisdom)

    --событие того, персонаж бьёт юнита с дебафом
    event_jow:RegisterUnitDamaging()
    event_jow:AddCondition(Paladin.IsJudgementOfWisdomDebuff)
    event_jow:AddAction(Paladin.JudgementOfWisdom)
end
