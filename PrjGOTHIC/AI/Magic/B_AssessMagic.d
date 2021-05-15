
func void B_AssessMagic()
{
	if(Npc_GetLastHitSpellCat(self) == SPELL_BAD)
	{
		Npc_SendPassivePerc(self,PERC_ASSESSFIGHTSOUND,self,other);
	};
	if((Npc_GetLastHitSpellID(self) == SPL_Whirlwind) && (self.guild != GIL_DRAGON))
	{
		Npc_ClearAIQueue(self);
		B_ClearPerceptions(self);
		AI_StartState(self,ZS_Whirlwind,0,"");
		return;
	};
	if((Npc_GetLastHitSpellID(self) == SPL_SuckEnergy) && (self.guild != GIL_DRAGON))
	{
		Npc_ClearAIQueue(self);
		B_ClearPerceptions(self);
		AI_StartState(self,ZS_SuckEnergy,0,"");
		return;
	};
	if((Npc_GetLastHitSpellID(self) == SPL_GreenTentacle) && (self.guild != GIL_DRAGON))
	{
		Npc_ClearAIQueue(self);
		B_ClearPerceptions(self);
		AI_StartState(self,ZS_Greententacle,0,"");
		return;
	};
	if((Npc_GetLastHitSpellID(self) == SPL_Swarm) && (self.guild != GIL_DRAGON))
	{
		Npc_ClearAIQueue(self);
		B_ClearPerceptions(self);
		AI_StartState(self,ZS_Swarm,0,"");
		return;
	};
	if((Npc_GetLastHitSpellID(self) == SPL_IceCube) || (Npc_GetLastHitSpellID(self) == SPL_IceWave))
	{
		Npc_ClearAIQueue(self);
		B_ClearPerceptions(self);
		AI_StartState(self,ZS_MagicFreeze,0,"");
		return;
	};
	if((Npc_GetLastHitSpellID(self) == SPL_ChargeZap) && (self.guild != GIL_DRAGON) && (other.guild != GIL_DRAGON))
	{
		/*Npc_ClearAIQueue(self);
		B_ClearPerceptions(self);
		AI_StartState(self,ZS_ShortZapped,0,"");
		return;*/
		var int zap;
		zap = Hlp_Random(2);
		if(zap == 0)
		{
			Npc_ClearAIQueue(self);
			B_ClearPerceptions(self);
			AI_StartState(self,ZS_ShortZapped,0,"");
			return;
		};
	};
	/*if(Npc_GetLastHitSpellID(self) == SPL_Fear)
	{
		Npc_ClearAIQueue(self);
		B_ClearPerceptions(self);
		Npc_SetTarget(self,other);
		if((self.guild < GIL_SEPERATOR_HUM) && (self.guild != GIL_KDF) && (self.guild != GIL_PAL) && (self.guild != GIL_KDW) && (Hlp_GetInstanceID(self) != Hlp_GetInstanceID(Vatras)))
		{
			AI_StartState(self,ZS_MagicFlee,0,"");
			return;
		}
		else if((self.guild > GIL_SEPERATOR_HUM) && (self.guild != GIL_DRAGON) && (self.guild != GIL_TROLL) && (self.guild != GIL_STONEGOLEM) && (self.guild != GIL_ICEGOLEM) && (self.guild != GIL_FIREGOLEM))
		{
			AI_StartState(self,ZS_MM_Flee,0,"");
			return;
		};
	};*/
	if((Npc_GetLastHitSpellID(self) == SPL_Firerain) && (self.guild != GIL_DRAGON))
	{
		Npc_ClearAIQueue(self);
		AI_StartState(self,ZS_MagicBurnShort,0,"");
		return;
	};
};


const func PLAYER_PERC_ASSESSMAGIC = B_AssessMagic;
