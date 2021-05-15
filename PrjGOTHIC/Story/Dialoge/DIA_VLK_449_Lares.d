
var int LaresToldAboutKDW1;
var int LaresToldAboutKDW2;

func void DIA_Addon_Lares_Patch_WhereTo()
{
	if(LaresToldAboutKDW1 == FALSE)
	{
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_teil2_09_00");	//We lads from the former New Camp still have good relations with the Water Mages.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_teil2_09_01");	//Even Lee will still protect the Water Mages against any danger today if it is within his power.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_teil2_09_02");	//To keep up the contact with the Water Mages, I'm in town most of the time, working together with Vatras.
		LaresToldAboutKDW1 = TRUE;
	};
	if(LaresToldAboutKDW2 == FALSE)
	{
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter2_09_00");	//The Water Mages are all beside themselves. They've been digging at an excavation site in the north-east for weeks. It's anybody's guess what they're trying to find there.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter2_09_01");	//It all started when the earth began trembling like it did in the worst times of the Barrier.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter2_09_02");	//Horrible stone creatures emerged from the ground, slaying everyone who went within 100 feet of them.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter2_09_03");	//The Water Mages took the matter in hand and destroyed those hostile invaders. And now they're digging down there, searching for an explanation for these strange events.
		Log_CreateTopic(TOPIC_Addon_KDW,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_KDW,LOG_Running);
		B_LogEntry(TOPIC_Addon_KDW,"Lares told me about the Water Mages' excavation site. They are investigating some peculiar events. There have been mysterious earthquakes, and strange stone creatures emerging from the ground.");
		LaresToldAboutKDW2 = TRUE;
	};
	AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortal_09_04");	//And one more thing: Don't even think about strolling around for long with this ornament. Go DIRECTLY to Saturas.
	B_GiveInvItems(self,other,ItMi_Ornament_Addon_Vatras,1);
	Info_ClearChoices(DIA_Addon_Lares_Patch);
};

instance DIA_Addon_Lares_Patch(C_Info)
{
	npc = VLK_449_Lares;
	nr = 99;
	condition = DIA_Addon_Lares_Patch_Condition;
	information = DIA_Addon_Lares_Patch_Info;
	description = "я могу отнести орнамент!";
};


