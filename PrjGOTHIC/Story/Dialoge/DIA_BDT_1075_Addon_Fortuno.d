
instance DIA_Addon_Fortuno_EXIT(C_Info)
{
	npc = BDT_1075_Addon_Fortuno;
	nr = 999;
	condition = DIA_Addon_Fortuno_EXIT_Condition;
	information = DIA_Addon_Fortuno_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Fortuno_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Fortuno_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Fortuno_PICKPOCKET(C_Info)
{
	npc = BDT_1075_Addon_Fortuno;
	nr = 900;
	condition = DIA_Addon_Fortuno_PICKPOCKET_Condition;
	information = DIA_Addon_Fortuno_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Addon_Fortuno_PICKPOCKET_Condition()
{
	return C_Beklauen(10,25);
};

func void DIA_Addon_Fortuno_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Fortuno_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Fortuno_PICKPOCKET,Dialog_Back,DIA_Addon_Fortuno_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Fortuno_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Fortuno_PICKPOCKET_DoIt);
};

func void DIA_Addon_Fortuno_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Fortuno_PICKPOCKET);
};

func void DIA_Addon_Fortuno_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Fortuno_PICKPOCKET);
};


instance DIA_Addon_Fortuno_Hi(C_Info)
{
	npc = BDT_1075_Addon_Fortuno;
	nr = 2;
	condition = DIA_Addon_Fortuno_Hi_Condition;
	information = DIA_Addon_Fortuno_Hi_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Fortuno_Hi_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Fortuno_Geheilt_01 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Fortuno_Hi_Info()
{
	if(MIS_Fortuno_Delusion == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Fortuno_Hi_13_00");	//(anxiously) A dark cloud over the house... the one approaches...
		AI_Output (self, other, "DIA_Addon_Fortuno_Hi_13_01");	//With blood... needed to call him... HE who sees me... he sees me... oh, no, go away, begone...
		AI_Output (other, self, "DIA_Addon_Fortuno_Hi_15_02");	//Are you all right?
		MIS_Fortuno_Delusion = LOG_Running;
		Log_CreateTopic(Topic_Addon_Fortuno,LOG_MISSION);
		Log_SetTopicStatus(Topic_Addon_Fortuno,LOG_Running);
		B_LogEntry(Topic_Addon_Fortuno,"Fortuno is out of his mind. He is looking for a 'green novice'.");
	};
	AI_Output(self,other,"DIA_Addon_Fortuno_Hi_13_03");	//Green... green novice... I cannot find it...
	Info_ClearChoices(DIA_Addon_Fortuno_Hi);
	Info_AddChoice(DIA_Addon_Fortuno_Hi,Dialog_Ende_v4,DIA_Addon_Fortuno_Hi_BACK);
	Info_AddChoice(DIA_Addon_Fortuno_Hi,"How can I help you?",DIA_Addon_Fortuno_Hi_HILFE);
	if(Npc_HasItems(other,ItMi_Joint))
	{
		Info_AddChoice (DIA_Addon_Fortuno_Hi, "Here, take this swampweed.", DIA_Addon_Fortuno_Hi_JOINT);
	};
	if(Npc_HasItems(other,ItMi_Addon_Joint_01))
	{
		Info_AddChoice (DIA_Addon_Fortuno_Hi, "Here, take this 'Green Novice'.", DIA_Addon_Fortuno_Hi_GREEN);
	};
	EnteredBanditsCamp = TRUE;
};

func void DIA_Addon_Fortuno_Hi_BACK()
{
	Info_ClearChoices(DIA_Addon_Fortuno_Hi);
	DIA_Common_IllBeBackLater();
	AI_WaitTillEnd(self,other);
	AI_StopProcessInfos(self);
};

func void DIA_Addon_Fortuno_Hi_HILFE()
{
	AI_Output (other, self, "DIA_Addon_Fortuno_Hi_HILFE_15_00");	//How can I help you?
	AI_Output (self, other, "DIA_Addon_Fortuno_Hi_HILFE_13_01");	//The green... the green novice will help the novice...
};

func void DIA_Addon_Fortuno_Hi_JOINT()
{
	AI_Output(other,self,"DIA_Addon_Fortuno_Hi_JOINT_15_00");	//Here, take this swampweed.
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(other,self,ItMi_Joint,1);
	AI_UseItem(self,ItMi_Joint);
	AI_Output(self,other,"DIA_Addon_Fortuno_Hi_JOINT_13_01");	//Not green, not strong, not green, not strong...
};

func void DIA_Addon_Fortuno_Hi_GREEN()
{
	AI_Output(other,self,"DIA_Addon_Fortuno_Hi_GREEN_15_00");	//Here, take this 'Green Novice'.
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(other,self,ItMi_Addon_Joint_01,1);
	AI_UseItem(self,ItMi_Addon_Joint_01);
	AI_Output(self,other,"DIA_Addon_Fortuno_Hi_GREEN_13_01");	//(recovering) AAAHHH...
	AI_Output(self,other,"DIA_Addon_Fortuno_Hi_GREEN_13_02");	//My head... who... I am... Fortuno... what... what is wrong?
	Info_ClearChoices(DIA_Addon_Fortuno_Hi);
	Fortuno_Geheilt_01 = TRUE;
	B_GivePlayerXP (XP_Addon_Fortuno_01);
	B_LogEntry (Topic_Addon_Fortuno, "The 'green novice' has helped Fortuno clear his head.");
};


instance DIA_Addon_Fortuno_wer(C_Info)
{
	npc = BDT_1075_Addon_Fortuno;
	nr = 2;
	condition = DIA_Addon_Fortuno_wer_Condition;
	information = DIA_Addon_Fortuno_wer_Info;
	permanent = FALSE;
	description = "So, tell me what is wrong with you.";
};


func int DIA_Addon_Fortuno_wer_Condition()
{
	if(Fortuno_Geheilt_01 == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Fortuno_wer_Info()
{
	AI_Output (other, self, "DIA_Addon_Fortuno_wer_15_00");	//So, tell me what is wrong with you.
	AI_Output (self, other, "DIA_Addon_Fortuno_wer_13_01");	//Once I belonged to the Brotherhood of the Sleeper. Everything was all right back then.
	AI_Output (self, other, "DIA_Addon_Fortuno_wer_13_02");	//Fine, we were all condemned crimials, but for us novices life was free from care...
	AI_Output (other, self, "DIA_Addon_Fortuno_wer_15_03");	//Hey, I was a prisoner in the Valley of Mines myself. Tell me something new.
	AI_Output (self, other, "DIA_Addon_Fortuno_wer_13_04");	//I... I don't remember anything. Darkness lies across my mind...
	AI_Output (other, self, "DIA_Addon_Fortuno_wer_15_05");	//Come on, concentrate. What happened? When did you come back to your senses?
	AI_Output (self, other, "DIA_Addon_Fortuno_wer_13_06");	//Raven... I only remember Raven and... and dark rooms.
	AI_Output (other, self, "DIA_Addon_Fortuno_wer_15_07");	//What about Raven? What did he do to you?
	AI_Output (self, other, "DIA_Addon_Fortuno_wer_13_08");	//(sighs) I'm sorry. It's as though my mind were held prisoner... I don't understand it myself...
};


instance DIA_Addon_Fortuno_FREE(C_Info)
{
	npc = BDT_1075_Addon_Fortuno;
	nr = 5;
	condition = DIA_Addon_Fortuno_FREE_Condition;
	information = DIA_Addon_Fortuno_FREE_Info;
	permanent = FALSE;
	description = "There must be a way to refresh your memory.";
};


func int DIA_Addon_Fortuno_FREE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Fortuno_wer))
	{
		return TRUE;
	};
};

