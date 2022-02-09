include "libraries/String.j"
include "libraries/EqSysWrapper.j"
include "common/spells.j"
include "scripts/lord_marrowgar/bonespike.j"
include "scripts/lord_marrowgar/coldflame.j"
include "scripts/lord_marrowgar/whirlwind.j"

setdef SUFFIX_NAME = LM
setdef COUNT = 3
INIT_STRUCT_ITEMS()

void InitTrig_Init_LM()
{
    UnitAddAbility( DUMMY_LM, COLDFLAME )
    UnitAddAbility( LORD_MARROWGAR, WHIRLWIND )
    
    String items_id = String.create("ARMOR_ITEM, ATTACK_ITEM, HP_ITEM")
    String items_spells_id = String.create("ARMOR_500, ATTACK_1500, HP_90K")
    
    FILL_STRUCT_ITEMS(items_id, items_spells_id)
    REGISTRATION_ITEMS()
    ADD_ITEMS_TO_UNIT(LORD_MARROWGAR)
    
    Init_Coldflame()
    Init_BoneSpike()
    Init_Whirlwind()
}
