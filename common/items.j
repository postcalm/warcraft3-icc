
#guard items

struct Items extends array
{
    int item_id
    string item_str

    int getIdByName(string name)
    {
        if(this.item_str == name) { return this.item_id }
        return 0
    }
}

struct ItemsSpells extends array
{
    int item_spell_id
    string item_spell_str

    int getIdByName(string name)
    {
        if(this.item_spell_str == name) { return this.item_spell_id }
        return 0
    }
}

int SearchItem(string name)
{
    int i = -1
    whilenot(i++ == 4)
    {
        if( Items[i].getIdByName(name) != 0 )
        {
            return Items[i].item_id
        }
    }
    return 0;
}

int SearchItemSpell(string name)
{
    int i = -1
    whilenot(i++ == 4)
    {
        if( ItemsSpells[i].getIdByName(name) != 0 )
        {
            return ItemsSpells[i].item_spell_id
        }
    }
    return 0;
}

define <InitItemsAndItemsSpells()> =
{
    // Предметы
    Items[0].item_id  = 'I001'
    Items[0].item_str = "ARMOR_ITEM"
    Items[1].item_id  = 'I000'
    Items[1].item_str = "ATTACK_ITEM"
    Items[2].item_id  = 'I002'
    Items[2].item_str = "HP_ITEM"
    Items[3].item_id  = 'I003'
    Items[3].item_str = "MAGICARMOR_ITEM"
    Items[4].item_id  = 'I004'
    Items[4].item_str = "DEC_DMG_ITEM" // decrease damage item

    // Способности, назначенные предметам
    ItemsSpells[0].item_spell_id  = 'A008'
    ItemsSpells[0].item_spell_str = "ARMOR_500"
    ItemsSpells[1].item_spell_id  = 'A007'
    ItemsSpells[1].item_spell_str = "ATTACK_1500"
    ItemsSpells[2].item_spell_id  = 'A00D'
    ItemsSpells[2].item_spell_str = "HP_90K"
    ItemsSpells[3].item_spell_id  = 'A00I'
    ItemsSpells[3].item_spell_str = "MAGICARMOR_500"
    ItemsSpells[4].item_spell_id  = 'A00K'
    ItemsSpells[4].item_spell_str = "DECREASE_DMG"
}
