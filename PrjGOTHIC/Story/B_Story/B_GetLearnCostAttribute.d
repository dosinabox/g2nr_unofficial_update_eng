
func int B_GetLearnCostAttribute(var C_Npc oth,var int attribut)
{
	var int kosten;
	var int penalty;
	kosten = 0;
	penalty = 0;
	if(attribut == ATR_STRENGTH)
	{
		if(PenaltiesAffectLearnCost == TRUE)
		{
			penalty = OrcRingCurrentPenalty;
		};
		if((oth.aivar[REAL_STRENGTH] - penalty) >= 120)
		{
			kosten = 5;
		}
		else if((oth.aivar[REAL_STRENGTH] - penalty) >= 90)
		{
			kosten = 4;
		}
		else if((oth.aivar[REAL_STRENGTH] - penalty) >= 60)
		{
			kosten = 3;
		}
		else if((oth.aivar[REAL_STRENGTH] - penalty) >= 30)
		{
			kosten = 2;
		}
		else
		{
			kosten = 1;
		};
	}
	else if(attribut == ATR_DEXTERITY)
	{
		if(oth.aivar[REAL_DEXTERITY] >= 120)
		{
			kosten = 5;
		}
		else if(oth.aivar[REAL_DEXTERITY] >= 90)
		{
			kosten = 4;
		}
		else if(oth.aivar[REAL_DEXTERITY] >= 60)
		{
			kosten = 3;
		}
		else if(oth.aivar[REAL_DEXTERITY] >= 30)
		{
			kosten = 2;
		}
		else
		{
			kosten = 1;
		};
	}
	else if(attribut == ATR_MANA_MAX)
	{
		if(oth.aivar[REAL_MANA_MAX] >= 120)
		{
			kosten = 5;
		}
		else if(oth.aivar[REAL_MANA_MAX] >= 90)
		{
			kosten = 4;
		}
		else if(oth.aivar[REAL_MANA_MAX] >= 60)
		{
			kosten = 3;
		}
		else if(oth.aivar[REAL_MANA_MAX] >= 30)
		{
			kosten = 2;
		}
		else
		{
			kosten = 1;
		};
	}
	else if(attribut == ATR_REGENERATEHP)
	{
		if(oth.attribute[ATR_REGENERATEHP] > 30)
		{
			kosten = 1;
		}
		else if(oth.attribute[ATR_REGENERATEHP] > 10)
		{
			kosten = 2;
		}
		else
		{
			kosten = 3;
		};
	}
	else if(attribut == ATR_REGENERATEMANA)
	{
		if(oth.attribute[ATR_REGENERATEMANA] > 30)
		{
			kosten = 1;
		}
		else if(oth.attribute[ATR_REGENERATEMANA] > 10)
		{
			kosten = 2;
		}
		else
		{
			kosten = 3;
		};
	};
	return kosten;
};

