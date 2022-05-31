
function CultAdherent.DeathchillBolt()
    TriggerSleepAction(3.)
    local enemy = GetUnitInArea(GroupHeroesInArea(gg_rct_areaLD, GetOwningPlayer(GetAttacker())))
    local model_name = "Abilities\\Spells\\Other\\BlackArrow\\BlackArrowMissile.mdl"

    local bolt = UnitSpell(CultAdherent.unit:GetUnit())
    local effect = Effect(bolt, model_name, 0.7)
    while true do
        TriggerSleepAction(0.)
        bolt:MoveToUnit(enemy)
        if bolt:NearTarget(enemy) then
            local damage = 940.
            CultAdherent.unit:DealMagicDamage(enemy, damage)
            break
        end
    end
    effect:Destroy()
    bolt:Remove()
end

function CultAdherent.InitDeathchillBolt()
    local event = EventsUnit(CultAdherent.unit:GetUnit())
    event:RegisterDamaging()
    event:AddAction(CultAdherent.DeathchillBolt)
end
