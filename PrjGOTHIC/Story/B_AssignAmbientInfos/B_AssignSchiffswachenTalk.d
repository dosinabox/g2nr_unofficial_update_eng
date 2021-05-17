
func void B_AssignSchiffswachenGuard(var C_Npc Schiffswache)
{
	if((MIS_ShipIsFree == TRUE) || (MIS_SCvisitShip == LOG_Running))
	{
		if(Schiffswache.voice == 4)
		{
			AI_Output (self, other, "DIA_Pal_Schiffswache_Ambient_04_00");	//We are watching you. Remember that.
		};
		if(Schiffswache.voice == 9)
		{
			AI_Output (self, other, "DIA_Pal_Schiffswache_Ambient_09_01");	//Don't get into trouble while you're here.
		};
		if(Schiffswache.voice == 12)
		{
			AI_Output (self, other, "DIA_Pal_Schiffswache_Ambient_12_02");	//Don't even think of stealing anything here, got it?
		};
		AI_StopProcessInfos(Schiffswache);
		Npc_SetRefuseTalk(Schiffswache,60);
		Npc_SetRefuseTalk(PAL_220_Schiffswache,60);
		Npc_SetRefuseTalk(PAL_221_Schiffswache,60);
		Npc_SetRefuseTalk(PAL_222_Schiffswache,60);
		Npc_SetRefuseTalk(PAL_223_Schiffswache,60);
		Npc_SetRefuseTalk(PAL_224_Schiffswache,60);
		Npc_SetRefuseTalk(PAL_225_Schiffswache,60);
		Npc_SetRefuseTalk(PAL_226_Schiffswache,60);
		Npc_SetRefuseTalk(PAL_227_Schiffswache,60);
		Npc_SetRefuseTalk(PAL_228_Schiffswache,60);
	}
	else
	{
		B_Say(self,other,"$ALARM");
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_GuardStopsIntruder,1);
		Npc_SetRefuseTalk(Schiffswache,20);
		Npc_SetRefuseTalk(PAL_220_Schiffswache,20);
		Npc_SetRefuseTalk(PAL_221_Schiffswache,20);
		Npc_SetRefuseTalk(PAL_222_Schiffswache,20);
		Npc_SetRefuseTalk(PAL_223_Schiffswache,20);
		Npc_SetRefuseTalk(PAL_224_Schiffswache,20);
		Npc_SetRefuseTalk(PAL_225_Schiffswache,20);
		Npc_SetRefuseTalk(PAL_226_Schiffswache,20);
		Npc_SetRefuseTalk(PAL_227_Schiffswache,20);
		Npc_SetRefuseTalk(PAL_228_Schiffswache,20);
	};
};

func void B_AssignSchiffswachenInfos(var C_Npc Schiffswache)
{
	if(MIS_ShipIsFree == TRUE)
	{
		if(Schiffswache.voice == 4)
		{
			AI_Output (self, other, "DIA_Pal_Schiffswache_AmbientKap5_04_00");	//The damned orcs have stormed Garond's castle. We must act at once.
		};
		if(Schiffswache.voice == 9)
		{
			AI_Output (self, other, "DIA_Pal_Schiffswache_AmbientKap5_09_01");	//If we ever get hold of that traitor who opened the main gate to the castle, we'll make short work of him.
		};
		if(Schiffswache.voice == 12)
		{
			AI_Output (self, other, "DIA_Pal_Schiffswache_AmbientKap5_12_02");	//We can't wait much longer. Our boys in the Valley of Mines need our help before the next wave of orcs attacks.
		};
	}
	else
	{
		if(Schiffswache.voice == 4)
		{
			AI_Output (self, other, "DIA_Pal_Schiffswache_AmbientKap5_04_03");	//Garond has called for a general mobilization. We'll set out for the Valley of Mines soon.
		};
		if(Schiffswache.voice == 9)
		{
			AI_Output (self, other, "DIA_Pal_Schiffswache_AmbientKap5_09_04");	//The orcs must finally be taught a lesson.
		};
		if(Schiffswache.voice == 12)
		{
			AI_Output (self, other, "DIA_Pal_Schiffswache_AmbientKap5_12_05");	//I can barely wait to give those orcs what for. We'll get started soon.
		};
	};
	AI_StopProcessInfos(Schiffswache);
};

func void B_AssignSchiffswachenTalk(var C_Npc Schiffswache)
{
	if(Kapitel >= 5)
	{
		B_AssignSchiffswachenInfos(Schiffswache);
	}
	else
	{
		B_AssignSchiffswachenGuard(Schiffswache);
	};
};

func int B_AssignSchiffswachenInfoConditions(var C_Npc Schiffswache)
{
	if((Kapitel < 5) && !Npc_RefuseTalk(self) && (MIS_SCvisitShip != LOG_Running))
	{
		return TRUE;
	}
	else if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
	return FALSE;
};

