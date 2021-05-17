
func void B_AssignDementorTalk_Ritual()
{
	var int randy;
	Wld_PlayEffect("DEMENTOR_FX",hero,hero,0,0,0,FALSE);
	Wld_PlayEffect("spellFX_Fear",self,self,0,0,0,FALSE);
	AI_PlayAni(self,"T_PRACTICEMAGIC5");
	if(MIS_DementorToldInnosEyeIsBroken == FALSE)
	{
		AI_Output (self, other, "DIA_RitualDementor_19_00");	//You have come too late.
		AI_Output (self, other, "DIA_RitualDementor_19_01");	//We have destroyed the Eye of Innos, so that it can never regain its power.
		AI_Output (self, other, "DIA_RitualDementor_19_02");	//We shall now demonstrate the futility of your attempt to challenge the Master.
		MIS_SCKnowsInnosEyeIsBroken = TRUE;
		MIS_DementorToldInnosEyeIsBroken = TRUE;
	}
	else
	{
		randy = Hlp_Random(4);
		if(randy == 0)
		{
			AI_Output (self, other, "DIA_RitualDementor_19_03");	//Now feel our power.
		};
		if(randy == 1)
		{
			AI_Output (self, other, "DIA_RitualDementor_19_04");	//For the Master.
		};
		if(randy == 2)
		{
			AI_Output (self, other, "DIA_RitualDementor_19_05");	//You cannot hide.
		};
		if(randy == 3)
		{
			AI_Output (self, other, "DIA_RitualDementor_19_06");	//We shall kill you.
		};
	};
	Npc_SetRefuseTalk(self,30);
};

func void B_AssignDementorTalk_Ritual_Exit()
{
	Wld_StopEffect("DEMENTOR_FX");
	B_SCIsObsessed(self);
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_SuddenEnemyInferno,1);
	Snd_Play("MFX_FEAR_CAST");
	self.aivar[AIV_EnemyOverride] = FALSE;
};

