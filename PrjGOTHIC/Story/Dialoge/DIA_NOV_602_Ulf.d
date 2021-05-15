
instance DIA_Ulf_EXIT(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 999;
	condition = DIA_Ulf_EXIT_Condition;
	information = DIA_Ulf_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Ulf_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Ulf_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Ulf_Hallo(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 2;
	condition = DIA_Ulf_Hallo_Condition;
	information = DIA_Ulf_Hallo_Info;
	permanent = FALSE;
	description = "What are you doing here?";
};


func int DIA_Ulf_Hallo_Condition()
{
	if((hero.guild != GIL_NOV) && (hero.guild != GIL_KDF) && (MIS_Schnitzeljagd == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Hallo_Info()
{
	AI_Output(other,self,"DIA_Ulf_Hallo_15_00");	//What are you doing here?
	if(hero.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_Ulf_Hallo_03_01");	//I'm trying to fulfill the tasks the monastery has set me to your satisfaction.
	}
	else
	{
		AI_Output(self,other,"DIA_Ulf_Hallo_03_02");	//I am a novice from the monastery. I run errands for the magicians and also the paladins.
	};
	AI_Output(self,other,"DIA_Ulf_Hallo_03_03");	//I have provided the three innkeepers in the city with wine from the monastery.
};


instance DIA_Ulf_Wirte(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 3;
	condition = DIA_Ulf_Wirte_Condition;
	information = DIA_Ulf_Wirte_Info;
	permanent = FALSE;
	description = "Who are the three innkeepers?";
};


func int DIA_Ulf_Wirte_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Ulf_Hallo) && (hero.guild != GIL_KDF) && (hero.guild != GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Wirte_Info()
{
	AI_Output (other, self, "DIA_Ulf_Wirte_15_00");	//Who are the three innkeepers?
	AI_Output (self, other, "DIA_Ulf_Wirte_03_01");	//One of them is the good man here behind the bar.
	AI_Output (self, other, "DIA_Ulf_Wirte_03_02");	//Then there is Caragon, who has his tavern on the temple square, and Kardif, the owner of the pub in the harbor district.
};


instance DIA_Ulf_Kloster(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 3;
	condition = DIA_Ulf_Kloster_Condition;
	information = DIA_Ulf_Kloster_Info;
	permanent = FALSE;
	description = "What can you tell me about the monastery?";
};


func int DIA_Ulf_Kloster_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Ulf_Hallo) && (hero.guild != GIL_KDF) && (hero.guild != GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Kloster_Info()
{
	AI_Output (other, self, "DIA_Ulf_Kloster_15_00");	//What can you tell me about the monastery?
	AI_Output (self, other, "DIA_Ulf_Kloster_03_01");	//We novices seek enlightenment in prayer to Innos and learn the principles of faith from the magicians.
	AI_Output (self, other, "DIA_Ulf_Kloster_03_02");	//We serve them as we serve Innos and prepare ourselves for the union with the Fire.
};


instance DIA_Ulf_Bringen(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 4;
	condition = DIA_Ulf_Bringen_Condition;
	information = DIA_Ulf_Bringen_Info;
	permanent = FALSE;
	description = "Take me to the monastery.";
};


func int DIA_Ulf_Bringen_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Ulf_Hallo) && (hero.guild != GIL_KDF) && (hero.guild != GIL_NOV) && (hero.guild != GIL_PAL))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Bringen_Info()
{
	AI_Output (other, self, "DIA_Ulf_Bringen_15_00");	//Take me to the monastery.
	AI_Output (self, other, "DIA_Ulf_Bringen_03_01");	//Forget it. Do you know how many creatures I had to evade on the way?
	AI_Output (self, other, "DIA_Ulf_Bringen_03_02");	//When I think of all those bloodflies, wolves and goblins, I'm glad that I don't have to leave here any more.
	AI_Output (self, other, "DIA_Ulf_Bringen_03_03");	//Besides, you can't enter the monastery anyway.
	AI_Output (other, self, "DIA_Ulf_Bringen_15_04");	//Why not?
	AI_Output (self, other, "DIA_Ulf_Bringen_03_05");	//Entrance is only permitted to magicians, paladins and novices.
};


instance DIA_Ulf_Aufnahme(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 3;
	condition = DIA_Ulf_Aufnahme_Condition;
	information = DIA_Ulf_Aufnahme_Info;
	permanent = FALSE;
	description = "How can I become a novice?";
};


func int DIA_Ulf_Aufnahme_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Ulf_Bringen) && (hero.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Aufnahme_Info()
{
	AI_Output (other, self, "DIA_Ulf_Aufnahme_15_00");	//How can I become a novice?
	AI_Output (self, other, "DIA_Ulf_Aufnahme_03_01");	//If a man feels the deep desire...
	AI_Output (other, self, "DIA_Ulf_Aufnahme_15_02");	//Hey - just tell me what the conditions are.
	AI_Output (self, other, "DIA_Ulf_Aufnahme_03_03");	//You need the offerings. A sheep and...
	B_Say_Gold(self,other,Summe_Kloster);
	if(SC_KnowsKlosterTribut == FALSE)
	{
		SC_KnowsKlosterTribut = TRUE;
		Log_CreateTopic(Topic_Kloster,LOG_MISSION);
		Log_SetTopicStatus(Topic_Kloster,LOG_Running);
		B_LogEntry(Topic_Kloster,"To become a novice at the monastery of Innos, I need a sheep and 1000 pieces of gold.");
	};
};


instance DIA_Ulf_Gold(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 8;
	condition = DIA_Ulf_Gold_Condition;
	information = DIA_Ulf_Gold_Info;
	permanent = FALSE;
	description = "How am I supposed to get that much gold?";
};


func int DIA_Ulf_Gold_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Ulf_Aufnahme) && (hero.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Gold_Info()
{
	AI_Output (other, self, "DIA_Ulf_Gold_15_00");	//How am I supposed to get that much gold?
	AI_Output (self, other, "DIA_Ulf_Gold_03_01");	//Since you obviously don't know anyone who would pay that for you, you'll simply have to go to work.
};


instance DIA_Ulf_Schaf(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 9;
	condition = DIA_Ulf_Schaf_Condition;
	information = DIA_Ulf_Schaf_Info;
	permanent = FALSE;
	description = "Where can I find a sheep?";
};


func int DIA_Ulf_Schaf_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Ulf_Aufnahme) && (hero.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Schaf_Info()
{
	AI_Output (other, self, "DIA_Ulf_Schaf_15_00");	//Where can I find a sheep?
	AI_Output (self, other, "DIA_Ulf_Schaf_03_01");	//From the farmers, of course. But you won't get one for nothing.
	B_LogEntry (Topic_Kloster, "I can get a sheep from the farmers.");
};


instance DIA_Ulf_Suche(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 9;
	condition = DIA_Ulf_Suche_Condition;
	information = DIA_Ulf_Suche_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Ulf_Suche_Condition()
{
	if((MIS_Schnitzeljagd == LOG_Running) && (other.guild == GIL_NOV) && (Npc_GetDistToWP(self,"NW_TROLLAREA_PATH_42") <= 1000) && !Npc_KnowsInfo(other,DIA_Ulf_Abrechnung))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Suche_Info()
{
	AI_Output (self, other, "DIA_Ulf_Suche_03_00");	//Hey, do you know what happened?
	AI_Output (other, self, "DIA_Ulf_Suche_15_01");	//You have been chosen.
	AI_Output (self, other, "DIA_Ulf_Suche_03_02");	//Right. Just as I was about to have a cool sip of beer - Daron comes around the corner and tells me that I've been chosen.
	AI_Output (self, other, "DIA_Ulf_Suche_03_03");	//Who would have thought? The will of Innos is unfathomable. And what brings you here?
	AI_Output (other, self, "DIA_Ulf_Suche_15_04");	//I have demanded the Test of Fire.
	AI_Output (self, other, "DIA_Ulf_Suche_03_05");	//It's not possible?! Boy, you are damned brave. Does that mean that you will also seek 'that which the believer finds behind the path'?
	AI_Output (other, self, "DIA_Ulf_Suche_15_06");	//Looks like it.
};


instance DIA_Ulf_Rausgefunden(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 9;
	condition = DIA_Ulf_Rausgefunden_Condition;
	information = DIA_Ulf_Rausgefunden_Info;
	permanent = FALSE;
	description = "Have you found out anything yet?";
};


func int DIA_Ulf_Rausgefunden_Condition()
{
	if((MIS_Schnitzeljagd == LOG_Running) && (other.guild == GIL_NOV) && (Npc_GetDistToWP(self,"NW_TROLLAREA_PATH_42") <= 1000) && !Npc_KnowsInfo(other,DIA_Ulf_Abrechnung))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Rausgefunden_Info()
{
	AI_Output (other, self, "DIA_Ulf_Rausgefunden_15_00");	//Have you found out anything yet?
	AI_Output (self, other, "DIA_Ulf_Rausgefunden_03_01");	//Well, I just followed Agon - but in the meantime I lost him.
	AI_Output (self, other, "DIA_Ulf_Rausgefunden_03_02");	//And now... what do they say? Follow the signs of Innos. But I don't understand that bit with the path ...
	AI_Output (self, other, "DIA_Ulf_Rausgefunden_03_03");	//So what, I'll keep searching.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "FOLLOW");
};


instance DIA_Ulf_Folgen(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 9;
	condition = DIA_Ulf_Folgen_Condition;
	information = DIA_Ulf_Folgen_Info;
	permanent = FALSE;
	description = "Hey, are you following me?";
};


func int DIA_Ulf_Folgen_Condition()
{
	if((MIS_Schnitzeljagd == LOG_Running) && (other.guild == GIL_NOV) && Npc_KnowsInfo(other,DIA_Ulf_Rausgefunden) && !Npc_KnowsInfo(other,DIA_Ulf_Abrechnung))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Folgen_Info()
{
	AI_Output (other, self, "DIA_Ulf_Folgen_15_00");	//Hey, are you following me?
	AI_Output (self, other, "DIA_Ulf_Folgen_03_01");	//Nonsense. I just happen to be going the same direction as you.
	AI_StopProcessInfos (self);
};


instance DIA_Ulf_Stop(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 9;
	condition = DIA_Ulf_Stop_Condition;
	information = DIA_Ulf_Stop_Info;
	permanent = FALSE;
	description = "Stop running after me!";
};


func int DIA_Ulf_Stop_Condition()
{
	if((MIS_Schnitzeljagd == LOG_Running) && (other.guild == GIL_NOV) && Npc_KnowsInfo(other,DIA_Ulf_Folgen) && !Npc_KnowsInfo(other,DIA_Ulf_Abrechnung))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Stop_Info()
{
	AI_Output (other, self, "DIA_Ulf_Stop_15_00");	//Stop running after me!
	AI_Output (self, other, "DIA_Ulf_Stop_03_01");	//I'm not following you. But please, if that's what you think - then I'll take a different path now.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "SUCHE");
};


instance DIA_Ulf_Abrechnung(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 1;
	condition = DIA_Ulf_Abrechnung_Condition;
	information = DIA_Ulf_Abrechnung_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Ulf_Abrechnung_Condition()
{
	if((MIS_Schnitzeljagd == LOG_Running) && (other.guild == GIL_NOV))
	{
		if(C_FireContestRuneFound())
		{
			return TRUE;
		};
	};
};

func void DIA_Ulf_Abrechnung_Info()
{
	AI_Output (self, other, "DIA_Ulf_Abrechnung_03_00");	//So we meet again. I've been thinking, you know. I believe that the desire to be a magician is strong in me.
	AI_Output (other, self, "DIA_Ulf_Abrechnung_15_01");	//Oh man - don't do that...
	AI_Output (self, other, "DIA_Ulf_Abrechnung_03_02");	//I have no choice. A novice's life is not for me.
	AI_Output (self, other, "DIA_Ulf_Abrechnung_03_03");	//I just have to be a magician. Then everything will go well with me. And now I shall take what I'm entitled to.
	AI_Output (self, other, "DIA_Ulf_Abrechnung_03_04");	//Do you have any last words?
	Info_ClearChoices (DIA_Ulf_Abrechnung);
	Info_AddChoice (DIA_Ulf_Abrechnung, "Cut it out, I don't want to kill you.", DIA_Ulf_Abrechnung_Lass);
	Info_AddChoice (DIA_Ulf_Abrechnung, "Let's get straight down to it - I need to get back to the monastery.", DIA_Ulf_Abrechnung_Schnell);
	Info_AddChoice (DIA_Ulf_Abrechnung, "Have you got anything to smoke?", DIA_Ulf_Abrechnung_Rauch);
};

func void DIA_Ulf_Abrechnung_Lass()
{
	AI_Output (other, self, "DIA_Ulf_Abrechnung_Lass_15_00");	//Cut it out, I don't want to kill you.
	AI_Output (self, other, "DIA_Ulf_Abrechnung_Lass_03_01");	//Big talk. But you know you don't have a chance against me! Let's go!
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_KILL, 0);
};

func void DIA_Ulf_Abrechnung_Schnell()
{
	AI_Output (other, self, "DIA_Ulf_Abrechnung_Schnell_15_00");	//Let's get straight down to it - I need to go back to the monastery.
	AI_Output (self, other, "DIA_Ulf_Abrechnung_Schnell_03_01");	//You're not going anywhere ever again!
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_KILL, 0);
};

func void DIA_Ulf_Abrechnung_Rauch()
{
	AI_Output(other,self,"DIA_Ulf_Abrechnung_Rauch_15_00");	//Have you got anything to smoke?
	AI_Output(self,other,"DIA_Ulf_Abrechnung_Rauch_03_01");	//You're lucky. I've actually got something right here.
	AI_Output(self,other,"DIA_Ulf_Abrechnung_Rauch_03_02");	//Let's get it over with.
	B_GiveInvItems(self,other,ItMi_Joint,1);
	CreateInvItems(self,ItMi_Joint,1);
	B_UseItem(self,ItMi_Joint);
	B_UseItem(other,ItMi_Joint);
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,0);
};


instance DIA_Ulf_Troll(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 9;
	condition = DIA_Ulf_Troll_Condition;
	information = DIA_Ulf_Troll_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Ulf_Troll_Condition()
{
	if((MIS_Schnitzeljagd == LOG_Running) && (other.guild == GIL_NOV) && Npc_KnowsInfo(other,DIA_Ulf_Rausgefunden) && ((Npc_GetDistToWP(self,"NW_TROLLAREA_PATH_14") <= 1000) || (Npc_GetDistToWP(self,"NW_TROLLAREA_PATH_15") <= 1000)) && !Npc_KnowsInfo(other,DIA_Ulf_Abrechnung))
	{
		return TRUE;
	};
};

func void DIA_Ulf_Troll_Info()
{
	AI_Output (self, other, "DIA_Ulf_Troll_03_00");	//Hey, do you really think we're going the right way? A troll lives back there somewhere.
	AI_Output (self, other, "DIA_Ulf_Troll_03_01");	//I think I'd rather look in a different direction.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "WAIT");
};


instance DIA_Ulf_PICKPOCKET(C_Info)
{
	npc = NOV_602_Ulf;
	nr = 900;
	condition = DIA_Ulf_PICKPOCKET_Condition;
	information = DIA_Ulf_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Ulf_PICKPOCKET_Condition()
{
	return C_Beklauen(34,50);
};

func void DIA_Ulf_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Ulf_PICKPOCKET);
	Info_AddChoice(DIA_Ulf_PICKPOCKET,Dialog_Back,DIA_Ulf_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Ulf_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Ulf_PICKPOCKET_DoIt);
};

func void DIA_Ulf_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Ulf_PICKPOCKET);
};

func void DIA_Ulf_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Ulf_PICKPOCKET);
};

