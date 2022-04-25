
function DeathAndDecay()

end

function Init_DeathAndDecay()
    local event = EventsUnit(LADY_DEATHWHISPER)
    event:RegisterAttacked()
    event:AddAction(DeathAndDecay)
end