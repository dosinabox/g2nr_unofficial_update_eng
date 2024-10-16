
func void B_MM_AssessQuietSound_Sleep()
{
	if(Wld_GetGuildAttitude(self.guild,other.guild) == ATT_HOSTILE)
	{
		B_MM_AssessEnemy();
	};
};

func void ZS_MM_Rtn_Sleep()
{
	Npc_PercEnable(self,PERC_ASSESSMAGIC,B_AssessMagic);
	Npc_PercEnable(self,PERC_ASSESSDAMAGE,B_MM_AssessDamage);
	Npc_PercEnable(self,PERC_ASSESSOTHERSDAMAGE,B_MM_AssessOthersDamage);
	Npc_PercEnable(self,PERC_ASSESSMURDER,B_MM_AssessOthersDamage);
	Npc_PercEnable(self,PERC_ASSESSWARN,B_MM_AssessWarn);
	Npc_PercEnable(self,PERC_ASSESSQUIETSOUND,B_MM_AssessQuietSound_Sleep);
	AI_SetWalkMode(self,NPC_WALK);
	B_MM_DeSynchronize();
	if(!Hlp_StrCmp(Npc_GetNearestWP(self),self.wp))
	{
		AI_GotoWP(self,self.wp);
	};
	if(Wld_IsFPAvailable(self,"FP_ROAM"))
	{
		AI_GotoFP(self,"FP_ROAM");
	};
	if(self.guild != GIL_BLOODFLY)
	{
		if((self.guild != GIL_SHADOWBEAST) && (self.guild != GIL_Gargoyle) && (self.guild != GIL_SHADOWBEAST_SKELETON))
		{
			AI_PlayAni(self,"T_PERCEPTION");
		};
		AI_PlayAniBS(self,"T_STAND_2_SLEEP",BS_LIE);
	};
	self.aivar[AIV_StateTime] = Hlp_Random(100) % 8 + 1;
};

func int ZS_MM_Rtn_Sleep_Loop()
{
	if(!Wld_IsTime(self.aivar[AIV_MM_SleepStart],0,self.aivar[AIV_MM_SleepEnd],self.aivar[AIV_StateTime]) && (self.aivar[AIV_MM_SleepStart] != OnlyRoutine))
	{
		AI_StartState(self,ZS_MM_AllScheduler,1,"");
		return LOOP_END;
	};
	return LOOP_CONTINUE;
};

func void ZS_MM_Rtn_Sleep_End()
{
	if(self.guild != GIL_BLOODFLY)
	{
		AI_PlayAniBS(self,"T_SLEEP_2_STAND",BS_STAND);
	};
};

