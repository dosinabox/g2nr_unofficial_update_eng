
instance DIA_CipherDJG_EXIT(C_Info)
{
	npc = DJG_703_Cipher;
	nr = 999;
	condition = DIA_CipherDJG_EXIT_Condition;
	information = DIA_CipherDJG_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_CipherDJG_EXIT_Condition()
{
	return TRUE;
};

func void DIA_CipherDJG_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Cipher_HALLO(C_Info)
{
	npc = DJG_703_Cipher;
	condition = DIA_Cipher_HALLO_Condition;
	information = DIA_Cipher_HALLO_Info;
	description = "Nice camp.";
};


func int DIA_Cipher_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Cipher_HALLO_Info()
{
	AI_Output (other, self, "DIA_Cipher_HALLO_15_00");	//Nice camp.
	AI_Output (self, other, "DIA_Cipher_HALLO_07_01");	//You said it. It stinks like a slaughterhouse here. Dead animals and rotten trees everywhere.
};


instance DIA_CipherDJG_HELLOAGAIN(C_Info)
{
	npc = DJG_703_Cipher;
	condition = DIA_CipherDJG_HELLOAGAIN_Condition;
	information = DIA_CipherDJG_HELLOAGAIN_Info;
	description = "What are you doing here?";
};


func int DIA_CipherDJG_HELLOAGAIN_Condition()
{
	if(!Npc_IsDead(SwampDragon) && Npc_KnowsInfo(other,DIA_Cipher_HALLO))
	{
		return TRUE;
	};
};

func void DIA_CipherDJG_HELLOAGAIN_Info()
{
	AI_Output (other, self, "DIA_CipherDJG_HELLOAGAIN_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_CipherDJG_HELLOAGAIN_07_01");	//I've been sitting here for some time just waiting for the right moment.
	AI_Output (other, self, "DIA_CipherDJG_HELLOAGAIN_15_02");	//Right moment? For what?
	AI_Output (self, other, "DIA_CipherDJG_HELLOAGAIN_07_03");	//There's supposed to be a dragon holed up over there. A pretty vile swamp has built up there since he came.
	AI_Output (self, other, "DIA_CipherDJG_HELLOAGAIN_07_04");	//I can well remember a time when you wouldn't get your feet wet around here.
	AI_Output (self, other, "DIA_CipherDJG_HELLOAGAIN_07_05");	//But now, I'd never go in there alone.
	if(!Npc_IsDead(DJG_Rod))
	{
		AI_Output (self, other, "DIA_CipherDJG_HELLOAGAIN_07_06");	//Well. Rod is still here. But he'd run at the first sight of meatbugs.
	};
	AI_Output (self, other, "DIA_CipherDJG_HELLOAGAIN_07_07");	//What about you? You didn't just come here for the pleasure of it, did you? Let's go in there together.
	B_LogEntry (TOPIC_Dragonhunter, "Cipher told me there's a dragon in the swamp of the Valley of Mines.");
	Info_AddChoice (DIA_CipherDJG_HELLOAGAIN, "I prefer to stay alone.", DIA_CipherDJG_HELLOAGAIN_GoAlone);
	Info_AddChoice (DIA_CipherDJG_HELLOAGAIN, "Why not - I could use some help.", DIA_CipherDJG_HELLOAGAIN_GoTogether);
};

func void DIA_CipherDJG_HELLOAGAIN_GoAlone()
{
	AI_Output (other, self, "DIA_CipherDJG_HELLOAGAIN_GoAlone_15_00");	//I prefer to stay alone.
	AI_Output (self, other, "DIA_CipherDJG_HELLOAGAIN_GoAlone_07_01");	//Suit yourself. So I was mistaken about you!
	AI_StopProcessInfos (self);
};

func void DIA_CipherDJG_HELLOAGAIN_GoTogether()
{
	AI_Output (other, self, "DIA_CipherDJG_HELLOAGAIN_GoTogether_15_00");	//Why not - I could use some help.
	AI_Output (self, other, "DIA_CipherDJG_HELLOAGAIN_GoTogether_07_01");	//That's good. Then I can finally get out of here. This stink is unbearable. Just give the word!
	DJG_SwampParty = TRUE;
	Info_ClearChoices(DIA_CipherDJG_HELLOAGAIN);
};


instance DIA_CipherDJG_GOTOGETHERAGAIN(C_Info)
{
	npc = DJG_703_Cipher;
	condition = DIA_CipherDJG_GOTOGETHERAGAIN_Condition;
	information = DIA_CipherDJG_GOTOGETHERAGAIN_Info;
	description = "I changed my mind! Let's go together!";
};


func int DIA_CipherDJG_GOTOGETHERAGAIN_Condition()
{
	if(Npc_KnowsInfo(other,DIA_CipherDJG_HELLOAGAIN) && (DJG_SwampParty == FALSE) && !Npc_IsDead(SwampDragon))
	{
		return TRUE;
	};
};

func void DIA_CipherDJG_GOTOGETHERAGAIN_Info()
{
	AI_Output(other,self,"DIA_CipherDJG_GOTOGETHERAGAIN_15_00");	//I changed my mind! Let's go together!
//	AI_Output(self,other,"DIA_CipherDJG_GOTOGETHERAGAIN_07_01");	//Just give the word!
	AI_Output(self,other,"DIA_Biff_KnowWhereEnemy_No_07_01");	//Well, well. Have fun, then.
	DJG_SwampParty = TRUE;
};


instance DIA_CipherDJG_GO(C_Info)
{
	npc = DJG_703_Cipher;
	condition = DIA_CipherDJG_GO_Condition;
	information = DIA_CipherDJG_GO_Info;
	description = "Now would be a good moment to get going!";
};


func int DIA_CipherDJG_GO_Condition()
{
	if((DJG_SwampParty == TRUE) && !Npc_IsDead(SwampDragon))
	{
		return TRUE;
	};
};


var int DJG_SwampParty_GoGoGo;

func void DIA_CipherDJG_GO_Info()
{
	AI_Output (other, self, "DIA_CipherDJG_GO_15_00");	//Now would be a good moment to get going!
	AI_Output (self, other, "DIA_CipherDJG_GO_07_01");	//Let's go, then!
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_Standup(self);
		B_TurnToNpc(self,other);
	};
	if(!Npc_IsDead(DJG_Rod) && C_BodyStateContains(DJG_Rod,BS_SIT))
	{
		AI_Standup(DJG_Rod);
	};
	AI_StopProcessInfos(self);
	DJG_SwampParty_GoGoGo = TRUE;
	self.npcType = NPCTYPE_FRIEND;
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	Npc_ExchangeRoutine(self,"SwampWait1");
	if(!Npc_IsDead(DJG_Rod))
	{
		DJG_Rod.npcType = NPCTYPE_FRIEND;
		DJG_Rod.aivar[AIV_PARTYMEMBER] = TRUE;
		B_StartOtherRoutine(DJG_Rod,"SwampWait1");
	};
};


