
function Paladin.ShieldOfRighteousness()
    -- 42% от силы + 520 ед. урона дополнительно
    local damage = GetHeroStr(GetTriggerUnit(), true) * 1.42 + 520.
    Paladin.hero:DealMagicDamage(GetSpellTargetUnit(), damage)
end

function Paladin.IsShieldOfRighteousness()
    return GetSpellAbilityId() == SHIELD_OF_RIGHTEOUSNESS
end


function Paladin.InitShieldOfRighteousness()
    Ability(
            SHIELD_OF_RIGHTEOUSNESS,
            "Щит праведности",
            "Мощный удар щитом, наносящий урон от светлой магии. " ..
            "Величина урона рассчитывается исходя из показателя блока и увеличивается на 520 ед. дополнительно."
    )
    Paladin.hero:SetAbilityManacost(SHIELD_OF_RIGHTEOUSNESS, 6)
    Paladin.hero:SetAbilityCooldown(SHIELD_OF_RIGHTEOUSNESS, 6.)

    local event = EventsPlayer()
    event:RegisterUnitSpellCast()
    event:AddCondition(Paladin.IsShieldOfRighteousness)
    event:AddAction(Paladin.ShieldOfRighteousness)
end