func int DIA_Addon_Lares_Patch_Condition()
{
	if(Npc_HasItems(self,ItMi_Ornament_Addon_Vatras) && (Kapitel >= 3) && (ENTERED_ADDONWORLD == FALSE) && !Npc_HasItems(other,ItMi_Ornament_Addon_Vatras) && (MIS_Addon_Lares_Ornament2Saturas != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_Patch_Info()
{
	AI_Output(other,self,"DIA_Addon_Lares_OrnamentBringJob_15_00");	//I can take the ornament there for you!
	AI_Output(self,other,"DIA_Addon_Lares_OrnamentBringJob_09_02");	//Only, I can't leave here at the moment. I need to keep an eye on the harbor.
	AI_Output(self,other,"DIA_Addon_Lares_YourMission_09_06");	//But you could help me.
	AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortalInter1_09_01");	//We are now going to take this ornament that you brought me back to Saturas. You remember Saturas, don't you?
	if(LaresToldAboutKDW1 == FALSE)
	{
		Info_ClearChoices(DIA_Addon_Lares_Patch);
		Info_AddChoice(DIA_Addon_Lares_Patch," онечно.",DIA_Addon_Lares_Patch_ja);
		Info_AddChoice(DIA_Addon_Lares_Patch,"—атурас?  то это такой?",DIA_Addon_Lares_Patch_wer);
	}
	else
	{
		DIA_Addon_Lares_Patch_WhereTo();
	};
};


func void DIA_Addon_Lares_Patch_wer()
{
	AI_Output (other, self, "DIA_Addon_Lares_ArrivedPortalInter1_wer_15_00");	//Saturas? Who is that?
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_wer_09_01");	//He was the head of the Water Mages in the New Camp, back in the Valley of Mines when the Barrier was still around us all.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_wer_09_02");	//Lee and I had made a pact with the Water Mages back then. Together, we were strong enough to hold up against the Old Camp.
	DIA_Addon_Lares_Patch_WhereTo();
};

func void DIA_Addon_Lares_Patch_ja()
{
	AI_Output(other,self,"DIA_Addon_Lares_ArrivedPortalInter1_ja_15_00");	//Certainly. He was the leader of the Water Mages in the New Camp.
	DIA_Addon_Lares_Patch_WhereTo();
};

instance DIA_Lares_Kap1_EXIT(C_Info)
{
	npc = VLK_449_Lares;
	nr = 999;
	condition = DIA_Lares_Kap1_EXIT_Condition;
	information = DIA_Lares_Kap1_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Lares_Kap1_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Lares_Kap1_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Lares_HaltsMaul(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_HaltsMaul_Condition;
	information = DIA_Addon_Lares_HaltsMaul_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Addon_Lares_HaltsMaul_Condition()
{
	if((Lares_HaltsMaul == TRUE) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_HaltsMaul_Info()
{
	AI_Output (self, other, "DIA_Addon_Lares_HaltsMaul_09_01");	//I'll see you later, down at the harbor.
	AI_StopProcessInfos (self);
};


instance DIA_Lares_PICKPOCKET(C_Info)
{
	npc = VLK_449_Lares;
	nr = 900;
	condition = DIA_Lares_PICKPOCKET_Condition;
	information = DIA_Lares_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Lares_PICKPOCKET_Condition()
{
	return C_Beklauen(95,350);
};

func void DIA_Lares_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Lares_PICKPOCKET);
	Info_AddChoice(DIA_Lares_PICKPOCKET,Dialog_Back,DIA_Lares_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Lares_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Lares_PICKPOCKET_DoIt);
};

func void DIA_Lares_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Lares_PICKPOCKET);
};

func void DIA_Lares_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Lares_PICKPOCKET);
};


func void B_Lares_Comment_MIL()
{
	AI_Output(self,other,"DIA_Lares_OtherGuild_09_01");	//(laughs) I'm gonna laugh myself sick - a former convict in the militia...
};

func void B_Lares_Comment_PAL()
{
	AI_Output(self,other,"DIA_Lares_OtherGuild_09_02");	//So now you're one of the King's paladins!
};

func void B_Lares_Comment_SLD()
{
	AI_Output(self,other,"DIA_Addon_Lares_OtherGuild_09_00");	//I heard that you have been accepted to join Lee.
};

var int Lares_FirstMetAsGuildless;

instance DIA_Lares_HALLO(C_Info)
{
	npc = VLK_449_Lares;
	nr = 2;
	condition = DIA_Lares_HALLO_Condition;
	information = DIA_Lares_HALLO_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Lares_HALLO_Condition()
{
	if(RangerMeetingRunning == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Lares_HALLO_Info()
{
	AI_Output (self, other, "DIA_Lares_HALLO_09_00");	//I must be crazy, what are you doing here?
	if ((Mil_310_schonmalreingelassen == FALSE) && (Mil_333_schonmalreingelassen == FALSE))
	{
		B_GivePlayerXP(500);
	};
	if(other.guild == GIL_NONE)
	{
		if((Mil_310_schonmalreingelassen == FALSE) && (Mil_333_schonmalreingelassen == FALSE) && (Npc_GetDistToWP(self,"HAFEN") < 10000))
		{
			AI_Output(self,other,"DIA_Lares_HALLO_09_01");	//Did you SWIM here?
			AI_Output(self,other,"DIA_Lares_HALLO_09_02");	//(laughs) That's one way to get past the guards at the city gate.
		};
		Lares_FirstMetAsGuildless = TRUE;
	}
	else if(other.guild == GIL_MIL)
	{
		B_Lares_Comment_MIL();
	}
	else if(other.guild == GIL_PAL)
	{
		B_Lares_Comment_PAL();
	}
	else if((other.guild == GIL_NOV) || (other.guild == GIL_KDF))
	{
		AI_Output(self,other,"DIA_Lares_OtherGuild_09_06_add");	//я слышал, ты поступил в монастырь.@@@
	}
	else if(other.guild == GIL_SLD)
	{
		B_Lares_Comment_SLD();
	};
	Info_ClearChoices(DIA_Lares_HALLO);
	Info_AddChoice(DIA_Lares_HALLO,"Have we met before?",DIA_Lares_HALLO_NO);
	Info_AddChoice(DIA_Lares_HALLO,"Hey, Lares, you old scoundrel...",DIA_Lares_HALLO_YES);
};

func void DIA_Lares_HALLO_NO()
{
	AI_Output (other, self, "DIA_Lares_HALLO_NO_15_00");	//Have we met before?
	AI_Output (self, other, "DIA_Lares_HALLO_NO_09_01");	//Man, don't you remember me? I used to hang around in the New Camp.
	AI_Output (self, other, "DIA_Lares_HALLO_NO_09_02");	//The list for the mine... Man, we had a lot of fun. Do you remember Lee?
	Info_ClearChoices (DIA_Lares_HALLO);
	Info_AddChoice (DIA_Lares_HALLO, "Of course I remember Lee!", DIA_Lares_HALLO_LEE);
	Info_AddChoice (DIA_Lares_HALLO, "Lee...?", DIA_Lares_HALLO_NOIDEA);
};

func void DIA_Lares_HALLO_YES()
{
	AI_Output (other, self, "DIA_Lares_HALLO_YES_15_00");	//Hey, Lares, you old scoundrel, how did you get here?
	AI_Output (self, other, "DIA_Lares_HALLO_YES_09_01");	//I was able to escape the Valley of Mines just in time, together with Lee and some of the other boys.
	AI_Output (self, other, "DIA_Lares_HALLO_YES_09_02");	//You remember Lee, don't you?
	Info_ClearChoices (DIA_Lares_HALLO);
	Info_AddChoice (DIA_Lares_HALLO, "Of course I remember Lee!", DIA_Lares_HALLO_LEE);
	Info_AddChoice (DIA_Lares_HALLO, "Lee ...?", DIA_Lares_HALLO_NOIDEA);
};

func void B_Lares_AboutLee()
{
	AI_Output(self,other,"B_Lares_AboutLee_09_00");	//I got out of the colony with him then. Just after the Barrier was destroyed.
	if((other.guild != GIL_SLD) && (other.guild != GIL_DJG))
	{
		AI_Output(self,other,"B_Lares_AboutLee_09_01");	//He and his boys are now on the farm of Onar the landowner.
		AI_Output(self,other,"B_Lares_AboutLee_09_02");	//He made a deal with the farmer. He and his boys defend the farm, and Onar feeds them in return.
	};
	AI_Output(self,other,"DIA_Lares_WhyInCity_09_03");	//Why did you com to the city?
	AI_Output(other,self,"DIA_Lares_Alternative_15_00");	//Do I have a choice?
};

func void DIA_Lares_HALLO_LEE()
{
	AI_Output (other, self, "DIA_Lares_HALLO_LEE_15_00");	//Of course I remember Lee!
	B_Lares_AboutLee ();
	Info_ClearChoices (DIA_Lares_HALLO);
};

func void DIA_Lares_HALLO_NOIDEA()
{
	AI_Output (other, self, "DIA_Lares_HALLO_NOIDEA_15_00");	//Lee ...?
	AI_Output (self, other, "DIA_Lares_HALLO_NOIDEA_09_01");	//You've been through a lot, huh? Lee was the leader of the mercenaries in the New Camp.
	B_Lares_AboutLee();
	Info_ClearChoices(DIA_Lares_HALLO);
};


instance DIA_Lares_AboutGorn(C_Info)
{
	npc = VLK_449_Lares;
	nr = 98;
	condition = DIA_Lares_AboutGorn_Condition;
	information = DIA_Lares_AboutGorn_Info;
	permanent = FALSE;
	description = "Gorn told you about me? What happend to him?";
};


func int DIA_Lares_AboutGorn_Condition()
{
	if((KnowsAboutGorn == TRUE) && (MIS_RescueGorn == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lares_AboutGorn_Info()
{
	AI_Output(other,self,"DIA_Lee_AboutGorn_15_00");	//Gorn told you about me? What happend to him?
	AI_Output(self,other,"DIA_Dexter_Wo_09_01");	//I think he's somewhere in the Valley of Mines.
};


instance DIA_Addon_Lares_Vatras(C_Info)
{
	npc = VLK_449_Lares;
	nr = 1;
	condition = DIA_Addon_Lares_Vatras_Condition;
	information = DIA_Addon_Lares_Vatras_Info;
	description = "Vatras sent me.";
};


func int DIA_Addon_Lares_Vatras_Condition()
{
	if(Vatras_GehZuLares == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_Vatras_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_Vatras_15_00");	//Vatras sent me. He told me to come to you when I needed help.
	AI_Output (self, other, "DIA_Addon_Lares_Vatras_09_01");	//(astonished)  So you've already been to see Vatras. You must have made a lasting impression on him.
	AI_Output (self, other, "DIA_Addon_Lares_Vatras_09_02");	//Otherwise he certainly wouldn't have volunteered my name. Especially not since the matter with those missing people still hasn't been resolved.
	AI_Output (self, other, "DIA_Addon_Lares_Vatras_09_03");	//Tell me what you need.
	Lares_RangerHelp = TRUE;
	if(GregLocation == Greg_Farm1)
	{
		B_StartOtherRoutine(BAU_974_Bauer,"GregInTaverne");
		GregLocation = Greg_Taverne;
		B_StartOtherRoutine(Greg_NW,"Taverne");
		if(GregWolfs == FALSE)
		{
			Wld_InsertNpc(YWolf,"NW_FARM1_PATH_CITY_05_B");
			Wld_InsertNpc(YWolf,"NW_FARM1_PATH_CITY_05_B");
			GregWolfs = TRUE;
		};
	};
};


instance DIA_Addon_Lares_WhatAreYouGuys(C_Info)
{
	npc = VLK_449_Lares;
	nr = 6;
	condition = DIA_Addon_Lares_WhatAreYouGuys_Condition;
	information = DIA_Addon_Lares_WhatAreYouGuys_Info;
	description = "So what's your business with Vatras?";
};


func int DIA_Addon_Lares_WhatAreYouGuys_Condition()
{
	if((Lares_RangerHelp == TRUE) && (SC_IsRanger == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_WhatAreYouGuys_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_WhatAreYouGuys_15_00");	//So what's your business with Vatras?
	AI_Output (self, other, "DIA_Addon_Lares_WhatAreYouGuys_09_01");	//I've got this little agreement with the Water Mages, you see.
	AI_Output (other, self, "DIA_Addon_Lares_WhatAreYouGuys_15_02");	//What kind of an agreement?
	AI_Output (self, other, "DIA_Addon_Lares_WhatAreYouGuys_09_03");	//We work for them, and they see to it that our past in the penal colony doesn't get us into trouble.
	AI_Output (other, self, "DIA_Addon_Lares_WhatAreYouGuys_15_04");	//You're talking about the 'Ring of Water'?
	AI_Output (self, other, "DIA_Addon_Lares_WhatAreYouGuys_09_05");	//You've heard of it?
	AI_Output (other, self, "DIA_Addon_Lares_WhatAreYouGuys_15_06");	//Vatras told me about it.
	AI_Output (self, other, "DIA_Addon_Lares_WhatAreYouGuys_09_07");	//You might have mentioned that right away.
	Log_CreateTopic (TOPIC_Addon_RingOfWater, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_RingOfWater, LOG_Running);
	B_LogEntry (TOPIC_Addon_RingOfWater, "Lares belongs to the 'Ring of Water'.");
};


instance DIA_Addon_Lares_Ranger(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_Ranger_Condition;
	information = DIA_Addon_Lares_Ranger_Info;
	description = "Tell me more about the 'Ring of Water'.";
};


func int DIA_Addon_Lares_Ranger_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Lares_WhatAreYouGuys) && (SC_IsRanger == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_Ranger_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_Ranger_15_00");	//Tell me more about the 'Ring of Water'.
	AI_Output (self, other, "DIA_Addon_Lares_Ranger_09_01");	//The 'Ring' is to the Water Mages what the paladins are to the Fire Magicians.
	AI_Output (self, other, "DIA_Addon_Lares_Ranger_09_02");	//But, unlike the paladins, we operate in the background.
	AI_Output (self, other, "DIA_Addon_Lares_Ranger_09_03");	//The 'Ring' is a mighty weapon in the battle against the dangers that threaten the people of Khorinis.
	AI_Output (self, other, "DIA_Addon_Lares_Ranger_09_04");	//But this only works as long as we keep the identity of all those secret who belong to the 'Ring of Water'.
	AI_Output (self, other, "DIA_Addon_Lares_Ranger_09_05");	//So keep this to yourself!
	AI_Output (other, self, "DIA_Addon_Lares_Ranger_15_06");	//Sure.
	B_LogEntry (TOPIC_Addon_RingOfWater, "The 'Ring' is to the Water Mages what the paladins are to the Fire Magicians. But the 'Ring' operates in the background. Nobody must know WHO belongs to it, so that its strength remains a secret.");
};


instance DIA_Addon_Lares_WannaBeRanger(C_Info)
{
	npc = VLK_449_Lares;
	nr = 2;
	condition = DIA_Addon_Lares_WannaBeRanger_Condition;
	information = DIA_Addon_Lares_WannaBeRanger_Info;
	description = "I want to join the 'Ring of Water' ...";
};


func int DIA_Addon_Lares_WannaBeRanger_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Lares_Ranger) && (SC_IsRanger == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_WannaBeRanger_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_WannaBeRanger_15_00");	//I want to join the 'Ring of Water' ...
	AI_Output (self, other, "DIA_Addon_Lares_WannaBeRanger_09_01");	//That's fine with me. But the decision about whether you will be accepted or not lies with the Water Mages alone.
	B_LogEntry (TOPIC_Addon_RingOfWater, LogText_Addon_KDWRight);
	Info_ClearChoices (DIA_Addon_Lares_WannaBeRanger);
	Info_AddChoice (DIA_Addon_Lares_WannaBeRanger, "I see.", DIA_Addon_Lares_WannaBeRanger_BACK);
	Info_AddChoice (DIA_Addon_Lares_WannaBeRanger, "What's it like to belong to the 'Ring'?", DIA_Addon_Lares_WannaBeRanger_HowIsIt);
	Info_AddChoice (DIA_Addon_Lares_WannaBeRanger, "What did you do to impress the Water Mages?", DIA_Addon_Lares_WannaBeRanger_AboutYou);
};

func void DIA_Addon_Lares_WannaBeRanger_BACK()
{
	AI_Output (other, self, "DIA_Addon_Lares_WannaBeRanger_BACK_15_00");	//I see.
	Info_ClearChoices (DIA_Addon_Lares_WannaBeRanger);
};

func void DIA_Addon_Lares_WannaBeRanger_AboutYou()
{
	AI_Output (other, self, "DIA_Addon_Lares_WannaBeRanger_AboutYou_15_00");	//What did you do to impress the Water Mages?
	AI_Output (self, other, "DIA_Addon_Lares_WannaBeRanger_AboutYou_09_01");	//I protected them for a long time when we were still living with the Barrier.
	AI_Output (self, other, "DIA_Addon_Lares_WannaBeRanger_AboutYou_09_02");	//(smiles) And they have plenty of reason to be grateful to me.
};

func void DIA_Addon_Lares_WannaBeRanger_HowIsIt()
{
	AI_Output (other, self, "DIA_Addon_Lares_WannaBeRanger_HowIsIt_15_00");	//What's it like to belong to the 'Ring'?
	AI_Output (self, other, "DIA_Addon_Lares_WannaBeRanger_HowIsIt_09_01");	//We are very different from the usual communities you can join here in Khorinis.
	AI_Output (self, other, "DIA_Addon_Lares_WannaBeRanger_HowIsIt_09_02");	//Once you're one of us, we're not going to ask anything of you that you are not ready to do.
	AI_Output (self, other, "DIA_Addon_Lares_WannaBeRanger_HowIsIt_09_03");	//The only thing we truly require of you is to keep quiet.
	AI_Output (self, other, "DIA_Addon_Lares_WannaBeRanger_HowIsIt_09_04");	//We work in secret and do not want to let outsiders know who our members are.
	AI_Output (self, other, "DIA_Addon_Lares_WannaBeRanger_HowIsIt_09_05");	//We shall keep an eye on you. Everything else remains to be seen.
};

func void B_Lares_Geheimtreffen()
{
	AI_Output (self, other, "DIA_Addon_Lares_RingBack_09_07");	//We are going to have a secret meeting soon in Orlan's tavern.
	AI_Output (self, other, "DIA_Addon_Lares_RingBack_09_08");	//Meet us there as soon as you can. We'll give you your gear there.
};


instance DIA_Addon_Lares_RingBack(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_RingBack_Condition;
	information = DIA_Addon_Lares_RingBack_Info;
	description = "I now belong to the 'Ring of Water'.";
};


func int DIA_Addon_Lares_RingBack_Condition()
{
	if((SC_IsRanger == TRUE) && (MIS_Addon_Lares_ComeToRangerMeeting != LOG_SUCCESS) && ((Npc_GetDistToWP(self,"NW_CITY_HABOUR_02_B") < 1000) || (Npc_GetDistToWP(self,"NW_CITY_HABOUR_TAVERN01_08") < 1000)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_RingBack_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_RingBack_15_00");	//I now belong to the 'Ring of Water'.
	if ((Lares_GotRingBack == FALSE) && (SC_GotLaresRing == TRUE))
	{
		AI_Output (self, other, "DIA_Addon_Lares_RingBack_09_01");	//Great. So can I have my aquamarine ring back?
		if (B_GiveInvItems (other, self, ItRi_Ranger_Lares_Addon, 1))
		{
			AI_Output (other, self, "DIA_Addon_Lares_RingBack_15_02");	//Sure. Here it is.
			AI_Output (self, other, "DIA_Addon_Lares_RingBack_09_03");	//I hope it proved useful to you. I'm glad to know you're one of us now.
			Lares_GotRingBack = TRUE;
			B_GivePlayerXP(XP_Ambient);
		}
		else
		{
			AI_Output (other, self, "DIA_Addon_Lares_RingBack_15_04");	//Hmm. I don't have it on me right now.
			AI_Output (self, other, "DIA_Addon_Lares_RingBack_09_05");	//Don't mess around with it! I still need it.
		};
	};
	AI_Output (self, other, "DIA_Addon_Lares_RingBack_09_06");	//I guess you want your gear now. So pay attention.
	B_Lares_Geheimtreffen ();
	B_LogEntry (TOPIC_Addon_RingOfWater, "Lares invited me to come to the secret meeting of the 'Ring' in Orlan's tavern.");
	MIS_Addon_Lares_ComeToRangerMeeting = LOG_Running;
};


instance DIA_Addon_Lares_RingBack2(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_RingBack2_Condition;
	information = DIA_Addon_Lares_RingBack2_Info;
	description = "Here's your aquamarine ring.";
};


func int DIA_Addon_Lares_RingBack2_Condition()
{
	if(Npc_HasItems(other,ItRi_Ranger_Lares_Addon) && (Lares_GotRingBack == FALSE) && (MIS_Addon_Lares_ComeToRangerMeeting != FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_RingBack2_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_RingBack2_15_00");	//Here's your aquamarine ring.
	B_GiveInvItems (other, self, ItRi_Ranger_Lares_Addon, 1);
	AI_Output (self, other, "DIA_Addon_Lares_RingBack2_09_01");	//Good for you. I thought you'd lost it.
	B_GivePlayerXP (XP_Ambient);
	Lares_GotRingBack = TRUE;
};


instance DIA_Addon_Lares_Geduld(C_Info)
{
	npc = VLK_449_Lares;
	nr = 2;
	condition = DIA_Addon_Lares_Geduld_Condition;
	information = DIA_Addon_Lares_Geduld_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Addon_Lares_Geduld_Condition()
{
	if((RangerMeetingRunning == LOG_Running) && (Npc_GetDistToWP(self,"NW_TAVERNE_IN_RANGERMEETING_LARES") > 200) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_Geduld_Info()
{
	AI_Output (self, other, "DIA_Addon_Lares_Geduld_09_01");	//You need to wait a little longer. Everyone's not here yet.
	AI_StopProcessInfos (self);
};


var int Lares_ArmorComment;

instance DIA_Addon_Lares_GetRangerArmor(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_GetRangerArmor_Condition;
	information = DIA_Addon_Lares_GetRangerArmor_Info;
	important = TRUE;
};


func int DIA_Addon_Lares_GetRangerArmor_Condition()
{
	if((MIS_Addon_Lares_ComeToRangerMeeting == LOG_Running) && (Npc_GetDistToWP(self,"NW_TAVERNE_IN_RANGERMEETING_LARES") <= 200) && (RangerMeetingRunning == LOG_Running) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_GetRangerArmor_Info()
{
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_09_00");	//All right, my young friend. We have come together here to celebrate your admission to the 'Ring of Water'.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_09_01");	//The boys who are present here will keep an eye out for you from today on.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_09_02");	//Of course, there are others who also belong to the 'Ring of Water', so be careful.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_09_03");	//Whether you do us a service or mess things up - we are going to learn about it.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_09_04");	//Here, take the armor of our community.
	if(Lares_ArmorComment == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortalInter1_teil2_09_03_add");	//The members of the Ring of Water have been wearing such armor since before the orc wars.
		Lares_ArmorComment = TRUE;
	};
	AI_WaitTillEnd(other,self);
	B_GiveArmor(ITAR_RANGER_Addon);
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_09_05");	//Wear it with pride, but never in town or in other inhabited areas.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_09_06");	//Remember, we must not be exposed. Nobody must therefore be told who the members of the 'Ring of Water' are.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_09_07");	//Nobody talks about the 'Ring of Water'. That's our foremost rule. Stick to it.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_09_08");	//Any more questions?
	MIS_Addon_Lares_ComeToRangerMeeting = LOG_SUCCESS;
	B_GivePlayerXP (XP_Ambient);
	Info_ClearChoices (DIA_Addon_Lares_GetRangerArmor);
	Info_AddChoice (DIA_Addon_Lares_GetRangerArmor, "I've got to go.", DIA_Addon_Lares_GetRangerArmor_end);
	Info_AddChoice (DIA_Addon_Lares_GetRangerArmor, "What kind of help can I get from you?", DIA_Addon_Lares_GetRangerArmor_Learn);
	Info_AddChoice (DIA_Addon_Lares_GetRangerArmor, "What about weapons, then?", DIA_Addon_Lares_GetRangerArmor_weapons);
};

func void DIA_Addon_Lares_GetRangerArmor_weapons()
{
	AI_Output (other, self, "DIA_Addon_Lares_GetRangerArmor_weapons_15_00");	//What about weapons, then?
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_weapons_09_01");	//The weapon of the 'Ring' is the quarterstaff, but everyone uses whatever arms he is most comfortable with.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_weapons_09_02");	//Here's one of our staffs. I never really figured out how to use it, but maybe you can handle the thing.
	CreateInvItems (self, ItMw_RangerStaff_Addon, 1);
	B_GiveInvItems (self, other, ItMw_RangerStaff_Addon, 1);
};

func void DIA_Addon_Lares_GetRangerArmor_end()
{
	B_MakeRangerReadyToLeaveMeetingALL();
	AI_Output (other, self, "DIA_Addon_Lares_GetRangerArmor_end_15_00");	//I've got to go.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_end_09_01");	//Fine, then don't let us keep you.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_end_09_02");	//Now go directly to Vatras and have him give you your first task.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_end_09_03");	//Brothers of the 'Ring'. Let us now return to our duties.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_end_09_04");	//The bandit attacks are still going on. We must see to it that this menace is stopped.
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_end_09_05");	//Adanos, preserve the balance of this world.
	if(!Npc_IsDead(Orlan))
	{
		CreateInvItem(Orlan,ItMW_Addon_Stab03);
	};
	Lares_TakeFirstMissionFromVatras = TRUE;
	Info_ClearChoices(DIA_Addon_Lares_GetRangerArmor);
	Info_AddChoice(DIA_Addon_Lares_GetRangerArmor,Dialog_Ende,DIA_Addon_Lares_GetRangerArmor_weiter);
};

func void DIA_Addon_Lares_GetRangerArmor_weiter()
{
	AI_StopProcessInfos (self);
	B_RangerMeetingParking ();
	B_LogEntry (TOPIC_Addon_RingOfWater, "I was given my armor during the secret meeting in Orlan's tavern. Now I am supposed to go see Vatras who will set me my first task as a member of the 'Ring'.");
};

func void DIA_Addon_Lares_GetRangerArmor_Learn()
{
	AI_Output (other, self, "DIA_Addon_Lares_GetRangerArmor_Learn_15_00");	//What kind of help can I get from you?
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_Learn_09_01");	//I can show you how to become more dexterous.
	if(!Npc_IsDead(Cord))
	{
		AI_Output(self,other,"DIA_Addon_Lares_GetRangerArmor_Learn_09_02");	//If you need help with wielding close-combat weapons, talk to Cord. He is a master of the blade.
		Cord_RangerHelp_Fight = TRUE;
	};
	if(!Npc_IsDead(Gaan))
	{
		AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_Learn_09_03");	//Gaan will gladly show you the proper way to gut animals.
	};
	if(!Npc_IsDead(Martin))
	{
		AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_Learn_09_04");	//Martin can tell you a lot about the paladins.
	};
	if(!Npc_IsDead(Cavalorn))
	{
		AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_Learn_09_05");	//Cavalorn will teach you sneaking, one-handed combat and archery.
	};
	if(!Npc_IsDead(Orlan))
	{
		AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_Learn_09_06");	//Orlan will always have a warm chamber and a bed waiting for you.
	};
	AI_Output (self, other, "DIA_Addon_Lares_GetRangerArmor_Learn_09_07");	//And for anything related to magic, talk to Vatras.
};


instance DIA_Addon_Lares_Teleportstation(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_Teleportstation_Condition;
	information = DIA_Addon_Lares_Teleportstation_Info;
	description = "Have you ever used a teleporter stone?";
};


func int DIA_Addon_Lares_Teleportstation_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_SUCCESS) && (SCUsed_TELEPORTER == TRUE) && (MIS_Lares_BringRangerToMe != FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_Teleportstation_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_Teleportstation_15_00");	//Have you ever used a teleporter stone?
	AI_Output (self, other, "DIA_Addon_Lares_Teleportstation_09_01");	//No, but I've heard of them. The Water Mages aren't too sure about those things yet.
	AI_Output (other, self, "DIA_Addon_Lares_Teleportstation_15_02");	//I've given it a try.
	AI_Output (self, other, "DIA_Addon_Lares_Teleportstation_09_03");	//(laughs) Of course you have. You're not afraid of anything, are you?
	AI_Output (self, other, "DIA_Addon_Lares_Teleportstation_09_04");	//Well. If you want to use the things, go ask Orlan the pub-owner whether he'll let you into his boarded-up cave.
	AI_Output (self, other, "DIA_Addon_Lares_Teleportstation_09_05");	//I think he has hidden one of the teleporter stones for the Water Mages near his tavern.
	if(!Npc_KnowsInfo(other,DIA_Addon_Orlan_Teleportstein))
	{
		B_LogEntry(TOPIC_Addon_TeleportsNW,"Lares told me that Orlan has hidden a teleporter stone near his tavern.");
	};
//	Orlan_Hint_Lares = TRUE;
};


instance DIA_Addon_Lares_Ornament(C_Info)
{
	npc = VLK_449_Lares;
	nr = 2;
	condition = DIA_Addon_Lares_Ornament_Condition;
	information = DIA_Addon_Lares_Ornament_Info;
	description = "Vatras gave me this ornament for you.";
};


func int DIA_Addon_Lares_Ornament_Condition()
{
	if(Npc_HasItems(other,ItMi_Ornament_Addon_Vatras) && Npc_KnowsInfo(other,DIA_Addon_Lares_Vatras))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_Ornament_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_Ornament_15_00");	//Vatras gave me this ornament to bring to you. He said it is to be taken back.
	B_GiveInvItems (other, self, ItMi_Ornament_Addon_Vatras, 1);
	AI_Output (self, other, "DIA_Addon_Lares_Ornament_09_01");	//(sighs) Of course. It's up to me, as usual. I might have known.
	AI_Output (self, other, "DIA_Addon_Lares_Ornament_09_02");	//I'll have to walk halfway across the island to take it back to the Water Mages.
};


instance DIA_Addon_Lares_OrnamentBringJob(C_Info)
{
	npc = VLK_449_Lares;
	nr = 2;
	condition = DIA_Addon_Lares_OrnamentBringJob_Condition;
	information = DIA_Addon_Lares_OrnamentBringJob_Info;
	description = "I can take the ornament there for you!";
};


func int DIA_Addon_Lares_OrnamentBringJob_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Lares_Ornament) && (MIS_Addon_Lares_Ornament2Saturas == FALSE) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_OrnamentBringJob_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_OrnamentBringJob_15_00");	//I can take the ornament there for you!
	AI_Output (self, other, "DIA_Addon_Lares_OrnamentBringJob_09_01");	//(pensively) Mmh. I think I had better take it there myself. But you could come with me.
	AI_Output (self, other, "DIA_Addon_Lares_OrnamentBringJob_09_02");	//Only, I can't leave here at the moment. I need to keep an eye on the harbor.
	B_LogEntry (TOPIC_Addon_KDW, "I brought Lares the ornament from Vatras. He wants to take it to the Water Mages himself. I should accompany him.");
	MIS_Addon_Lares_Ornament2Saturas = LOG_Running;
};


instance DIA_Addon_Lares_YourMission(C_Info)
{
	npc = VLK_449_Lares;
	nr = 2;
	condition = DIA_Addon_Lares_YourMission_Condition;
	information = DIA_Addon_Lares_YourMission_Info;
	permanent = TRUE;
	description = "What exactly do you do here at the harbor?";
};


func int DIA_Addon_Lares_YourMission_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Lares_Ornament) && (MIS_Lares_BringRangerToMe == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_YourMission_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_YourMission_15_00");	//What exactly do you do here at the harbor?
	if (!Npc_KnowsInfo (other, DIA_Addon_Lares_WhatAreYouGuys))
	{
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_01");	//I can't talk about that.
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_02");	//Vatras would have my head ...
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_03");	//I'm doing what we all do. I fulfill the tasks the Water Mages give me.
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_04");	//Some of the missing people where fishermen. They disappeared along with their boats.
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_05");	//That's why I'm standing here, watching the harbor. Maybe something will happen yet.
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_06");	//But you could help me.
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_07");	//Listen. I shall give you my aquamarine ring. It signifies that the bearer belongs to the 'Ring of Water'.
		CreateInvItems (self, ItRi_Ranger_Lares_Addon, 1);
		B_GiveInvItems (self, other, ItRi_Ranger_Lares_Addon, 1);
		SC_GotLaresRing = TRUE;
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_08");	//If you wear my ring, the rest of us will know that you're acting on my behalf.
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_09");	//Get someone to take over my duties so that I can take the ornament back.
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_10");	//One of us is always keeping an eye on the marketplace. But I don't know whose turn it is.
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_11");	//You had better go talk to all those standing around there. Once the right man sees my aquamarine ring on you, he will let you know.
		AI_Output (self, other, "DIA_Addon_Lares_YourMission_09_12");	//Tell him to see to it that somebody else takes over here at the harbor.
		Log_CreateTopic(TOPIC_Addon_BringRangerToLares,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_BringRangerToLares,LOG_Running);
		B_LogEntries(TOPIC_Addon_BringRangerToLares,"Lares cannot leave the harbor. I am to show myself in the marketplace wearing his aquamarine ring to try and find someone who can take over his job.");
		B_LogNextEntry(TOPIC_Addon_RingOfWater,"Lares gave me his aquamarine ring - the secret sign of the 'Ring'. When I wear it, the other members of the 'Ring' will reveal themselves to me.");
		MIS_Lares_BringRangerToMe = LOG_Running;
	};
};


instance DIA_Addon_Lares_BaltramAbloese(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_BaltramAbloese_Condition;
	information = DIA_Addon_Lares_BaltramAbloese_Info;
	description = "I have talked to Baltram.";
};


func int DIA_Addon_Lares_BaltramAbloese_Condition()
{
	if((MIS_Lares_BringRangerToMe == LOG_Running) && (Baltram_Exchange4Lares == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_BaltramAbloese_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_BaltramAbloese_15_00");	//I have talked to Baltram. He will find someone to relieve you.
	AI_Output (self, other, "DIA_Addon_Lares_BaltramAbloese_09_01");	//Ah. Very good. Then we can finally leave here.
	if (SC_IsRanger == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Lares_BaltramAbloese_09_02");	//You had better keep my aquamarine ring for now.
		if (Npc_KnowsInfo (other, DIA_Addon_Lares_WannaBeRanger))
		{
			AI_Output (self, other, "DIA_Addon_Lares_BaltramAbloese_09_03");	//(smiles) I assume it will come in handy for you.
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_Lares_BaltramAbloese_09_04");	//(smiles) Who knows, you might want to join us ...
		};
	};
	MIS_Lares_BringRangerToMe = LOG_SUCCESS;
	B_CheckLog();
	Lares_CanBringScToPlaces = TRUE;
};


var int Lares_PeopleMissing_PERM;

instance DIA_Addon_Lares_PeopleMissing(C_Info)
{
	npc = VLK_449_Lares;
	nr = 3;
	condition = DIA_Addon_Lares_PeopleMissing_Condition;
	information = DIA_Addon_Lares_PeopleMissing_Info;
	permanent = TRUE;
	description = "About those missing people...";
};


func int DIA_Addon_Lares_PeopleMissing_Condition()
{
	if((Lares_RangerHelp == TRUE) && (Lares_PeopleMissing_PERM == FALSE) && ((SC_IsRanger == FALSE) || (MissingPeopleReturnedHome == TRUE)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_PeopleMissing_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_PeopleMissing_15_00");	//About those missing people ...
	Info_ClearChoices (DIA_Addon_Lares_PeopleMissing);
	Info_AddChoice (DIA_Addon_Lares_PeopleMissing, Dialog_Back, DIA_Addon_Lares_PeopleMissing_BACK);
	if (MissingPeopleReturnedHome == TRUE)
	{
		Info_AddChoice (DIA_Addon_Lares_PeopleMissing, "I've been able to rescue some of the missing people.", DIA_Addon_Lares_PeopleMissing_SAVED);
	}
	else if((MIS_Lares_BringRangerToMe != FALSE) && (SCKnowsMissingPeopleAreInAddonWorld == TRUE) && (MissingPeopleReturnedHome == FALSE))
	{
		Info_AddChoice (DIA_Addon_Lares_PeopleMissing, "I know what became of the missing people.", DIA_Addon_Lares_PeopleMissing_Success);
	}
	else
	{
		Info_AddChoice (DIA_Addon_Lares_PeopleMissing, "Isn't this a case for the militia?", DIA_Addon_Lares_PeopleMissing_MIL);
		Info_AddChoice (DIA_Addon_Lares_PeopleMissing, "Tell me what you know.", DIA_Addon_Lares_PeopleMissing_TellMe);
	};
};

func void DIA_Addon_Lares_PeopleMissing_BACK()
{
	Info_ClearChoices(DIA_Addon_Lares_PeopleMissing);
};

func void DIA_Addon_Lares_PeopleMissing_TellMe()
{
	AI_Output (other, self, "DIA_Addon_Lares_PeopleMissing_TellMe_15_00");	//Tell me what you know.
	AI_Output (self, other, "DIA_Addon_Lares_PeopleMissing_TellMe_09_01");	//The first was William, one of the fishermen here in Khorinis. One day, he simply didn't return.
	AI_Output (self, other, "DIA_Addon_Lares_PeopleMissing_TellMe_09_02");	//At first we thought that one of those sea monsters out there had eaten him and his boat for breakfast.
	AI_Output (self, other, "DIA_Addon_Lares_PeopleMissing_TellMe_09_03");	//But not too long afterwards, other people started disappearing from the town and the surroundings. Pretty random events, though.
	AI_Output (self, other, "DIA_Addon_Lares_PeopleMissing_TellMe_09_04");	//Everyone's at a loss so far. The way it looks, we'll just have to wait until we finally stumble across a clue.
	if (SC_HearedAboutMissingPeople == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_WhoStolePeople,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_WhoStolePeople,LOG_Running);
		B_LogEntries(TOPIC_Addon_WhoStolePeople,LogText_Addon_SCKnowsMisspeapl);
		if(MissingPeopleReturnedHome == FALSE)
		{
			Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
		};
		B_LogNextEntry(TOPIC_Addon_MissingPeople,LogText_Addon_WilliamMissing);
		SC_HearedAboutMissingPeople = TRUE;
	};
};

func void DIA_Addon_Lares_PeopleMissing_MIL()
{
	AI_Output (other, self, "DIA_Addon_Lares_PeopleMissing_MIL_15_00");	//Isn't this a case for the militia?
	AI_Output (self, other, "DIA_Addon_Lares_PeopleMissing_MIL_09_01");	//The militia is pretty useless, if you ask me.
	AI_Output (self, other, "DIA_Addon_Lares_PeopleMissing_MIL_09_02");	//They're never going to clear this up. The missing people have just vanished into thin air.
};

func void DIA_Addon_Lares_PeopleMissing_Success()
{
	AI_Output (other, self, "DIA_Addon_Lares_PeopleMissing_Success_15_00");	//I know what has become of all the missing people!
	AI_Output (self, other, "DIA_Addon_Lares_PeopleMissing_Success_09_01");	//(surprised) Really.
	AI_Output (other, self, "DIA_Addon_Lares_PeopleMissing_Success_15_02");	//The former ore baron Raven had them kidnapped.
	AI_Output (self, other, "DIA_Addon_Lares_PeopleMissing_Success_09_03");	//Are you sure? Then we need to get them out of there.
	AI_Output (other, self, "DIA_Addon_Lares_PeopleMissing_Success_15_04");	//I'm working on it.
	AI_Output (self, other, "DIA_Addon_Lares_PeopleMissing_Success_09_05");	//All right. But you know, whenever you need my help...
	AI_Output (other, self, "DIA_Addon_Lares_PeopleMissing_Success_15_06");	//...then I'll know where to find you. Understood.
	Lares_CanBringScToPlaces = TRUE;
	Info_ClearChoices(DIA_Addon_Lares_PeopleMissing);
};

func void DIA_Addon_Lares_PeopleMissing_SAVED()
{
	AI_Output (other, self, "DIA_Addon_Lares_PeopleMissing_SAVED_15_00");	//I've been able to rescue some of the missing people.
	AI_Output (self, other, "DIA_Addon_Lares_PeopleMissing_SAVED_09_01");	//I knew you'd succeed. Then I can finally go about my own business now.
	B_GivePlayerXP (XP_Ambient);
	Lares_PeopleMissing_PERM = TRUE;
	Lares_CanBringScToPlaces = TRUE;
	Info_ClearChoices(DIA_Addon_Lares_PeopleMissing);
};


var int DIA_Addon_Lares_RangerHelp_gilde_OneTime_Waffe;
var int DIA_Addon_Lares_RangerHelp_gilde_OneTime_geld;
var int DIA_Addon_Lares_RangerHelp_gilde_OneTime_ruestung;

instance DIA_Addon_Lares_RangerHelp(C_Info)
{
	npc = VLK_449_Lares;
	nr = 2;
	condition = DIA_Addon_Lares_RangerHelp_Condition;
	information = DIA_Addon_Lares_RangerHelp_Info;
	permanent = TRUE;
	description = "I need your help.";
};


func int DIA_Addon_Lares_RangerHelp_Condition()
{
	if(((Lares_RangerHelp == TRUE) && (DIA_Addon_Lares_RangerHelp_gilde_OneTime_Waffe == FALSE) && (DIA_Addon_Lares_RangerHelp_gilde_OneTime_geld == FALSE) && (DIA_Addon_Lares_RangerHelp_gilde_OneTime_ruestung == FALSE)) || Npc_IsInState(Moe,ZS_Attack))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_RangerHelp_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_RangerHelp_15_00");	//I need your help.
	AI_Output (self, other, "DIA_Addon_Lares_RangerHelp_09_01");	//And what exactly were you thinking of?
	Info_ClearChoices (DIA_Addon_Lares_RangerHelp);
	Info_AddChoice (DIA_Addon_Lares_RangerHelp, Dialog_Back, DIA_Addon_Lares_RangerHelp_nix);
	if (Npc_IsInState (Moe, ZS_Attack))
	{
		Info_AddChoice (DIA_Addon_Lares_RangerHelp, "That guy is pestering me!", DIA_Addon_Lares_RangerHelp_Moe);
	};
	if((DIA_Addon_Lares_RangerHelp_gilde_OneTime_Waffe == FALSE) && (Lares_RangerHelp == TRUE))
	{
		Info_AddChoice (DIA_Addon_Lares_RangerHelp, "I need a better weapon.", DIA_Addon_Lares_RangerHelp_waffe);
	};
	if((DIA_Addon_Lares_RangerHelp_gilde_OneTime_ruestung == FALSE) && (Lares_RangerHelp == TRUE))
	{
		Info_AddChoice (DIA_Addon_Lares_RangerHelp, "What about some better armor?", DIA_Addon_Lares_RangerHelp_ruestung);
	};
	if((DIA_Addon_Lares_RangerHelp_gilde_OneTime_geld == FALSE) && (Lares_RangerHelp == TRUE))
	{
		Info_AddChoice (DIA_Addon_Lares_RangerHelp, "I need some money.", DIA_Addon_Lares_RangerHelp_geld);
	};
};

func void DIA_Addon_Lares_RangerHelp_ruestung()
{
	AI_Output (other, self, "DIA_Addon_Lares_RangerHelp_ruestung_15_00");	//What about some better armor?
	AI_Output (self, other, "DIA_Addon_Lares_RangerHelp_ruestung_09_01");	//Mmh. Matteo sells armor. But he'll probably charge you an arm and a leg for it.
	AI_Output (self, other, "DIA_Addon_Lares_RangerHelp_ruestung_09_02");	//There is a way you could get it cheaper, though, if you don't mind pulling a fast one on the militia ...
	AI_Output (other, self, "DIA_Addon_Lares_RangerHelp_ruestung_15_03");	//What do you mean?
	AI_Output (self, other, "DIA_Addon_Lares_RangerHelp_ruestung_09_04");	//There's a storage area next to Matteo's house. But all the merchandise has been confiscated by the militia.
	AI_Output (self, other, "DIA_Addon_Lares_RangerHelp_ruestung_09_05");	//Go to Zuris at the marketplace and get yourself a sleeping spell. Then you send the guards off to dreamland.
	AI_Output (self, other, "DIA_Addon_Lares_RangerHelp_ruestung_09_06");	//I'm sure you'll find some decent armor among Matteo's stock ...
	DIA_Addon_Lares_RangerHelp_gilde_OneTime_ruestung = TRUE;
	if(!Npc_HasItems(other,ItSc_Sleep) && !Npc_HasItems(Zuris,ItSc_Sleep))
	{
		CreateInvItem(Zuris,ItSc_Sleep);
	};
};

func void DIA_Addon_Lares_RangerHelp_waffe()
{
	AI_Output (other, self, "DIA_Addon_Lares_RangerHelp_waffe_15_00");	//I need a better weapon.
	AI_Output (self, other, "DIA_Addon_Lares_RangerHelp_waffe_09_01");	//There's nothing I can do about that, I'm afraid. Have you tried the marketplace?
	DIA_Addon_Lares_RangerHelp_gilde_OneTime_Waffe = TRUE;
};

func void DIA_Addon_Lares_RangerHelp_geld()
{
	AI_Output (other, self, "DIA_Addon_Lares_RangerHelp_geld_15_00");	//I need some money.
	AI_Output (self, other, "DIA_Addon_Lares_RangerHelp_geld_09_01");	//Don't we all? Sorry, but I have none to give you. But Lehmar the moneylender still owes me a favor.
	AI_Output (self, other, "DIA_Addon_Lares_RangerHelp_geld_09_02");	//Go to him and borrow whatever money you need. I'll take care of the rest. You'll find Lehmar in the harbor district, where it borders on the lower part of town.
	DIA_Addon_Lares_RangerHelp_gilde_OneTime_geld = TRUE;
	RangerHelp_LehmarKohle = TRUE;
//	Info_ClearChoices(DIA_Addon_Lares_RangerHelp);
};

func void DIA_Addon_Lares_RangerHelp_nix()
{
	Info_ClearChoices(DIA_Addon_Lares_RangerHelp);
};

func void DIA_Addon_Lares_RangerHelp_Moe()
{
	AI_Output (other, self, "DIA_Addon_Lares_Moe_15_00");	//That guy is pestering me ...
	AI_Output (self, other, "DIA_Addon_Lares_Moe_09_01");	//Not for long ...
	Info_ClearChoices (DIA_Addon_Lares_RangerHelp);
	AI_StopProcessInfos (self);
	other.aivar[AIV_INVINCIBLE] = FALSE;
	B_Attack(self,Moe,AR_GuardStopsFight,0);
};


instance DIA_Lares_Paladine(C_Info)
{
	npc = VLK_449_Lares;
	nr = 4;
	condition = DIA_Lares_Paladine_Condition;
	information = DIA_Lares_Paladine_Info;
	permanent = FALSE;
	description = "I must talk to the paladins, by any means!";
};


func int DIA_Lares_Paladine_Condition()
{
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
	{
		if((RangerHelp_gildeMIL == FALSE) && (RangerHelp_gildeSLD == FALSE) && (RangerHelp_gildeKDF == FALSE))
		{
			return TRUE;
		};
	};
};

func void DIA_Lares_Paladine_Info()
{
	AI_Output (other, self, "DIA_Lares_Paladine_15_00");	//I must talk to the paladins, by all means!
	AI_Output (self, other, "DIA_Lares_Paladine_09_01");	//What do you want from THEM?
	AI_Output (other, self, "DIA_Lares_Paladine_15_02");	//They've got a powerful amulet, the Eye of Innos. I need to have it.
	if(other.guild == GIL_NONE)
	{
		AI_Output(self,other,"DIA_Lares_Paladine_09_03");	//And you think they'll give it to you? You'll never get into the upper end of town.
	}
	else
	{
		AI_Output(self,other,"DIA_Lares_Paladine_09_03_add");	//And you think they'll give it to you?@@@
	};
	if(!Npc_KnowsInfo(other,DIA_Addon_Lares_Vatras))
	{
		AI_Output(other,self,"DIA_Lares_Paladine_15_04");	//I'll find a way somehow.
		if(other.guild == GIL_NONE)
		{
			AI_Output(self,other,"DIA_Lares_Paladine_09_05");	//Sure, if you want to ingratiate yourself with the citizens or play errand boy for the militia...
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_Lares_RangerHelp_waffe_09_01_add");	//Ѕоюсь, что тут € тебе помочь не могу.@@@
		};
	};
};


instance DIA_Lares_WhyPalHere(C_Info)
{
	npc = VLK_449_Lares;
	nr = 4;
	condition = DIA_Lares_WhyPalHere_Condition;
	information = DIA_Lares_WhyPalHere_Info;
	permanent = FALSE;
	description = "Do you know why the paladins are here?";
};


func int DIA_Lares_WhyPalHere_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lares_Paladine) || (RangerHelp_gildeMIL == TRUE) || (RangerHelp_gildeSLD == TRUE) || (RangerHelp_gildeKDF == TRUE) || (MIS_Garvell_Infos == LOG_Running))
	{
		if(KnowsPaladins_Ore == FALSE)
		{
			return TRUE;
		};
	};
};

func void DIA_Lares_WhyPalHere_Info()
{
	AI_Output (other, self, "DIA_Lares_WhyPalHere_15_00");	//Do you know why the paladins are here?
	AI_Output (self, other, "DIA_Lares_WhyPalHere_09_01");	//Nobody knows for sure ... Lots of people think it's because of the orcs, but I think there's another reason.
	AI_Output (self, other, "DIA_Lares_WhyPalHere_09_02");	//It probably has something to do with the old penal colony.
};


var int Lares_WayToOnar;

func void B_LaresOffersWayToOnar()
{
	if(Lares_WayToOnar == FALSE)
	{
		AI_Output(self,other,"DIA_Lares_WegZumHof_09_01");	//I can take you there if you want.
		Lares_WayToOnar = TRUE;
	};
};

instance DIA_Addon_Lares_Gilde(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_Gilde_Condition;
	information = DIA_Addon_Lares_Gilde_Info;
	permanent = TRUE;
	description = "¬атрас сказал, что ты можешь помочь мне присоединитьс€ к одному из сообществ.";
};


func int DIA_Addon_Lares_Gilde_Condition()
{
	if((Lares_RangerHelp == TRUE) && (other.guild == GIL_NONE) && (RangerHelp_gildeMIL == FALSE) && (RangerHelp_gildeSLD == FALSE) && (RangerHelp_gildeKDF == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_Gilde_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_Gilde_15_00");	//Vatras said you could help me join a community.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_09_01");	//(laughs) Getting tired of being the underdog, are you?
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_09_02");	//All right. I see your point.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_09_03");	//I can exert my influence with the mercenaries if you want to join Lee.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_09_04");	//And I'm sure we can find a way to get you into the monastery soon.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_09_05");	//But the easiest thing would certainly be for you to join the militia.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_09_06");	//Which community do you prefer?
	Info_ClearChoices (DIA_Addon_Lares_Gilde);
	Info_AddChoice (DIA_Addon_Lares_Gilde, "I'll think about it...", DIA_Addon_Lares_Gilde_BACK);
	Info_AddChoice (DIA_Addon_Lares_Gilde, "The Fire Magicians.", DIA_Addon_Lares_Gilde_KDF);
	Info_AddChoice (DIA_Addon_Lares_Gilde, "The mercenaries.", DIA_Addon_Lares_Gilde_SLD);
	Info_AddChoice (DIA_Addon_Lares_Gilde, "The militia.", DIA_Addon_Lares_Gilde_MIL);
};

func void DIA_Addon_Lares_Gilde_BACK()
{
	AI_Output (other, self, "DIA_Addon_Lares_Gilde_BACK_15_00");	//I'll have to think about it ...
	Info_ClearChoices (DIA_Addon_Lares_Gilde);
};

func void DIA_Addon_Lares_Gilde_SLD()
{
	AI_Output (other, self, "DIA_Addon_Lares_Gilde_SLD_15_00");	//The mercenaries.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_SLD_09_01");	//I'm sure that Lee will accept you.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_SLD_Add_09_01");	//But first you're going to have to pass a test.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_SLD_09_02");	//Go and talk to Cord on Onar's farm.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_SLD_Add_09_02");	//He can help you with your test.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_SLD_09_03");	//Tell him that you 'reside beneath my wing'. He'll understand.
	if(Npc_KnowsInfo(other,DIA_Addon_Cord_YouAreRanger))
	{
		AI_Output(other,self,"DIA_Addon_Lares_Gilde_SLD_15_00_add");	//я поговорил с ним.@@@
		AI_Output(self,other,"DIA_Lares_OtherGuild_09_03");	//(mischievously) Only you could pull something like that...
		B_GivePlayerXP(100);
	}
	else
	{
		B_LaresOffersWayToOnar();
		Log_CreateTopic(TOPIC_Addon_RangerHelpSLD,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_RangerHelpSLD,LOG_Running);
		B_LogEntry(TOPIC_Addon_RangerHelpSLD,"Lares said that Cord the mercenary could make life on the landowner's farm easier for me.");
	};
	RangerHelp_gildeSLD = TRUE;
//	SC_KnowsCordAsRangerFromLares = TRUE;
	Info_ClearChoices(DIA_Addon_Lares_Gilde);
};

func void DIA_Addon_Lares_Gilde_MIL()
{
	AI_Output (other, self, "DIA_Addon_Lares_Gilde_MIL_15_00");	//The militia.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_MIL_09_01");	//(amused) Yes. I can imagine you'd like that, eh? Read the law to other people while you're pocketing their purses.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_MIL_09_02");	//The paladins have set up their provisions store by the harbor. Their provisions master is a good friend of mine.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_MIL_09_03");	//Maybe he can do something for you. His name is Martin.
	Log_CreateTopic (TOPIC_Addon_RangerHelpMIL, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_RangerHelpMIL, LOG_Running);
	B_LogEntry (TOPIC_Addon_RangerHelpMIL, "Lares said that Martin the provision master will help me join the militia sooner. He is usually found at the harbor where the paladins have their provisions store.");
	RangerHelp_gildeMIL = TRUE;
	Info_ClearChoices(DIA_Addon_Lares_Gilde);
};

func void DIA_Addon_Lares_Gilde_KDF()
{
	AI_Output (other, self, "DIA_Addon_Lares_Gilde_KDF_15_00");	//The Fire Magicians.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_KDF_09_01");	//(laughs) I bet Vatras didn't foresee that, or he wouldn't have sent you to me.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_KDF_09_02");	//Joining the monastery is expensive.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_KDF_09_03");	//Those boys won't even let you in unless you pay them a tribute.
	AI_Output (self, other, "DIA_Addon_Lares_Gilde_KDF_09_04");	//And the only one who could do anything about that is Vatras himself. You had better talk to him again about this.
	Log_CreateTopic (TOPIC_Addon_RangerHelpKDF, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_RangerHelpKDF, LOG_Running);
	B_LogEntry (TOPIC_Addon_RangerHelpKDF, "Lares said that Vatras knows an easy way to get into the monastery.");
	RangerHelp_gildeKDF = TRUE;
	Info_ClearChoices(DIA_Addon_Lares_Gilde);
};


var int Lares_WorkForLee;

instance DIA_Lares_AboutSld(C_Info)
{
	npc = VLK_449_Lares;
	nr = 10;
	condition = DIA_Lares_AboutSld_Condition;
	information = DIA_Lares_AboutSld_Info;
	permanent = TRUE;
	description = "Tell me more about Lee and his mercenaries...";
};


func int DIA_Lares_AboutSld_Condition()
{
	if(other.guild == GIL_NONE)
	{
		return TRUE;
	};
};

func void DIA_Lares_AboutSld_Info()
{
	AI_Output (other, self, "DIA_ADDON_Lares_AboutSld_15_00");	//Tell me more about Lee and his mercenaries ...
	AI_Output (self, other, "DIA_ADDON_Lares_AboutSld_09_01");	//What do you want to know?
	Info_ClearChoices(DIA_Lares_AboutSld);
	Info_AddChoice(DIA_Lares_AboutSld,Dialog_Back,DIA_Lares_AboutSld_BACK);
	Info_AddChoice(DIA_Lares_AboutSld,"Why aren't YOU with Lee and his mercenaries?",DIA_Lares_AboutSld_WhyNotYou);
	Info_AddChoice(DIA_Lares_AboutSld,"Tell me more about the mercenaries...",DIA_Lares_AboutSld_Sld);
	if(Lares_WayToOnar == FALSE)
	{
		Info_AddChoice(DIA_Lares_AboutSld,"How do I find the landowner's farm?",DIA_Lares_AboutSld_WayToOnar);
	};
};

func void DIA_Lares_AboutSld_BACK()
{
	Info_ClearChoices(DIA_Lares_AboutSld);
};

func void DIA_Lares_AboutSld_Sld()
{
	AI_Output (other, self, "DIA_Lares_AboutSld_15_00");	//Tell me more about the mercenaries.
	AI_Output (self, other, "DIA_Lares_AboutSld_09_01");	//Well, if you're as tough as you were back then, you shouldn't have any problems with them.
	AI_Output (self, other, "DIA_Lares_AboutSld_09_02");	//Most of them are ruffians and if you can't stand up to them, you won't get far.
	AI_Output (self, other, "DIA_Lares_AboutSld_09_03");	//(laughs) If you're squeamish, you don't have a chance of landing with them...
};

func void DIA_Lares_AboutSld_WhyNotYou()
{
	AI_Output (other, self, "DIA_Lares_WhyInCity_15_00");	//Why aren't YOU with Lee and his mercenaries?
	AI_Output (self, other, "DIA_Lares_WhyInCity_09_01");	//But I am! Just not on the farm.
	AI_Output (self, other, "DIA_Lares_WhyInCity_09_02");	//You could say I'm our outpost in the city. We don't want the ship to sail without us.
	Lares_WorkForLee = TRUE;
	Info_AddChoice (DIA_Lares_AboutSld, "What ship were you talking about?", DIA_Lares_AboutSld_Schiff);
};

func void DIA_Lares_AboutSld_Schiff()
{
	AI_Output (other, self, "DIA_Lares_Schiff_15_00");	//What ship were you talking about?
	AI_Output (self, other, "DIA_Lares_Schiff_09_01");	//It's on the open sea harbor, behind the cliffs. Lee and a few of his people really want to get away from here.
	AI_Output (self, other, "DIA_Lares_Schiff_09_02");	//But that could take a while...
	AI_Output (other, self, "DIA_Lares_Schiff_15_03");	//Why?
	AI_Output (self, other, "DIA_Lares_Schiff_09_04");	//You'd better ask Lee about that, if you meet him ... He's got plans.
	if(Lares_WayToOnar == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Lares_WegZumHof_09_01");	//I can take you there if you want.
		Lares_WayToOnar = TRUE;
	};
};

func void DIA_Lares_AboutSld_WayToOnar()
{
	AI_Output (other, self, "DIA_Lares_WegZumHof_15_00");	//How do I find the landowner's farm?
	AI_Output (self, other, "DIA_Addon_Lares_WegZumHof_09_00");	//It's quite simple. You leave the seaport by the east gate, and then follow the path towards the east.
	B_LaresOffersWayToOnar();
};

instance DIA_Lares_GuildOfThieves(C_Info)
{
	npc = VLK_449_Lares;
	nr = 14;
	condition = DIA_Lares_GuildOfThieves_Condition;
	information = DIA_Lares_GuildOfThieves_Info;
	permanent = FALSE;
	description = "Do you know anything about a thieves' guild in town?";
};


func int DIA_Lares_GuildOfThieves_Condition()
{
	if(((MIS_Andre_GuildOfThieves == LOG_Running) || Npc_KnowsInfo(other,DIA_Lares_GotKey)) && (DG_gefunden == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lares_GuildOfThieves_Info()
{
	AI_Output (other, self, "DIA_Lares_GuildOfThieves_15_00");	//Do you know anything about a thieves' guild in town?
	AI_Output (self, other, "DIA_Lares_GuildOfThieves_09_01");	//The questions you ask ...
	AI_Output (self, other, "DIA_Lares_GuildOfThieves_09_02");	//Of course, there's a thieves' guild here. Just like in every big city.
	AI_Output (self, other, "DIA_Lares_GuildOfThieves_09_03");	//And every petty pickpocket or fence is probably connected to it somehow.
};


instance DIA_Lares_WhereGuildOfThieves(C_Info)
{
	npc = VLK_449_Lares;
	nr = 15;
	condition = DIA_Lares_WhereGuildOfThieves_Condition;
	information = DIA_Lares_WhereGuildOfThieves_Info;
	permanent = FALSE;
	description = "Do you know where I can find the thieves' guild?";
};


func int DIA_Lares_WhereGuildOfThieves_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lares_GuildOfThieves) && (DG_gefunden == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lares_WhereGuildOfThieves_Info()
{
	AI_Output (other, self, "DIA_Lares_WhereGuildOfThieves_15_00");	//Do you know where I can find the thieves' guild?
	AI_Output (self, other, "DIA_Lares_WhereGuildOfThieves_09_01");	//(laughs) No offense, but even if I knew, I wouldn't tell you anything.
	AI_Output (self, other, "DIA_Lares_WhereGuildOfThieves_09_02");	//These people usually react VERY sensitively to things like that.
	AI_Output (self, other, "DIA_Lares_WhereGuildOfThieves_09_03");	//If you want to get involved with them, you should be very careful.
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV) || (other.guild == GIL_SLD) || (other.guild == GIL_DJG))
	{
		AI_Output(self,other,"DIA_Lares_WegZumHof_09_02");	//There's usually no militia here in the herbor, but I can't risk one of them getting suspicious.
	};
};


instance DIA_Lares_GotKey(C_Info)
{
	npc = VLK_449_Lares;
	nr = 16;
	condition = DIA_Lares_GotKey_Condition;
	information = DIA_Lares_GotKey_Info;
	permanent = FALSE;
	description = "I've got this key here. It's been corroded by sea salt ...";
};


func int DIA_Lares_GotKey_Condition()
{
	if(Npc_HasItems(other,ItKe_ThiefGuildKey_MIS) && (DG_gefunden == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lares_GotKey_Info()
{
	AI_Output (other, self, "DIA_Lares_GotKey_15_00");	//I've got this key here. It's been corroded by sea salt ...
	AI_Output (self, other, "DIA_Lares_GotKey_09_01");	//So?
	AI_Output (other, self, "DIA_Lares_GotKey_15_02");	//I think it will lead me to the hideout of the thieves' guild ...
	AI_Output (self, other, "DIA_Lares_GotKey_09_03");	//Well, it could be the key to the sewers.
};


instance DIA_Lares_Kanalisation(C_Info)
{
	npc = VLK_449_Lares;
	nr = 17;
	condition = DIA_Lares_Kanalisation_Condition;
	information = DIA_Lares_Kanalisation_Info;
	permanent = FALSE;
	description = "Where can I find the sewers?";
};


func int DIA_Lares_Kanalisation_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lares_GotKey) && (DG_gefunden == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lares_Kanalisation_Info()
{
	AI_Output (other, self, "DIA_Lares_Kanalisation_15_00");	//Where can I find the sewers?
	AI_Output (self, other, "DIA_Lares_Kanalisation_09_01");	//What do I know... they usually empty into the ocean.
};


instance DIA_Lares_OtherGuild(C_Info)
{
	npc = VLK_449_Lares;
	nr = 1;
	condition = DIA_Lares_OtherGuild_Condition;
	information = DIA_Lares_OtherGuild_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Lares_OtherGuild_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (other.guild != GIL_NONE) && (SC_IsRanger == FALSE) && (Lares_FirstMetAsGuildless == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Lares_OtherGuild_Info()
{
	if((other.guild == GIL_MIL) || (other.guild == GIL_PAL))
	{
		if(other.guild == GIL_MIL)
		{
			AI_Output(self,other,"DIA_Lares_OtherGuild_09_00");	//You're in the militia now!
			B_Lares_Comment_MIL();
		}
		else
		{
			AI_Output(self,other,"DIA_Lares_OtherGuild_09_09");	//I heard you got accepted.
			B_Lares_Comment_PAL();
		};
		AI_Output (self, other, "DIA_Lares_OtherGuild_09_03");	//(mischievously) Only you could pull something like that...
		if (Lares_WorkForLee == TRUE)
		{
			AI_Output (self, other, "DIA_Lares_OtherGuild_09_04");	//(concerned) You won't blow the whistle on me about working for Lee, will you?
			AI_Output (other, self, "DIA_Lares_OtherGuild_15_05");	//But you know me ...
		};
	};
	if((other.guild == GIL_KDF) || (other.guild == GIL_NOV))
	{
		AI_Output (self, other, "DIA_Lares_OtherGuild_09_06");	//I don't get it. You entered the monastery. What's it like there?
		AI_Output (other, self, "DIA_Lares_OtherGuild_15_07");	//Different.
		AI_Output (self, other, "DIA_Lares_OtherGuild_09_08");	//I can imagine.
	};
	if((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
	{
		B_Lares_Comment_SLD();
		AI_Output(self,other,"DIA_Lares_OtherGuild_09_10");	//Congratulations.
	};
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Lares_Forest(C_Info)
{
	npc = VLK_449_Lares;
	nr = 9;
	condition = DIA_Addon_Lares_Forest_Condition;
	information = DIA_Addon_Lares_Forest_Info;
	description = "Can you help me get through the thick woods in the east?";
};


func int DIA_Addon_Lares_Forest_Condition()
{
	if(MIS_Addon_Nefarius_BringMissingOrnaments == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_Forest_Info()
{
	AI_Output(other,self,"DIA_Addon_Lares_RangerHelp_Forest_15_00");	//Can you help me get through the thick woods in the east?
	if(Kapitel < 3)
	{
		AI_Output(self,other,"DIA_Addon_Lares_RangerHelp_Forest_09_01");	//Okay. But what do you want to go there for?
	};
	AI_Output (other, self, "DIA_Addon_Lares_RangerHelp_Forest_15_02");	//Nefarius ordered me to find more ornaments.
	AI_Output (other, self, "DIA_Addon_Lares_RangerHelp_Forest_15_03");	//One of the places where I'm supposed to look is in the middle of the woods.
	if(Kapitel < 3)
	{
	AI_Output (self, other, "DIA_Addon_Lares_RangerHelp_Forest_09_04");	//I see. And that's still too dangerous for you alone, right?
	AI_Output (self, other, "DIA_Addon_Lares_RangerHelp_Forest_09_05");	//No problem. Let me know when you want to leave.
		RangerHelp_OrnamentForest = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Lares_OrnamentBringJob_09_02");	//Only, I can't leave here at the moment. I need to keep an eye on the harbor.
	};
};


instance DIA_Lares_GoNow(C_Info)
{
	npc = VLK_449_Lares;
	nr = 10;
	condition = DIA_Lares_GoNow_Condition;
	information = DIA_Lares_GoNow_Info;
	permanent = TRUE;
	description = "OK, let's go.";
};


func int DIA_Lares_GoNow_Condition()
{
	if(((Lares_WayToOnar == TRUE) || (MIS_Addon_Lares_Ornament2Saturas == LOG_Running) || (RangerHelp_OrnamentForest == TRUE)) && ((LaresGuide_ZumPortal == 0) || (LaresGuide_ZumPortal == 8)) && ((LaresGuide_ZuOnar == FALSE) || (LaresGuide_ZuOnar == LOG_SUCCESS)) && ((LaresGuide_OrnamentForest == 0) || (LaresGuide_OrnamentForest == 3)) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Lares_GoNow_GoingConditions()
{
	AI_Output(self,other,"DIA_Lares_GoNow_09_01");	//Then let's go... Follow me.
	AI_StopProcessInfos(self);
	Lares_Guide = Wld_GetDay();
	Lares_Distracted = FALSE;
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	if(!Npc_KnowsInfo(other,DIA_Moe_Hallo))
	{
		Npc_SetRefuseTalk(Moe,30);
	};
};

func void DIA_Lares_GoNow_Info()
{
	AI_Output (other, self, "DIA_Lares_GoNow_15_00");	//Okay, lass uns gehen.
	if (Lares_CanBringScToPlaces == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Lares_GoNow_09_03");	//I cannot leave here until we know more about the missing people, or someone else takes over my duties.
	}
	else if(MIS_Addon_Lares_ComeToRangerMeeting == LOG_Running)
	{
		B_Lares_Geheimtreffen();
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Lares_GoNow_09_04");	//Where?
		Info_ClearChoices(DIA_Lares_GoNow);
		Info_AddChoice(DIA_Lares_GoNow,Dialog_Back,DIA_Lares_GoNow_warte);
		if((Lares_WayToOnar == TRUE) && (LaresGuide_ZuOnar != LOG_SUCCESS))
		{
			Info_AddChoice (DIA_Lares_GoNow, "To Onar's farm.", DIA_Lares_GoNow_Onar);
		};
		if((MIS_Addon_Lares_Ornament2Saturas == LOG_Running) && (Lares_Angekommen == FALSE))
		{
			Info_AddChoice (DIA_Lares_GoNow, "Let us take Vatras' ornament back.", DIA_Lares_GoNow_Maya);
		};
		if((ORNAMENT_SWITCHED_FOREST == FALSE) && (LaresGuide_OrnamentForest == 0) && (RangerHelp_OrnamentForest == TRUE))
		{
			Info_AddChoice (DIA_Lares_GoNow, "To the dense forest in the east.", DIA_Lares_GoNow_Forest);
		};
	};
};

func void DIA_Lares_GoNow_Maya()
{
	AI_Output (other, self, "DIA_Addon_Lares_GoNow_Maya_15_00");	//Let us take Vatras' ornament back.
	LaresGuide_ZumPortal = 1;
	Npc_ExchangeRoutine(self,"GUIDEPORTALTEMPEL1");
	B_StartOtherRoutine(BridgeBandit,"Intercept");
	DIA_Lares_GoNow_GoingConditions();
};

func void DIA_Lares_GoNow_Onar()
{
	AI_Output (other, self, "DIA_Addon_Lares_GoNow_Onar_15_00");	//To Onar's farm.
	LaresGuide_ZuOnar = TRUE;
	Npc_ExchangeRoutine(self,"GUIDE");
	DIA_Lares_GoNow_GoingConditions();
};

func void DIA_Lares_GoNow_Forest()
{
	AI_Output (other, self, "DIA_Addon_Lares_GoNow_Forest_15_00");	//To the dense forest in the east.
	LaresGuide_OrnamentForest = 1;
	Npc_ExchangeRoutine(self,"GUIDEMEDIUMWALD1");
	DIA_Lares_GoNow_GoingConditions();
};

func void DIA_Lares_GoNow_warte()
{
	Info_ClearChoices(DIA_Lares_GoNow);
};


func void B_LaresSoLate()
{
	AI_Output(self,other,"DIA_Lares_GUIDE_09_01");	//So there you are. I was beginning to think you'd been eaten by wolves.
};

func void B_LaresDistractionCheck()
{
	if(Lares_Distracted == TRUE)
	{
		if(LaresGuide_ZumPortal == 3)
		{
			AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortalInterWeiter2_09_00");	//Don't you break down on me now.
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortalInterWeiter_09_00");	//What's wrong? Are you still holding up?
		};
	}
	else
	{
		if(LaresGuide_ZumPortal == 3)
		{
			AI_Output(self,other,"DIA_Addon_Lares_GetRangerArmor_09_08");	//Any more questions?
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortalInterWeiter3_09_00");	//Can you still go on?
		};
	};
};

instance DIA_Lares_GUIDE(C_Info)
{
	npc = VLK_449_Lares;
	nr = 1;
	condition = DIA_Lares_GUIDE_Condition;
	information = DIA_Lares_GUIDE_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Lares_GUIDE_Condition()
{
	if((LaresGuide_ZuOnar == TRUE) && Hlp_StrCmp(Npc_GetNearestWP(self),"NW_TAVERNE_BIGFARM_05"))
	{
		return TRUE;
	};
};

func void DIA_Lares_GUIDE_Info()
{
	if(Lares_Guide > (Wld_GetDay() - 2))
	{
		AI_Output (self, other, "DIA_Lares_GUIDE_09_00");	//So, here we are.
	}
	else
	{
		B_LaresSoLate();
	};
	AI_Output (self, other, "DIA_Lares_GUIDE_09_02");	//So, the rest of the way you can manage alone. I have to get back to the city, I've got a few things to take care of...
	AI_Output (self, other, "DIA_Lares_GUIDE_09_03");	//Just follow this road here, and remember - stand up for yourself and don't take any crap, and it'll be smooth sailing.
	if((other.guild == GIL_NONE) && Npc_KnowsInfo(other,DIA_Lares_Paladine))
	{
		AI_Output(self,other,"DIA_Lares_Alternative_09_01");	//If I were you, I'd go to Onar's farm and talk to Lee.
		AI_Output(self,other,"DIA_Lares_Alternative_09_02");	//I'm sure we'll find a way to get you into the upper end of town.
	};
	Knows_Taverne = TRUE;
	AI_StopProcessInfos(self);
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"START");
	LaresGuide_ZuOnar = LOG_SUCCESS;
};


instance DIA_Addon_Lares_ArrivedPortalInter1(C_Info)
{
	npc = VLK_449_Lares;
	nr = 1;
	condition = DIA_Addon_Lares_ArrivedPortalInter1_Condition;
	information = DIA_Addon_Lares_ArrivedPortalInter1_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Lares_ArrivedPortalInter1_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_Running) && Hlp_StrCmp(Npc_GetNearestWP(self),"NW_CITY_TO_FOREST_11") && (LaresGuide_ZumPortal == 1))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_ArrivedPortalInter1_Info()
{
	if(LaresToldAboutKDW1 == FALSE)
	{
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_09_00");	//Now that we're no longer in town and cannot be overheard, let me tell you a little more.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_09_01");	//We are now going to take this ornament that you brought me back to Saturas. You remember Saturas, don't you?
		LaresToldAboutKDW1 = TRUE;
		Info_ClearChoices(DIA_Addon_Lares_ArrivedPortalInter1);
		Info_AddChoice(DIA_Addon_Lares_ArrivedPortalInter1,"Sure.",DIA_Addon_Lares_ArrivedPortalInter1_ja);
		Info_AddChoice(DIA_Addon_Lares_ArrivedPortalInter1,"Saturas? Who is that?",DIA_Addon_Lares_ArrivedPortalInter1_wer);
	}
	else 
	{
		if(Lares_Guide > (Wld_GetDay() - 2))
		{
			B_LaresDistractionCheck();
		}
		else
		{
			B_LaresSoLate();
		};
		B_MakeRangerReadyForMeeting(self);
	};
	Lares_Distracted = FALSE;
	LaresGuide_ZumPortal = 2;
};

func void DIA_Addon_Lares_ArrivedPortalInter1_teil2()
{
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_teil2_09_00");	//We lads from the former New Camp still have good relations with the Water Mages.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_teil2_09_01");	//Even Lee will still protect the Water Mages against any danger today if it is within his power.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_teil2_09_02");	//To keep up the contact with the Water Mages, I'm in town most of the time, working together with Vatras.
	B_MakeRangerReadyForMeeting(self);
	if(Lares_ArmorComment == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortalInter1_teil2_09_03");	//And this is the armor that is issued to each of us by the Water Mages. The members of the Ring of Water have been wearing such armor since before the orc wars.
		Lares_ArmorComment = TRUE;
	};
	if(Cavalorn_RangerHint == TRUE)
	{
		AI_Output (other, self, "DIA_Addon_Lares_ArrivedPortalInter1_teil2_15_04");	//What is Cavalorn's part in this? He wasn't a follower of the New Camp as far as I know.
		AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_teil2_09_05");	//You are right, our community has grown. Even I do not know how many there are by now.
	};
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_teil2_09_06");	//But let us move on. I want to get further away from the city. We can talk more about it later.
	Info_ClearChoices (DIA_Addon_Lares_ArrivedPortalInter1);
};

func void DIA_Addon_Lares_ArrivedPortalInter1_wer()
{
	AI_Output (other, self, "DIA_Addon_Lares_ArrivedPortalInter1_wer_15_00");	//Saturas? Who is that?
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_wer_09_01");	//He was the head of the Water Mages in the New Camp, back in the Valley of Mines when the Barrier was still around us all.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter1_wer_09_02");	//Lee and I had made a pact with the Water Mages back then. Together, we were strong enough to hold up against the Old Camp.
	DIA_Addon_Lares_ArrivedPortalInter1_teil2 ();
};

func void DIA_Addon_Lares_ArrivedPortalInter1_ja()
{
	AI_Output (other, self, "DIA_Addon_Lares_ArrivedPortalInter1_ja_15_00");	//Certainly. He was the leader of the Water Mages in the New Camp.
	DIA_Addon_Lares_ArrivedPortalInter1_teil2 ();
};


instance DIA_Addon_Lares_ArrivedPortalInterWeiter(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_ArrivedPortalInterWeiter_Condition;
	information = DIA_Addon_Lares_ArrivedPortalInterWeiter_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Lares_ArrivedPortalInterWeiter_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_Running) && Hlp_StrCmp(Npc_GetNearestWP(self),"NW_TAVERN_TO_FOREST_02") && (LaresGuide_ZumPortal == 2))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_ArrivedPortalInterWeiter_Info()
{
	if(Lares_Guide > (Wld_GetDay() - 2))
	{
		B_LaresDistractionCheck();
	}
	else
	{
		B_LaresSoLate();
	};
	if((MIS_Addon_Erol_BanditStuff == LOG_Running) && (Npc_GetDistToWP(Erol,"NW_TAVERN_TO_FOREST_03") < 1000) && !Npc_IsDead(Erol))
	{
		AI_Output(other,self,"DIA_Addon_Lares_ArrivedPortalInterWeiter_15_01");	//That fellow over there has problems with bandits.
		AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortalInterWeiter_09_02");	//(snidely) Too bad for him, but we don't have time for that now.
	};
	Lares_Distracted = FALSE;
	LaresGuide_ZumPortal = 3;
};


instance DIA_Addon_Lares_ArrivedPortalInterWeiter2(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_ArrivedPortalInterWeiter2_Condition;
	information = DIA_Addon_Lares_ArrivedPortalInterWeiter2_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Lares_ArrivedPortalInterWeiter2_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_Running) && Hlp_StrCmp(Npc_GetNearestWP(self),"NW_TAVERNE_TROLLAREA_14") && (LaresGuide_ZumPortal == 3))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_ArrivedPortalInterWeiter2_Info()
{
	if(Lares_Guide > (Wld_GetDay() - 2))
	{
		B_LaresDistractionCheck();
	}
	else
	{
		B_LaresSoLate();
	};
	Lares_Distracted = FALSE;
	LaresGuide_ZumPortal = 4;
};


instance DIA_Addon_Lares_ArrivedPortalInter2(C_Info)
{
	npc = VLK_449_Lares;
	nr = 1;
	condition = DIA_Addon_Lares_ArrivedPortalInter2_Condition;
	information = DIA_Addon_Lares_ArrivedPortalInter2_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Lares_ArrivedPortalInter2_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_Running) && Hlp_StrCmp(Npc_GetNearestWP(self),"NW_TROLLAREA_PATH_58") && (LaresGuide_ZumPortal == 4))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_ArrivedPortalInter2_Info()
{
	if(LaresToldAboutKDW2 == FALSE)
	{
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter2_09_00");	//The Water Mages are all beside themselves. They've been digging at an excavation site in the north-east for weeks. It's anybody's guess what they're trying to find there.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter2_09_01");	//It all started when the earth began trembling like it did in the worst times of the Barrier.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter2_09_02");	//Horrible stone creatures emerged from the ground, slaying everyone who went within 100 feet of them.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter2_09_03");	//The Water Mages took the matter in hand and destroyed those hostile invaders. And now they're digging down there, searching for an explanation for these strange events.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortalInter2_09_04");	//But you will soon see for yourself.
		B_LogEntry(TOPIC_Addon_KDW,"Lares told me about the Water Mages' excavation site. They are investigating some peculiar events. There have been mysterious earthquakes, and strange stone creatures emerging from the ground.");
		LaresToldAboutKDW2 = TRUE;
	}
	else
	{
		if(Lares_Guide > (Wld_GetDay() - 2))
		{
			B_LaresDistractionCheck();
		}
		else
		{
			B_LaresSoLate();
		};
	};
	Lares_Distracted = FALSE;
	LaresGuide_ZumPortal = 5;
};


instance DIA_Addon_Lares_ArrivedPortalInterWeiter3(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_ArrivedPortalInterWeiter3_Condition;
	information = DIA_Addon_Lares_ArrivedPortalInterWeiter3_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Lares_ArrivedPortalInterWeiter3_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_Running) && (Npc_GetDistToWP(self,"NW_TROLLAREA_PATH_47") < 200) && (LaresGuide_ZumPortal == 5))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_ArrivedPortalInterWeiter3_Info()
{
	if(Lares_Guide > (Wld_GetDay() - 2))
	{
		B_LaresDistractionCheck();
	}
	else
	{
		B_LaresSoLate();
	};
	Lares_Distracted = FALSE;
	LaresGuide_ZumPortal = 6;
};


instance DIA_Addon_Lares_ArrivedPortalInterWeiter4(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Addon_Lares_ArrivedPortalInterWeiter4_Condition;
	information = DIA_Addon_Lares_ArrivedPortalInterWeiter4_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Lares_ArrivedPortalInterWeiter4_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_Running) && Hlp_StrCmp(Npc_GetNearestWP(self),"NW_TROLLAREA_RUINS_02") && (LaresGuide_ZumPortal == 6))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_ArrivedPortalInterWeiter4_Info()
{
	AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortalInterWeiter4_09_00");	//Right. It could get dangerous here.
	B_StartOtherRoutine(BridgeBandit,"Intercept");
	Lares_Distracted = FALSE;
	LaresGuide_ZumPortal = 7;
};


instance DIA_Addon_Lares_ArrivedPortal(C_Info)
{
	npc = VLK_449_Lares;
	nr = 1;
	condition = DIA_Addon_Lares_ArrivedPortal_Condition;
	information = DIA_Addon_Lares_ArrivedPortal_Info;
	important = TRUE;
};


func int DIA_Addon_Lares_ArrivedPortal_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_Running) && Hlp_StrCmp(Npc_GetNearestWP(self),"NW_TROLLAREA_RUINS_41") && (LaresGuide_ZumPortal == 7))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_ArrivedPortal_Info()
{
	B_MakeRangerReadyToLeaveMeeting(self);
	if(Lares_Guide > (Wld_GetDay() - 2))
	{
		AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortal_09_00");	//We're here.
	}
	else
	{
		B_LaresSoLate();
	};
	AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortal_09_01");	//Here, take the ornament. The Water Mages must be in there somewhere. Take it to them.
	AI_WaitTillEnd(other,self);
	B_GiveInvItems(self,other,ItMi_Ornament_Addon_Vatras,1);
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortal_09_02");	//If you should meet any beasts down in that hole in the ground that look like they're too much for you, flee forward to Saturas.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortal_09_03");	//He'll take care of the beasts for you. I need to go back.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortal_09_04");	//And one more thing: Don't even think about strolling around for long with this ornament. Go DIRECTLY to Saturas.
	AI_Output (self, other, "DIA_Addon_Lares_ArrivedPortal_09_05");	//See you.
	B_LogEntry(TOPIC_Addon_KDW,"Lares handed me this ornament. He wants me to give it to Saturas the Water Mage.");
	AI_StopProcessInfos(self);
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"START");
	Lares_Distracted = FALSE;
	LaresGuide_ZumPortal = 8;
	Lares_Angekommen = TRUE;
};


instance DIA_Addon_Lares_Albern(C_Info)
{
	npc = VLK_449_Lares;
	nr = 1;
	condition = DIA_Addon_Lares_Albern_Condition;
	information = DIA_Addon_Lares_Albern_Info;
	important = TRUE;
};


func int DIA_Addon_Lares_Albern_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas != LOG_SUCCESS) && (Lares_Angekommen == TRUE))
	{
		if(Npc_GetDistToWP(self,"NW_TROLLAREA_RUINS_41") > 1000)
		{
			return TRUE;
		}
		else if(Npc_IsInState(self,ZS_Talk))
		{
			return TRUE;
		};
	};
};

func void DIA_Addon_Lares_Albern_Info()
{
	if(Npc_GetDistToWP(self,"HAFEN") < 2000)
	{
		AI_Output(self,other,"DIA_Canthar_WhatOffer_Price_09_05");	//Do we have a deal?
		DIA_Common_NoNotYet();
	};
	AI_Output(self,other,"DIA_Addon_Lares_Albern_09_00");	//(strictly) Stop goofing off! Take that ornament to Saturas already!
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Lares_GOFORESTPRE(C_Info)
{
	npc = VLK_449_Lares;
	nr = 1;
	condition = DIA_Addon_Lares_GOFORESTPRE_Condition;
	information = DIA_Addon_Lares_GOFORESTPRE_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Lares_GOFORESTPRE_Condition()
{
	if(Hlp_StrCmp(Npc_GetNearestWP(self),"NW_CITY_TO_FARM2_04") && (LaresGuide_OrnamentForest == 1))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_GOFORESTPRE_ja()
{
	B_MakeRangerReadyForMeeting(self);
	DIA_Common_Yes();
	AI_Output(self,other,"DIA_Addon_Lares_GOFORESTPRE_ja_09_01");	//All right, my friend. Then follow me. This is going to be gross.
	AI_StopProcessInfos (self);
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"GUIDEMEDIUMWALD2");
	LaresGuide_OrnamentForest = 2;
};

func void DIA_Addon_Lares_GOFORESTPRE_nein()
{
	AI_Output (other, self, "DIA_Addon_Lares_GOFORESTPRE_nein_15_00");	//No. You can go.
	AI_Output (self, other, "DIA_Addon_Lares_GOFORESTPRE_nein_09_01");	//I guess the matter has taken care of itself? All right. See you.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "Start");
	LaresGuide_OrnamentForest = 3;
};

func void DIA_Addon_Lares_GOFORESTPRE_Info()
{
	if(Lares_Guide <= (Wld_GetDay() - 2))
	{
		B_LaresSoLate();
	};
	if(ORNAMENT_SWITCHED_FOREST == TRUE)
	{
		AI_Output(self,other,"DIA_Addon_Lares_GOFORESTPRE_09_00");	//Do you still want to go into the woods with me?
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Lares_GOFORESTPRE_09_01");	//Have you thought about going into the woods? Do you really want to do that?
	};
	Info_ClearChoices (DIA_Addon_Lares_GOFORESTPRE);
	Info_AddChoice (DIA_Addon_Lares_GOFORESTPRE, "No. You can go.", DIA_Addon_Lares_GOFORESTPRE_nein);
	Info_AddChoice (DIA_Addon_Lares_GOFORESTPRE, "Yes.", DIA_Addon_Lares_GOFORESTPRE_ja);
};


instance DIA_Addon_Lares_GOFOREST(C_Info)
{
	npc = VLK_449_Lares;
	nr = 1;
	condition = DIA_Addon_Lares_GOFOREST_Condition;
	information = DIA_Addon_Lares_GOFOREST_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Addon_Lares_GOFOREST_Condition()
{
	if(Hlp_StrCmp(Npc_GetNearestWP(self),"NW_FOREST_PATH_62") && (LaresGuide_OrnamentForest == 2) && Npc_IsDead(Stoneguardian_Ornament))
	{
		if(Lares_ArrivedToForest == FALSE)
		{
			return TRUE;
		};
		if((ORNAMENT_SWITCHED_FOREST == FALSE) && Npc_IsInState(self,ZS_Talk))
		{
			return TRUE;
		};
		if(ORNAMENT_SWITCHED_FOREST == TRUE)
		{
			return TRUE;
		};
	};
};

func void DIA_Addon_Lares_GOFOREST_Info()
{
	if(Lares_ArrivedToForest == FALSE)
	{
		if(Lares_Guide > (Wld_GetDay() - 2))
		{
			AI_Output(self,other,"DIA_Addon_Lares_ArrivedPortal_09_00");	//We're here.
		}
		else
		{
			B_LaresSoLate();
		};
		Lares_ArrivedToForest = TRUE;
	};
	if(ORNAMENT_SWITCHED_FOREST == TRUE)
	{
		B_MakeRangerReadyToLeaveMeeting(self);
		AI_Output(self,other,"DIA_Addon_Lares_GOFOREST_09_00");	//There. You should be able to do the rest by yourself. I'm headed back, then.
		AI_StopProcessInfos(self);
		self.aivar[AIV_PARTYMEMBER] = FALSE;
		Npc_ExchangeRoutine(self,"START");
		LaresGuide_OrnamentForest = 3;
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Lares_GOFOREST_09_01");	//Hurry up. I don't want to stay here any longer than I have to.
		AI_StopProcessInfos (self);
	};
};


instance DIA_Addon_Lares_PortalInterWEITER(C_Info)
{
	npc = VLK_449_Lares;
	nr = 1;
	condition = DIA_Addon_Lares_PortalInterWEITER_Condition;
	information = DIA_Addon_Lares_PortalInterWEITER_Info;
	permanent = TRUE;
	description = "Let's move on.";
};


func int DIA_Addon_Lares_PortalInterWEITER_Condition()
{
	if((LaresGuide_ZumPortal != 0) && (LaresGuide_ZumPortal != 8))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lares_PortalInterWEITER_Info()
{
	AI_Output(other,self,"DIA_Addon_Lares_PortalInterWEITER_15_02");	//Let's move on.
	Lares_Distracted = FALSE;
	Lares_Guide = Wld_GetDay();
	if(LaresGuide_ZumPortal == 7)
	{
		AI_Output(self,other,"DIA_Addon_Lares_PortalInterWEITER_09_03");	//Keep back a little.
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Lares_PortalInterWEITER_09_04");	//Stay close behind me.
	};
	if(LaresGuide_ZumPortal == 4)
	{
		AI_Output(other,self,"DIA_Addon_Lares_PortalInterWEITER_15_00");	//Stop blabbing.
	}
	else if(LaresGuide_ZumPortal == 6)
	{
		AI_Output(other,self,"DIA_Addon_Lares_PortalInterWEITER_15_01");	//(irritated) Yeah, yeah.
	};
	AI_StopProcessInfos(self);
	if(LaresGuide_ZumPortal == 2)
	{
		Npc_ExchangeRoutine(self,"GUIDEPORTALTEMPEL2");
	}
	else if(LaresGuide_ZumPortal == 3)
	{
		Npc_ExchangeRoutine(self,"GUIDEPORTALTEMPEL3");
	}
	else if(LaresGuide_ZumPortal == 4)
	{
		Npc_ExchangeRoutine(self,"GUIDEPORTALTEMPEL4");
	}
	else if(LaresGuide_ZumPortal == 5)
	{
		Npc_ExchangeRoutine(self,"GUIDEPORTALTEMPEL5");
		if(Hlp_IsValidNpc(Gobbo_Black_Crossbow_Guard_01) && !Npc_IsDead(Gobbo_Black_Crossbow_Guard_01))
		{
			Npc_ChangeAttribute(Gobbo_Black_Crossbow_Guard_01,ATR_HITPOINTS,-Gobbo_Black_Crossbow_Guard_01.attribute[ATR_HITPOINTS_MAX]);
		};
		if(Hlp_IsValidNpc(Gobbo_Black_Crossbow_Guard_02) && !Npc_IsDead(Gobbo_Black_Crossbow_Guard_02))
		{
			Npc_ChangeAttribute(Gobbo_Black_Crossbow_Guard_02,ATR_HITPOINTS,-Gobbo_Black_Crossbow_Guard_02.attribute[ATR_HITPOINTS_MAX]);
		};
		B_StartOtherRoutine(BridgeBandit,"Hide");
	}
	else if(LaresGuide_ZumPortal == 6)
	{
		Npc_ExchangeRoutine(self,"GUIDEPORTALTEMPEL6");
	}
	else if(LaresGuide_ZumPortal == 7)
	{
		Npc_ExchangeRoutine(self,"GUIDEPORTALTEMPELEND");
	};
};


instance DIA_Lares_DEX(C_Info)
{
	npc = VLK_449_Lares;
	nr = 20;
	condition = DIA_Lares_DEX_Condition;
	information = DIA_Lares_DEX_Info;
	permanent = FALSE;
	description = "Can you teach me something?";
};


func int DIA_Lares_DEX_Condition()
{
	return TRUE;
};

func void DIA_Lares_DEX_Info()
{
	AI_Output (other, self, "DIA_Lares_DEX_15_00");	//Can you teach me something?
	AI_Output (self, other, "DIA_Addon_Lares_DEX_Add_09_01");	//Sure. I can help you become stronger and more dexterous if you like.
	Lares_TeachDEX = TRUE;
	if(DIA_Kardif_Lernen_permanent == FALSE)
	{
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_CityTeacher,"Lares can help me become stronger and more dextrous.");
	};
};


var int Lares_MerkeDEX;
var int Lares_MerkeSTR;

func void B_BuildLearnDialog_Lares()
{
	Info_ClearChoices(DIA_Lares_TEACH);
	Info_AddChoice(DIA_Lares_TEACH,Dialog_Back,DIA_Lares_TEACH_BACK);
	Info_AddChoice(DIA_Lares_TEACH,B_BuildLearnString(PRINT_LearnDEX1,B_GetLearnCostAttribute(other,ATR_DEXTERITY)),DIA_Lares_TEACH_1);
	Info_AddChoice(DIA_Lares_TEACH,B_BuildLearnString(PRINT_LearnDEX5,B_GetLearnCostAttribute(other,ATR_DEXTERITY) * 5),DIA_Lares_TEACH_5);
	Info_AddChoice(DIA_Lares_TEACH,B_BuildLearnString(PRINT_LearnSTR1,B_GetLearnCostAttribute(other,ATR_STRENGTH)),DIA_Lares_TEACHSTR_1);
	Info_AddChoice(DIA_Lares_TEACH,B_BuildLearnString(PRINT_LearnSTR5,B_GetLearnCostAttribute(other,ATR_STRENGTH) * 5),DIA_Lares_TEACHSTR_5);
};

instance DIA_Lares_TEACH(C_Info)
{
	npc = VLK_449_Lares;
	nr = 20;
	condition = DIA_Lares_TEACH_Condition;
	information = DIA_Lares_TEACH_Info;
	permanent = TRUE;
	description = "Teach me something.";
};


func int DIA_Lares_TEACH_Condition()
{
	if(Lares_TeachDEX == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Lares_TEACH_Info()
{
	AI_Output (other, self, "DIA_Addon_Lares_Teach_15_00");	//Teach me something.
	Lares_MerkeDEX = other.aivar[REAL_DEXTERITY];
	Lares_MerkeSTR = other.aivar[REAL_STRENGTH];
	B_BuildLearnDialog_Lares();
};

func void DIA_Lares_TEACH_BACK()
{
	if(other.aivar[REAL_DEXTERITY] > Lares_MerkeDEX)
	{
		AI_Output(self,other,"DIA_Lares_TEACH_BACK_09_00");	//You've already gotten more dexterous.
	};
	if(other.aivar[REAL_STRENGTH] > Lares_MerkeSTR)
	{
		AI_Output(self,other,"DIA_Addon_Lares_TEACH_BACK_Add_09_00");	//(appraisingly). Good. Your strength has increased.
	};
	Info_ClearChoices(DIA_Lares_TEACH);
};

func void DIA_Lares_TEACH_1()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,1,T_MED))
	{
		B_BuildLearnDialog_Lares();
	};
};

func void DIA_Lares_TEACH_5()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,5,T_MED))
	{
		B_BuildLearnDialog_Lares();
	};
};

func void DIA_Lares_TEACHSTR_1()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,1,T_LOW))
	{
		B_BuildLearnDialog_Lares();
	};
};

func void DIA_Lares_TEACHSTR_5()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,5,T_LOW))
	{
		B_BuildLearnDialog_Lares();
	};
};

