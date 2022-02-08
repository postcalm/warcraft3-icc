include "libraries/String.j"
include "libraries/EqSysWrapper.j"
include "scripts/lady_deathwhisper/manashield.j"
include "scripts/lady_deathwhisper/shadowbolt.j"

setdef SUFFIX_NAME = LD
setdef COUNT = 3
INIT_STRUCT_ITEMS()

void InitTrig_Init_LD()
{
    String items_id = String.create("HP_ITEM, ARMOR_ITEM, ATTACK_ITEM")
    String items_spells_id = String.create("HP_90K, ARMOR_500, ATTACK_1500")
    
    FILL_STRUCT_ITEMS(items_id, items_spells_id)
    REGISTRATION_ITEMS()
    ADD_ITEMS_TO_UNIT(LADY_DEATHWHISPER)
    
    Init_ManaShield()
    Init_ShadowBolt()
}

