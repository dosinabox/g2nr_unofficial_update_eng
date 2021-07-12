
var int Parlan_Hammer;

func void B_Parlan_HAMMER()
{
	AI_Output (self, other, "DIA_Parlan_HAMMER_05_00");	//(severely) Wait a moment, my son.
	AI_Output (self, other, "DIA_Parlan_HAMMER_05_01");	//Rumor has it that a valuable artifact has 'disappeared' from the sanctuary.
	AI_Output (self, other, "DIA_Parlan_HAMMER_05_02");	//I do not even want to know more about it - I expect that it will return to its place.
	Parlan_Hammer = TRUE;
};

instance DIA_Parlan_Kap1_EXIT(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 999;
	condition = DIA_Parlan_Kap1_EXIT_Condition;
	information = DIA_Parlan_Kap1_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Parlan_Kap1_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Parlan_Kap1_EXIT_Info()
{
	if((Parlan_Hammer == FALSE) && (Hammer_Taken == TRUE) && !Npc_IsDead(Garwig))
	{
		B_Parlan_HAMMER();
	}
	else if((other.guild == GIL_PAL) || (other.guild == GIL_KDF))
	{
		if(Kapitel >= 3)
		{
			AI_Output(self,other,"DIA_Parlan_EXIT_05_00");	//May Innos protect you.
		};
	};
	AI_StopProcessInfos(self);
};


var int Parlan_LastPetzCounter;
var int Parlan_LastPetzCrime;

instance DIA_Parlan_PMSchulden(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 1;
	condition = DIA_Parlan_PMSchulden_Condition;
	information = DIA_Parlan_PMSchulden_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Parlan_PMSchulden_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Parlan_Schulden > 0) && (B_GetGreatestPetzCrime(self) <= Parlan_LastPetzCrime))
	{
		if(other.guild == GIL_NOV)
		{
			if(!Npc_KnowsInfo(other,DIA_Parlan_WELCOME))
			{
				return FALSE;
			};
		};
		return TRUE;
	};
};

func void DIA_Parlan_PMSchulden_Info()
{
	var int diff;
	if((Parlan_Hammer == FALSE) && (Hammer_Taken == TRUE) && !Npc_IsDead(Garwig))
	{
		B_Parlan_HAMMER();
	};
	AI_Output (self, other, "DIA_Parlan_PMSchulden_05_00");	//You have violated the rules of our community.
	if (B_GetTotalPetzCounter (self) > Parlan_LastPetzCounter)
	{
		AI_Output (self, other, "DIA_Parlan_PMSchulden_05_01");	//And although you were already accused, you have laden more guilt upon yourself.
		if (Parlan_Schulden < 1000)
		{
			AI_Output (self, other, "DIA_Parlan_PMSchulden_05_02");	//Your guilt can only be purged by a larger donation to the monastery.
			AI_Output (other, self, "DIA_Parlan_PMAdd_15_00");	//How much?
			diff = B_GetTotalPetzCounter (self) - Parlan_LastPetzCounter;
			if (diff > 0)
			{
				Parlan_Schulden += diff * 50;
			};
			if(Parlan_Schulden > 1000)
			{
				Parlan_Schulden = 1000;
			};
			B_Say_Gold(self,other,Parlan_Schulden);
		}
		else
		{
			AI_Output (self, other, "DIA_Parlan_PMSchulden_05_03");	//Who do you think you are? Pray to Innos for forgiveness for your deeds!
		};
	}
	else if(B_GetGreatestPetzCrime(self) < Parlan_LastPetzCrime)
	{
		AI_Output (self, other, "DIA_Parlan_PMSchulden_05_04");	//Your situation has changed.
		if (Parlan_LastPetzCrime == CRIME_MURDER)
		{
			AI_Output (self, other, "DIA_Parlan_PMSchulden_05_05");	//There are no more witnesses for your murder!
		};
		if((Parlan_LastPetzCrime == CRIME_THEFT) || ((Parlan_LastPetzCrime > CRIME_THEFT) && (B_GetGreatestPetzCrime(self) < CRIME_THEFT)))
		{
			AI_Output (self, other, "DIA_Parlan_PMSchulden_05_06");	//No one will testify now that you have stolen!
		};
		if((Parlan_LastPetzCrime == CRIME_ATTACK) || ((Parlan_LastPetzCrime > CRIME_ATTACK) && (B_GetGreatestPetzCrime(self) < CRIME_ATTACK)))
		{
			AI_Output (self, other, "DIA_Parlan_PMSchulden_05_07");	//There are no more accusers who will testify to your brawling!
		};
		if(B_GetGreatestPetzCrime(self) == CRIME_NONE)
		{
			AI_Output (self, other, "DIA_Parlan_PMSchulden_05_08");	//All of the accusations against you have been dropped!
		};
		AI_Output (self, other, "DIA_Parlan_PMSchulden_05_09");	//Perhaps you can fool me - but Innos knows your deeds!
		if (B_GetGreatestPetzCrime (self) == CRIME_NONE)
		{
			AI_Output (self, other, "DIA_Parlan_PMSchulden_05_10");	//Your sins are now forgiven.
			AI_Output (self, other, "DIA_Parlan_PMSchulden_05_11");	//Take care that it stays that way!
			Parlan_Schulden = 0;
			Parlan_LastPetzCounter = 0;
			Parlan_LastPetzCrime = CRIME_NONE;
		}
		else
		{
			AI_Output (self, other, "DIA_Parlan_PMSchulden_05_12");	//You will pay your penalty - as is the will of Innos!
			B_Say_Gold (self, other, Parlan_Schulden);
			AI_Output (self, other, "DIA_Parlan_PMSchulden_05_13");	//Free yourself of your guilt!
		};
	};
	if(B_GetGreatestPetzCrime(self) != CRIME_NONE)
	{
		Info_ClearChoices (DIA_Parlan_PMSchulden);
		Info_ClearChoices (DIA_Parlan_PETZMASTER);
		Info_AddChoice (DIA_Parlan_PMSchulden, "I haven't got enough gold!", DIA_Parlan_PETZMASTER_PayLater);
		Info_AddChoice (DIA_Parlan_PMSchulden, "How much was that again?", DIA_Parlan_PMSchulden_HowMuchAgain);
		if (Npc_HasItems (other, ItMi_Gold) >= Parlan_Schulden)
		{
			Info_AddChoice (DIA_Parlan_PMSchulden, "I want to pay the penalty!", DIA_Parlan_PETZMASTER_PayNow);
		};
	};
};