instance DIA_CipherDJG_SwampWait2(C_Info)
{
	npc = DJG_703_Cipher;
	condition = DIA_CipherDJG_SwampWait2_Condition;
	information = DIA_CipherDJG_SwampWait2_Info;
	important = TRUE;
};


func int DIA_CipherDJG_SwampWait2_Condition()
{
	if((Npc_GetDistToWP(self,"OW_DJG_SWAMP_WAIT1_01") < 700) && !Npc_IsDead(SwampDragon))
	{
		return TRUE;
	};
};

func void DIA_CipherDJG_SwampWait2_Info()
{
	AI_Output (self, other, "DIA_CipherDJG_SwampWait2_07_00");	//The swamp starts just behind the next bend here. I suggest we go straight through here.
	AI_Output (self, other, "DIA_CipherDJG_SwampWait2_07_01");	//Or you can also check the passage over there, so none of the beasts can attack us from the rear. What do you prefer?
	AI_Output (other, self, "DIA_CipherDJG_SwampWait2_15_02");	//Let's not waste any time!
	Info_AddChoice (DIA_CipherDJG_SwampWait2, Dialog_Ende, DIA_CipherDJG_SwampWait2_weiter);
};

func void DIA_CipherDJG_SwampWait2_weiter()
{
	AI_StopProcessInfos(self);
	DJG_SwampParty = TRUE;
	DJG_SwampParty_GoGoGo = TRUE;
	self.npcType = NPCTYPE_FRIEND;
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	Npc_ExchangeRoutine(self,"SwampWait2");
	if(!Npc_IsDead(DJG_Rod))
	{
		DJG_Rod.npcType = NPCTYPE_FRIEND;
		DJG_Rod.aivar[AIV_PARTYMEMBER] = TRUE;
		B_StartOtherRoutine(DJG_Rod,"SwampWait2");
	};
};


instance DIA_CipherDJG_GoForSwampDragon(C_Info)
{
	npc = DJG_703_Cipher;
	condition = DIA_CipherDJG_GoForSwampDragon_Condition;
	information = DIA_CipherDJG_GoForSwampDragon_Info;
	important = TRUE;
	permanent = FALSE;
};


func int DIA_CipherDJG_GoForSwampDragon_Condition()
{
	if((Npc_GetDistToWP(self,"OW_DJG_SWAMP_WAIT2_01") < 1000) && !Npc_IsDead(SwampDragon))
	{
		return TRUE;
	};
};

