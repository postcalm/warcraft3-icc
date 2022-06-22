
function DummyForHealing()
    local d = Unit(PLAYER_1, FourCC('hfoo'), Location(4480., 400.), 0.)
    d:SetMaxLife(50000)
    d:SetLife(100)
end