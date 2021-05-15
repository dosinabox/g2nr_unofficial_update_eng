
func int B_GhostSpecialDamage(var C_Npc oth,var C_Npc slf)
{
	if((Hlp_GetInstanceID(self) == Hlp_GetInstanceID(Quarhodron)) || (Hlp_GetInstanceID(self) == Hlp_GetInstanceID(Rhademes)))
	{
		Wld_PlayEffect("spellFX_BELIARSRAGE",oth,oth,0,0,0,FALSE);
		if(oth.flags != NPC_FLAG_IMMORTAL)
		{
			if(!C_NpcIsHero(oth))
			{
				Npc_ChangeAttribute(oth,ATR_HITPOINTS,-oth.attribute[ATR_HITPOINTS_MAX]);
			}
			else
			{
				GhostAttackWarn += 1;
				if(GhostAttackWarn < 3)
				{
					oth.attribute[ATR_HITPOINTS] /= 2;
				}
				else
				{
					oth.attribute[ATR_HITPOINTS] = 0;
					AI_PlayAni(oth,"T_DEAD");
				};
			};
		};
	};
	return FALSE;
};


func void B_ArrowBonusDamage(var C_Npc oth,var C_Npc slf)
{
	var C_Item readyweap;
	readyweap = Npc_GetReadiedWeapon(oth);
	if(Npc_HasReadiedRangedWeapon(oth))
	{
		if(readyweap.munition == ItRw_Addon_FireArrow)
		{
			Wld_PlayEffect("spellFX_Firestorm_SPREAD",slf,slf,0,0,0,FALSE);
			Wld_PlayEffect("VOB_MAGICBURN",slf,slf,0,0,0,FALSE);
			if(slf.flags == 0)
			{
				if(slf.protection[PROT_FIRE] < SpecialDamage_FireBow)
				{
					if((slf.attribute[ATR_HITPOINTS] + slf.protection[PROT_FIRE] - SpecialDamage_FireBow) >= 0)
					{
						slf.attribute[ATR_HITPOINTS] -= (SpecialDamage_FireBow - slf.protection[PROT_FIRE]);
					}
					else
					{
						slf.attribute[ATR_HITPOINTS] = 0;
					};
				};
			};
			if(Npc_GetDistToNpc(slf,oth) <= 600)
			{
				Wld_PlayEffect("VOB_MAGICBURN",oth,oth,0,0,0,FALSE);
				if(oth.protection[PROT_FIRE] < SpecialDamage_FireBow)
				{
					if((oth.attribute[ATR_HITPOINTS] + oth.protection[PROT_FIRE] - SpecialDamage_FireBow) >= 0)
					{
						oth.attribute[ATR_HITPOINTS] -= (SpecialDamage_FireBow - oth.protection[PROT_FIRE]);
					}
					else
					{
						oth.attribute[ATR_HITPOINTS] = 0;
					};
				};
				if(oth.attribute[ATR_HITPOINTS] <= 0)
				{
					AI_PlayAni(oth,"T_DEAD");
				};
			};
			if(Npc_IsDead(slf))
			{
				B_GiveDeathXP(oth,slf);
			};
		};
	};
};

