
function Paladin.RemoveJudgementOfWisdom(target, timer)
    if BuffSystem.IsBuffOnHero(target, JUDGEMENT_OF_WISDOM) then
        UnitRemoveAbilityBJ(JUDGEMENT_OF_WISDOM_BUFF, target)
        BuffSystem.RemoveBuffToHero(target, JUDGEMENT_OF_WISDOM)
    end
    DestroyTimer(timer)
end

function Paladin.JudgementOfWisdom()
    if GetRandomReal(0., 1.) <= 0.7 then
        Paladin.hero:GainMana{percent=2}
        TextTag(Paladin.hero:GetPercentManaOfMax(2), Paladin.hero):Preset("mana")
    end
end

function Paladin.IsJudgementOfWisdomDebuff()
    return GetUnitAbilityLevel(GetEventDamageSource(), JUDGEMENT_OF_WISDOM_BUFF) > 0
end

function Paladin.CastJudgementOfWisdom()
    local target = GetSpellTargetUnit()
    BuffSystem.RegisterHero(target)
    if BuffSystem.IsBuffOnHero(target, JUDGEMENT_OF_WISDOM) then
        BuffSystem.RemoveBuffToHeroByFunc(target, JUDGEMENT_OF_WISDOM)
    end

    local jow_unit = Unit(GetTriggerPlayer(), DUMMY, Paladin.hero:GetLoc())
    jow_unit:AddAbilities(JUDGEMENT_OF_WISDOM)
    jow_unit:CastToTarget("shadowstrike", target)

    local timer = CreateTimer()
    local remove_buff = function() Paladin.RemoveJudgementOfWisdom(target, timer) end

    BuffSystem.AddBuffToHero(target, JUDGEMENT_OF_WISDOM, remove_buff)
    TimerStart(timer, 20., false, remove_buff)
    jow_unit:ApplyTimedLife(2.)
end

function Paladin.IsJudgementOfWisdom()
    return GetSpellAbilityId() == JUDGEMENT_OF_WISDOM_TR
end

function Paladin.InitJudgementOfWisdom()
    Ability(
            JUDGEMENT_OF_WISDOM_TR,
            "Правосудие мудрости (F)",
            "Высвобождает энергию печати и обрушивает ее на противника, после чего в течение 20 сек. " ..
            "после чего каждая атака против него может восстановить 2%% базового запаса маны атакующего."
    )
    Paladin.hero:SetAbilityManacost(JUDGEMENT_OF_WISDOM_TR, 5)
    Paladin.hero:SetAbilityCooldown(JUDGEMENT_OF_WISDOM_TR, 10.)

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