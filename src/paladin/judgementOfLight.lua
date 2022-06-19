
function Paladin.RemoveJudgementOfLight(target)
    UnitRemoveAbilityBJ(JUDGEMENT_OF_LIGHT_BUFF, target)
    BuffSystem.RemoveBuffToHero(target, "JudgementOfLight")
end

function Paladin.JudgementOfLight()
    if GetRandomReal(0., 1.) <= 0.7  then
        Paladin.hero:GainLife{percent=2}
        TextTag(Paladin.hero:GetPercentLifeOfMax(2), Paladin.hero):Preset("heal")
    end
end

function Paladin.IsJudgementOfLightDebuff()
    return GetUnitAbilityLevel(GetEventDamageSource(), JUDGEMENT_OF_LIGHT_BUFF) > 0
end

function Paladin.CastJudgementOfLight()
    Paladin.hero:LoseMana{percent=5}
    local target = GetSpellTargetUnit()
    BuffSystem.RegisterHero(target)
    --создаем юнита и выдаем ему основную способность
    --и бьем по таргету паладина
    if not BuffSystem.IsBuffOnHero(target, "JudgementOfLight") then
        local jol_unit = Unit(GetTriggerPlayer(), DUMMY, Paladin.hero:GetLoc())
        jol_unit:AddAbilities(JUDGEMENT_OF_LIGHT)
        jol_unit:CastToTarget("shadowstrike", target)
        local remove_buff = function() Paladin.RemoveJudgementOfLight(target) end
        BuffSystem.AddBuffToHero(target, "JudgementOfLight", remove_buff)
        jol_unit:ApplyTimedLife(2.)
    end
end

function Paladin.IsJudgementOfLight()
    return GetSpellAbilityId() == JUDGEMENT_OF_LIGHT_TR
end

function Paladin.InitJudgementOfLight()
    local event_ability = EventsPlayer()
    local event_jol = EventsPlayer()

    --событие того, что персонаж использовал способность
    event_ability:RegisterUnitSpellCast()
    event_ability:AddCondition(Paladin.IsJudgementOfLight)
    event_ability:AddAction(Paladin.CastJudgementOfLight)

    --событие того, что персонаж бьёт юнита с дебафом
    event_jol:RegisterUnitDamaging()
    event_jol:AddCondition(Paladin.IsJudgementOfLightDebuff)
    event_jol:AddAction(Paladin.JudgementOfLight)
end