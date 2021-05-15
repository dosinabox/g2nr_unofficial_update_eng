
instance DIA_Ramirez_EXIT(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 999;
	condition = DIA_Ramirez_EXIT_Condition;
	information = DIA_Ramirez_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Ramirez_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Ramirez_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Ramirez_PICKPOCKET(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 900;
	condition = DIA_Ramirez_PICKPOCKET_Condition;
	information = DIA_Ramirez_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Ramirez_PICKPOCKET_Condition()
{
	return C_Beklauen(90,300);
};

func void DIA_Ramirez_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Ramirez_PICKPOCKET);
	Info_AddChoice(DIA_Ramirez_PICKPOCKET,Dialog_Back,DIA_Ramirez_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Ramirez_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Ramirez_PICKPOCKET_DoIt);
};

func void DIA_Ramirez_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Ramirez_PICKPOCKET);
};

func void DIA_Ramirez_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Ramirez_PICKPOCKET);
};


instance DIA_Ramirez_Zeichen(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 800;
	condition = DIA_Ramirez_Zeichen_Condition;
	information = DIA_Ramirez_Zeichen_Info;
	permanent = FALSE;
	description = DIALOG_SecretSign;
};


func int DIA_Ramirez_Zeichen_Condition()
{
	if(Knows_SecretSign == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Ramirez_Zeichen_Info()
{
	AI_PlayAni (other, "T_YES");
	AI_Output (self, other, "DIA_Ramirez_Zeichen_14_00");	//Well, well, you know the sign. (yawns) I'm impressed.
};


instance DIA_Ramirez_Hallo(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 2;
	condition = DIA_Ramirez_Hallo_Condition;
	information = DIA_Ramirez_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Ramirez_Hallo_Condition()
{
	if((Join_Thiefs == FALSE) && !Npc_IsDead(Cassia) && !Npc_IsDead(Jesper))
	{
		return TRUE;
	};
};

func void DIA_Ramirez_Hallo_Info()
{
		AI_Output (self, other, "DIA_Ramirez_Hallo_14_00");	//Have you lost your way? I don't think this is the right place for you.
		AI_Output (self, other, "DIA_Ramirez_Hallo_14_01");	//If anything happens to you here, no one's going to help you. So be careful. (broad grin)
	AI_StopProcessInfos(self);
};


instance DIA_Ramirez_Hallo_Joined(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 2;
	condition = DIA_Ramirez_Hallo_Joined_Condition;
	information = DIA_Ramirez_Hallo_Joined_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Ramirez_Hallo_Joined_Condition()
{
	if((Join_Thiefs == TRUE) && !Npc_IsDead(Cassia) && !Npc_IsDead(Jesper))
	{
		return TRUE;
	};
};

func void DIA_Ramirez_Hallo_Joined_Info()
{
		AI_Output (self, other, "DIA_Ramirez_Hallo_14_02");	//So you're in. Well, I wish you success then - and be careful, whatever you do.
		AI_Output (self, other, "DIA_Ramirez_Hallo_14_03");	//Oh, and one more thing - I don't care who you are up there, and with whom you work.
		AI_Output (self, other, "DIA_Ramirez_Hallo_14_04");	//Here below, you're only one of us. A thief. No more and no less.
};


instance DIA_Ramirez_Beute(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 3;
	condition = DIA_Ramirez_Beute_Condition;
	information = DIA_Ramirez_Beute_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Ramirez_Beute_Condition()
{
	if(Npc_IsDead(Cassia) || Npc_IsDead(Jesper))
	{
		return FALSE;
	}
	else if(Npc_GetDistToWP(self,"NW_CITY_KANAL_ROOM_04_01") < 1000)
	{
		if(Mob_HasItems("THIEF_CHEST_01",ItMi_Gold) < 50)
		{
			return TRUE;
		};
		if(Mob_HasItems("THIEF_CHEST_02",ItMi_Gold) < 100)
		{
			return TRUE;
		};
		if(!Mob_HasItems("THIEF_CHEST_02",ItMi_SilverCup))
		{
			return TRUE;
		};
		if(Mob_HasItems("THIEF_CHEST_03",ItMi_Gold) < 75)
		{
			return TRUE;
		};
		if(Mob_HasItems("THIEF_CHEST_03",ItRw_Bolt) < 25)
		{
			return TRUE;
		};
		if(Mob_HasItems("THIEF_CHEST_03",ItRw_Arrow) < 25)
		{
			return TRUE;
		};
	}
	else if(Npc_GetDistToWP(self,"NW_CITY_KANAL_ROOM_05_02") < 1000)
	{
		if(Mob_HasItems("THIEF_CHEST_04",ItMi_Gold) < 100)
		{
			return TRUE;
		};
		if(Mob_HasItems("THIEF_CHEST_04",ItSc_InstantFireball) < 2)
		{
			return TRUE;
		};
		if(!Mob_HasItems("THIEF_CHEST_04",ItSc_LightHeal))
		{
			return TRUE;
		};
		if(!Mob_HasItems("THIEF_CHEST_04",ItSc_ChargeFireball))
		{
			return TRUE;
		};
	};
};

func void DIA_Ramirez_Beute_Info()
{
	AI_Output (self, other, "DIA_Ramirez_Beute_14_00");	//Listen, you can't be serious, can you? You're bagging our gold ... you're trying to steal from us?
	if(Join_Thiefs == TRUE)
	{
	AI_Output (other, self, "DIA_Ramirez_Beute_15_01");	//Don't get all worked up over a couple of coins.
	AI_Output (other, self, "DIA_Ramirez_Beute_15_02");	//I mean, this bit of stuff here - is that ALL of your booty? That's all the thieves' guild of Khorinis has to offer?
	AI_Output (self, other, "DIA_Ramirez_Beute_14_03");	//Who says our booty is stored down here?
	AI_Output (other, self, "DIA_Ramirez_Beute_15_04");	//I couldn't quite believe that, either. So where did you hide your treasures?
	AI_Output (self, other, "DIA_Ramirez_Beute_14_05");	//In a very safe place.
	AI_Output (other, self, "DIA_Ramirez_Beute_15_06");	//I see.
	AI_Output (self, other, "DIA_Ramirez_Beute_14_07");	//All right, you can keep the gold. But I'll keep an eye on you. So don't overdo it.
	}
	else
	{
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_NONE,1);
	};
};


instance DIA_Ramirez_Bezahlen(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 9;
	condition = DIA_Ramirez_Bezahlen_Condition;
	information = DIA_Ramirez_Bezahlen_Info;
	permanent = TRUE;
	description = "Can you teach me something?";
};


var int DIA_Ramirez_Bezahlen_permanent;

func int DIA_Ramirez_Bezahlen_Condition()
{
	if((Join_Thiefs == TRUE) && (DIA_Ramirez_Bezahlen_permanent == FALSE) && Npc_KnowsInfo(other,DIA_Cassia_Lernen))
	{
		return TRUE;
	};
};

func void DIA_Ramirez_Bezahlen_Info()
{
	if(MIS_ThiefGuild_sucked == FALSE)
	{
		Ramirez_Cost = 150;
	}
	else
	{
		Ramirez_Cost = 300;
	};
	AI_Output(other,self,"DIA_Ramirez_Bezahlen_15_00");	//Can you teach me something?
	if(Npc_GetTalentSkill(other,NPC_TALENT_PICKLOCK))
	{
		AI_Output (self, other, "DIA_Ramirez_Bezahlen_14_01");	//I can't teach you anything. You already know everything about picking locks.
		if (other.attribute[ATR_DEXTERITY] < T_MAX)
		{
			AI_Output (self, other, "DIA_Ramirez_Add_14_00");	//Now you only need to improve your dexterity ...
		};
		DIA_Ramirez_Bezahlen_permanent = TRUE;
		Info_ClearChoices(DIA_Ramirez_Bezahlen);
	}
	else
	{
		AI_Output (self, other, "DIA_Ramirez_Bezahlen_14_02");	//I can show you how to pick a lock. That'll cost you a mere ...
		B_Say_Gold (self, other, Ramirez_Cost);
		Info_ClearChoices (DIA_Ramirez_Bezahlen);
		Info_AddChoice (DIA_Ramirez_Bezahlen, "Maybe later ...(BACK)", DIA_Ramirez_Bezahlen_Spaeter);
		Info_AddChoice (DIA_Ramirez_Bezahlen, "OK, I'll pay ...", DIA_Ramirez_Bezahlen_Okay);
	};
};

func void DIA_Ramirez_Bezahlen_Spaeter()
{
	DIA_Common_MaybeLater();
	Info_ClearChoices(DIA_Ramirez_Bezahlen);
};

func void DIA_Ramirez_Bezahlen_Okay()
{
	AI_Output (other, self, "DIA_Ramirez_Bezahlen_Okay_15_00");	//OK, I'll pay ...
	if (B_GiveInvItems (other, self, ItMi_Gold, Ramirez_Cost))
	{
		AI_Output (other, self, "DIA_Ramirez_Bezahlen_Okay_15_01");	//...here's the gold.
		AI_Output (self, other, "DIA_Ramirez_Bezahlen_Okay_14_02");	//Great. I'm at your service.
		Ramirez_TeachPlayer = TRUE;
		DIA_Ramirez_Bezahlen_permanent = TRUE;
		Info_ClearChoices(DIA_Ramirez_Bezahlen);
	}
	else
	{
		AI_Output (self, other, "DIA_Ramirez_Bezahlen_Okay_14_03");	//Get the gold, then, and come back.
		Info_ClearChoices (DIA_Ramirez_Bezahlen);
	};
};


instance DIA_Ramirez_Teach(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 99;
	condition = DIA_Ramirez_Teach_Condition;
	information = DIA_Ramirez_Teach_Info;
	permanent = TRUE;
//	description = B_BuildLearnString("Teach me how to pick a lock!",B_GetLearnCostTalent(other,NPC_TALENT_PICKLOCK,1));
	description = B_BuildLearnString(NAME_Skill_PickLock,B_GetLearnCostTalent(other,NPC_TALENT_PICKLOCK,1));
};


func int DIA_Ramirez_Teach_Condition()
{
	if((Ramirez_TeachPlayer == TRUE) && !Npc_GetTalentSkill(other,NPC_TALENT_PICKLOCK))
	{
		return TRUE;
	};
};

func void DIA_Ramirez_Teach_Info()
{
	AI_Output (other, self, "DIA_Ramirez_Teach_15_00");	//Show me how to pick a lock!
	if (Ramirez_Zweimal == FALSE)
	{
		AI_Output (self, other, "DIA_Ramirez_Teach_14_06");	//Lock picking is the high art of thieves.
		AI_Output (self, other, "DIA_Ramirez_Teach_14_01");	//You need a lot of feeling and intuition. And a couple of good lock picks.
		AI_Output (self, other, "DIA_Ramirez_Teach_14_02");	//Some chests, however, are fitted with special locks which can only be opened with the corresponding key.
		Ramirez_Zweimal = TRUE;
	};
	if(B_TeachThiefTalent(self,other,NPC_TALENT_PICKLOCK))
	{
		AI_Output (self, other, "DIA_Ramirez_Teach_14_03");	//So, kneeling in front of the lock, turn your lock pick to the left and right.
		AI_Output (self, other, "DIA_Ramirez_Teach_14_04");	//If you twist it too fast or too hard, it will break.
		AI_Output (self, other, "DIA_Ramirez_Teach_14_05");	//But the more adept you become, the easier you'll find it to handle the tool.
	};
};


instance DIA_Ramirez_Viertel(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 8;
	condition = DIA_Ramirez_Viertel_Condition;
	information = DIA_Ramirez_Viertel_Info;
	permanent = TRUE;
	description = "Where is it worth the trouble to break in?";
};


func int DIA_Ramirez_Viertel_Condition()
{
	if((Join_Thiefs == TRUE) && (RamirezToldAboutWambo == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Ramirez_Viertel_Info()
{
	AI_Output (other, self, "DIA_Ramirez_Viertel_15_00");	//Where is it worth the trouble to break in?
	AI_Output (self, other, "DIA_Ramirez_Viertel_14_01");	//In the upper quarter of town, of course.
	if(Npc_KnowsInfo(other,DIA_Ramirez_Zeichen))
	{
	AI_Output (self, other, "DIA_Ramirez_Viertel_14_02");	//But if you want to break in somewhere up there, wait until night - everyone's asleep then - except for the city guards.
	AI_Output (self, other, "DIA_Ramirez_Viertel_14_03");	//They patrol at night. I know one of them - Wambo. He's the only one interested in gold.
	AI_Output (self, other, "DIA_Ramirez_Viertel_14_04");	//He's expensive, but once you've paid him you don't have to worry any more.
		RamirezToldAboutWambo = TRUE;
	}
	else
	{
		AI_StopProcessInfos(self);
	};	
};


instance DIA_Ramirez_Sextant(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 2;
	condition = DIA_Ramirez_Sextant_Condition;
	information = DIA_Ramirez_Sextant_Info;
	permanent = FALSE;
	description = "Have you got a job for me?";
};


func int DIA_Ramirez_Sextant_Condition()
{
//	if((MIS_CassiaRing == LOG_SUCCESS) && (Kapitel >= 2) && Npc_KnowsInfo(other,DIA_Ramirez_Zeichen))
	if(Join_Thiefs == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Ramirez_Sextant_Info()
{
	AI_Output (other, self, "DIA_Ramirez_Sextant_15_00");	//Have you got a job for me?
	AI_Output (self, other, "DIA_Ramirez_Sextant_14_01");	//Hmm ... there is a thing that I'd like to have. But I haven't found one so far.
	AI_Output (other, self, "DIA_Ramirez_Sextant_15_02");	//What can I get you?
	AI_Output (self, other, "DIA_Ramirez_Sextant_14_03");	//A sextant. Bring me a sextant - I'll pay you a good price for it.
	Log_CreateTopic (Topic_RamirezSextant, LOG_MISSION);
	Log_SetTopicStatus (Topic_RamirezSextant, LOG_Running);
	B_LogEntry (Topic_RamirezSextant, "Ramirez wants me to bring him a sextant.");
	MIS_RamirezSextant = LOG_Running;
};


instance DIA_Ramirez_Success(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 2;
	condition = DIA_Ramirez_Success_Condition;
	information = DIA_Ramirez_Success_Info;
	permanent = FALSE;
	description = "I've got a sextant for you.";
};


func int DIA_Ramirez_Success_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Ramirez_Sextant) && Npc_HasItems(other,ItMi_Sextant))
	{
		return TRUE;
	};
};

func void DIA_Ramirez_Success_Info()
{
	AI_Output(other,self,"DIA_Ramirez_Success_15_00");	//I've got a sextant for you.
	B_GiveInvItems(other,self,ItMi_Sextant,1);
	AI_Output (self, other, "DIA_Ramirez_Success_14_01");	//Incredible. You actually managed to find one.
	AI_Output (self, other, "DIA_Ramirez_Success_14_02");	//Here, you have really earned your pay.
	B_GiveInvItems(self,other,ItMi_Gold,Value_Sextant / 2);
//	Ramirez_Sextant = TRUE;
	MIS_RamirezSextant = LOG_SUCCESS;
	B_GivePlayerXP(XP_RamirezSextant);
};


func void B_ThievesKiller()
{
	if(MIS_CassiaRing == LOG_Running)
	{
		MIS_CassiaRing = LOG_FAILED;
	};
	if(MIS_CassiaKelche == LOG_Running)
	{
		MIS_CassiaKelche = LOG_FAILED;
	};
	if(MIS_RamirezSextant == LOG_Running)
	{
		MIS_RamirezSextant = LOG_FAILED;
	};
	B_CheckLog();
	SewerThieves_KilledByPlayer = TRUE;
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,1);
};

instance DIA_Ramirez_Killer(C_Info)
{
	npc = VLK_445_Ramirez;
	nr = 1;
	condition = DIA_Ramirez_Killer_Condition;
	information = DIA_Ramirez_Killer_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Ramirez_Killer_Condition()
{
	if(Npc_IsDead(Cassia) || Npc_IsDead(Jesper))
	{
		return TRUE;
	};
};

func void DIA_Ramirez_Killer_Info()
{
	B_Say(self,other,"$YOUMURDERER");
	B_ThievesKiller();
};

