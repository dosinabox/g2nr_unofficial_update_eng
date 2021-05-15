
func int C_PlayerHasFakeGuild(var C_Npc slf,var C_Npc oth)
{
	var C_Item itm;
	itm = Npc_GetEquippedArmor(oth);
	if(Npc_HasEquippedArmor(oth))
	{
		if(Hlp_IsItem(itm,ITAR_RANGER_Addon) && (CurrentLevel == NEWWORLD_ZEN))
		{
			if((Hlp_GetInstanceID(slf) == Hlp_GetInstanceID(Cavalorn)) && ((Npc_GetDistToWP(slf,"NW_CITY_MERCHANT_PATH_15") < 5000) || (Npc_GetDistToWP(slf,"NW_CITY_TAVERN_IN_07") < 5000)))
			{
				return TRUE;
			};
			if((Hlp_GetInstanceID(slf) == Hlp_GetInstanceID(Lares)) && (Npc_GetDistToWP(slf,"NW_CITY_HABOUR_02_B") < 5000))
			{
				return TRUE;
			};
			if((Hlp_GetInstanceID(slf) == Hlp_GetInstanceID(Vatras)) && (Npc_GetDistToWP(slf,"NW_CITY_MERCHANT_TEMPLE_FRONT") < 5000))
			{
				return TRUE;
			};
			if((Hlp_GetInstanceID(slf) == Hlp_GetInstanceID(Myxir_CITY)) && (Npc_GetDistToWP(slf,"NW_CITY_MERCHANT_TEMPLE_FRONT") < 5000))
			{
				return TRUE;
			};
			if((Hlp_GetInstanceID(slf) == Hlp_GetInstanceID(Martin)) && ((Npc_GetDistToWP(slf,"NW_CITY_PALCAMP_15") < 5000) || (Npc_GetDistToWP(slf,"NW_CITY_HABOUR_TAVERN01_04") < 5000)))
			{
				return TRUE;
			};
			if((Hlp_GetInstanceID(slf) == Hlp_GetInstanceID(Cord)) && (Npc_GetDistToWP(slf,"NW_BIGFARM_HOUSE_15") < 1000))
			{
				return TRUE;
			};
		};
	};
	if(slf.aivar[AIV_IgnoresArmor] == TRUE)
	{
		return FALSE;
	};
	if(slf.aivar[AIV_IgnoresFakeGuild] == TRUE)
	{
		return FALSE;
	};
	if(slf.guild == GIL_DMT)
	{
		return FALSE;
	};
	if(C_NpcIsGateGuard(slf))
	{
		return FALSE;
	};
	if((slf.guild == GIL_BDT) && C_PlayerIsFakeBandit(slf,oth))
	{
		if(!Npc_HasEquippedArmor(oth))
		{
			return TRUE;
		}
		else
		{
			return FALSE;
		};
	};
	if(!Npc_HasEquippedArmor(oth))
	{
		if((slf.guild == GIL_SLD) || (slf.guild == GIL_DJG))
		{
			if((oth.guild == GIL_SLD) || (oth.guild == GIL_DJG))
			{
				return TRUE;
			};
		}
		else if(slf.guild == GIL_PAL)
		{
			if((oth.guild == GIL_MIL) || (oth.guild == GIL_PAL))
			{
				return TRUE;
			};
		}
		else if(slf.guild == GIL_MIL)
		{
			if(oth.guild == GIL_MIL)
			{
				return TRUE;
			};
		}
		else if((slf.guild == GIL_NOV) || (Hlp_GetInstanceID(slf) == Hlp_GetInstanceID(Ulf)))
		{
			if(oth.guild == GIL_NOV)
			{
				return TRUE;
			};
		}
		else if((slf.guild == GIL_KDF) || (Hlp_GetInstanceID(slf) == Hlp_GetInstanceID(Daron)))
		{
			if((oth.guild == GIL_NOV) || (oth.guild == GIL_KDF))
			{
				return TRUE;
			};
		};
		return FALSE;
	}
	else if(slf.guild == oth.guild)
	{
		if(oth.guild == GIL_NONE)
		{
			if(Hlp_IsItem(itm,ITAR_Vlk_L) || Hlp_IsItem(itm,ITAR_Vlk_M) || Hlp_IsItem(itm,ITAR_Vlk_H) || Hlp_IsItem(itm,ITAR_Bau_L) || Hlp_IsItem(itm,ITAR_Bau_M) || Hlp_IsItem(itm,ITAR_Leather_L))
			{
				return FALSE;
			};
			if(Hlp_IsItem(itm,ITAR_DJG_Crawler) || Hlp_IsItem(itm,ITAR_OHT) || Hlp_IsItem(itm,ITAR_DHT) || Hlp_IsItem(itm,ITAR_RANGER_Addon))
			{
				return FALSE;
			};
		}
		else if(oth.guild == GIL_MIL)
		{
			if(Hlp_IsItem(itm,ITAR_MIL_L) || Hlp_IsItem(itm,ITAR_MIL_M))
			{
				return FALSE;
			};
		}
		else if(oth.guild == GIL_PAL)
		{
			if(Hlp_IsItem(itm,ITAR_PAL_M) || Hlp_IsItem(itm,ITAR_PAL_H))
			{
				return FALSE;
			};
			if(Hlp_IsItem(itm,ITAR_PALN_M) || Hlp_IsItem(itm,ITAR_PALN_H))
			{
				return FALSE;
			};
			if(Hlp_IsItem(itm,ITAR_PAL_S))
			{
				return FALSE;
			};
		}
		else if(oth.guild == GIL_SLD)
		{
			if(Hlp_IsItem(itm,ITAR_SLD_L) || Hlp_IsItem(itm,ITAR_SLD_M) || Hlp_IsItem(itm,ITAR_SLD_S) || Hlp_IsItem(itm,ITAR_SLD_H))
			{
				return FALSE;
			};
		}
		else if(oth.guild == GIL_DJG)
		{
			if(Hlp_IsItem(itm,ITAR_SLD_L) || Hlp_IsItem(itm,ITAR_SLD_M) || Hlp_IsItem(itm,ITAR_SLD_S) || Hlp_IsItem(itm,ITAR_SLD_H) || Hlp_IsItem(itm,ITAR_DJG_L) || Hlp_IsItem(itm,ITAR_DJG_M) || Hlp_IsItem(itm,ITAR_DJG_H) || Hlp_IsItem(itm,ITAR_DJG_Crawler))
			{
				return FALSE;
			};
			if(Hlp_IsItem(itm,ITAR_DJGN_M) || Hlp_IsItem(itm,ITAR_DJGN_H))
			{
				return FALSE;
			};
		}
		else if(oth.guild == GIL_NOV)
		{
			if(Hlp_IsItem(itm,ITAR_NOV_L))
			{
				return FALSE;
			};
		}
		else if(oth.guild == GIL_KDF)
		{
			if(Hlp_IsItem(itm,ITAR_KDF_L) || Hlp_IsItem(itm,ITAR_KDF_M) || Hlp_IsItem(itm,ITAR_KDF_H) || Hlp_IsItem(itm,ITAR_KDF_S))
			{
				return FALSE;
			};
		};
		return TRUE;
	}
	else if((slf.guild == GIL_KDF) && (oth.guild == GIL_NOV))
	{
		if(!Hlp_IsItem(itm,ITAR_NOV_L))
		{
			return TRUE;
		};
	}
	else if(Hlp_GetInstanceID(slf) == Hlp_GetInstanceID(Ulf))
	{
		if((oth.guild == GIL_NOV) && !Hlp_IsItem(itm,ITAR_NOV_L))
		{
			return TRUE;
		};
	}
	else if(Hlp_GetInstanceID(slf) == Hlp_GetInstanceID(Daron))
	{
		if((oth.guild == GIL_KDF) && !Hlp_IsItem(itm,ITAR_KDF_L) && !Hlp_IsItem(itm,ITAR_KDF_M) && !Hlp_IsItem(itm,ITAR_KDF_H) && !Hlp_IsItem(itm,ITAR_KDF_S))
		{
			return TRUE;
		};
		if((oth.guild == GIL_NOV) && !Hlp_IsItem(itm,ITAR_NOV_L))
		{
			return TRUE;
		};
	};
	return FALSE;
};

