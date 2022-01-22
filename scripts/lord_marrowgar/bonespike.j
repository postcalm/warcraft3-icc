
bool BONE_SPIKE_EXIST = false

// механика спелла
void BoneSpike_Actions()
{
    unit boneSpikeObj = null
    player whoPlayer = GetTriggerPlayer()
    
    TriggerSleepAction( GetRandomReal( 14., 17. ) )
    
    unit targetEnemy = GetUnitInArea( GroupHeroesInArea(AREA_LM) )
    float targetEnemyHealth = GetUnitState( targetEnemy, UNIT_STATE_MAX_LIFE )
    
    if( BONE_SPIKE_EXIST )
    {
        // призываем шип в позиции атакованной цели
        boneSpikeObj = new unit( whoPlayer, BONE_SPIKE_OBJ, \ 
                                 GetLocationX( GetUnitLoc( targetEnemy ) ), \
                                 GetLocationY( GetUnitLoc( targetEnemy ) ) )

        SetUnitAnimation( boneSpikeObj, "Stand Lumber" )
        SetUnitFlyHeight( targetEnemy, 150., 0. )

        PauseUnit( targetEnemy, true )
        PauseUnit( boneSpikeObj, true )
        
        // сразу 9к
        SetUnitState( targetEnemy, UNIT_STATE_LIFE, ( GetUnitState( targetEnemy, UNIT_STATE_LIFE ) - 9000.  ) )

        while( true )
        {
            SetUnitState( targetEnemy, UNIT_STATE_LIFE, ( GetUnitState( targetEnemy, UNIT_STATE_LIFE ) - ( targetEnemyHealth * 0.10 ) ) )
            TriggerSleepAction( 3. )
            
            // если шип уничтожен - выходим и сбрасываем игрока
            if( GetUnitState( boneSpikeObj, UNIT_STATE_LIFE ) <= 0 ) 
            {
                SetUnitAnimation( boneSpikeObj, "Decay" )
                SetUnitFlyHeight( targetEnemy, 0., 0. )
                PauseUnit( targetEnemy, false )
                RemoveUnit( boneSpikeObj )
                boneSpikeObj = null
                targetEnemy = null
                whoPlayer = null
                BONE_SPIKE_EXIST = false
                
                break
            }
            // если игрок умер - сбрасываем шип
            elseif( GetUnitState( targetEnemy, UNIT_STATE_LIFE ) <= 0  )
            {
                KillUnit(boneSpikeObj)
                RemoveUnit(boneSpikeObj)
                boneSpikeObj = null
                targetEnemy = null
                whoPlayer = null
                BONE_SPIKE_EXIST = false
                
                break
            }
        }
    }
}

// если шип не призван
bool StartBoneSpike()
{
    if( !BONE_SPIKE_EXIST )
    {
        BONE_SPIKE_EXIST = true
        return BONE_SPIKE_EXIST
    }
    return false
}

// main
void Init_BoneSpike()
{
    trigger triggerBoneSpike = new trigger

    TriggerRegisterUnitEvent( triggerBoneSpike, LORD_MARROWGAR, EVENT_UNIT_ATTACKED )    
    TriggerAddCondition( triggerBoneSpike, Condition( function StartBoneSpike ) )
    TriggerAddAction( triggerBoneSpike, function BoneSpike_Actions )
    
    triggerBoneSpike = null
}

