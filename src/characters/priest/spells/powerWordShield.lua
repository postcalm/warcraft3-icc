---@author meiso

function Priest.RemovePowerWordShield(unit)
    if BuffSystem.IsBuffOnHero(unit, Spells.priest.power_word_shield) then
        BuffSystem.RemoveBuffFromHero(unit, Spells.priest.power_word_shield)
    end
end

function Priest.CastPowerWordShield()
    local unit = Unit(GetSpellTargetUnit())
    local event = EventsUnit(unit)
    local buff_timer = Timer(7.)
    local debuff_timer = Timer(5.)
    local absorb = 2230
    local model = "Abilities/Spells/Human/ManaShield/ManaShieldCaster.mdx"

    BuffSystem.RegisterHero(unit)

    --ничего не делаем, если есть дебаф на повтор
    if BuffSystem.IsBuffOnHero(unit, Spells.priest.weakened_soul) then
        return
    end
    --проверяем есть ли щит, если да - сбрасываем и обновляем
    if BuffSystem.IsBuffOnHero(unit, Spells.priest.power_word_shield) then
        BuffSystem.RemoveBuffFromHeroByFunc(unit, Spells.priest.power_word_shield)
    end

    local pws_effect = Effect(unit, model, "origin")
    event:RegisterDamaged()

    local remove_buff = function()
        Logger("priest"):Info("remove")
        Priest.RemovePowerWordShield(unit)
        buff_timer:Destroy()
        event:Destroy()
        pws_effect:Destroy()
        Logger("priest"):Info("ok")
    end

    local remove_debuff = function()
        BuffSystem.RemoveBuffFromHero(unit, Spells.priest.weakened_soul)
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

    BuffSystem.AddBuffToHero(unit, Spells.priest.power_word_shield, remove_buff)
    BuffSystem.AddBuffToHero(unit, Spells.priest.weakened_soul, remove_debuff, true)
    buff_timer:SetFunc(remove_buff)
    debuff_timer:SetFunc(remove_debuff)
    buff_timer:Start()
    debuff_timer:Start()

    event:AddCondition(UsingShield)
    event:AddAction(Shield)
end

function Priest.IsPowerWordShield()
    return Spells.priest.power_word_shield:SpellCasted()
end

function Priest.InitPowerWordShield(player)
    local event = EventsPlayer(player)
    event:RegisterUnitSpellCast()
    event:AddCondition(Priest.IsPowerWordShield)
    event:AddAction(Priest.CastPowerWordShield)
end