func void DIA_Parlan_PMSchulden_HowMuchAgain()
{
	AI_Output (other, self, "DIA_Parlan_PMSchulden_HowMuchAgain_15_00");	//How much was that again?
	B_Say_Gold (self, other, Parlan_Schulden);
	Info_ClearChoices (DIA_Parlan_PMSchulden);
	Info_ClearChoices (DIA_Parlan_PETZMASTER);
	Info_AddChoice (DIA_Parlan_PMSchulden, "I haven't got enough gold!", DIA_Parlan_PETZMASTER_PayLater);
	Info_AddChoice (DIA_Parlan_PMSchulden, "How much was that again?", DIA_Parlan_PMSchulden_HowMuchAgain);
	if (Npc_HasItems (other, ItMi_Gold) >= Parlan_Schulden)
	{
		Info_AddChoice (DIA_Parlan_PMSchulden, "I want to pay the penalty!", DIA_Parlan_PETZMASTER_PayNow);
	};
};


instance DIA_Parlan_PETZMASTER(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 1;
	condition = DIA_Parlan_PETZMASTER_Condition;
	information = DIA_Parlan_PETZMASTER_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Parlan_PETZMASTER_Condition()
{
	if(B_GetGreatestPetzCrime(self) > Parlan_LastPetzCrime)
	{
		if(other.guild == GIL_NOV)
		{
			if(!Npc_KnowsInfo(other,DIA_Parlan_WELCOME))
			{
				return FALSE;
			};
		};
		return TRUE;
	};
};

func void DIA_Parlan_PETZMASTER_Info()
{
	if((Parlan_Hammer == FALSE) && (Hammer_Taken == TRUE) && !Npc_IsDead(Garwig))
	{
		B_Parlan_HAMMER();
	};
	Parlan_Schulden = 0;
	if(self.aivar[AIV_TalkedToPlayer] == FALSE)
	{
		AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_00");	//We have not yet spoken with one another, and already you have incurred a burden of guilt!
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_MURDER)
	{
		AI_Output(self,other,"DIA_Parlan_PETZMASTER_05_01");	//You are guilty of the worst of all crimes! Murder!
		Parlan_Schulden = B_GetTotalPetzCounter(self) * 50 + 500;
		if((PETZCOUNTER_City_Theft + PETZCOUNTER_City_Attack + PETZCOUNTER_City_Sheepkiller) > 0)
		{
			AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_02");	//And you have burdened yourself with even more guilt!
		};
		AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_03");	//If it were up to me, you would be condemned on the spot, you murderer!
		AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_04");	//If you pay the penalty for your crime, however, I will absolve you of your guilt.
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_THEFT)
	{
		AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_05");	//Theft is a violation of the rules of the monastery!
		if ((PETZCOUNTER_City_Attack + PETZCOUNTER_City_Sheepkiller) > 0)
		{
			AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_06");	//Apart from that, you have also broken other rules.
		};
		AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_07");	//These transgressions must be punished. Thus is the law of Innos.
		AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_08");	//You will pay an appropriate penalty to the monastery.
		Parlan_Schulden = B_GetTotalPetzCounter (self) * 50;
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_ATTACK)
	{
		AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_09");	//We do not tolerate brawling in the monastery. Such behavior violates our rules.
		if (PETZCOUNTER_City_Sheepkiller > 0)
		{
			AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_10");	//And why are you killing our sheep?
		};
		AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_11");	//We live here according to rules. And they also apply to you.
		AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_12");	//For your crime, you will make a donation to the monastery.
		Parlan_Schulden = B_GetTotalPetzCounter (self) * 50;
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_SHEEPKILLER)
	{
		AI_Output (self, other, "DIA_Parlan_PETZMASTER_05_13");	//You have killed our sheep. You will pay compensation for that!
		Parlan_Schulden = 100;
	};
	AI_Output (other, self, "DIA_Parlan_PETZMASTER_15_14");	//How much?
	if (Parlan_Schulden > 1000)
	{
		Parlan_Schulden = 1000;
	};
	B_Say_Gold (self, other, Parlan_Schulden);
	Info_ClearChoices (DIA_Parlan_PMSchulden);
	Info_ClearChoices (DIA_Parlan_PETZMASTER);
	Info_AddChoice (DIA_Parlan_PETZMASTER, "I haven't got enough gold!", DIA_Parlan_PETZMASTER_PayLater);
	if (Npc_HasItems (other, ItMi_Gold) >= Parlan_Schulden)
	{
		Info_AddChoice (DIA_Parlan_PETZMASTER, "I want to pay the penalty!", DIA_Parlan_PETZMASTER_PayNow);
	};
};

func void DIA_Parlan_PETZMASTER_PayNow()
{
	AI_Output (other, self, "DIA_Parlan_PETZMASTER_PayNow_15_00");	//I want to pay the penalty!
	B_GiveInvItems (other, self, ItMi_Gold, Parlan_Schulden);
	AI_Output (self, other, "DIA_Parlan_PETZMASTER_PayNow_05_01");	//I accept your donation. Your transgressions are forgiven. May Innos give you the wisdom not to make the same mistakes again.
	B_GrantAbsolution (LOC_MONASTERY);
	Parlan_Schulden = 0;
	Parlan_LastPetzCounter = 0;
	Parlan_LastPetzCrime = CRIME_NONE;
	Info_ClearChoices(DIA_Parlan_PMSchulden);
	Info_ClearChoices(DIA_Parlan_PETZMASTER);
};

func void DIA_Parlan_PETZMASTER_PayLater()
{
	AI_Output (other, self, "DIA_Parlan_PETZMASTER_PayLater_15_00");	//I haven't got enough gold!
	AI_Output (self, other, "DIA_Parlan_PETZMASTER_PayLater_05_01");	//You could have thought of that before you committed those transgressions.
	AI_Output (self, other, "DIA_Parlan_PETZMASTER_PayLater_05_02");	//Perhaps you have learned from this. Cause no more trouble, then you will not have to pay.
	Parlan_LastPetzCounter = B_GetTotalPetzCounter (self);
	Parlan_LastPetzCrime = B_GetGreatestPetzCrime (self);
	Info_ClearChoices (DIA_Parlan_PMSchulden);
	Info_ClearChoices (DIA_Parlan_PETZMASTER);
	AI_StopProcessInfos (self);
};


func void B_DIA_Parlan_WELCOME_GoForTribute()
{
	AI_Output(self,other,"DIA_Parlan_WELCOME_05_09");	//When you have done that, we shall speak about your work here in the monastery.
};

func void B_DIA_Parlan_WELCOME_BringTribute2Gorax()
{
//	AI_Output(self,other,"DIA_Addon_Parlan_WELCOME_05_00");	//Take your tribute to Gorax at the monastery at once. He will handle it further.
	AI_Output(self,other,"DIA_Addon_Pyrokar_MissingPeople_11_01");	//Take your tribute to Gorax at the monastery at once. He will handle it further.
};

instance DIA_Parlan_WELCOME(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 1;
	condition = DIA_Parlan_WELCOME_Condition;
	information = DIA_Parlan_WELCOME_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Parlan_WELCOME_Condition()
{
	if(other.guild == GIL_NOV)
	{
		return TRUE;
	};
};

func void DIA_Parlan_WELCOME_Info()
{
	AI_Output (self, other, "DIA_Parlan_WELCOME_05_00");	//Welcome, new novice, I am Parlan.
	AI_Output (other, self, "DIA_Parlan_WELCOME_15_01");	//I am ...
	AI_Output (self, other, "DIA_Parlan_WELCOME_05_02");	//(interrupts) ... a NOVICE. It is not important who you were before. Now you are a servant of Innos. That is all that matters.
	AI_Output (self, other, "DIA_Parlan_WELCOME_05_03");	//And with the acceptance into the Brotherhood of Fire, all of your previous transgressions will be forgiven.
	AI_Output (self, other, "DIA_Parlan_WELCOME_05_04");	//May Innos bless this man, who places his life in his service, and wash away his sins.
	AI_Output (other, self, "DIA_Parlan_WELCOME_15_05");	//And now?
	AI_Output (self, other, "DIA_Parlan_WELCOME_05_06");	//First you will fulfill the duties of a novice. You will work and serve the Brotherhood.
	B_GrantAbsolution(LOC_ALL);
	Snd_Play("LEVELUP");
	Log_CreateTopic(Topic_Gemeinschaft,LOG_MISSION);
	Log_SetTopicStatus(Topic_Gemeinschaft,LOG_Running);
	B_LogEntry(Topic_Gemeinschaft,"It is my duty as a novice to perform tasks to serve the community.");
	if(Pedro_NOV_Aufnahme_LostInnosStatue_Daron == FALSE)
	{
		if(Liesel_Giveaway == FALSE)
		{
			AI_Output (self, other, "DIA_Parlan_WELCOME_05_07");	//But take your sheep to Opolos first, he will take care of it.
		};
		if(DIA_Gorax_GOLD_perm == FALSE)
		{
			AI_Output (self, other, "DIA_Parlan_WELCOME_05_08");	//You can give your gold to Gorax, our steward. You will find him in the winery.
			B_DIA_Parlan_WELCOME_GoForTribute ();
		};
	}
	else if(DIA_Gorax_GOLD_perm == FALSE)
	{
		B_DIA_Parlan_WELCOME_BringTribute2Gorax();
		B_DIA_Parlan_WELCOME_GoForTribute();
	};
};


instance DIA_Parlan_Auge(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 2;
	condition = DIA_Parlan_Auge_Condition;
	information = DIA_Parlan_Auge_Info;
	permanent = FALSE;
	description = "I'm looking for the Eye of Innos.";
};


func int DIA_Parlan_Auge_Condition()
{
	if(Kapitel <= 2)
	{
		return TRUE;
	};
};

func void DIA_Parlan_Auge_Info()
{
	AI_Output (other, self, "DIA_Parlan_Auge_15_00");	//I'm looking for the Eye of Innos.
	AI_Output (self, other, "DIA_Parlan_Auge_05_01");	//I don't know who told you about that - but the divine artifact is not accessible to anyone.
	AI_Output (other, self, "DIA_Parlan_Auge_15_02");	//Where is the Eye of Innos kept?
	AI_Output (self, other, "DIA_Parlan_Auge_05_03");	//The fewer people know this secret, the better it is protected. Seek for it - and you will not find it.
};


instance DIA_Parlan_Amulett(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 3;
	condition = DIA_Parlan_Amulett_Condition;
	information = DIA_Parlan_Amulett_Info;
	permanent = FALSE;
	description = "Tell me about the Eye of Innos.";
};


func int DIA_Parlan_Amulett_Condition()
{
	if((Kapitel <= 2) && Npc_KnowsInfo(other,DIA_Parlan_Auge))
	{
		return TRUE;
	};
	if(Kapitel >= 3)
	{
		return TRUE;
	};
};

func void DIA_Parlan_Amulett_Info()
{
	AI_Output (other, self, "DIA_Parlan_Amulett_15_00");	//Tell me about the Eye of Innos.
	AI_Output (self, other, "DIA_Parlan_Amulett_05_01");	//All right. The Eye of Innos contains a part of the divine power of Innos. Only ONE chosen servant of Innos is permitted to bear the amulet.
	AI_Output (self, other, "DIA_Parlan_Amulett_05_02");	//It was created to protect us from the powers of Evil when the time has come.
};


instance DIA_Parlan_Hagen(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 2;
	condition = DIA_Parlan_Hagen_Condition;
	information = DIA_Parlan_Hagen_Info;
	permanent = FALSE;
	description = "I need to talk to the leader of the paladins!";
};


func int DIA_Parlan_Hagen_Condition()
{
	if((LordHagen.aivar[AIV_TalkedToPlayer] == FALSE) && (other.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Parlan_Hagen_Info()
{
	AI_Output (other, self, "DIA_Parlan_Hagen_15_00");	//I need to talk to the leader of the paladins!
	AI_Output (self, other, "DIA_Parlan_Hagen_05_01");	//Lord Hagen does not receive novices - only we magicians are permitted to see him.
	Player_KnowsLordHagen = TRUE;
};


instance DIA_Parlan_WORK(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 2;
	condition = DIA_Parlan_WORK_Condition;
	information = DIA_Parlan_WORK_Info;
	permanent = TRUE;
	description = "How can I serve the community?";
};


var int DIA_Parlan_WORK_perm;

func int DIA_Parlan_WORK_Condition()
{
	if(!Npc_KnowsInfo(other,DIA_Parlan_KNOWSJUDGE) && Npc_KnowsInfo(other,DIA_Parlan_WELCOME) && (DIA_Parlan_WORK_perm == FALSE))
	{
		if(Kapitel == 1)
		{
			return TRUE;
		}
		else if(GuildlessMode == TRUE)
		{
			return TRUE;
		};
	};
};

func void DIA_Parlan_WORK_Info()
{
	AI_Output (other, self, "DIA_Parlan_WORK_15_00");	//How can I serve the community?
	if ((Liesel_Giveaway == FALSE) || (DIA_Gorax_GOLD_perm == FALSE))
	{
		AI_Output (self, other, "DIA_Parlan_WELCOME_05_06");	//First you will fulfill the duties of a novice. You will work and serve the Brotherhood.
		if (Liesel_Giveaway == FALSE)
		{
			AI_Output (self, other, "DIA_Parlan_WELCOME_05_07");	//But take your sheep to Opolos first, he will take care of it.
		};
		if(DIA_Gorax_GOLD_perm == FALSE)
		{
			if(Pedro_NOV_Aufnahme_LostInnosStatue_Daron == TRUE)
			{
				B_DIA_Parlan_WELCOME_BringTribute2Gorax();
				B_DIA_Parlan_WELCOME_GoForTribute();
			}
			else
			{
				AI_Output(self,other,"DIA_Parlan_WELCOME_05_08");	//You can give your gold to Gorax, our steward. You will find him in the winery.
				B_DIA_Parlan_WELCOME_GoForTribute();
			};
		};
		AI_StopProcessInfos(self);
	}
	else if(Wld_IsTime(22,0,7,30))
	{
		AI_Output (self, other, "DIA_Parlan_WORK_NIGHT_05_01");	//It is the time of peace. The work of the novices begins in the morning and continues until darkness.
		AI_Output (self, other, "DIA_Parlan_WORK_NIGHT_05_02");	//You should sleep, too. Come again when the time of work begins.
		AI_StopProcessInfos (self);
	}
	else
	{
		AI_Output (self, other, "DIA_Parlan_WORK_05_03");	//Speak to the other magicians. They will give you tasks.
		AI_Output (self, other, "DIA_Parlan_WORK_05_04");	//I will oversee your work, and when you have fulfilled your duties adequately, you will receive permission to enter the library to study the word of Innos.
		DIA_Parlan_WORK_perm = TRUE;
		MIS_KlosterArbeit = LOG_Running;
		B_LogEntry (Topic_Gemeinschaft, "If I complete the tasks for the mages, I will be granted permission to study in the library.");
	};
};


instance DIA_Parlan_Stand(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 23;
	condition = DIA_Parlan_Stand_Condition;
	information = DIA_Parlan_Stand_Info;
	permanent = TRUE;
	description = "Can I have access to the library?";
};


func int DIA_Parlan_Stand_Condition()
{
	if((MIS_KlosterArbeit == LOG_Running) && (other.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Parlan_Stand_Info()
{
	Kloster_Punkte = 0;
	AI_Output (other, self, "DIA_Parlan_Stand_15_00");	//Can I have access to the library?
	if (MIS_NeorasPflanzen == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Parlan_Stand_05_01");	//You have obtained fire nettles for Brother Neoras.
		Kloster_Punkte += 2;
	};
	if(MIS_NeorasRezept == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Parlan_Stand_05_02");	//You have found Brother Neoras' recipe.
		Kloster_Punkte += 2;
	};
	if(MIS_IsgarothWolf == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Parlan_Stand_05_03");	//You have vanquished the black wolf which threatened the shrine.
		Kloster_Punkte += 1;
	};
	if(MIS_ParlanFegen == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Parlan_Stand_05_04");	//You have succeeded in finding four novices and thus cleaned the chambers.
		Kloster_Punkte += 3;
	};
	if(MIS_GoraxEssen == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Parlan_Stand_05_05");	//You have distributed the food to the novices fairly, as Brother Gorax instructed you.
		Kloster_Punkte += 1;
	}
	else if(MIS_GoraxEssen == LOG_FAILED)
	{
		AI_Output(self,other,"DIA_Parlan_Stand_05_06");	//Gorax was not satisfied with you, because you did not hand out the food fairly.
	};
	if(MIS_GoraxWein == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Parlan_Stand_05_07");	//You have sold the wine to Gorax's satisfaction.
		Kloster_Punkte += 1;
	}
	else if(MIS_GoraxWein == LOG_FAILED)
	{
		AI_Output(self,other,"DIA_Parlan_Stand_05_08");	//The less said about the matter with the wine, the better...
	};
	if(Kloster_Punkte >= 8)
	{
		AI_Output (self, other, "DIA_Parlan_Stand_05_09");	//Yes, you have worked enough. Now it is time for you to study the teachings of Innos. Speak to Master Hyglas in the library.
		AI_Output (self, other, "DIA_Parlan_Stand_05_10");	//I hereby give you the key.
		B_GiveInvItems(self,other,ItKe_KlosterBibliothek,1);
		Parlan_Erlaubnis = TRUE;
		MIS_KlosterArbeit = LOG_SUCCESS;
		B_CheckLog();
	}
	else if(Kloster_Punkte >= 1)
	{
		AI_Output (self, other, "DIA_Parlan_Stand_05_11");	//You have certainly worked, but it is your duty to continue serving the community.
	}
	else
	{
		AI_Output (self, other, "DIA_Parlan_Stand_05_12");	//First fulfill your duties in service to the community. When you're done working, we shall speak about this again.
	};
};


instance DIA_Parlan_Aufgabe(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 10;
	condition = DIA_Parlan_Aufgabe_Condition;
	information = DIA_Parlan_Aufgabe_Info;
	permanent = FALSE;
	description = "Do you have an assignment for me?";
};


func int DIA_Parlan_Aufgabe_Condition()
{
	if(MIS_KlosterArbeit == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Parlan_Aufgabe_Info()
{
	AI_Output (other, self, "DIA_Parlan_Aufgabe_15_00");	//Do you have an assignment for me?
	AI_Output (self, other, "DIA_Parlan_Aufgabe_05_01");	//Hmm ... Yes, there is indeed something you can do for the community.
	AI_Output (self, other, "DIA_Parlan_Aufgabe_05_02");	//The novices' chambers could do with a good sweeping. Take care of that.
	AI_Output (other, self, "DIA_Parlan_Aufgabe_15_03");	//But that will take forever ...
	AI_Output (self, other, "DIA_Parlan_Aufgabe_05_04");	//Then you had better start right away, hadn't you?
	MIS_ParlanFegen = LOG_Running;
	Log_CreateTopic (Topic_ParlanFegen, LOG_MISSION);
	Log_SetTopicStatus (Topic_ParlanFegen, LOG_Running);
	B_LogEntry (Topic_ParlanFegen, "Master Parlan wants me to sweep the four novices' chambers. That'll take ages.");
};


instance DIA_Parlan_Fegen(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 3;
	condition = DIA_Parlan_Fegen_Condition;
	information = DIA_Parlan_Fegen_Info;
	permanent = TRUE;
	description = "About the novices' chambers...";
};


var int DIA_Parlan_Fegen_permanent;

func int DIA_Parlan_Fegen_Condition()
{
	if((MIS_ParlanFegen == LOG_Running) && (DIA_Parlan_Fegen_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Parlan_Fegen_Info()
{
	AI_Output (other, self, "DIA_Parlan_Fegen_15_00");	//About the novices' chambers...
	if (NOV_Helfer >= 4)
	{
		AI_Output (self, other, "DIA_Parlan_Fegen_05_01");	//You actually managed to find four novices to help you. I think they can now return to their daily work.
		AI_Output (self, other, "DIA_Parlan_Fegen_05_02");	//Well done, novice. You have accomplished the task I set you.
		MIS_ParlanFegen = LOG_SUCCESS;
		B_GivePlayerXP(XP_ParlanFegen);
		DIA_Parlan_Fegen_permanent = TRUE;
		B_StartOtherRoutine(Feger1,"START");
		B_StartOtherRoutine(Feger2,"START");
		B_StartOtherRoutine(Feger3,"START");
		B_StartOtherRoutine(Babo,"START");
	}
	else
	{
		AI_Output (self, other, "DIA_Parlan_Fegen_05_03");	//Indisputably - it is not a simple task. But with the help of Innos you will manage.
	};
};


instance DIA_Parlan_LEARN(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 23;
	condition = DIA_Parlan_LEARN_Condition;
	information = DIA_Parlan_LEARN_Info;
	permanent = FALSE;
	description = "How can I learn the art of magic?";
};


func int DIA_Parlan_LEARN_Condition()
{
//	if(Npc_KnowsInfo(hero,DIA_Parlan_Hagen) && (other.guild == GIL_NOV))
	if(other.guild == GIL_NOV)
	{
		return TRUE;
	};
};

func void DIA_Parlan_LEARN_Info()
{
	AI_Output (other, self, "DIA_Parlan_LEARN_15_00");	//How can I learn the art of magic?
	AI_Output (self, other, "DIA_Parlan_LEARN_05_01");	//You are not here to receive the gift of magic - you are here to serve Innos.
	AI_Output (self, other, "DIA_Parlan_LEARN_05_02");	//But I can show you how to increase your magic power.
	B_LogEntry (Topic_KlosterTeacher, "Master Parlan can help me to improve my magic powers.");
};


instance DIA_Parlan_KNOWSJUDGE(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 23;
	condition = DIA_Parlan_KNOWSJUDGE_Condition;
	information = DIA_Parlan_KNOWSJUDGE_Info;
	permanent = FALSE;
	description = "I want to undergo the Test of Fire.";
};


func int DIA_Parlan_KNOWSJUDGE_Condition()
{
	if((other.guild == GIL_NOV) && (KNOWS_FIRE_CONTEST == TRUE) && !Npc_KnowsInfo(hero,DIA_Pyrokar_FIRE))
	{
		return TRUE;
	};
};

func void DIA_Parlan_KNOWSJUDGE_Info()
{
	AI_Output (other, self, "DIA_Parlan_KNOWSJUDGE_15_00");	//I want to undergo the Test of Fire.
	AI_Output (self, other, "DIA_Parlan_KNOWSJUDGE_05_01");	//What ...? Hm ... (insistently) Are you really serious?
	AI_Output (other, self, "DIA_Parlan_KNOWSJUDGE_15_02");	//I insist.
	AI_Output (self, other, "DIA_Parlan_KNOWSJUDGE_05_03");	//You are an exceptional novice. All right, if you are serious, then speak to Master Pyrokar.
	B_LogEntry (TOPIC_FireContest, "If I want to demand the Test of Fire, I should speak to Master Pyrokar.");
};


func void B_BuildLearnDialog_Parlan()
{
	if((other.aivar[REAL_MANA_MAX] >= T_MED) || ((IgnoreBonuses == TRUE) && (other.attribute[ATR_MANA_MAX] >= T_MED)))
	{
		AI_Output (self, other, "DIA_Parlan_TEACH_MANA_05_00");	//Your magic power has grown. I cannot help you to increase it more.
		AI_Output (self, other, "DIA_Parlan_TEACH_MANA_05_01");	//If you want to learn more, ask Pyrokar.
		Parlan_Sends = TRUE;
	}
	else
	{
		Info_ClearChoices(DIA_Parlan_TEACH_MANA);
		Info_AddChoice(DIA_Parlan_TEACH_MANA,Dialog_Back,DIA_Parlan_TEACH_MANA_BACK);
		Info_AddChoice(DIA_Parlan_TEACH_MANA,B_BuildLearnString(PRINT_LearnMANA1,B_GetLearnCostAttribute(other,ATR_MANA_MAX)),DIA_Parlan_TEACH_MANA_1);
		Info_AddChoice(DIA_Parlan_TEACH_MANA,B_BuildLearnString(PRINT_LearnMANA5,B_GetLearnCostAttribute(other,ATR_MANA_MAX) * 5),DIA_Parlan_TEACH_MANA_5);
	};
};

instance DIA_Parlan_TEACH_MANA(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 10;
	condition = DIA_Parlan_TEACH_MANA_Condition;
	information = DIA_Parlan_TEACH_MANA_Info;
	permanent = TRUE;
	description = "I want to increase my magic powers.";
};


func int DIA_Parlan_TEACH_MANA_Condition()
{
	if(((other.guild == GIL_KDF) || (other.guild == GIL_PAL) || ((other.guild == GIL_NOV) && Npc_KnowsInfo(hero,DIA_Parlan_LEARN))) && (Parlan_Sends == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Parlan_TEACH_MANA_Info()
{
	AI_Output(other,self,"DIA_Parlan_TEACH_MANA_15_00");	//I want to increase my magic powers.
	B_BuildLearnDialog_Parlan();
};

func void DIA_Parlan_TEACH_MANA_BACK()
{
	Info_ClearChoices(DIA_Parlan_TEACH_MANA);
};

func void DIA_Parlan_TEACH_MANA_1()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,1,T_MED))
	{
		B_BuildLearnDialog_Parlan();
	};
};

func void DIA_Parlan_TEACH_MANA_5()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,5,T_MED))
	{
		B_BuildLearnDialog_Parlan();
	};
};

instance DIA_Parlan_MAGE(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 2;
	condition = DIA_Parlan_MAGE_Condition;
	information = DIA_Parlan_MAGE_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Parlan_MAGE_Condition()
{
//	if((other.guild == GIL_KDF) && Npc_IsInState(self,ZS_Talk))
	if((other.guild == GIL_KDF) && (B_GetGreatestPetzCrime(self) == CRIME_NONE))
	{
		return TRUE;
	};
};

func void DIA_Parlan_MAGE_Info()
{
	AI_Output (self, other, "DIA_Parlan_MAGE_05_00");	//You have sworn your oath, Brother. Welcome to our ranks.
	AI_Output (self, other, "DIA_Parlan_MAGE_05_01");	//I will instruct you in the Circles of Magic when you have enough experience.
	AI_Output (self, other, "DIA_Parlan_MAGE_05_02");	//Take this runestone as a token that the power now lies in your hands.
	AI_WaitTillEnd(other,self);
	CreateInvItem(other,ItMi_RuneBlank);
	AI_PrintScreen("Received: Blank Rune",-1,YPOS_ItemTaken,FONT_ScreenSmall,2);
	if(!Npc_KnowsInfo(other,DIA_Pyrokar_Lernen))
	{
		Log_CreateTopic(Topic_KlosterTeacher,LOG_NOTE);
		B_LogEntry(Topic_KlosterTeacher,"Brother Parlan will introduce me into the first circles of magic and teach me various magic formulas.");
	};
	if(!Npc_KnowsInfo(other,DIA_Parlan_LEARN))
	{
		Log_CreateTopic(Topic_KlosterTeacher,LOG_NOTE);
		B_LogEntry(Topic_KlosterTeacher,"Brother Parlan can increase my magic energy.");
	};
};


instance DIA_Parlan_CIRCLE1(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 99;
	condition = DIA_Parlan_CIRCLE1_Condition;
	information = DIA_Parlan_CIRCLE1_Info;
	permanent = TRUE;
//	description = B_BuildLearnString("Teach me the first Circle of Magic.",B_GetLearnCostTalent(other,NPC_TALENT_MAGE,1));
	description = B_BuildLearnString("First Circle of Magic",B_GetLearnCostTalent(other,NPC_TALENT_MAGE,1));
};


func int DIA_Parlan_CIRCLE1_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Parlan_MAGE) && (other.guild == GIL_KDF) && (Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 0))
	{
		return TRUE;
	};
};

func void DIA_Parlan_CIRCLE1_Info()
{
	DIA_Common_TeachMe_FirstMagicCirlce();
	if(B_TeachMagicCircle(self,other,1))
	{
		AI_Output (self, other, "DIA_Parlan_TECH_CIRCLE1_05_01");	//The first Circle of Magic allows you to use the runes which you have created.
		AI_Output (self, other, "DIA_Parlan_TECH_CIRCLE1_05_02");	//You can now learn the formulas of the spells to create your own runes.
		AI_Output (self, other, "DIA_Parlan_TECH_CIRCLE1_05_03");	//Each of us specializes in an area of magic. So consider well what sort of magic yours shall be.
	};
};


instance DIA_Parlan_CIRCLE2(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 99;
	condition = DIA_Parlan_CIRCLE2_Condition;
	information = DIA_Parlan_CIRCLE2_Info;
	permanent = TRUE;
//	description = B_BuildLearnString("Научи меня второму Кругу магии",B_GetLearnCostTalent(other,NPC_TALENT_MAGE,2));
	description = B_BuildLearnString("Second Circle of Magic",B_GetLearnCostTalent(other,NPC_TALENT_MAGE,2));
};


func int DIA_Parlan_CIRCLE2_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Parlan_MAGE) && (other.guild == GIL_KDF) && (Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 1))
	{
		return TRUE;
	};
};

func void DIA_Parlan_CIRCLE2_Info()
{
	AI_Output (other, self, "DIA_Parlan_TECH_CIRCLE2_15_00");	//Teach me the second Circle of Magic.
	if (Kapitel >= 2)
	{
		if(B_TeachMagicCircle(self,other,2))
		{
			AI_Output (self, other, "DIA_Parlan_TECH_CIRCLE2_05_01");	//Enter now the second Circle and learn to work even more powerful magic.
			AI_Output (self, other, "DIA_Parlan_TECH_CIRCLE2_05_02");	//But also remember that you bear a responsibility. Not to me and not to Pyrokar - but to Innos.
			AI_Output (self, other, "DIA_Parlan_TECH_CIRCLE2_05_03");	//He shows you the direction - but your deeds form the path.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Parlan_TECH_CIRCLE2_05_04");	//The time has not yet come.
	};
};


instance DIA_Parlan_CIRCLE3(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 99;
	condition = DIA_Parlan_CIRCLE3_Condition;
	information = DIA_Parlan_CIRCLE3_Info;
	permanent = TRUE;
//	description = B_BuildLearnString("Научи меня третьему Кругу магии",B_GetLearnCostTalent(other,NPC_TALENT_MAGE,3));
	description = B_BuildLearnString("Third Circle of Magic",B_GetLearnCostTalent(other,NPC_TALENT_MAGE,3));
};


func int DIA_Parlan_CIRCLE3_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Parlan_MAGE) && (other.guild == GIL_KDF) && (Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 2))
	{
		return TRUE;
	};
};

func void DIA_Parlan_CIRCLE3_Info()
{
	AI_Output (other, self, "DIA_Parlan_TECH_CIRCLE3_15_00");	//Teach me the third Circle of Magic.
	if (Kapitel >= 3)
	{
		if(B_TeachMagicCircle(self,other,3))
		{
			AI_Output (self, other, "DIA_Parlan_TECH_CIRCLE3_05_01");	//Yes, the time has come. Enter now the third Circle of Magic. New spells await you.
			AI_Output (self, other, "DIA_Parlan_TECH_CIRCLE3_05_02");	//You will need them, for Evil draws nigh and it can be thwarted only with the power of Innos.
			AI_Output (self, other, "DIA_Parlan_TECH_CIRCLE3_05_03");	//I have now taught you all of the Circles that I can pass on. Karas will instruct you in the higher Circles.
			B_LogEntry (Topic_KlosterTeacher, "Brother Parlan has taught me the first three Circles. Brother Karras will help me into the next Circles.");
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Parlan_TECH_CIRCLE3_05_04");	//It is not yet time for you to learn the third Circle.
	};
};


instance DIA_Parlan_TEACH(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 3;
	condition = DIA_Parlan_TEACH_Condition;
	information = DIA_Parlan_TEACH_Info;
	permanent = TRUE;
	description = "Teach me (create runes).";
};


func int DIA_Parlan_TEACH_Condition()
{
	if(other.guild == GIL_KDF)
	{
		return TRUE;
	};
};

func void DIA_Parlan_TEACH_Info()
{
	var int abletolearn;
	abletolearn = 0;
	DIA_Common_WantToLearnNewRunes();
	Info_ClearChoices(DIA_Parlan_TEACH);
	Info_AddChoice(DIA_Parlan_TEACH,Dialog_Back,DIA_Parlan_TEACH_BACK);
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 1) && (PLAYER_TALENT_RUNES[SPL_LightHeal] == FALSE))
	{
		Info_AddChoice(DIA_Parlan_TEACH,B_BuildLearnString(NAME_SPL_LightHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_LightHeal)),DIA_Parlan_TEACH_LIGHT_HEAL);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 1) && (PLAYER_TALENT_RUNES[SPL_Light] == FALSE))
	{
		Info_AddChoice(DIA_Parlan_TEACH,B_BuildLearnString(NAME_SPL_LIGHT,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Light)),DIA_Parlan_TEACH_LIGHT);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 2) && (PLAYER_TALENT_RUNES[SPL_WindFist] == FALSE))
	{
		Info_AddChoice(DIA_Parlan_TEACH,B_BuildLearnString(NAME_SPL_WINDFIST,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_WindFist)),DIA_Parlan_TEACH_WINDFIST);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 2) && (PLAYER_TALENT_RUNES[SPL_Sleep] == FALSE))
	{
		Info_AddChoice(DIA_Parlan_TEACH,B_BuildLearnString(NAME_SPL_Sleep,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Sleep)),DIA_Parlan_TEACH_Sleep);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 3) && (PLAYER_TALENT_RUNES[SPL_MediumHeal] == FALSE))
	{
		Info_AddChoice(DIA_Parlan_TEACH,B_BuildLearnString(NAME_SPL_MediumHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_MediumHeal)),DIA_Parlan_TEACH_MediumHeal);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 3) && (PLAYER_TALENT_RUNES[SPL_Fear] == FALSE))
	{
		Info_AddChoice(DIA_Parlan_TEACH,B_BuildLearnString(NAME_SPL_Fear,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Fear)),DIA_Parlan_TEACH_Fear);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 4) && (PLAYER_TALENT_RUNES[SPL_DestroyUndead] == FALSE))
	{
		Info_AddChoice(DIA_Parlan_TEACH,B_BuildLearnString(NAME_SPL_DestroyUndead,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_DestroyUndead)),DIA_Parlan_TEACH_DestroyUndead);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 5) && (PLAYER_TALENT_RUNES[SPL_FullHeal] == FALSE))
	{
		Info_AddChoice(DIA_Parlan_TEACH,B_BuildLearnString(NAME_SPL_FullHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_FullHeal)),DIA_Parlan_TEACH_FullHeal);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 5) && (PLAYER_TALENT_RUNES[SPL_Shrink] == FALSE))
	{
		Info_AddChoice(DIA_Parlan_TEACH,B_BuildLearnString(NAME_SPL_Shrink,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Shrink)),DIA_Parlan_TEACH_Shrink);
		abletolearn += 1;
	};
	if(abletolearn < 1)
	{
		AI_Output(self,other,"DIA_Parlan_TEACH_05_01");	//I cannot teach you more formulas at the moment.
		if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 0)
		{
			PrintScreen(PRINT_MAGCIRCLES_NEEDFIRST,-1,-1,FONT_ScreenSmall,2);
		};
		Info_ClearChoices(DIA_Parlan_TEACH);
	};
};

