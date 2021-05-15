
instance DIA_Nagur_EXIT(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 999;
	condition = DIA_Nagur_EXIT_Condition;
	information = DIA_Nagur_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Nagur_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Nagur_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Nagur_PICKPOCKET(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 900;
	condition = DIA_Nagur_PICKPOCKET_Condition;
	information = DIA_Nagur_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Nagur_PICKPOCKET_Condition()
{
	return C_Beklauen(75,150);
};

func void DIA_Nagur_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Nagur_PICKPOCKET);
	Info_AddChoice(DIA_Nagur_PICKPOCKET,Dialog_Back,DIA_Nagur_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Nagur_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Nagur_PICKPOCKET_DoIt);
};

func void DIA_Nagur_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Nagur_PICKPOCKET);
};

func void DIA_Nagur_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Nagur_PICKPOCKET);
};

func void B_Kardif_LeaveMeAlone()
{
	AI_Output(self,other,"DIA_Nagur_Hallo_08_01");	//Послушай, оставь меня в покое, хорошо?
};

instance DIA_Nagur_Hallo(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 2;
	condition = DIA_Nagur_Hallo_Condition;
	information = DIA_Nagur_Hallo_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Nagur_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (DIA_Kardif_Diebeswerk_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Nagur_Hallo_Info()
{
	if(self.aivar[AIV_TalkedToPlayer] == FALSE)
	{
		AI_Output (self, other, "DIA_Nagur_Hallo_08_00");	//Hey, I haven't got time to chat with you. Talk to Kardif if you want information.
		AI_StopProcessInfos (self);
	}
	else
	{
		B_Kardif_LeaveMeAlone();
		AI_StopProcessInfos(self);
	};
};


var int NagurHack;

func void B_Nagur_Abfertigen()
{
	if(!C_LawArmorEquipped(other))
	{
		AI_Output (self, other, "DIA_Nagur_Add_08_02");	//And don't think I don't recognize you just because you're wearing different togs!
	};
	AI_Output (self, other, "DIA_Nagur_Add_08_03");	//(conspiratorially) You're about to stick your nose into things that are none of your business!
	AI_Output (self, other, "DIA_Nagur_Add_08_04");	//Get lost!
	MIS_Nagur_Bote = LOG_SUCCESS;
	NagurHack = TRUE;
	AI_StopProcessInfos(self);
};


instance DIA_Nagur_Job(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 3;
	condition = DIA_Nagur_Job_Condition;
	information = DIA_Nagur_Job_Info;
//	permanent = FALSE;
	permanent = TRUE;
	description = "Kardif says you may have a job for me.";
};


func int DIA_Nagur_Job_Condition()
{
	if((DIA_Kardif_Diebeswerk_permanent == TRUE) && (Nagur_Job_Dia1_Passed == FALSE) && (MIS_Nagur_Bote != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Nagur_Job_Info()
{
	AI_Output (other, self, "DIA_Nagur_Job_15_00");	//Kardif says you may have a job for me.
	if ((other.guild == GIL_NOV) || (other.guild == GIL_KDF))
	{
		AI_Output (self, other, "DIA_Nagur_Add_08_00");	//There ARE no jobs for monastery folk down here at the harbor! (laughs)
		B_Nagur_Abfertigen ();
	}
	else if((other.guild == GIL_MIL) || (other.guild == GIL_PAL))
	{
		AI_Output (self, other, "DIA_Nagur_Add_08_01");	//There ARE no jobs for the King's soldiers down here at the harbor.
		B_Nagur_Abfertigen ();
	}
	else
	{
		if((Npc_GetDistToWP(Martin,"NW_CITY_HABOUR_TAVERN01_04") < 700) && !Npc_IsDead(Martin))
		{
			if(!C_BodyStateContains(self,BS_SIT))
			{
				AI_WaitTillEnd(self,other);
				AI_PlayAni(self,"T_SEARCH");
			};
			B_Kardif_LeaveMeAlone();
			DIA_Common_IllBeBackLater();
			AI_StopProcessInfos(self);
		}
		else
		{
			Nagur_Job_Dia1_Passed = TRUE;
		AI_Output (self, other, "DIA_Nagur_Job_08_01");	//(appraising) Well, well, so you're looking for a special job. Okay, but we play by my rules, understood?
		AI_Output (other, self, "DIA_Nagur_Job_15_02");	//What does that mean?
		AI_Output (self, other, "DIA_Nagur_Job_08_03");	//That means you do what I say and you get a third of the profits.
		AI_Output (self, other, "DIA_Nagur_Job_08_04");	//If you don't like it, then there's no job.
			Info_ClearChoices(DIA_Nagur_Job);
			Info_AddChoice(DIA_Nagur_Job,"We're business partners, so it's fifty-fifty.",DIA_Nagur_Job_Halbe);
			Info_AddChoice(DIA_Nagur_Job,"All right, you're the boss.",DIA_Nagur_Job_Klar);
		};
	};
};

func void DIA_Nagur_Job_Klar()
{
	AI_Output (other, self, "DIA_Nagur_Job_Klar_15_00");	//All right, you're the boss.
	AI_Output (self, other, "DIA_Nagur_Job_Klar_08_01");	//Good, then let me know when you're ready to rake in a heap of gold.
	Nagur_Deal = 80;
	Info_ClearChoices(DIA_Nagur_Job);
};

func void DIA_Nagur_Job_Halbe()
{
	AI_Output (other, self, "DIA_Nagur_Job_Halbe_15_00");	//We're business partners, so it's fifty-fifty.
	AI_Output (self, other, "DIA_Nagur_Job_Halbe_08_01");	//Okay, I thought I'd give it a shot. Of course we'll split our profits fairly.
	Nagur_Deal = 120;
	Info_ClearChoices(DIA_Nagur_Job);
};


instance DIA_Nagur_Auftrag(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 4;
	condition = DIA_Nagur_Auftrag_Condition;
	information = DIA_Nagur_Auftrag_Info;
//	permanent = FALSE;
	permanent = TRUE;
	description = "All right, what's your plan?";
};


func int DIA_Nagur_Auftrag_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Nagur_Job) && (MIS_Nagur_Bote != LOG_SUCCESS) && (Nagur_Job_Dia2_Passed == FALSE))
	if((Nagur_Job_Dia1_Passed == TRUE) && (MIS_Nagur_Bote != LOG_SUCCESS) && (Nagur_Job_Dia2_Passed == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Nagur_Auftrag_Info()
{
	AI_Output(other,self,"DIA_Nagur_Auftrag_15_00");	//All right, what's your plan?
	if((Npc_GetDistToWP(Martin,"NW_CITY_HABOUR_TAVERN01_04") < 700) && !Npc_IsDead(Martin))
	{
		if(!C_BodyStateContains(self,BS_SIT))
		{
			AI_WaitTillEnd(self,other);
			AI_PlayAni(self,"T_SEARCH");
		};
		B_Kardif_LeaveMeAlone();
		DIA_Common_IllBeBackLater();
		AI_StopProcessInfos(self);
	}
	else
	{
		Nagur_Job_Dia2_Passed = TRUE;
		AI_Output(self,other,"DIA_Nagur_Auftrag_08_01");	//You know the merchant Baltram, don't you? If not, it's time you talked to him.
		if(!Npc_IsDead(Bote))
		{
			AI_Output(self,other,"DIA_Nagur_Auftrag_08_02");	//This Baltram has a messenger who supplies him with goods from Akil's farm.
			AI_Output(self,other,"DIA_Nagur_Auftrag_08_03");	///That is, he HAD a messenger, until I cut his throat. And now Baltram has to get a new one. And that will be you.
			AI_Teleport(Bote,"NW_CITY_HABOUR_KASERN_05_01");
			B_StartOtherRoutine(Bote,"Dead");
			B_KillNpc(VLK_4006_Bote);
			Bote_Killed = TRUE;
			if(Npc_KnowsInfo(other,DIA_Rengaru_HALLODIEB) && !Npc_KnowsInfo(other,DIA_Rengaru_INKNAST) && !Npc_KnowsInfo(other,DIA_Rengaru_SPARE) && (Rengaru_Ausgeliefert == FALSE))
			{
				B_StartOtherRoutine(Rengaru,"Hide");
			};
		};
		AI_Output(self,other,"DIA_Nagur_Auftrag_08_04");	//Your job is to get hired by Baltram and fetch the delivery from Akil.
		AI_Output(self,other,"DIA_Nagur_Auftrag_08_05");	//You bring it to me and then I'll sell it to an interested customer. He'll fork over a tidy little sum for it.
		AI_Output(self,other,"DIA_Nagur_Auftrag_08_06");	//And just don't try selling the stuff yourself. Have you got all that?
		Info_ClearChoices(DIA_Nagur_Auftrag);
		Info_AddChoice(DIA_Nagur_Auftrag,"Well then, I'm all set (END)",DIA_Nagur_Auftrag_Okay);
		Info_AddChoice(DIA_Nagur_Auftrag,"Where can I find Baltram?",DIA_Nagur_Auftrag_Baltram);
		Info_AddChoice(DIA_Nagur_Auftrag,"When should I talk to Baltram?",DIA_Nagur_Auftrag_Wann);
		Info_AddChoice(DIA_Nagur_Auftrag,"Where is Akil's farm?",DIA_Nagur_Auftrag_Akil);
		Info_AddChoice(DIA_Nagur_Auftrag,"How much will the profit be?",DIA_Nagur_Auftrag_Gewinn);
	};
};

func void DIA_Nagur_Auftrag_Akil()
{
	AI_Output (other, self, "DIA_Nagur_Auftrag_Akil_15_00");	//Where is Akil's farm?
	AI_Output (self, other, "DIA_Nagur_Auftrag_Akil_08_01");	//Leave the city by the east gate, that's directly on the marketplace.
	AI_Output (self, other, "DIA_Nagur_Auftrag_Akil_08_02");	//If you follow the road to the right, you'll soon come to a few steps cut into the rock.
	AI_Output (self, other, "DIA_Nagur_Auftrag_Akil_08_03");	//Go up there and you'll come to Akil's farm.
};

func void DIA_Nagur_Auftrag_Gewinn()
{
	AI_Output (other, self, "DIA_Nagur_Auftrag_Gewinn_15_00");	//How high will the profit be?
	AI_Output (self, other, "DIA_Nagur_Auftrag_Gewinn_08_01");	//I can't say exactly. But I estimate about 400 gold pieces.
};

func void DIA_Nagur_Auftrag_Baltram()
{
	AI_Output (other, self, "DIA_Nagur_Auftrag_Baltram_15_00");	//Where can I find Baltram?
	AI_Output (self, other, "DIA_Nagur_Auftrag_Baltram_08_01");	//He has his stand in the marketplace.
};

func void DIA_Nagur_Auftrag_Wann()
{
	AI_Output(other,self,"DIA_Nagur_Auftrag_Wann_15_00");	//When should I talk to Baltram?
	if(Bote_Killed == TRUE)
	{
		AI_Output(self,other,"DIA_Nagur_Auftrag_Wann_08_01");	//You can go right away. He should know by now that his messenger won't show up any more. (dirty laugh)
	}
	else
	{
		AI_Output(self,other,"DIA_Andre_Add_08_11");	//Тебе лучше отправиться прямо к нему.@@@
	};
};

func void DIA_Nagur_Auftrag_Okay()
{
	AI_Output(other,self,"DIA_Nagur_Auftrag_Okay_15_00");	//Well then, I'm all set.
	if(Bote_Killed == TRUE)
	{
		AI_Output(self,other,"DIA_Nagur_Auftrag_Okay_08_01");	//Good, then get on your way - but if you try to cheat me, you'll soon be every bit as dead as the messenger! Don't forget it!
	}
	else
	{
		AI_Output(self,other,"DIA_Andre_PERM_08_02");	//Carry out your assignments.
	};
	MIS_Nagur_Bote = LOG_Running;
	Log_CreateTopic(TOPIC_Nagur,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Nagur,LOG_Running);
	B_LogEntry(TOPIC_Nagur,"I must get Baltram to take me on as his new errand-boy. Then I must collect the delivery from farmer Akil and bring it to Nagur.");
	AI_StopProcessInfos(self);
};


instance DIA_Nagur_Success(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 5;
	condition = DIA_Nagur_Success_Condition;
	information = DIA_Nagur_Success_Info;
	permanent = FALSE;
	description = "I brought the package.";
};


func int DIA_Nagur_Success_Condition()
{
	if((MIS_Nagur_Bote == LOG_Running) && Npc_HasItems(other,ItMi_BaltramPaket) && (Nagur_Ausgeliefert == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Nagur_Success_Info()
{
	AI_Output(other,self,"DIA_Nagur_Success_15_00");	//I brought the package.
	B_GiveInvItems(other,self,ItMi_BaltramPaket,1);
	Npc_RemoveInvItem(self,ItMi_BaltramPaket);
	AI_Output(self,other,"DIA_Nagur_Success_08_01");	//Well done. I'll see to it that I sell it. Come back tomorrow.
	B_GivePlayerXP(XP_NagurOnlyGaveMoney);
	B_LogEntry(TOPIC_Nagur,"Nagur has got the delivery. He'll pay me my gold tomorrow.");
	AI_StopProcessInfos(self);
	NagurDay = B_GetDayPlus();
};


instance DIA_Nagur_Deal(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 6;
	condition = DIA_Nagur_Deal_Condition;
	information = DIA_Nagur_Deal_Info;
	permanent = TRUE;
	description = "Did you sell the wares, then?";
};


var int DIA_Nagur_Deal_permanent;

func int DIA_Nagur_Deal_Condition()
{
	if((DIA_Nagur_Deal_permanent == FALSE) && (MIS_Nagur_Bote == LOG_Running) && (Nagur_Ausgeliefert == FALSE) && Npc_KnowsInfo(other,DIA_Nagur_Success))
	{
		return TRUE;
	};
};

func void DIA_Nagur_Deal_Info()
{
	AI_Output (other, self, "DIA_Nagur_Deal_15_00");	//Did you sell the wares, then?
	if (B_GetDayPlus () > NagurDay)
	{
		AI_Output (self, other, "DIA_Nagur_Deal_08_01");	//Yeah, but for less than I thought. I only got 300 gold pieces.
		AI_Output (self, other, "DIA_Nagur_Deal_08_02");	//Part of that goes to my employers ...
		AI_Output (self, other, "DIA_Nagur_Deal_08_03");	//And Kardif gets his usual percentage - plus the gold for your commission.
		AI_Output (self, other, "DIA_Nagur_Deal_08_04");	//Which leaves a total of 240 gold pieces. We'll split those as agreed. Here's your part.
		B_GiveInvItems(self,other,ItMi_Gold,Nagur_Deal);
		AI_Output(self,other,"DIA_Nagur_Deal_08_05");	//You did good work. I've passed that on to my employers.
		AI_Output(self,other,"DIA_Nagur_Deal_08_06");	//What comes of that is out of my hands.
		MIS_Nagur_Bote = LOG_SUCCESS;
		MIS_Baltram_ScoutAkil = LOG_FAILED;
		B_GivePlayerXP(XP_Nagur_Bote);
		DIA_Nagur_Deal_permanent = TRUE;
		Diebesgilde_Okay += 1;
		AI_StopProcessInfos(self);
	}
	else
	{
		AI_Output (self, other, "DIA_Nagur_Deal_08_07");	//No, not yet. These things take their time. I want to get a good price, after all.
	};
};


instance DIA_Nagur_Auftraggeber(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 7;
	condition = DIA_Nagur_Auftraggeber_Condition;
	information = DIA_Nagur_Auftraggeber_Info;
	permanent = FALSE;
	description = "Who are your employers?";
};


func int DIA_Nagur_Auftraggeber_Condition()
{
	if(MIS_Nagur_Bote == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Nagur_Auftraggeber_Info()
{
	AI_Output (other, self, "DIA_Nagur_Auftraggeber_15_00");	//Who are your employers?
	AI_Output (self, other, "DIA_Nagur_Auftraggeber_08_01");	//You don't really think I'd tell you that, do you?
};


instance DIA_Nagur_Fazit(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 7;
	condition = DIA_Nagur_Fazit_Condition;
	information = DIA_Nagur_Fazit_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Nagur_Fazit_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Nagur_Auftraggeber) && Npc_IsInState(self,ZS_Talk) && (Knows_SecretSign == FALSE) && (NagurHack == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Nagur_Fazit_Info()
{
	AI_Output (self, other, "DIA_Nagur_Fazit_08_00");	//The job went well, but I don't talk about my employers. So stay cool.
	AI_StopProcessInfos (self);
};


instance DIA_Nagur_Knast(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 7;
	condition = DIA_Nagur_Knast_Condition;
	information = DIA_Nagur_Knast_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Nagur_Knast_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Npc_GetDistToWP(self,"NW_CITY_HABOUR_KASERN_NAGUR") <= 1000) && (Nagur_Ausgeliefert == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Nagur_Knast_Info()
{
	AI_Output (self, other, "DIA_Nagur_Knast_08_00");	//You betrayed me! That was a big mistake - now piss off!
	AI_StopProcessInfos (self);
};


instance DIA_Nagur_Sign(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 800;
	condition = DIA_Nagur_Sign_Condition;
	information = DIA_Nagur_Sign_Info;
	permanent = FALSE;
	description = DIALOG_SecretSign;
};


func int DIA_Nagur_Sign_Condition()
{
	if((MIS_Nagur_Bote == LOG_SUCCESS) && (Knows_SecretSign == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Nagur_Sign_Info()
{
	AI_PlayAni(other,"T_YES");
	AI_Output (self, other, "DIA_Nagur_Sign_08_00");	//So you did it. Now you know who my employers are.
	AI_Output (self, other, "DIA_Nagur_Sign_08_01");	//Stick to what Cassia tells you - we don't care who you are otherwise - you're one of us, and that's all that counts.
	B_GivePlayerXP(XP_NagurGotThief);
	AI_StopProcessInfos(self);
};


instance DIA_Nagur_Perm(C_Info)
{
	npc = VLK_493_Nagur;
	nr = 7;
	condition = DIA_Nagur_Perm_Condition;
	information = DIA_Nagur_Perm_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Nagur_Perm_Condition()
{
	if((MIS_Nagur_Bote == LOG_SUCCESS) && Npc_KnowsInfo(other,DIA_Nagur_Sign) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Nagur_Perm_Info()
{
	AI_Output(self,other,"DIA_Nagur_Perm_08_00");	//Look for someone else, there's enough people running around. I don't have anything else for you.
	if(!Npc_GetTalentSkill(other,NPC_TALENT_PICKPOCKET) || (other.attribute[ATR_DEXTERITY] < 65) || (self.aivar[AIV_PlayerHasPickedMyPocket] == TRUE))
	{
		AI_StopProcessInfos(self);
	};
};