func void DIA_Addon_Fortuno_FREE_Info()
{
	AI_Output (other, self, "DIA_Addon_Fortuno_FREE_15_00");	//There must be a way to refresh your memory.
	AI_Output (self, other, "DIA_Addon_Fortuno_FREE_13_01");	//Yes... yes, maybe there is a way.
	AI_Output (self, other, "DIA_Addon_Fortuno_FREE_13_02");	//The gurus knew of various forms of altering the spirit and the will.
	AI_Output (other, self, "DIA_Addon_Fortuno_FREE_15_03");	//Do YOU remember anything about that?
	AI_Output (self, other, "DIA_Addon_Fortuno_FREE_13_04");	//No, I'm afraid this knowledge vanished with the gurus...
	AI_Output (other, self, "DIA_Addon_Fortuno_FREE_15_05");	//Damn. Well - if there is a way to free your spirit, I'll find it.
	Wld_InsertNpc (Bloodfly, "ADW_PATH_TO_BL_09");
	Wld_InsertNpc (Bloodfly, "ADW_PATH_TO_BL_10");
	Wld_InsertNpc (Bloodfly, "ADW_PATH_TO_BL_10");
	Wld_InsertNpc (Bloodfly, "ADW_PATH_TO_LOCH_01");
	Wld_InsertNpc (Bloodfly, "ADW_PATH_TO_LOCH_01");
	B_LogEntry (Topic_Addon_Fortuno, "Fortuno has regained his senses, but he still remembers nothing.");
};


instance DIA_Addon_Fortuno_Herb(C_Info)
{
	npc = BDT_1075_Addon_Fortuno;
	nr = 99;
	condition = DIA_Addon_Fortuno_Herb_Condition;
	information = DIA_Addon_Fortuno_Herb_Info;
	permanent = FALSE;
	description = "Do you need more swampweed?";
};


