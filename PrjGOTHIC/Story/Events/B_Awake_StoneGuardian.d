
func void b_awake_stoneguardian(var C_Npc slf)
{
	if((RavenIsDead == FALSE) && (slf.aivar[AIV_EnemyOverride] == TRUE) && (slf.attribute[ATR_HITPOINTS] > 0))
	{
		Wld_PlayEffect("spellFX_INCOVATION_WHITE",slf,slf,0,0,0,FALSE);
		Wld_PlayEffect("spellFX_LIGHTSTAR_RingRitual",slf,slf,0,0,0,FALSE);
		slf.aivar[AIV_EnemyOverride] = FALSE;
	};
};
