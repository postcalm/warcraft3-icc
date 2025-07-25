---@author meiso

function DummyForDPS(location)
    local loc = location or Location(4480., 400.)
    local d = Unit(LICH_KING, FourCC('hfoo'), loc, 0.)
    d:SetMaxLife(500000, true)
    d:SetBaseDamage(4000.)
    d:SetMoveSpeed(0)
    d:AutoRegen()
end


function TrashDummyForDPS(location, name, health)
    local loc = location or Location(4480., 400.)
    local d = Unit(LICH_KING, FourCC('hfoo'), loc, 0.)
    health = health or 50000
    d:SetName(name)
    d:SetMaxLife(health, true)
    d:SetBaseDamage(2000.)
    d:AutoRegen()
end


function DummyForHealing(location)
    local loc = location or Location(4480., 400.)
    local d = Unit(GetLocalPlayer(), FourCC('hfoo'), loc, 0.)
    d:SetMaxLife(500000)
    d:SetLife(100)
end


function SpawnTrashDummies(count)
    for i = 1, count do
        TrashDummyForDPS(Location(GetRandomReal(-600., -400.), 200.), tostring(i), 5000)
    end
end
