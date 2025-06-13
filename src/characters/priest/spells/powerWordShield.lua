---@author meiso

function Priest.RemovePowerWordShield(unit)
    if BuffSystem.IsBuffOnHero(unit, Spells.paladin.power_word_shield) then
        BuffSystem.RemoveBuffFromHero(unit, Spells.paladin.power_word_shield)
    end
end

function Priest.CastPowerWordShield()
    local unit = Unit(GetSpellTargetUnit())
    local event = EventsUnit(unit)
    local buff_timer = Timer(30.)
    local debuff_timer = Timer(15.)
    local absorb = 2230
    local model = "Abilities/Spells/Human/ManaShield/ManaShieldCaster.mdx"

    BuffSystem.RegisterHero(unit)

    --ничего не делаем, если есть дебаф на повтор
    if BuffSystem.IsBuffOnHero(unit, Spells.paladin.weakened_soul) then
        return
    end
    --проверяем есть ли щит, если да - сбрасываем и обновляем
    if BuffSystem.IsBuffOnHero(unit, Spells.paladin.power_word_shield) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, Spells.paladin.power_word_shield)
    end

    local pws_effect = Effect(unit, model, "origin")
    event:RegisterDamaged()

    local remove_buff = function()
        Priest.RemovePowerWordShield(unit)
        buff_timer:Destroy()
        event:Destroy()
        pws_effect:Destroy()
    end

    local remove_debuff = function()
        BuffSystem.RemoveBuffFromHero(unit, Spells.paladin.weakened_soul)
        debuff_timer:Destroy()
    end

    local function Shield()
        local damage = GetEventDamage()
        if damage == 0 then return end
        absorb = absorb - damage
        if 0. <= absorb and absorb < damage then
            BlzSetEventDamage(absorb)
            remove_buff()
        else
            BlzSetEventDamage(0.)
        end
    end

    local function UsingShield()
        return absorb > 0.
    end

    BuffSystem.AddBuffToHero(unit, Spells.paladin.power_word_shield, remove_buff)
    BuffSystem.AddBuffToHero(unit, Spells.paladin.weakened_soul, remove_debuff, true)
    buff_timer:SetFunc(remove_buff)
    debuff_timer:SetFunc(remove_debuff)
    buff_timer:Start()
    debuff_timer:Start()

    event:AddCondition(UsingShield)
    event:AddAction(Shield)
end

function Priest.IsPowerWordShield()
    return Spells.paladin.power_word_shield:SpellCasted()
end

function Priest.InitPowerWordShield(player)
    local event = EventsPlayer(player)
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsPowerWordShield)
    event:AddAction(Priest.CastPowerWordShield)
end