func void DIA_Parlan_TEACH_BACK()
{
	Info_ClearChoices(DIA_Parlan_TEACH);
};

func void DIA_Parlan_TEACH_LIGHT_HEAL()
{
	B_TeachPlayerTalentRunes(self,other,SPL_LightHeal);
};

func void DIA_Parlan_TEACH_LIGHT()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Light);
};

func void DIA_Parlan_TEACH_WINDFIST()
{
	B_TeachPlayerTalentRunes(self,other,SPL_WindFist);
};

func void DIA_Parlan_TEACH_Sleep()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Sleep);
};

func void DIA_Parlan_TEACH_MediumHeal()
{
	B_TeachPlayerTalentRunes(self,other,SPL_MediumHeal);
};

func void DIA_Parlan_TEACH_Fear()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Fear);
};

func void DIA_Parlan_TEACH_DestroyUndead()
{
	B_TeachPlayerTalentRunes(self,other,SPL_DestroyUndead);
};

func void DIA_Parlan_TEACH_FullHeal()
{
	B_TeachPlayerTalentRunes(self,other,SPL_FullHeal);
};

func void DIA_Parlan_TEACH_Shrink()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Shrink);
};


instance DIA_Parlan_IAmParlan(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 39;
	condition = DIA_Parlan_IAmParlan_Condition;
	information = DIA_Parlan_IAmParlan_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Parlan_IAmParlan_Condition()
{
//	if((Kapitel >= 3) && Npc_IsInState(self,ZS_Talk) && ((other.guild != GIL_NOV) && (other.guild != GIL_KDF)))
	if((Kapitel >= 3) && (other.guild != GIL_NOV) && (other.guild != GIL_KDF) && (B_GetGreatestPetzCrime(self) == CRIME_NONE))
	{
		return TRUE;
	};
};

func void DIA_Parlan_IAmParlan_Info()
{
	if(other.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_Parlan_IAmParlan_05_00");	//I see that you have decided to fight on our side. I am glad.
		AI_Output (self, other, "DIA_Parlan_IAmParlan_05_01");	//We can use every man. You should go speak directly to Marduk, he is responsible for you paladins.
	}
	else
	{
		AI_Output (self, other, "DIA_Parlan_IAmParlan_05_02");	//I do not know why you were allowed to enter the monastery. I am Parlan, and I am responsible for our novices.
		AI_Output (self, other, "DIA_Parlan_IAmParlan_05_03");	//I do not want you to keep them from their work with stupid questions. Is that clear?
		Parlan_DontTalkToNovice = LOG_Running;
		Info_ClearChoices (DIA_Parlan_IAmParlan);
		Info_AddChoice (DIA_Parlan_IAmParlan, "I shall do what I please.", DIA_Parlan_IAmParlan_MyChoice);
		Info_AddChoice (DIA_Parlan_IAmParlan, "Sure.", DIA_Parlan_IAmParlan_OK);
	};
/*	if((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
	{
		Wld_InsertItem(ItKe_KlosterBibliothek,"NW_MONASTERY_CORRIDOR_02");
	};*/
};

func void DIA_Parlan_IAmParlan_MyChoice()
{
	AI_Output (other, self, "DIA_Parlan_IAmParlan_MyChoice_15_00");	//I shall do what I please.
	AI_Output (self, other, "DIA_Parlan_IAmParlan_MyChoice_05_01");	//There must be reasons why you are tolerated here, but there is a limit to everything.
	AI_Output (self, other, "DIA_Parlan_IAmParlan_MyChoice_05_02");	//If you cause trouble, you'll pay for it. So stay away from the novices.
	Info_ClearChoices (DIA_Parlan_IAmParlan);
};

func void DIA_Parlan_IAmParlan_OK()
{
	AI_Output (other, self, "DIA_Parlan_IAmParlan_OK_15_00");	//Sure.
	AI_Output (self, other, "DIA_Parlan_IAmParlan_OK_05_01");	//I certainly hope so.
	Info_ClearChoices (DIA_Parlan_IAmParlan);
};


instance DIA_Parlan_Bibliothek(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 40;
	condition = DIA_Parlan_Bibliothek_Condition;
	information = DIA_Parlan_Bibliothek_Info;
	permanent = FALSE;
	description = "Have you got anything else for me?";
};


func int DIA_Parlan_Bibliothek_Condition()
{
//	if((other.guild != GIL_KDF) && (Kapitel >= 3) && (other.guild != GIL_SLD) && (other.guild != GIL_DJG))
	if((other.guild != GIL_KDF) && (Kapitel >= 3))
	{
		return TRUE;
	};
};

func void DIA_Parlan_Bibliothek_Info()
{
	AI_Output(other,self,"DIA_Parlan_Bibliothek_15_00");	//Have you got anything else for me?
	if((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
	{
		AI_Output(self,other,"DIA_Parlan_IAmParlan_05_00");	//I see that you have decided to fight on our side. I am glad.
	};
	AI_Output(self,other,"DIA_Parlan_Bibliothek_05_01");	//Yes. As a member of the library, you are given the key to the library. There you will find Brothers Karas and Hyglas.
	AI_Output(self,other,"DIA_Parlan_Bibliothek_05_02");	//If you like, you can speak with them there.
	if(other.guild != GIL_PAL)
	{
		AI_Output(self,other,"DIA_Parlan_DontDisturb_05_03");	//But leave my novices alone!
	};
	B_GiveInvItems(self,other,ItKe_KlosterBibliothek,1);
};


instance DIA_Parlan_DontDisturb(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 39;
	condition = DIA_Parlan_DontDisturb_Condition;
	information = DIA_Parlan_DontDisturb_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Parlan_DontDisturb_Condition()
{
//	if((Parlan_DontTalkToNovice == LOG_SUCCESS) && (B_GetGreatestPetzCrime(self) == CRIME_NONE) && ((other.guild != GIL_PAL) || (other.guild != GIL_NOV) || (other.guild != GIL_KDF)))
	if((Parlan_DontTalkToNovice == LOG_FAILED) && (B_GetGreatestPetzCrime(self) == CRIME_NONE) && (other.guild != GIL_PAL))
	{
		return TRUE;
	};
};

func void DIA_Parlan_DontDisturb_Info()
{
	AI_Output (self, other, "DIA_Parlan_DontDisturb_05_00");	//(threatening) I do not like to repeat my self. Leave the novices alone.
	AI_Output (self, other, "DIA_Parlan_DontDisturb_05_01");	//They are supposed to purify their spirits with physical labor and prepare themselves for life in the monastery.
	AI_Output (self, other, "DIA_Parlan_DontDisturb_05_02");	//(energetic) I will not tolerate further distractions!
	Parlan_DontTalkToNovice = LOG_Running;
	AI_StopProcessInfos(self);
};


instance DIA_Parlan_Kap3U4U5_PERM(C_Info)
{
	npc = KDF_504_Parlan;
	nr = 39;
	condition = DIA_Parlan_Kap3U4U5_PERM_Condition;
	information = DIA_Parlan_Kap3U4U5_PERM_Info;
	permanent = TRUE;
	description = "Where can I find...";
};


func int DIA_Parlan_Kap3U4U5_PERM_Condition()
{
	if((Kapitel >= 3) && (other.guild != GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Parlan_Kap3U4U5_PERM_Info()
{
	AI_Output (other, self, "DIA_Parlan_Kap3_PERM_15_00");	//Where can I find ...
	Info_ClearChoices (DIA_Parlan_Kap3U4U5_PERM);
	Info_AddChoice (DIA_Parlan_Kap3U4U5_PERM, Dialog_Back, DIA_Parlan_Kap3U4U5_PERM_Back);
	Info_AddChoice (DIA_Parlan_Kap3U4U5_PERM, "... the church?", DIA_Parlan_Kap3U4U5_PERM_Church);
	Info_AddChoice (DIA_Parlan_Kap3U4U5_PERM, "... the library?", DIA_Parlan_Kap3U4U5_PERM_Library);
	Info_AddChoice (DIA_Parlan_Kap3U4U5_PERM, "... the chapel?", DIA_Parlan_Kap3U4U5_PERM_Chapel);
	Info_AddChoice (DIA_Parlan_Kap3U4U5_PERM, "... the cellars?", DIA_Parlan_Kap3U4U5_PERM_Cellar);
};

func void DIA_Parlan_Kap3U4U5_PERM_Back()
{
	Info_ClearChoices(DIA_Parlan_Kap3U4U5_PERM);
};

func void DIA_Parlan_Kap3U4U5_PERM_Church()
{
	AI_Output (other, self, "DIA_Parlan_Kap3U4U5_PERM_Church_15_00");	//...the church?
	AI_Output (self, other, "DIA_Parlan_Add_05_00");	//Lord Almighty! Has Innos stricken you blind?
	AI_Output (self, other, "DIA_Parlan_Add_05_01");	//(cynically) Where is the church? Oh my, where could it possibly be?
};

func void DIA_Parlan_Kap3U4U5_PERM_Library()
{
	AI_Output (other, self, "DIA_Parlan_Kap3U4U5_PERM_Library_15_00");	//...the library?
	AI_Output (self, other, "DIA_Parlan_Add_05_02");	//The library is at the end of the colonnade to the left, directly across from the church.
};

func void DIA_Parlan_Kap3U4U5_PERM_Chapel()
{
	AI_Output (other, self, "DIA_Parlan_Kap3U4U5_PERM_Chapel_15_00");	//...the chapel?
	AI_Output (self, other, "DIA_Parlan_Add_05_03");	//The chapel is the room halfway along the left colonnade. That's where the paladins pray to Innos.
};

func void DIA_Parlan_Kap3U4U5_PERM_Cellar()
{
	AI_Output (other, self, "DIA_Parlan_Kap3U4U5_PERM_Cellar_15_00");	//...the cellars?
	AI_Output (self, other, "DIA_Parlan_Add_05_04");	//The entrance to the cellars lies halfway along the colonnade on the right.
};