func int DIA_Addon_Fortuno_Herb_Condition()
{
	if(Fortuno_Geheilt_01 == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Fortuno_Herb_Info()
{
	AI_Output (other, self, "DIA_Addon_Fortuno_Herb_15_00");	//Do you need more swampweed?
	AI_Output (self, other, "DIA_Addon_Fortuno_Herb_13_01");	//Yeeesss, definitely. I will buy all the swampweed you can get your hands on.
	AI_Output (self, other, "DIA_Addon_Fortuno_Herb_13_02");	//I'll even pay you more for it than Fisk.
};

func void B_Fortuno_InfoManager()
{
	Info_ClearChoices(DIA_Addon_Fortuno_Trade);
	Info_AddChoice(DIA_Addon_Fortuno_Trade,Dialog_Back,DIA_Addon_Fortuno_Trade_BACK);
	if(Npc_HasItems(other,ItPl_SwampHerb) > 1)
	{
		Info_AddChoice(DIA_Addon_Fortuno_Trade,"(hand over all swampweed)",DIA_Addon_Fortuno_Trade_all);
	};
	Info_AddChoice(DIA_Addon_Fortuno_Trade,"(hand over 1 swampweed)",DIA_Addon_Fortuno_Trade_1);
};


instance DIA_Addon_Fortuno_Trade(C_Info)
{
	npc = BDT_1075_Addon_Fortuno;
	nr = 100;
	condition = DIA_Addon_Fortuno_Trade_Condition;
	information = DIA_Addon_Fortuno_Trade_Info;
	permanent = TRUE;
	description = "I've got swampweed for you...";
};


func int DIA_Addon_Fortuno_Trade_Condition()
{
	if(Npc_HasItems(other,ItPl_SwampHerb) && Npc_KnowsInfo(other,DIA_Addon_Fortuno_Herb))
	{
		return TRUE;
	};
};

func void DIA_Addon_Fortuno_Trade_Info()
{
	AI_Output (other, self, "DIA_Addon_Fortuno_Trade_15_00");	//I've got swampweed for you...
	B_Fortuno_InfoManager ();
};

func void DIA_Addon_Fortuno_Trade_BACK()
{
	Info_ClearChoices(DIA_Addon_Fortuno_Trade);
};

func void DIA_Addon_Fortuno_Trade_all()
{
	var int amount;
	amount = Npc_HasItems(other,ItPl_SwampHerb);
	B_GiveInvItems(other,self,ItPl_SwampHerb,amount);
	Npc_RemoveInvItems(self,ItPl_SwampHerb,Npc_HasItems(self,ItPl_SwampHerb));
	B_GiveInvItems(self,other,ItMi_Gold,amount * Value_SwampHerb);
	B_GivePlayerXP(amount * 10);
	Info_ClearChoices(DIA_Addon_Fortuno_Trade);
};

func void DIA_Addon_Fortuno_Trade_1()
{
	B_GiveInvItems(other,self,ItPl_SwampHerb,1);
	Npc_RemoveInvItems(self,ItPl_SwampHerb,Npc_HasItems(self,ItPl_SwampHerb));
	B_GiveInvItems(self,other,ItMi_Gold,Value_SwampHerb);
	B_GivePlayerXP(10);
	if(Npc_HasItems(other,ItPl_SwampHerb))
	{
		AI_PrintScreen(ConcatStrings("Осталось болотной травы: ",IntToString(Npc_HasItems(other,ItPl_SwampHerb))),-1,-1,FONT_ScreenSmall,2);
		B_Fortuno_InfoManager();
	}
	else
	{
		Info_ClearChoices(DIA_Addon_Fortuno_Trade);
	};
};


instance DIA_Addon_Fortuno_Trank(C_Info)
{
	npc = BDT_1075_Addon_Fortuno;
	nr = 3;
	condition = DIA_Addon_Fortuno_Trank_Condition;
	information = DIA_Addon_Fortuno_Trank_Info;
	permanent = FALSE;
	description = "I've got a potion for you...";
};


func int DIA_Addon_Fortuno_Trank_Condition()
{
	if((Fortuno_Geheilt_01 == TRUE) && Npc_KnowsInfo(other,DIA_Addon_Fortuno_FREE) && (Npc_HasItems(other,ItPo_Addon_Geist_01) || Npc_HasItems(other,ItPo_Addon_Geist_02)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Fortuno_Trank_Info()
{
	AI_Output (other, self, "DIA_Addon_Fortuno_Trank_15_00");	//I have a potion for you. It will help you to remember.
	AI_Output (self, other, "DIA_Addon_Fortuno_Trank_13_01");	//I trust you.
	if(Npc_HasItems(other,ItPo_Addon_Geist_02))
	{
		B_GiveInvItems(other,self,ItPo_Addon_Geist_02,1);
		AI_UseItem(self,ItPo_Addon_Geist_02);
		B_GivePlayerXP(XP_Addon_Fortuno_02);
	}
	else if(B_GiveInvItems(other,self,ItPo_Addon_Geist_01,1))
	{
		AI_StopProcessInfos(self);
		AI_UseItem(self,ItPo_Addon_Geist_01);
	};
};


instance DIA_Addon_Fortuno_more(C_Info)
{
	npc = BDT_1075_Addon_Fortuno;
	nr = 2;
	condition = DIA_Addon_Fortuno_more_Condition;
	information = DIA_Addon_Fortuno_more_Info;
	permanent = FALSE;
	description = "And...?";
};


func int DIA_Addon_Fortuno_more_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Fortuno_Trank))
	{
		return TRUE;
	};
};

func void DIA_Addon_Fortuno_more_Info()
{
	AI_Output (other, self, "DIA_Addon_Fortuno_more_15_00");	//And...?
	AI_Output (self, other, "DIA_Addon_Fortuno_more_13_01");	//Aah! I... I remember again! Now I see... Adanos be with me - what have I done?
	AI_Output (other, self, "DIA_Addon_Fortuno_more_15_02");	//Yes, what have you done? And above all - what has Raven done?
	AI_Output (self, other, "DIA_Addon_Fortuno_more_13_03");	//I helped him... to make contact. With HIM. He wanted various elixirs... I brewed them for him.
	AI_Output (self, other, "DIA_Addon_Fortuno_more_13_04");	//He tried to open the portal to get into the temple.
	AI_Output (other, self, "DIA_Addon_Fortuno_more_15_05");	//Why? What does he want in the temple?
	AI_Output (self, other, "DIA_Addon_Fortuno_more_13_06");	//A powerful artifact... it lies buried together with the one who once bore it. A mighty warrior who fell to HIM...
	AI_Output (other, self, "DIA_Addon_Fortuno_more_15_07");	//And then?
	AI_Output (self, other, "DIA_Addon_Fortuno_more_13_08");	//We couldn't open the portal...
	AI_Output (self, other, "DIA_Addon_Fortuno_more_13_09");	//But Raven was SURE that he could, if he had the tomb of the priest excavated.
	AI_Output (self, other, "DIA_Addon_Fortuno_more_13_10");	//That's why he brought the slaves here. Victims he could force to dig where the powers of time lie at rest.
	AI_Output (other, self, "DIA_Addon_Fortuno_more_15_11");	//Tomb of the priest?
	AI_Output (self, other, "DIA_Addon_Fortuno_more_13_12");	//The resting place of a priest of Adanos. It lies in the mine.
	AI_Output (self, other, "DIA_Addon_Fortuno_more_13_13");	//I also remember the stone tablets. He believed that they would show him the way.
	AI_Output (self, other, "DIA_Addon_Fortuno_more_13_14");	//And once he was able to decipher the characters on them, he no longer needed me.
	AI_Output (self, other, "DIA_Addon_Fortuno_more_13_15");	//He put a spell of forgetfulness on me and... and you have freed me.
	MIS_Fortuno_Delusion = LOG_SUCCESS;
	B_LogEntry (TOPIC_Addon_RavenKDW, "Raven wants to recover a powerful artifact from the temple of Adanos.");
	Log_AddEntry (TOPIC_Addon_RavenKDW, "For some reason Raven has had the tomb of a priest of the old culture excavated in the mine.");
	Log_AddEntry (TOPIC_Addon_RavenKDW, "Raven believes that some stone tablets will help him with his plans.");
	Npc_ExchangeRoutine(self,"START");
	B_StartOtherRoutine(BDT_10006_Addon_Bandit,"FORTUNO");
	B_StartOtherRoutine(BDT_10010_Addon_Bandit,"FORTUNO");
	B_GivePlayerXP(XP_Addon_Fortuno_03);
};


instance DIA_Addon_Fortuno_Attentat(C_Info)
{
	npc = BDT_1075_Addon_Fortuno;
	nr = 9;
	condition = DIA_Addon_Fortuno_Attentat_Condition;
	information = DIA_Addon_Fortuno_Attentat_Info;
	permanent = FALSE;
	description = DIALOG_ADDON_ATTENTAT_DESCRIPTION;
};


func int DIA_Addon_Fortuno_Attentat_Condition()
{
	if((MIS_Judas == LOG_Running) && Npc_KnowsInfo(other,DIA_Addon_Fortuno_Trank))
	{
		return TRUE;
	};
};

func void DIA_Addon_Fortuno_Attentat_Info()
{
	B_Say (other, self, "$ATTENTAT_ADDON_DESCRIPTION");
	AI_Output (self, other, "DIA_Addon_Fortuno_Attentat_13_00");	//Attack? Sorry, I was... absent... for some time. I don't know anything about it.
};

