---@author meiso

function Paladin.RemoveJudgementOfLight(target)
    if BuffSystem.IsBuffOnHero(target, judgement_of_light_tr) then
        UnitRemoveAbilityBJ(JUDGEMENT_OF_LIGHT_BUFF, target)
        BuffSystem.RemoveBuffFromHero(target, judgement_of_light_tr)
    end
end

function Paladin.JudgementOfLight()
    if GetRandomReal(0., 1.) <= 0.7 then
        Paladin.hero:GainLife { percent = 2, show = true }
        TextTag(Paladin.hero:GetPercentLifeOfMax(2), Paladin.hero):Preset("heal")
    end
end

function Paladin.IsJudgementOfLightDebuff()
    return Unit(GetEventDamageSource()):HasBuff(JUDGEMENT_OF_LIGHT_BUFF)
end

function Paladin.CastJudgementOfLight()
    local target = GetSpellTargetUnit()
    local model = "judgement_impact_chest.mdl"
    local effect = Effect(target, model, "overhead")
    local timer = Timer(20.)

    BuffSystem.RegisterHero(target)
    --создаем юнита и выдаем ему основную способность
    --и бьем по таргету паладина
    if BuffSystem.IsBuffOnHero(target, judgement_of_light_tr) then
        BuffSystem.RemoveBuffFromHeroByFunc(target, judgement_of_light_tr)
    end

    local jol_unit = Unit(GetTriggerPlayer(), DUMMY, Paladin.hero:GetLoc())
    jol_unit:AddAbilities(JUDGEMENT_OF_LIGHT)
    jol_unit:CastToTarget("shadowstrike", target)

    local remove_buff = function()
        Paladin.RemoveJudgementOfLight(target)
        timer:Destroy()
    end

    BuffSystem.AddBuffToHero(target, judgement_of_light_tr, remove_buff)
    timer:SetFunc(remove_buff)
    timer:Start()
    jol_unit:ApplyTimedLife(2.)
    effect:Destroy()
end

function Paladin.IsJudgementOfLight()
    return judgement_of_light_tr:SpellCasted()
end

function Paladin.InitJudgementOfLight()
    local event_ability = EventsPlayer()
    local event_jol = EventsPlayer()

    --персонаж использовал способность
    event_ability:RegisterUnitSpellCast()
    event_ability:AddCondition(Paladin.IsJudgementOfLight)
    event_ability:AddAction(Paladin.CastJudgementOfLight)

    --персонаж бьёт юнита с дебафом
    event_jol:RegisterUnitDamaging()
    event_jol:AddCondition(Paladin.IsJudgementOfLightDebuff)
    event_jol:AddAction(Paladin.JudgementOfLight)
end