var int Lares_AnyNews_OneTime;

instance DIA_Lares_AnyNews(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Lares_AnyNews_Condition;
	information = DIA_Lares_AnyNews_Info;
	permanent = TRUE;
	description = "Any news?";
};


func int DIA_Lares_AnyNews_Condition()
{
	if(Kapitel == 3)
	{
		return TRUE;
	};
};

func void DIA_Lares_AnyNews_Info()
{
	AI_Output (other, self, "DIA_Lares_AnyNews_15_00");	//Any news?
	if (MIS_RescueBennet == LOG_SUCCESS)
	{
		if(Lares_AnyNews_OneTime == FALSE)
		{
			AI_Output(self,other,"DIA_Lares_AnyNews_09_01");	//You're responsible for the best news yourself. They've let Bennet go again, he's back at the farm.
			if(!Npc_KnowsInfo(other,DIA_Bennet_Present))
			{
				AI_Output(self,other,"DIA_Lares_AnyNews_09_02");	//You could say so. The paladins have arrested Bennet, our smith.
			};
			Lares_AnyNews_OneTime = TRUE;
		}
		else
		{
			DIA_Common_09_AllQuiet();
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Lares_AnyNews_09_03");	//You could say so. The paladins have arrested Bennet, our smith.
		if (MIS_RescueBennet == LOG_Running)
		{
			AI_Output (other, self, "DIA_Lares_AnyNews_15_04");	//So I've heard. That's a bad business.
			AI_Output (self, other, "DIA_Lares_AnyNews_09_05");	//You can say that again.
		}
		else
		{
			AI_Output (other, self, "DIA_Lares_AnyNews_15_06");	//How did that happen?
			AI_Output (self, other, "DIA_Lares_AnyNews_09_07");	//Bennet went to town to buy supplies. Well, he never came back.
			AI_Output (self, other, "DIA_Lares_AnyNews_09_08");	//If you want to learn more, you should ask Hodges, he was in the city with Bennet.
			MIS_RescueBennet = LOG_Running;
			Log_CreateTopic(TOPIC_RescueBennet,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_RescueBennet,LOG_Running);
			B_LogEntry(TOPIC_RescueBennet,"Bennet the blacksmith was arrested by the paladins in Khorinis.");
			if(!Npc_KnowsInfo(other,DIA_Hodges_WhatHappened) || !Npc_KnowsInfo(other,DIA_Hodges_BennetsCrime))
			{
				Log_AddEntry(TOPIC_RescueBennet,"I can learn the details from Hodges, his apprentice.");
			};
 		};
	};
};


instance DIA_Lares_NewsAboutBennet(C_Info)
{
	npc = VLK_449_Lares;
	nr = 6;
	condition = DIA_Lares_NewsAboutBennet_Condition;
	information = DIA_Lares_NewsAboutBennet_Info;
	permanent = FALSE;
	description = "Any news of Bennet?";
};


func int DIA_Lares_NewsAboutBennet_Condition()
{
	if(MIS_RescueBennet == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Lares_NewsAboutBennet_Info()
{
	AI_Output (other, self, "DIA_Lares_NewsAboutBennet_15_00");	//Any news of Bennet?
	AI_Output (self, other, "DIA_Lares_NewsAboutBennet_09_01");	//They seem to have taken him to the barracks and tossed him into the dungeon.
	AI_Output (other, self, "DIA_Lares_NewsAboutBennet_15_02");	//How can we get him out of there?
	AI_Output (self, other, "DIA_Lares_NewsAboutBennet_09_03");	//I don't have any ideas so far. I can't get to his cell to talk to him.
	AI_Output (self, other, "DIA_Lares_NewsAboutBennet_09_04");	//All I can do is keep my ears open, but there isn't much to learn around here.
};


instance DIA_Lares_Kap4_PERM(C_Info)
{
	npc = VLK_449_Lares;
	nr = 6;
	condition = DIA_Lares_Kap4_PERM_Condition;
	information = DIA_Lares_Kap4_PERM_Info;
//	permanent = TRUE;
	permanent = FALSE;
	description = "Why aren't you out hunting dragons?";
};


func int DIA_Lares_Kap4_PERM_Condition()
{
	if(Kapitel >= 4)
	{
		return TRUE;
	};
};

func void DIA_Lares_Kap4_PERM_Info()
{
	AI_Output (other, self, "DIA_Lares_Kap4_PERM_15_00");	//Why aren't you out hunting dragons?
	AI_Output (self, other, "DIA_Lares_Kap4_PERM_09_01");	//That's not my kind of thing, I'll leave that to the others.
	AI_Output (self, other, "DIA_Lares_Kap4_PERM_09_02");	//Nah, nah. Fresh sea air - that's what I need now.
};


instance DIA_Lares_KnowWhereEnemy(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Lares_KnowWhereEnemy_Condition;
	information = DIA_Lares_KnowWhereEnemy_Info;
	permanent = TRUE;
	description = "Would you want to leave this island?";
};


func int DIA_Lares_KnowWhereEnemy_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && (Lares_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lares_KnowWhereEnemy_Info()
{
	AI_Output (other, self, "DIA_Lares_KnowWhereEnemy_15_00");	//Would you fancy leaving this island?
	AI_Output (self, other, "DIA_Lares_KnowWhereEnemy_09_01");	//More than anything. What have you got in mind?
	AI_Output (other, self, "DIA_Lares_KnowWhereEnemy_15_02");	//I found out where the leader of the dragons is hiding. He's on an island, not far from here.
	AI_Output (other, self, "DIA_Lares_KnowWhereEnemy_15_03");	//I intend to get rid of him for good.
	AI_Output (self, other, "DIA_Lares_KnowWhereEnemy_09_04");	//Sounds like a blast. If you can use me, I'm in.
	AI_Output (self, other, "DIA_Lares_KnowWhereEnemy_09_05");	//Couldn't you use a teacher for dexterity or combat with one-handed weapons on your journey?
	if(SCToldLaresHeKnowWhereEnemy == FALSE)
	{
		B_LogEntry(Topic_Crew,"If I take Lares with me, he will be able to teach me one-handed fight and increase my dexterity.");
		SCToldLaresHeKnowWhereEnemy = TRUE;
	};
	if(Crewmember_Count >= Max_Crew)
	{
		AI_Output(other,self,"DIA_Lares_KnowWhereEnemy_15_06");	//The ship's already full, but I'll get back to you if there is a change.
	}
	else
	{
		Info_ClearChoices (DIA_Lares_KnowWhereEnemy);
		Info_AddChoice (DIA_Lares_KnowWhereEnemy, "I have no use for you.", DIA_Lares_KnowWhereEnemy_No);
		Info_AddChoice (DIA_Lares_KnowWhereEnemy, "I knew I could rely on you.", DIA_Lares_KnowWhereEnemy_Yes);
	};
};

func void DIA_Lares_KnowWhereEnemy_Yes()
{
	AI_Output (other, self, "DIA_Lares_KnowWhereEnemy_Yes_15_00");	//I knew I could rely on you.
	AI_Output (other, self, "DIA_Lares_KnowWhereEnemy_Yes_15_01");	//We're all going to meet at the ship.
	AI_Output (self, other, "DIA_Lares_KnowWhereEnemy_Yes_09_02");	//A man of action, that's what I like. See you later.
	B_JoinShip(self);
};

func void DIA_Lares_KnowWhereEnemy_No()
{
	AI_Output (other, self, "DIA_Lares_KnowWhereEnemy_No_15_00");	//I appreciate your offer, but I have no use for you.
	AI_Output (self, other, "DIA_Lares_KnowWhereEnemy_No_09_01");	//You must know what you want. If you want to talk about it later, you know where to find me.
	if (hero.guild == GIL_DJG)
	{
		Lares_IsOnBoard = LOG_OBSOLETE;
	}
	else
	{
		Lares_IsOnBoard = LOG_FAILED;
	};
	B_CheckLog();
	Info_ClearChoices(DIA_Lares_KnowWhereEnemy);
};


instance DIA_Lares_LeaveMyShip(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Lares_LeaveMyShip_Condition;
	information = DIA_Lares_LeaveMyShip_Info;
	permanent = TRUE;
	description = "It's better if you don't come along.";
};


func int DIA_Lares_LeaveMyShip_Condition()
{
	if((Lares_IsOnBoard == LOG_SUCCESS) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lares_LeaveMyShip_Info()
{
	AI_Output (other, self, "DIA_Lares_LeaveMyShip_15_00");	//It's better if you don't come along.
	AI_Output (self, other, "DIA_Lares_LeaveMyShip_09_01");	//As you like, but in the future, think about what you promise to whom.
	if (hero.guild == GIL_DJG)
	{
		Lares_IsOnBoard = LOG_OBSOLETE;
	}
	else
	{
		Lares_IsOnBoard = LOG_FAILED;
	};
	B_CheckLog();
	Crewmember_Count -= 1;
	Npc_ExchangeRoutine(self,"ShipOff");
};


instance DIA_Lares_StillNeedYou(C_Info)
{
	npc = VLK_449_Lares;
	nr = 5;
	condition = DIA_Lares_StillNeedYou_Condition;
	information = DIA_Lares_StillNeedYou_Info;
	permanent = TRUE;
	description = "Are you still interested in the voyage?";
};


func int DIA_Lares_StillNeedYou_Condition()
{
	if(((Lares_IsOnBoard == LOG_OBSOLETE) || (Lares_IsOnBoard == LOG_FAILED)) && (Crewmember_Count < Max_Crew))
	{
		return TRUE;
	};
};

func void DIA_Lares_StillNeedYou_Info()
{
	AI_Output (other, self, "DIA_Lares_StillNeedYou_15_00");	//Are you still interested in the voyage?
	if (Lares_IsOnBoard == LOG_OBSOLETE)
	{
		AI_Output (self, other, "DIA_Lares_StillNeedYou_09_01");	//Normally, I don't let people treat me like that, but since you're one of us, I'll let you get away with it this time.
		AI_Output (self, other, "DIA_Lares_StillNeedYou_09_02");	//We'll meet on the ship.
		B_JoinShip(self);
	}
	else
	{
		AI_Output (self, other, "DIA_Lares_StillNeedYou_09_03");	//Don't take it personally, but I think you were right.
		AI_Output (self, other, "DIA_Lares_StillNeedYou_09_04");	//It's better if I stay here.
		AI_StopProcessInfos(self);
	};
	B_CheckLog();
};

