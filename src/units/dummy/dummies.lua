---@author meiso

function DummyForDPS(location)
    local loc = location or Location(4480., 400.)
    local d = Unit(LICH_KING, FourCC('hfoo'), loc, 0.)
    d:SetMaxLife(500000, true)
    d:SetBaseDamage(4000.)
    d:SetMoveSpeed(0)
end


function TrashDummyForDPS(location, name)
    local loc = location or Location(4480., 400.)
    local d = Unit(LICH_KING, FourCC('hfoo'), loc, 0.)
    d:SetName(name)
    d:SetMaxLife(50000, true)
    d:SetBaseDamage(200.)
end


function DummyForHealing(location)
    local loc = location or Location(4480., 400.)
    local d = Unit(GetLocalPlayer(), FourCC('hfoo'), loc, 0.)
    d:SetMaxLife(500000)
    d:SetLife(100)
end


function SpawnTrashDummies(count)
    for i = 1, count do
        TrashDummyForDPS(Location(GetRandomReal(-600., -400.), 200.), tostring(i))
    end
end
