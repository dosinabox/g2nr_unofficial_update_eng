
func void B_RestartGreententacle()
{
	if(Npc_GetLastHitSpellID(self) == SPL_GreenTentacle)
	{
		Npc_SetStateTime(self,0);
	};
};

func void B_StopGreententacle()
{
	Npc_PercEnable(self,PERC_ASSESSMAGIC,B_AssessMagic);
	Npc_ClearAIQueue(self);
	AI_Standup(self);
	if(self.guild < GIL_SEPERATOR_HUM)
	{
		B_AssessDamage();
	}
	else
	{
		Npc_SetTempAttitude(self,ATT_HOSTILE);
	};
};

func void ZS_Greententacle()
{
	Npc_PercEnable(self,PERC_ASSESSMAGIC,B_RestartGreententacle);
	Npc_PercEnable(self,PERC_ASSESSDAMAGE,B_AssessDamage);
	Npc_StopAni(self,"S_GREENTENTACLEA_VICTIM");
	Npc_ClearAIQueue(self);
	AI_Standup(self);
	if(!C_BodyStateContains(self,BS_UNCONSCIOUS))
	{
		if(self.guild < GIL_SEPERATOR_HUM)
		{
			AI_PlayAniBS(self,"T_STAND_2_GREENTENTACLEA_VICTIM",BS_UNCONSCIOUS);
		}
		else
		{
			AI_PlayAniBS(self,"T_STAND_2_FREEZE_VICTIM",BS_UNCONSCIOUS);
		};
	};
};

func int ZS_Greententacle_Loop()
{
	if(Npc_GetStateTime(self) > SPL_TIME_Greententacle)
	{
		B_StopGreententacle();
		return LOOP_END;
	};
	return LOOP_CONTINUE;
};

func void ZS_GreenTentacle_End()
{
};