func void DIA_CipherDJG_GoForSwampDragon_Info()
{
	if(Npc_KnowsInfo(other,DIA_Dragon_Swamp_Exit))
	{
		AI_Output (self, other, "DIA_CipherDJG_GoForSwampDragon_07_00");	//(bellows) Attack!
		AI_StopProcessInfos (self);
		Npc_ExchangeRoutine (self, "SwampDragon");
		B_StartOtherRoutine (DJG_Rod, "SwampDragon");
	}
	else
	{
		AI_Output (self, other, "DIA_CipherDJG_GoForSwampDragon_07_01");	//I can already hear the creature. We must be careful!
		AI_Output (self, other, "DIA_CipherDJG_GoForSwampDragon_07_02");	//Go ahead and see if we can attack.
		AI_StopProcessInfos (self);
	};
//	self.flags = 0;
//	DJG_Rod.flags = 0;
};


instance DIA_CipherDJG_SWAMPDRAGONDEAD(C_Info)
{
	npc = DJG_703_Cipher;
	condition = DIA_CipherDJG_SWAMPDRAGONDEAD_Condition;
	information = DIA_CipherDJG_SWAMPDRAGONDEAD_Info;
	important = TRUE;
};


func int DIA_CipherDJG_SWAMPDRAGONDEAD_Condition()
{
	if(Npc_IsDead(SwampDragon) && (DJG_SwampParty == TRUE) && (DJG_SwampParty_GoGoGo == TRUE))
	{
		return TRUE;
	};
};

func void DIA_CipherDJG_SWAMPDRAGONDEAD_Info()
{
	AI_Output (self, other, "DIA_CipherDJG_SWAMPDRAGONDEAD_07_00");	//Damn. Is it dead?
	AI_Output (other, self, "DIA_CipherDJG_SWAMPDRAGONDEAD_15_01");	//Calm down. It's over!
	AI_Output (self, other, "DIA_CipherDJG_SWAMPDRAGONDEAD_07_02");	//Boy, what a humdinger.
	AI_StopProcessInfos (self);
	B_GivePlayerXP (XP_CipherDJGDeadDragon);
	DJG_SwampParty = FALSE;
	DJG_SwampParty_GoGoGo = FALSE;
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"Start");
	if(!Npc_IsDead(DJG_Rod))
	{
		DJG_Rod.aivar[AIV_PARTYMEMBER] = FALSE;
		B_StartOtherRoutine(DJG_Rod,"Start");
	};
};


instance DIA_CipherDJG_WHATNEXT(C_Info)
{
	npc = DJG_703_Cipher;
	condition = DIA_CipherDJG_WHATNEXT_Condition;
	information = DIA_CipherDJG_WHATNEXT_Info;
	permanent = TRUE;
	description = "The swamp dragon is dead! What are you going to do now?";
};


func int DIA_CipherDJG_WHATNEXT_Condition()
{
	if(Npc_IsDead(SwampDragon))
	{
		return TRUE;
	};
};

var int DIA_CipherDJG_WHATNEXT_Once;

func void DIA_CipherDJG_WHATNEXT_Info()
{
	AI_Output (other, self, "DIA_CipherDJG_WHATNEXT_15_00");	//The swamp dragon is dead! What are you going to do now?
	AI_Output (self, other, "DIA_CipherDJG_WHATNEXT_07_01");	//No idea. I haven't thought about it, really. At any rate, you could now return to Khorinis as a hero.
	AI_Output (self, other, "DIA_CipherDJG_WHATNEXT_07_02");	//I bet there's a pile to be made out of this. Think about it.
	if(DIA_CipherDJG_WHATNEXT_Once == FALSE)
	{
		B_LogEntry(TOPIC_Dragonhunter,"When the swamp dragon was dead, Cipher said he'd now make big bucks as the great 'hero'. Yeah right. We'll see.");
		DIA_CipherDJG_WHATNEXT_Once = TRUE;
	};
	AI_StopProcessInfos(self);
};


instance DIA_Cipher_KrautPaket_OW(C_Info)
{
	npc = DJG_703_Cipher;
	nr = 800;
	condition = DIA_Cipher_KrautPaket_Condition;
	information = DIA_Cipher_KrautPaket_Info;
	permanent = FALSE;
	description = "Would this package of swampweed happen to be yours?";
};


instance DIA_Cipher_PICKPOCKET(C_Info)
{
	npc = DJG_703_Cipher;
	nr = 900;
	condition = DIA_Cipher_PICKPOCKET_Condition;
	information = DIA_Cipher_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Cipher_PICKPOCKET_Condition()
{
	return C_Beklauen(79,220);
};

func void DIA_Cipher_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Cipher_PICKPOCKET);
	Info_AddChoice(DIA_Cipher_PICKPOCKET,Dialog_Back,DIA_Cipher_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Cipher_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Cipher_PICKPOCKET_DoIt);
};

func void DIA_Cipher_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Cipher_PICKPOCKET);
};

func void DIA_Cipher_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Cipher_PICKPOCKET);
};

