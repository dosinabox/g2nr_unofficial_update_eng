
instance DIA_Hagen_EXIT(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 999;
	condition = DIA_Hagen_EXIT_Condition;
	information = DIA_Hagen_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Hagen_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Hagen_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


var int Hagen_LastPetzCounter;
var int Hagen_LastPetzCrime;

func void B_Hagen_CityLaws()
{
	AI_Output(self,other,"DIA_Hagen_PMSchulden_04_01");	//You don't take the city laws very seriously, do you?
};

instance DIA_Hagen_PMSchulden(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 1;
	condition = DIA_Hagen_PMSchulden_Condition;
	information = DIA_Hagen_PMSchulden_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Hagen_PMSchulden_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Hagen_Schulden > 0) && (B_GetGreatestPetzCrime(self) <= Hagen_LastPetzCrime))
	{
		return TRUE;
	};
};

func void DIA_Hagen_PMSchulden_Info()
{
	var int diff;
	AI_Output (self, other, "DIA_Hagen_PMSchulden_04_00");	//It's good that you've come. You can pay your penalty right away.
	if (B_GetTotalPetzCounter (self) > Hagen_LastPetzCounter)
	{
		diff = B_GetTotalPetzCounter(self) - Hagen_LastPetzCounter;
		if(diff > 0)
		{
			Hagen_Schulden += diff * 50;
		};
		if(Hagen_Schulden > 1000)
		{
			Hagen_Schulden = 1000;
		};
		B_Hagen_CityLaws();
		AI_Output(self,other,"DIA_Hagen_PMSchulden_04_02");	//The list of your offenses has grown longer.
		if(Hagen_Schulden < 1000)
		{
			AI_Output(self,other,"DIA_Hagen_PMSchulden_04_03");	//And don't tell me you didn't know that!
		}
		else
		{
			AI_Output(self,other,"DIA_Hagen_PMSchulden_04_04");	//You will pay the maximum penalty.
			B_Say_Gold(self,other,Hagen_Schulden);
		};
	}
	else if(B_GetGreatestPetzCrime(self) < Hagen_LastPetzCrime)
	{
		AI_Output (self, other, "DIA_Hagen_PMSchulden_04_05");	//Well, it appears that the situation has changed.
		if (Hagen_LastPetzCrime == CRIME_MURDER)
		{
			AI_Output (self, other, "DIA_Hagen_PMSchulden_04_06");	//There are no more witnesses for your murder!
		};
		if((Hagen_LastPetzCrime == CRIME_THEFT) || ((Hagen_LastPetzCrime > CRIME_THEFT) && (B_GetGreatestPetzCrime(self) < CRIME_THEFT)))
		{
			AI_Output (self, other, "DIA_Hagen_PMSchulden_04_07");	//No one will testify now that you have stolen!
		};
		if((Hagen_LastPetzCrime == CRIME_ATTACK) || ((Hagen_LastPetzCrime > CRIME_ATTACK) && (B_GetGreatestPetzCrime(self) < CRIME_ATTACK)))
		{
			AI_Output (self, other, "DIA_Hagen_PMSchulden_04_08");	//There are no more witnesses for your brawling.
		};
		if(B_GetGreatestPetzCrime(self) == CRIME_NONE)
		{
			AI_Output (self, other, "DIA_Hagen_PMSchulden_04_09");	//All of the accusations against you are no longer valid.
		};
		AI_Output (self, other, "DIA_Hagen_PMSchulden_04_10");	//I don't know what happened there in the city - and I don't want to know.
		AI_Output (self, other, "DIA_Hagen_PMSchulden_04_11");	//Simply make sure that you don't get into trouble here.
		if (B_GetGreatestPetzCrime (self) == CRIME_NONE)
		{
			AI_Output (self, other, "DIA_Hagen_PMSchulden_04_12");	//In any case, I have decided to excuse your debts.
			AI_Output (self, other, "DIA_Hagen_PMSchulden_04_13");	//See to it that you don't get into any more difficulties.
			Hagen_Schulden = 0;
			Hagen_LastPetzCounter = 0;
			Hagen_LastPetzCrime = CRIME_NONE;
		}
		else
		{
			AI_Output (self, other, "DIA_Hagen_PMSchulden_04_14");	//You will, nevertheless, pay your fines in full.
			B_Say_Gold (self, other, Hagen_Schulden);
			AI_Output (self, other, "DIA_Hagen_PMSchulden_04_15");	//So, do you want to pay?
		};
	};
	if(B_GetGreatestPetzCrime(self) != CRIME_NONE)
	{
		Info_ClearChoices (DIA_Hagen_PMSchulden);
		Info_ClearChoices (DIA_Hagen_PETZMASTER);
		Info_AddChoice (DIA_Hagen_PMSchulden, "I haven't got enough gold!", DIA_Hagen_PETZMASTER_PayLater);
		Info_AddChoice (DIA_Hagen_PMSchulden, "How much was that again?", DIA_Hagen_PMSchulden_HowMuchAgain);
		if (Npc_HasItems (other, ItMi_Gold) >= Hagen_Schulden)
		{
			Info_AddChoice (DIA_Hagen_PMSchulden, "I want to pay the penalty!", DIA_Hagen_PETZMASTER_PayNow);
		};
	};
};

func void DIA_Hagen_PMSchulden_HowMuchAgain()
{
	AI_Output (other, self, "DIA_Hagen_PMSchulden_HowMuchAgain_15_00");	//How much was that again?
	B_Say_Gold (self, other, Hagen_Schulden);
	Info_ClearChoices (DIA_Hagen_PMSchulden);
	Info_ClearChoices (DIA_Hagen_PETZMASTER);
	Info_AddChoice (DIA_Hagen_PMSchulden, "I haven't got enough gold!", DIA_Hagen_PETZMASTER_PayLater);
	Info_AddChoice (DIA_Hagen_PMSchulden, "How much was that again?", DIA_Hagen_PMSchulden_HowMuchAgain);
	if (Npc_HasItems (other, ItMi_Gold) >= Hagen_Schulden)
	{
		Info_AddChoice (DIA_Hagen_PMSchulden, "I want to pay the penalty!", DIA_Hagen_PETZMASTER_PayNow);
	};
};


instance DIA_Hagen_PETZMASTER(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 1;
	condition = DIA_Hagen_PETZMASTER_Condition;
	information = DIA_Hagen_PETZMASTER_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Hagen_PETZMASTER_Condition()
{
	if(B_GetGreatestPetzCrime(self) > Hagen_LastPetzCrime)
	{
		return TRUE;
	};
};

func void DIA_Hagen_PETZMASTER_Info()
{
	Hagen_Schulden = 0;
	if(self.aivar[AIV_TalkedToPlayer] == FALSE)
	{
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_00");	//Your reputation precedes you. You have violated the laws of the city.
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_MURDER)
	{
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_01");	//You have gotten yourself into a fine mess.
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_02");	//Murder is a serious crime!
		Hagen_Schulden = B_GetTotalPetzCounter(self) * 50 + 500;
		if((PETZCOUNTER_City_Theft + PETZCOUNTER_City_Attack + PETZCOUNTER_City_Sheepkiller) > 0)
		{
			AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_03");	//Not to mention your other offenses.
		};
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_04");	//The guards have orders to execute every murderer on the spot.
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_05");	//Murder is not acceptable in this city. But you can show your remorse by paying your penalty
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_THEFT)
	{
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_06");	//You are accused of theft!
		if ((PETZCOUNTER_City_Attack + PETZCOUNTER_City_Sheepkiller) > 0)
		{
			AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_07");	//Not to mention the other things I have heard.
		};
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_08");	//That is a violation of the laws of the city. You will pay a penalty for that.
		Hagen_Schulden = B_GetTotalPetzCounter (self) * 50;
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_ATTACK)
	{
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_09");	//You have been involved in a brawl. In doing so, you have violated the law.
		if (PETZCOUNTER_City_Sheepkiller > 0)
		{
			AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_10");	//And what was that thing with the sheep?
		};
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_11");	//A violation of the laws of the city - is a violation of the laws of Innos.
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_12");	//Therefore, you will pay for it.
		Hagen_Schulden = B_GetTotalPetzCounter (self) * 50;
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_SHEEPKILLER)
	{
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_13");	//You have been after our sheep - I didn't want to believe it at first.
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_14");	//Why must I busy myself with such trifles?
		AI_Output (self, other, "DIA_Hagen_PETZMASTER_04_15");	//You will have to pay compensation!
		Hagen_Schulden = 100;
	};
	AI_Output (other, self, "DIA_Hagen_PETZMASTER_15_16");	//How much?
	if (Hagen_Schulden > 1000)
	{
		Hagen_Schulden = 1000;
	};
	B_Say_Gold (self, other, Hagen_Schulden);
	Info_ClearChoices (DIA_Hagen_PMSchulden);
	Info_ClearChoices (DIA_Hagen_PETZMASTER);
	Info_AddChoice (DIA_Hagen_PETZMASTER, "I haven't got enough gold!", DIA_Hagen_PETZMASTER_PayLater);
	if (Npc_HasItems (other, ItMi_Gold) >= Hagen_Schulden)
	{
		Info_AddChoice (DIA_Hagen_PETZMASTER, "I want to pay the penalty!", DIA_Hagen_PETZMASTER_PayNow);
	};
};

func void DIA_Hagen_PETZMASTER_PayNow()
{
	AI_Output (other, self, "DIA_Hagen_PETZMASTER_PayNow_15_00");	//I want to pay the penalty!
	B_GiveInvItems (other, self, ItMi_Gold, Hagen_Schulden);
	AI_Output (self, other, "DIA_Hagen_PETZMASTER_PayNow_04_01");	//Good! I shall see to it that every one in the city learns of it - this will restore your reputation to some degree.
	B_GrantAbsolution (LOC_CITY);
	Hagen_Schulden = 0;
	Hagen_LastPetzCounter = 0;
	Hagen_LastPetzCrime = CRIME_NONE;
	Info_ClearChoices(DIA_Hagen_PETZMASTER);
	Info_ClearChoices(DIA_Hagen_PMSchulden);
};

func void DIA_Hagen_PETZMASTER_PayLater()
{
	AI_Output (other, self, "DIA_Hagen_PETZMASTER_PayLater_15_00");	//I don't have enough gold!
	AI_Output (self, other, "DIA_Hagen_PETZMASTER_PayLater_04_01");	//Then see to it that you acquire the gold as quickly as possible
	AI_Output (self, other, "DIA_Hagen_PETZMASTER_PayLater_04_02");	//And I'm warning you: if you add to your guilt, things will get worse for you.
	Hagen_LastPetzCounter = B_GetTotalPetzCounter (self);
	Hagen_LastPetzCrime = B_GetGreatestPetzCrime (self);
	AI_StopProcessInfos (self);
};


instance DIA_Lord_Hagen_Hallo(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 2;
	condition = DIA_Lord_Hagen_Hallo_Condition;
	information = DIA_Lord_Hagen_Hallo_Info;
	important = TRUE;
	permanent = FALSE;
};


func int DIA_Lord_Hagen_Hallo_Condition()
{
	if(self.aivar[AIV_TalkedToPlayer] == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_Hallo_Info()
{
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
	{
		B_Hagen_CityLaws();
	};
	if(((Npc_KnowsInfo(other,DIA_Lothar_MESSAGE) || Npc_KnowsInfo(other,DIA_Lothar_Hagen)) && (Lothar_Day < Wld_GetDay())) || Npc_KnowsInfo(other,DIA_Lothar_EyeInnos) || (Andre_EyeInnos == TRUE))
	{
		AI_Output(self,other,"DIA_Lord_Hagen_Hallo_04_00");	//I have already heard of you.
		if(Npc_KnowsInfo(other,DIA_Lothar_MESSAGE) || Npc_KnowsInfo(other,DIA_Lothar_Hagen))
		{
			if(Lothar_Day < Wld_GetDay())
			{
				AI_Output(self,other,"DIA_Lord_Hagen_Add_04_03");	//Lothar has reported that you wish to speak with me.
			};
		};
		if(Npc_KnowsInfo(other,DIA_Lothar_EyeInnos) || (Andre_EyeInnos == TRUE))
		{
			AI_Output(self,other,"DIA_Lord_Hagen_Hallo_04_01");	//You are the stranger who has demanded the Eye of Innos.
		};
	};
	if((other.guild != GIL_NONE) && (other.guild != GIL_NOV))
	{
		AI_Output(self,other,"DIA_Lord_Hagen_Hallo_04_02");	//I am Lord Hagen.
		AI_Output (self, other, "DIA_Lord_Hagen_Hallo_04_03");	//Paladin of the king, warrior of our Lord Innos and commander-in-chief of Khorinis.
	};
	AI_Output (self, other, "DIA_Lord_Hagen_Hallo_04_04");	//I have much to do. So do not waste my time - tell me, rather, why you are here.
};


instance DIA_Lord_Hagen_Frieden(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 2;
	condition = DIA_Lord_Hagen_Frieden_Condition;
	information = DIA_Lord_Hagen_Frieden_Info;
	permanent = FALSE;
	description = "I bring an offer of peace from the mercenaries!";
};


func int DIA_Lord_Hagen_Frieden_Condition()
{
	if((MIS_Lee_Friedensangebot == LOG_Running) && Npc_HasItems(other,ItWr_Passage_MIS))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_Frieden_Info()
{
	AI_Output(other,self,"DIA_Lord_Hagen_Frieden_15_00");	//I bring an offer of peace from the mercenaries!
	AI_Output(self,other,"DIA_Lord_Hagen_Frieden_04_01");	//(grumpily) Hm - show me!
	B_GiveInvItems(other,self,ItWr_Passage_MIS,1);
	B_UseFakeScroll();
	AI_Output (self, other, "DIA_Lord_Hagen_Frieden_04_02");	//I know General Lee. I also know the circumstances under which he was condemned to forced labor in the colony.
	AI_Output (self, other, "DIA_Lord_Hagen_Frieden_04_03");	//I consider him to be an honorable man. I am prepared to grant him absolution - only him!
	AI_Output (self, other, "DIA_Lord_Hagen_Frieden_04_04");	//That does not apply to his men, however. Most of them are dishonorable cut-throats and have earned their punishment!
	AI_Output (self, other, "DIA_Lord_Hagen_Frieden_04_05");	//I shall certainly not offer them absolution. Report that to him.
	Hagen_FriedenAbgelehnt = TRUE;
	if(!Npc_KnowsInfo(other,DIA_Lord_Hagen_Armee))
	{
		AI_Output (self, other, "DIA_Lord_Hagen_Frieden_04_06");	//Was that all?
	};
	B_LogEntry (TOPIC_Frieden, "Lord Hagen is willing to grant absolution to Lee, but not to any of the other mercenaries.");
};


instance DIA_Lord_Hagen_Armee(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 2;
	condition = DIA_Lord_Hagen_Armee_Condition;
	information = DIA_Lord_Hagen_Armee_Info;
	permanent = FALSE;
	description = "The hosts of evil are gathering very close to here. In the Valley of Mines.";
};


func int DIA_Lord_Hagen_Armee_Condition()
{
	if((MIS_Lee_Friedensangebot == FALSE) || (Hagen_FriedenAbgelehnt == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_Armee_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_Armee_15_00");	//The hosts of evil are gathering very close to here. In the Valley of Mines.
	AI_Output (self, other, "DIA_Lord_Hagen_Armee_04_01");	//In the Valley of Mines? We have dispatched an expedition there. We are also aware of reports that say the pass there is occupied by orcs.
	AI_Output (self, other, "DIA_Lord_Hagen_Armee_04_02");	//But thus far, nothing has come to me of an army of Evil.
	if (Npc_KnowsInfo (other, DIA_Lord_Hagen_Frieden))
	{
		AI_Output (self, other, "DIA_Lord_Hagen_Armee_04_03");	//Is this merely a trick to make me believe that it is necessary to form an alliance with the mercenaries?
		AI_Output (other, self, "DIA_Lord_Hagen_Armee_15_04");	//No.
	};
	AI_Output (self, other, "DIA_Lord_Hagen_Armee_04_05");	//(skeptical) What army is that supposed to be?
	AI_Output (other, self, "DIA_Lord_Hagen_Armee_15_06");	//An army of dragons who have gathered hosts of their minions around them.
	AI_Output (self, other, "DIA_Lord_Hagen_Armee_04_07");	//Dragons? According to the old scriptures it is many centuries since dragons were last sighted.
	AI_Output (self, other, "DIA_Lord_Hagen_Armee_04_08");	//Tell me - why should I believe a word you say?
	AI_Output (other, self, "DIA_Lord_Hagen_Armee_15_09");	//But the question isn't whether you can believe me. The question is whether you can afford NOT to believe me when I tell the truth.
	AI_Output (self, other, "DIA_Lord_Hagen_Armee_04_10");	//As long as I have no proof, I cannot afford to send even more men there.
};


instance DIA_Lord_Hagen_Proof(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 2;
	condition = DIA_Lord_Hagen_Proof_Condition;
	information = DIA_Lord_Hagen_Proof_Info;
	permanent = TRUE;
	description = "So you want me to bring you proof?";
};


func int DIA_Lord_Hagen_Proof_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lord_Hagen_Armee) && (Hagen_BringProof == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_Proof_Info()
{
	AI_Output(other,self,"DIA_Lord_Hagen_Proof_15_00");	//o you want me to bring you proof?
	if(((hero.guild != GIL_NONE) && (hero.guild != GIL_NOV)) || (GuildlessMode == TRUE))
	{
		AI_Output (self, other, "DIA_Lord_Hagen_Proof_04_01");	//Precisely. Cross the pass and go to the Valley of Mines. Once there, seek out the expedition - and when you have found them, speak to Commander Garond.
		AI_Output (self, other, "DIA_Lord_Hagen_Proof_04_02");	//If anyone knows the situation there, he will.
		AI_Output (self, other, "DIA_Lord_Hagen_Proof_04_03");	//If he confirms your words, then I am prepared to help you.
		AI_Output (other, self, "DIA_Lord_Hagen_Proof_15_04");	//Does that mean you'll hand over the Eye of Innos to me?
		AI_Output (self, other, "DIA_Lord_Hagen_Proof_04_05");	//The Eye of Innos ... good. Bring me proof, then I shall see to it that you are permitted to wear the amulet.
		AI_Output (other, self, "DIA_Lord_Hagen_Proof_15_06");	//Then can I say I've got your word in this matter?
		AI_Output (self, other, "DIA_Lord_Hagen_Proof_04_07");	//You can - for you have it.
		Hagen_BringProof = TRUE;
	}
	else
	{
		if(hero.guild == GIL_NOV)
		{
			PrintScreen(PRINT_Addon_GuildNeeded_NOV,-1,-1,FONT_Screen,2);
		}
		else
		{
			PrintScreen(PRINT_Addon_GuildNeeded,-1,-1,FONT_Screen,2);
		};
		B_Say(self,other,"$NOLEARNNOPOINTS");
	};
};


instance DIA_Lord_Hagen_Auge(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 2;
	condition = DIA_Lord_Hagen_Auge_Condition;
	information = DIA_Lord_Hagen_Auge_Info;
	permanent = FALSE;
	description = "What do you know about the Eye of Innos?";
};


func int DIA_Lord_Hagen_Auge_Condition()
{
	return TRUE;
};

func void DIA_Lord_Hagen_Auge_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_Auge_15_00");	//What do you know about the Eye of Innos?
	AI_Output (self, other, "DIA_Lord_Hagen_Auge_04_01");	//It is a divine artifact. (pensive) In the old prophecies it is mentioned in connection with dragons.
	AI_Output (self, other, "DIA_Lord_Hagen_Auge_04_02");	//However, the scriptures also say that only a Chosen of Innos can wear it.
	if (other.guild == GIL_KDF)
	{
		AI_Output (other, self, "DIA_Lord_Hagen_Auge_15_03");	//I AM a Chosen of Innos!
		AI_Output (self, other, "DIA_Lord_Hagen_Auge_04_04");	//Then perhaps it will be possible for you to wear the amulet.
	};
};


instance DIA_Lord_Hagen_Pass(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 2;
	condition = DIA_Lord_Hagen_Pass_Condition;
	information = DIA_Lord_Hagen_Pass_Info;
	permanent = FALSE;
	description = "How am I supposed to get across the pass?";
};


func int DIA_Lord_Hagen_Pass_Condition()
{
	if((Hagen_BringProof == TRUE) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_Pass_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_Pass_15_00");	//How am I supposed to get across the pass?
	AI_Output (self, other, "DIA_Lord_Hagen_Pass_04_01");	//I shall give you the key to the gate to the pass. However, you will have to find your own way through the ranks of the orcs.
	AI_Output (self, other, "DIA_Lord_Hagen_Pass_04_02");	//May Innos protect you.
	AI_StopProcessInfos (self);
	MIS_OLDWORLD = LOG_Running;
	B_Kapitelwechsel(2,NEWWORLD_ZEN);
	CreateInvItems(self,ItKe_Pass_MIS,1);
	B_GiveInvItems(self,other,ItKe_Pass_MIS,1);
	Log_CreateTopic(Topic_MISOLDWORLD,LOG_MISSION);
	Log_SetTopicStatus(Topic_MISOLDWORLD,LOG_Running);
	B_LogEntry(Topic_MISOLDWORLD,"Lord Hagen wants me to bring him proof of the army of Evil. I'm going to head for the Valley of Mines and talk to Commander Garond there.");
	if((Fernando_Betrayal == FALSE) && (Fernando_ImKnast == FALSE))
	{
		B_StartOtherRoutine(Fernando,"WAIT");
	};
};


instance DIA_Addon_Lord_Hagen_Ornament(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 10;
	condition = DIA_Addon_Lord_Hagen_Ornament_Condition;
	information = DIA_Addon_Lord_Hagen_Ornament_Info;
	description = "I'm looking for a metal ornament.";
};


func int DIA_Addon_Lord_Hagen_Ornament_Condition()
{
	if((MIS_Addon_Cavalorn_GetOrnamentFromPAL == LOG_Running) && (Lord_Hagen_GotOrnament == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lord_Hagen_Ornament_Info()
{
	AI_Output (other, self, "DIA_Addon_Lord_Hagen_GiveOrnament_15_00");	//I am looking for a metal ornament. It should have been by the stone circle near Lobart's farm.
	AI_Output (self, other, "DIA_Addon_Lord_Hagen_GiveOrnament_04_01");	//If you mean this thing here ... we suspected that it might be a magical rune, but it turned out to be completely worthless.
	AI_Output (self, other, "DIA_Addon_Lord_Hagen_GiveOrnament_04_02");	//You can have it if you like. I have no use for it.
	CreateInvItems (self, ItMi_Ornament_Addon, 1);
	B_GiveInvItems (self, other, ItMi_Ornament_Addon, 1);
	Lord_Hagen_GotOrnament = TRUE;
	B_GivePlayerXP(XP_AmbientKap3);
};


instance DIA_Lord_Hagen_Khorinis(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 2;
	condition = DIA_Lord_Hagen_Khorinis_Condition;
	information = DIA_Lord_Hagen_Khorinis_Info;
	permanent = FALSE;
	description = "Why have you come to Khorinis?";
};


func int DIA_Lord_Hagen_Khorinis_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lord_Hagen_Armee) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_Khorinis_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_Khorinis_15_00");	//Why have you come to Khorinis?
	AI_Output (self, other, "DIA_Lord_Hagen_Khorinis_04_01");	//We are on an important mission for the kingdom. Our orders come directly from King Rhobar.
	AI_Output (self, other, "DIA_Lord_Hagen_Khorinis_04_02");	//I told you that we have sent an expedition to the Valley of Mines. That is the reason for our presence.
};


var int DIA_Lord_Hagen_Minental_noPerm;

instance DIA_Lord_Hagen_Minental(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 2;
	condition = DIA_Lord_Hagen_Minental_Condition;
	information = DIA_Lord_Hagen_Minental_Info;
	permanent = TRUE;
	description = "What are your men doing in the Valley of Mines?";
};


func int DIA_Lord_Hagen_Minental_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lord_Hagen_Khorinis) && (DIA_Lord_Hagen_Minental_noPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_Minental_Info()
{
	AI_Output(other,self,"DIA_Lord_Hagen_Minental_15_00");	//What are your men doing in the Valley of Mines?
	if((Hagen_BringProof == FALSE) && (other.guild != GIL_KDF))
	{
		AI_Output(self,other,"DIA_Lord_Hagen_Minental_04_01");	//I see no reason to reveal that to you!
	}
	else
	{
		if(other.guild != GIL_KDF)
		{
			if(Npc_KnowsInfo(other,DIA_Garond_NeedProof))
			{
				AI_Output(self,other,"DIA_Lord_Hagen_Minental_04_02");	//You were there. You should know.
			}
			else if(Hagen_BringProof == TRUE)
			{
				AI_Output(self,other,"DIA_Lord_Hagen_Minental_04_03");	//All right, since you are going there anyway, I might as well tell you.
			};
		};
		AI_Output (self, other, "DIA_Lord_Hagen_Minental_04_04");	//This is all about the magic ore. It can decide the outcome of the war.
		AI_Output (self, other, "DIA_Lord_Hagen_Minental_04_05");	//Without enough weapons made of magic ore, the king's army does not stand the slightest chance against the elite warriors of the orcs.
		if((other.guild != GIL_SLD) && (other.guild != GIL_DJG))
		{
			AI_Output (self, other, "DIA_Lord_Hagen_Minental_04_06");	//And the ore mines here on the island are the last to which we still have access.
		};
		AI_Output(self,other,"DIA_Lord_Hagen_Minental_04_07");	//As soon as our ship is fully laden with ore, we shall sail back to the mainland.
		AI_Output (other, self, "DIA_Lord_Hagen_Minental_15_08");	//The war against the orcs is going badly, then?
		AI_Output (self, other, "DIA_Lord_Hagen_Minental_04_09");	//I have already told you too much.
		KnowsPaladins_Ore = TRUE;
		DIA_Lord_Hagen_Minental_noPerm = TRUE;
	};
};


instance DIA_Hagen_CanTeach(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 5;
	condition = DIA_Hagen_CanTeach_Condition;
	information = DIA_Hagen_CanTeach_Info;
	permanent = TRUE;
	description = "I'm looking for a swordmaster.";
};


func int DIA_Hagen_CanTeach_Condition()
{
	if((LordHagen_Teach2H == FALSE) && (other.guild == GIL_PAL) && (other.HitChance[NPC_TALENT_2H] < TeachLimit_2H_Hagen))
	{
		return TRUE;
	};
};

func void DIA_Hagen_CanTeach_Info()
{
	AI_Output(other,self,"DIA_Hagen_CanTeach_15_00");	//I'm looking for a swordmaster.
	if(!TeacherCanTrainTalent(NPC_TALENT_2H,TeachCondition_2H_Hagen))
	{
		B_Say(self,other,"$NOLEARNNOPOINTS");
	}
	else
	{
		AI_Output(self,other,"DIA_Hagen_CanTeach_04_01");	//So? You have found one.
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_CityTeacher,"Lord Hagen can teach me to fight with two-handed weapons.");
		LordHagen_Teach2H = TRUE;
	};
};


var int DIA_Hagen_Teach_permanent;

func void B_BuildLearnDialog_Hagen()
{
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Hagen)
	{
		Info_ClearChoices(DIA_Hagen_Teach);
		Info_AddChoice(DIA_Hagen_Teach,Dialog_Back,DIA_Hagen_Teach_Back);
		Info_AddChoice(DIA_Hagen_Teach,B_BuildLearnString(PRINT_Learn2h1,B_GetLearnCostTalent(other,NPC_TALENT_2H,1)),DIA_Hagen_Teach_2H_1);
		Info_AddChoice(DIA_Hagen_Teach,B_BuildLearnString(PRINT_Learn2h5,B_GetLearnCostTalent(other,NPC_TALENT_2H,5)),DIA_Hagen_Teach_2H_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Hagen)
		{
			DIA_Hagen_Teach_permanent = TRUE;
		};
		PrintScreen(PRINT_NoLearnOverMAX,-1,53,FONT_Screen,2);
		B_Wulfgar_NoMoreTeach();
		AI_Output(self,other,"DIA_Hagen_Teach_04_01");	//May your future deeds be guided by the wisdom of a swordmaster.
		AI_StopProcessInfos(self);
	};
};

instance DIA_Hagen_Teach(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 100;
	condition = DIA_Hagen_Teach_Condition;
	information = DIA_Hagen_Teach_Info;
	permanent = TRUE;
	description = "Let us begin (learn two-handed combat).";
};


func int DIA_Hagen_Teach_Condition()
{
	if((LordHagen_Teach2H == TRUE) && (DIA_Hagen_Teach_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Hagen_Teach_Info()
{
	AI_Output(other,self,"DIA_Hagen_Teach_15_00");	//Let us begin.
	B_BuildLearnDialog_Hagen();
};

func void DIA_Hagen_Teach_Back()
{
	Info_ClearChoices(DIA_Hagen_Teach);
};

func void DIA_Hagen_Teach_2H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,1,TeachLimit_2H_Hagen))
	{
		B_BuildLearnDialog_Hagen();
	};
};

func void DIA_Hagen_Teach_2H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,5,TeachLimit_2H_Hagen))
	{
		B_BuildLearnDialog_Hagen();
	};
};

instance DIA_Lord_Hagen_Knight(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 990;
	condition = DIA_Lord_Hagen_Knight_Condition;
	information = DIA_Lord_Hagen_Knight_Info;
	permanent = TRUE;
	description = "I want to take up service with the order.";
};


func int DIA_Lord_Hagen_Knight_Condition()
{
	if(hero.guild == GIL_MIL)
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_Knight_Info()
{
	AI_Output(other,self,"DIA_Lord_Hagen_Knight_15_00");	//I want to take up service with the order.
	if((MIS_OLDWORLD == LOG_Running) && (KAPITEL == 3))
	{
		AI_Output(self,other,"DIA_Lord_Hagen_WhatProof_04_01");	//Your deeds will show whether you are worthy.
		AI_Output(self,other,"DIA_Lord_Hagen_BACKINTOWN_04_01");	//Our situation is worse than I had feared. But report to me on the situation in the Valley of Mines.
	}
	else if(MIS_RescueBennet == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Lord_Hagen_Knight_04_01");	//Good, you have proven that you have the courage, the skill and the knowledge to serve Innos.
		AI_Output (self, other, "DIA_Lord_Hagen_Knight_04_02");	//Your deeds bear witness to a pure heart.
		AI_Output (self, other, "DIA_Lord_Hagen_Knight_04_03");	//If it is your wish, then I shall bid you welcome to our order.
		Info_ClearChoices (DIA_Lord_Hagen_Knight);
		Info_AddChoice (DIA_Lord_Hagen_Knight, "I'm not quite sure yet.", DIA_Lord_Hagen_Knight_No);
		Info_AddChoice (DIA_Lord_Hagen_Knight, "I'm ready!", DIA_Lord_Hagen_Knight_Yes);
	}
	else
	{
		AI_Output (self, other, "DIA_Lord_Hagen_Knight_04_04");	//To be a warrior of Innos means to devote yourself entirely to the cause of Innos.
		AI_Output (self, other, "DIA_Lord_Hagen_Knight_04_05");	//Only the noblest and bravest warriors are accepted into our order.
		AI_Output (self, other, "DIA_Lord_Hagen_Knight_04_06");	//If you are truly determined to become a paladin, you must prove that you are worthy.
	};
	Hagen_GaveInfoKnight = TRUE;
};

func void DIA_Lord_Hagen_Knight_No()
{
	AI_Output (other, self, "DIA_Lord_Hagen_Knight_No_15_00");	//I'm not quite sure yet.
	AI_Output (self, other, "DIA_Lord_Hagen_Knight_No_04_01");	//Then go and free your heart of doubt. Return when you are prepared.
	Info_ClearChoices (DIA_Lord_Hagen_Knight);
};

func void DIA_Lord_Hagen_Knight_Yes()
{
	AI_Output (other, self, "DIA_Lord_Hagen_Knight_Yes_15_00");	//I am ready!
	AI_Output (self, other, "DIA_Lord_Hagen_Knight_Yes_04_01");	//(serious) Then so shall it be!
	AI_Output (self, other, "DIA_Lord_Hagen_Knight_Yes_04_02");	//(serious) Many men have taken this path and given their lives in the name of Innos.
	AI_Output (self, other, "DIA_Lord_Hagen_Knight_Yes_04_03");	//(serious) Do you swear that your deeds will honor their deaths and proclaim the fame of Innos?
	AI_Output (other, self, "DIA_Lord_Hagen_Knight_Yes_15_04");	//I swear!
	AI_Output (self, other, "DIA_Lord_Hagen_Knight_Yes_04_05");	//Then, from now on, you are a member of our fellowship.
	AI_Output (self, other, "DIA_Lord_Hagen_Knight_Yes_04_06");	//I hereby appoint you a warrior of Innos.
	AI_Output (self, other, "DIA_Lord_Hagen_Knight_Yes_04_07");	//I give to you the weapons and armor of a knight. Bear them with pride, knight!
	B_SetGuild(hero,GIL_PAL);
	if(Helmets_Enabled == TRUE)
	{
		B_GiveArmor(ITAR_PALN_M);
		CreateInvItem(hero,ITHE_PAL_M);
	}
	else
	{
		B_GiveArmor(ITAR_PAL_M);
	};
	if(other.HitChance[NPC_TALENT_2H] > other.HitChance[NPC_TALENT_1H])
	{
		CreateInvItems(self,ItMw_2h_Pal_Sword,1);
		B_GiveInvItems(self,other,ItMw_2h_Pal_Sword,1);
	}
	else
	{
		CreateInvItems(self,ItMw_1h_Pal_Sword,1);
		B_GiveInvItems(self,other,ItMw_1h_Pal_Sword,1);
	};
	Snd_Play("LEVELUP");
	AI_Output(self,other,"DIA_Lord_Hagen_Knight_Yes_04_08");	//Henceforth, by virtue of your rank, you shall have access to the monastery.
	if(!Npc_IsDead(Albrecht))
	{
		AI_Output(self,other,"DIA_Lord_Hagen_Knight_Yes_04_09");	//Albrecht will teach you our magic, just go and talk to him.
	};
	AI_Output(self,other,"DIA_Lord_Hagen_Add_04_02");	//And, of course, our quarters in the upper end of the city are now open to you.
	Info_ClearChoices(DIA_Lord_Hagen_Knight);
};


instance DIA_Lord_Hagen_WhatProof(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 991;
	condition = DIA_Lord_Hagen_WhatProof_Condition;
	information = DIA_Lord_Hagen_WhatProof_Info;
	permanent = FALSE;
	description = "How can I prove myself worthy?";
};


func int DIA_Lord_Hagen_WhatProof_Condition()
{
	if((Hagen_GaveInfoKnight == TRUE) && (MIS_RescueBennet != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_WhatProof_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_WhatProof_15_00");	//How can I prove myself worthy?
	AI_Output (self, other, "DIA_Lord_Hagen_WhatProof_04_01");	//Your deeds will show whether you are worthy.
	AI_Output (self, other, "DIA_Lord_Hagen_WhatProof_04_02");	//We fight for freedom and justice in the name of Innos.
	AI_Output (self, other, "DIA_Lord_Hagen_WhatProof_04_03");	//We fight against Beliar and his henchmen, who want to destroy the just order of Innos.
	AI_Output (other, self, "DIA_Lord_Hagen_WhatProof_15_04");	//I understand.
	AI_Output (self, other, "DIA_Lord_Hagen_WhatProof_04_05");	//You understand nothing at all! Our honor is our life and our life is Innos.
	AI_Output (self, other, "DIA_Lord_Hagen_WhatProof_04_06");	//A paladin goes to battle praising Innos, and many of us have lost their lives on the altar of the eternal strife between Good and Evil.
	AI_Output (self, other, "DIA_Lord_Hagen_WhatProof_04_07");	//Every single one of us has committed himself to this tradition. If we fail, we tarnish the deeds of our fallen comrades.
	AI_Output (self, other, "DIA_Lord_Hagen_WhatProof_04_08");	//Only he who truly understands this is worthy of being a paladin.
};


var int Hagen_KnowsEyeKaputt;

instance DIA_Lord_Hagen_KAP3U4_PERM(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 998;
	condition = DIA_Lord_Hagen_KAP3U4_PERM_Condition;
	information = DIA_Lord_Hagen_KAP3U4_PERM_Info;
	permanent = TRUE;
	description = "How are things?";
};


func int DIA_Lord_Hagen_KAP3U4_PERM_Condition()
{
	if(Kapitel == 3)
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_KAP3U4_PERM_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_KAP3U4_PERM_15_00");	//How's the situation?
	if (MIS_OLDWORLD == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Lord_Hagen_Add_04_04");	//I must find a way to rescue this expedition.
		AI_Output (self, other, "DIA_Lord_Hagen_Add_04_05");	//We must do something against the dragons.
		if (Hagen_KnowsEyeKaputt == FALSE)
		{
			AI_Output (self, other, "DIA_Lord_Hagen_Add_04_06");	//(to himself) Perhaps the Eye of Innos can save us all now ...
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Lord_Hagen_KAP3U4_PERM_04_01");	//I shall go mad here. I am a soldier, not a bureaucrat.
		AI_Output (self, other, "DIA_Lord_Hagen_KAP3U4_PERM_04_02");	//With all this paperwork that I must do, I barely remember what my sword feels like in my hand.
	};
};


instance DIA_Lord_Hagen_EyeBroken(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 1;
	condition = DIA_Lord_Hagen_EyeBroken_Condition;
	information = DIA_Lord_Hagen_EyeBroken_Info;
	permanent = FALSE;
	description = "I have the Eye - it is broken.";
};


func int DIA_Lord_Hagen_EyeBroken_Condition()
{
	if((Kapitel == 3) && (MIS_ReadyforChapter4 == FALSE) && (Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) || (MIS_SCKnowsInnosEyeIsBroken == TRUE)) && (MIS_Bennet_InnosEyeRepairedSetting != LOG_SUCCESS))
	{
		if(Npc_HasItems(other,ItMi_InnosEye_Broken_Mis))
		{
			DIA_Lord_Hagen_EyeBroken.description = "I have the Eye - it is broken.";
		}
		else
		{
			DIA_Lord_Hagen_EyeBroken.description = "The Eye of Innos is broken.";
		};
		return TRUE;
	};
};

func void DIA_Lord_Hagen_EyeBroken_Info()
{
	if(Npc_HasItems(other,ItMi_InnosEye_Broken_Mis))
	{
		AI_Output(other,self,"DIA_Lord_Hagen_Add_15_07");	//I have the Eye - it is broken.
	}
	else
	{
		DIA_Common_InnosEyeBroken();
	};
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_08");	//WHAT? By Innos! What have you done? We need the Eye!
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_09");	//Speak to Pyrokar! There must be a way to put it back together.
	Hagen_KnowsEyeKaputt = TRUE;
};


func void B_Hagen_GiveTeleportRune()
{
	AI_Output(self,other,"DIA_Lord_Hagen_Add_04_00");	//One more thing, before you go...
	AI_Output(self,other,"DIA_Lord_Hagen_Add_04_01");	//Take this rune as a token of my gratitude. It will take you safely back to the city whenever you want.
	B_GiveInvItems(self,other,ItRu_TeleportSeaport,1);
};

instance DIA_Lord_Hagen_BACKINTOWN(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 2;
	condition = DIA_Lord_Hagen_BACKINTOWN_Condition;
	information = DIA_Lord_Hagen_BACKINTOWN_Info;
	permanent = FALSE;
	description = "I bring you news from Garond.";
};


func int DIA_Lord_Hagen_BACKINTOWN_Condition()
{
	if((MIS_OLDWORLD == LOG_Running) && Npc_HasItems(other,ItWr_PaladinLetter_MIS) && (Kapitel == 3))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_BACKINTOWN_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_BACKINTOWN_15_00");	//I bring you news from Garond. Here, he gave me these lines for you.
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(other,self,ItWr_PaladinLetter_MIS,1);
	B_UseFakeScroll();
	AI_Output (self, other, "DIA_Lord_Hagen_BACKINTOWN_04_01");	//Our situation is worse than I had feared. But report to me on the situation in the Valley of Mines.
	AI_Output (other, self, "DIA_Lord_Hagen_BACKINTOWN_15_02");	//The paladins are holed up in the castle in the Valley of mines, surrounded by orcs.
	AI_Output (other, self, "DIA_Lord_Hagen_BACKINTOWN_15_03");	//There were many casualties in the prospecting operations, and there's barely any ore left.
	AI_Output (other, self, "DIA_Lord_Hagen_BACKINTOWN_15_04");	//Well, I should say that, without any help, the lads are lost. That's how it looks.
	AI_Output (self, other, "DIA_Lord_Hagen_BACKINTOWN_04_05");	//I shall find a way to rescue this expedition. You have done much for us. Innos will thank you ...
	AI_Output (other, self, "DIA_Lord_Hagen_BACKINTOWN_15_06");	//I'm not all that interested in his gratitude. I want his eye.
	if((other.guild != GIL_PAL) && (other.guild != GIL_KDF))
	{
		AI_Output(self,other,"DIA_Lord_Hagen_BACKINTOWN_04_07");	//Yes, of course. I stand by my word. Take this letter. It will open the monastery gates to you.
	};
	AI_Output(self,other,"DIA_Lord_Hagen_BACKINTOWN_04_08");	//Speak with Pyrokar, the highest Fire Magician, and show him this authorization. He will grant you access to the Eye of Innos.
	CreateInvItems(self,ItWr_PermissionToWearInnosEye_MIS,1);
	B_GiveInvItems(self,other,ItWr_PermissionToWearInnosEye_MIS,1);
	B_LogEntry(TOPIC_INNOSEYE,"Lord Hagen's given me a message. This will cause Master Pyrokar to hand me the Eye of Innos at the monastery.");
	if(MIS_RescueBennet != LOG_SUCCESS)
	{
		B_Hagen_GiveTeleportRune();
	};
	MIS_OLDWORLD = LOG_SUCCESS;
	B_CheckLog();
	Wld_InsertNpc(VLK_4250_Jorgen,"NW_MONASTERY_BRIDGE_01");
	Wld_InsertNpc(BDT_1050_Landstreicher,"NW_TROLLAREA_NOVCHASE_01");
	Wld_InsertNpc(BDT_1051_Wegelagerer,"NW_TROLLAREA_RITUALFOREST_09");
	Wld_InsertNpc(BDT_1052_Wegelagerer,"NW_TROLLAREA_RITUALFOREST_09");
	B_KillNpc(BDT_1020_Bandit_L);
	Wld_InsertNpc(DMT_1200_Dementor,"NW_TROLLAREA_RITUALPATH_01");
	Wld_InsertNpc(DMT_1202_Dementor,"NW_TROLLAREA_RITUAL_01");
	Wld_InsertNpc(DMT_1204_Dementor,"NW_TROLLAREA_RITUAL_03");
	Wld_InsertNpc(DMT_1206_Dementor,"NW_TROLLAREA_RITUAL_05");
	Wld_InsertNpc(DMT_1207_Dementor,"NW_TROLLAREA_RITUALPATH_01");
	Wld_InsertNpc(DMT_1209_Dementor,"NW_TROLLAREA_RITUALPATH_01");
	Wld_InsertNpc(DMT_1210_Dementor,"NW_TROLLAREA_RITUALPATH_01");
	Wld_InsertNpc(DMT_1211_Dementor,"NW_TROLLAREA_RITUALPATH_01");
	B_RemoveNpc(NOV_600_Pedro);
	B_StartOtherRoutine(MiltenNW,"START");
	Wld_InsertNpc(NOV_650_ToterNovize,"NW_TROLLAREA_RITUALPATH_01");
	B_KillNpc(NOV_650_ToterNovize);
	Wld_InsertNpc(NOV_651_ToterNovize,"NW_TROLLAREA_RITUALPATH_01");
	B_KillNpc(NOV_651_ToterNovize);
	Wld_InsertNpc(NOV_652_ToterNovize,"NW_TROLLAREA_RITUALPATH_01");
	B_KillNpc(NOV_652_ToterNovize);
	Wld_InsertNpc(NOV_653_ToterNovize,"NW_TROLLAREA_RITUALPATH_01");
	B_KillNpc(NOV_653_ToterNovize);
	Wld_InsertNpc(NOV_654_ToterNovize,"NW_TROLLAREA_RITUALPATH_01");
	B_KillNpc(NOV_654_ToterNovize);
	Wld_InsertNpc(NOV_655_ToterNovize,"NW_TROLLAREA_RITUALPATH_01");
	B_KillNpc(NOV_655_ToterNovize);
	Wld_InsertNpc(NOV_656_ToterNovize,"NW_TROLLAREA_RITUALPATH_01");
	B_KillNpc(NOV_656_ToterNovize);
	B_InitNpcGlobals();
	TEXT_Innoseye_Setting = TEXT_Innoseye_Setting_Broken;
	Wld_InsertItem(ItMi_InnosEye_Broken_Mis,"FP_TROLLAREA_RITUAL_ITEM");
};


var int Hagen_einmalBennet;

instance DIA_Lord_Hagen_RescueBennet(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 3;
	condition = DIA_Lord_Hagen_RescueBennet_Condition;
	information = DIA_Lord_Hagen_RescueBennet_Info;
	permanent = TRUE;
	description = "I need to talk to you about Bennet.";
};


func int DIA_Lord_Hagen_RescueBennet_Condition()
{
	if(MIS_RescueBennet == LOG_Running)
	{
		if((RescueBennet_KnowsCornelius == TRUE) && Npc_HasItems(other,ItWr_CorneliusTagebuch_Mis) && (Cornelius_IsLiar == TRUE))
		{
			return FALSE;
		}
		else
		{
			return TRUE;
		};
	};
};

func void DIA_Lord_Hagen_RescueBennet_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_RescueBennet_15_00");	//I need to talk to you about Bennet.
	if (Hagen_einmalBennet == FALSE)
	{
		AI_Output (self, other, "DIA_Lord_Hagen_RescueBennet_04_01");	//But that's the mercenary who murdered one of my men.
		Hagen_einmalBennet = TRUE;
	};
	Info_ClearChoices (DIA_Lord_Hagen_RescueBennet);
	Info_AddChoice (DIA_Lord_Hagen_RescueBennet, Dialog_Back, DIA_Lord_Hagen_RescueBennet_Back);
	Info_AddChoice (DIA_Lord_Hagen_RescueBennet, "How come you're so sure that Bennet is the killer?", DIA_Lord_Hagen_RescueBennet_WhySure);
	Info_AddChoice (DIA_Lord_Hagen_RescueBennet, "I believe that Bennet is innocent.", DIA_Lord_Hagen_RescueBennet_Innoscent);
	if ((MIS_RescueBennet == LOG_Running) && (MIS_RitualInnosEyeRepair == LOG_Running) && (Hagen_KnowsEyeKaputt == TRUE))
	{
		Info_AddChoice (DIA_Lord_Hagen_RescueBennet, "Bennet could help us to repair the Eye of Innos.", DIA_Lord_Hagen_RescueBennet_Hilfe);
	};
};

func void DIA_Lord_Hagen_RescueBennet_Hilfe()
{
	AI_Output (other, self, "DIA_Lord_Hagen_Add_15_16");	//Bennet could help us to repair the Eye of Innos.
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_17");	//Even if he could summon down the power of Innos himself to earth ...
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_18");	//He has murdered a paladin. He will be executed for that!
};

func void DIA_Lord_Hagen_RescueBennet_Back()
{
	Info_ClearChoices(DIA_Lord_Hagen_RescueBennet);
};

func void DIA_Lord_Hagen_RescueBennet_WhySure()
{
	AI_Output (other, self, "DIA_Lord_Hagen_RescueBennet_WhySure_15_00");	//How come you're so sure that Bennet is the killer?
	AI_Output (self, other, "DIA_Lord_Hagen_RescueBennet_WhySure_04_01");	//We have a witness.
	AI_Output (self, other, "DIA_Lord_Hagen_RescueBennet_WhySure_04_02");	//As you see, there is no doubt about the mercenary's guilt.
	AI_Output (other, self, "DIA_Lord_Hagen_RescueBennet_Witness_15_00");	//Who is that witness?
	AI_Output (self, other, "DIA_Lord_Hagen_RescueBennet_Witness_04_01");	//Cornelius, the governor's secretary, saw the murder.
	AI_Output (self, other, "DIA_Lord_Hagen_RescueBennet_Witness_04_02");	//His description fits Bennet, no doubt about that. As far as I am concerned, that settles the matter.
	AI_Output (self, other, "DIA_Lord_Hagen_RescueBennet_Witness_04_03");	//The mercenary will hang for treason.
	if(RescueBennet_KnowsCornelius == FALSE)
	{
		if(!Npc_IsDead(Cornelius))
		{
			Cornelius.guild = GIL_NONE;
			Cornelius.aivar[AIV_CommentedPlayerCrime] = FALSE;
		};
		B_LogEntry(TOPIC_RescueBennet,"Cornelius, the governor's secretary, is the witness. He claims to have witnessed the murder.");
		RescueBennet_KnowsCornelius = TRUE;
	};
};

func void DIA_Lord_Hagen_RescueBennet_Innoscent()
{
	AI_Output (other, self, "DIA_Lord_Hagen_RescueBennet_Innoscent_15_00");	//I believe that Bennet is innocent.
	AI_Output (self, other, "DIA_Lord_Hagen_RescueBennet_Innoscent_04_01");	//The evidence is clear. He is guilty.
	AI_Output (other, self, "DIA_Lord_Hagen_RescueBennet_Innoscent_15_02");	//So what if the proof is wrong?
	AI_Output (self, other, "DIA_Lord_Hagen_RescueBennet_Innoscent_04_03");	//Be careful what you say. You raise some serious accusations.
	AI_Output (self, other, "DIA_Lord_Hagen_RescueBennet_Innoscent_04_04");	//If you cannot present me with evidence that the witness lied, then you had best hold your tongue.
};


instance DIA_Lord_Hagen_Cornelius(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 3;
	condition = DIA_Lord_Hagen_Cornelius_Condition;
	information = DIA_Lord_Hagen_Cornelius_Info;
	permanent = TRUE;
	description = "Cornelius lied.";
};


func int DIA_Lord_Hagen_Cornelius_Condition()
{
	if((MIS_RescueBennet == LOG_Running) && (RescueBennet_KnowsCornelius == TRUE))
	{
		if(Npc_HasItems(other,ItWr_CorneliusTagebuch_Mis) && (Cornelius_IsLiar == TRUE))
		{
			return TRUE;
		};
	};
};

func void DIA_Lord_Hagen_Cornelius_Info()
{
	if(!Npc_IsDead(Cornelius) && (CorneliusFlee == FALSE))
	{
		AI_Teleport(Cornelius,"NW_CITY_HABOUR_KASERN_BORKA");
	};
	AI_Output (other, self, "DIA_Lord_Hagen_Cornelius_15_00");	//Cornelius lied.
	AI_Output (self, other, "DIA_Lord_Hagen_Cornelius_04_01");	//How do you know that?
	AI_Output (other, self, "DIA_Lord_Hagen_Cornelius_15_02");	//Here, I've got his diary. Everything's in there.
	B_GiveInvItems(other,self,ItWr_CorneliusTagebuch_Mis,1);
	B_UseOpenBook1();
	AI_Output (self, other, "DIA_Lord_Hagen_Cornelius_04_03");	//(furious) That slimy little criminal!
	AI_Output (self, other, "DIA_Lord_Hagen_Cornelius_04_04");	//In view of the new evidence, there is nothing else I can do.
	AI_Output (self, other, "DIA_Lord_Hagen_Cornelius_04_05");	//By virtue of the office granted me by king and church, I declare...
	AI_Output (self, other, "DIA_Lord_Hagen_Cornelius_04_06");	//...that the prisoner Bennet is exonerated of all charges and is thereby a free man.
	B_NpcSetReleased(Bennet);
	B_StartOtherRoutine(Bennet,"START");
	B_StartOtherRoutine(Hodges,"START");
	AI_Output(self,other,"DIA_Lord_Hagen_Cornelius_04_07");	//Cornelius is to be taken into immediate custody for perjury.
	if(Npc_IsDead(Cornelius))
	{
		AI_Output (other, self, "DIA_Lord_Hagen_Cornelius_15_08");	//Save yourself the trouble. Cornelius is dead.
		AI_Output (self, other, "DIA_Lord_Hagen_Cornelius_04_09");	//Then he has already received his just punishment. Well done.
	}
	else if(CorneliusFlee == TRUE)
	{
		AI_Output (other, self, "DIA_Lord_Hagen_Cornelius_15_10");	//He's made himself scarce.
		AI_Output (self, other, "DIA_Lord_Hagen_Cornelius_04_11");	//Sooner or later, he will turn up. Then we shall arrest him.
		B_StartOtherRoutine (Cornelius, "FLED");
	}
	else
	{
		B_NpcSetJailed(Cornelius);
		B_StartOtherRoutine(Cornelius,"PRISON");
	};
	MIS_RescueBennet = LOG_SUCCESS;
	B_GivePlayerXP(XP_RescueBennet);
	if(hero.guild == GIL_MIL)
	{
		AI_Output(self,other,"DIA_Lord_Hagen_Cornelius_04_12");	//Your deeds would redound to the honor of one of our own.
	};
	if(MIS_OLDWORLD != LOG_SUCCESS)
	{
		B_Hagen_GiveTeleportRune();
	};
};


instance DIA_Lord_Hagen_AugeAmStart(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 4;
	condition = DIA_Lord_Hagen_AugeAmStart_Condition;
	information = DIA_Lord_Hagen_AugeAmStart_Info;
	permanent = FALSE;
	description = "I carry the Eye!";
};


func int DIA_Lord_Hagen_AugeAmStart_Condition()
{
//	if((Kapitel <= 4) && (MIS_ReadyforChapter4 == TRUE) && (SC_IsWearingInnosEye == TRUE))
	if(SC_IsWearingInnosEye == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_AugeAmStart_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_Add_15_10");	//I carry the Eye!
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_11");	//(reverently) You bear the Eye!
	if (Hagen_KnowsEyeKaputt == TRUE)
	{
		AI_Output (self, other, "DIA_Lord_Hagen_Add_04_12");	//And you have put it back together!
	};
	AI_Output(self,other,"DIA_Lord_Hagen_Add_04_13");	//Then you are a Chosen of Innos!
	if(MIS_AllDragonsDead == FALSE)
	{
		AI_Output(other,self,"DIA_Lord_Hagen_Add_15_14");	//I shall set out and kill all the dragons in the Valley of Mines!
	};
	AI_Output(self,other,"DIA_Lord_Hagen_Add_04_15");	//Go with Innos and destroy Evil with his power!
};


var int Hagen_SawOrcRing;

instance DIA_Lord_Hagen_ANTIPALADINE(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 3;
	condition = DIA_Lord_Hagen_ANTIPALADINE_Condition;
	information = DIA_Lord_Hagen_ANTIPALADINE_Info;
	permanent = TRUE;
	description = "The orcs' elite warriors are attacking the land.";
};


func int DIA_Lord_Hagen_ANTIPALADINE_Condition()
{
	if(((TalkedTo_AntiPaladin == TRUE) || Npc_HasItems(other,ItRi_OrcEliteRing)) && (Hagen_SawOrcRing == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_ANTIPALADINE_Info()
{
	AI_Output(other,self,"DIA_Lord_Hagen_ANTIPALADINE_15_00");	//The orcs' elite warriors are attacking the land.
	if(hero.guild == GIL_PAL)
	{
		Log_CreateTopic(TOPIC_OrcElite,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_OrcElite,LOG_Running);
		B_LogEntry(TOPIC_OrcElite,"I told Lord Hagen about the advancing hordes of orcish warlords.");
		if((TalkedTo_AntiPaladin == TRUE) && (MIS_KillOrkOberst == FALSE))
		{
			AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_01");	//What makes you say that?
			AI_Output (other, self, "DIA_Lord_Hagen_ANTIPALADINE_15_02");	//I talked to one of them. Your name was mentioned.
		};
	AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_03");	//Nonsense. My people have not reported a massive invasion of orcs so far.
	AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_04");	//Perhaps some of their scouts got lost in the nearby woods.
		if(Npc_HasItems(other,ItRi_OrcEliteRing))
		{
			AI_Output(other,self,"DIA_Lord_Hagen_ANTIPALADINE_15_05");	//Those were no scouts. I took this ring from one of them.
			AI_Output(self,other,"DIA_Lord_Hagen_ANTIPALADINE_04_06");	//Show me.
			B_GiveInvItems(other,self,ItRi_OrcEliteRing,1);
		AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_07");	//Mmh. That is certainly disturbing.
		AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_08");	//That is a sign of their strength. So the orcs have left their palisades and are fighting on the open field.
		AI_Output (other, self, "DIA_Lord_Hagen_ANTIPALADINE_15_09");	//I haven't seen a whole lot so far. Mainly their warlords, and only a few fighters.
		AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_10");	//So? Then they must be plotting something else. That is rather unlike orcs that their leaders should leave their protective palisades by themselves.
		AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_11");	//It would be a good opportunity, however, to deliver them a telling blow.
		AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_12");	//If they lose their leaders, their morale will sink as well.
		AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_13");	//You have a new assignment, knight. Go and kill the orc leaders you can find here in the area.
		AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_14");	//Bring me their rings. That will be a tough blow to the orcs.
		B_LogEntry (TOPIC_OrcElite, "I was able to bring Hagen a ring of the orcish warlord as proof. He wants me to bring all the ones to him I can find.");
			if(!Npc_IsDead(Ingmar) && (MIS_KillOrkOberst == FALSE))
			{
					AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_15");	//Ask Ingmar about this. He can give you a few tactical hints for fighting the orc leaders.
					AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_16");	//The orcs' elite warriors are his specialty. He has often had to deal with them.
				Log_AddEntry(TOPIC_OrcElite,"The orcish elite warriors are Ingmar's specialty.");
			};
			Hagen_SawOrcRing = TRUE;
			B_GivePlayerXP(XP_PAL_OrcRing);
		}
		else
		{
			if(MIS_KillOrkOberst == LOG_SUCCESS)
			{
				AI_Output(self,other,"DIA_Lord_Hagen_ANTIPALADINE_04_17");	//Your word alone that you have killed the chief warlord of the orcs is not enough for me.
			};
			AI_Output(self,other,"DIA_Lord_Hagen_ANTIPALADINE_04_18");	//I need more tangible evidence if I am to respond to this.
			B_LogEntry(TOPIC_OrcElite,"Hagen is unwilling to believe me. He demands evidence that the elite warriors are attacking the civilized lands. Well, it would have surprised me if he hadn't.");
		};
	}
	else
	{
		AI_Output(self,other,"DIA_Lord_Hagen_ANTIPALADINE_04_03");	//Nonsense. My people have not reported a massive invasion of orcs so far.
		AI_Output(self,other,"DIA_Lord_Hagen_ANTIPALADINE_04_04");	//Perhaps some of their scouts got lost in the nearby woods.
		AI_Output (other, self, "DIA_Lord_Hagen_ANTIPALADINE_15_05");	//Those were no scouts. I took this ring from one of them.
		AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_06");	//Show me.
		AI_PrintScreen("Given: Ring",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
		AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_07");	//Mmh. That is certainly disturbing.
		AI_Output (self, other, "DIA_Lord_Hagen_ANTIPALADINE_04_08");	//That is a sign of their strength. So the orcs have left their palisades and are fighting on the open field.
		AI_Output(self,other,"DIA_Lord_Hagen_ANTIPALADINE_04_11");	//It would be a good opportunity, however, to deliver them a telling blow.
		AI_PrintScreen("Received: Ring",-1,YPOS_ItemTaken,FONT_ScreenSmall,2);
		Hagen_SawOrcRing = TRUE;
		B_GivePlayerXP(XP_PAL_OrcRing);
	};
};


func void DIA_Hagen_MoreOrcRings()
{
	AI_Output(other,self,"DIA_Lord_Hagen_RINGEBRINGEN_15_03");	//I can give you some more orc rings.
};

var int OrkRingCounter;

instance DIA_Lord_Hagen_RINGEBRINGEN(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 5;
	condition = DIA_Lord_Hagen_RINGEBRINGEN_Condition;
	information = DIA_Lord_Hagen_RINGEBRINGEN_Info;
	permanent = TRUE;
	description = "There's something else I have to report about the orcish warlords.";
};


func int DIA_Lord_Hagen_RINGEBRINGEN_Condition()
{
	if((Hagen_SawOrcRing == TRUE) && Npc_HasItems(other,ItRi_OrcEliteRing) && (hero.guild == GIL_PAL))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_RINGEBRINGEN_Info()
{
	var int Ringcount;
	var int XP_PAL_OrcRings;
	var int OrcRingGeld;
	var int HagensRingOffer;
	AI_Output (other, self, "DIA_Lord_Hagen_RINGEBRINGEN_15_00");	//There's something else I have to report about the orcish warlords.
	AI_Output (self, other, "DIA_Lord_Hagen_RINGEBRINGEN_04_01");	//Then tell me.
	HagensRingOffer = 150;
	Ringcount = Npc_HasItems(other,ItRi_OrcEliteRing);
	if(Ringcount == 1)
	{
		AI_Output(other,self,"DIA_Lord_Hagen_RINGEBRINGEN_15_02");	//I can give you another orc ring.
		B_GiveInvItems(other,self,ItRi_OrcEliteRing,1);
		OrkRingCounter += 1;
		B_GivePlayerXP(XP_PAL_OrcRing);
	}
	else
	{
		DIA_Hagen_MoreOrcRings();
		B_GiveInvItems(other,self,ItRi_OrcEliteRing,Ringcount);
		XP_PAL_OrcRings = Ringcount * XP_PAL_OrcRing;
		OrkRingCounter += Ringcount;
		B_GivePlayerXP(XP_PAL_OrcRings);
	};
	AI_Output (self, other, "DIA_Lord_Hagen_RINGEBRINGEN_04_04");	//I am proud of you. Carry on!
	if (OrkRingCounter <= 10)
	{
		AI_Output (self, other, "DIA_Lord_Hagen_RINGEBRINGEN_04_05");	//There may still be a few of them out there.
	}
	else if(OrkRingCounter <= 20)
	{
		AI_Output (self, other, "DIA_Lord_Hagen_RINGEBRINGEN_04_06");	//Soon we shall have forced them to their knees.
	}
	else
	{
		AI_Output (self, other, "DIA_Lord_Hagen_RINGEBRINGEN_04_07");	//I would be amazed if you still found very many of them.
		AI_Output (self, other, "DIA_Lord_Hagen_RINGEBRINGEN_04_08");	//You are welcome to keep bringing me their rings, but I think the orcs have gotten the message now.
		TOPIC_END_OrcElite = TRUE;
		B_CheckLog();
	};
	AI_Output (self, other, "DIA_Lord_Hagen_RINGEBRINGEN_04_09");	//Here. Let me give you some gold towards your equipment.
	OrcRingGeld = Ringcount * HagensRingOffer;
	CreateInvItems(self,ItMi_Gold,OrcRingGeld);
	B_GiveInvItems(self,other,ItMi_Gold,OrcRingGeld);
};


instance DIA_Lord_Hagen_AllDragonsDead(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 4;
	condition = DIA_Lord_Hagen_AllDragonsDead_Condition;
	information = DIA_Lord_Hagen_AllDragonsDead_Info;
	permanent = FALSE;
	description = "The dragons are dead.";
};


func int DIA_Lord_Hagen_AllDragonsDead_Condition()
{
	if(Kapitel == 5)
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_AllDragonsDead_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_AllDragonsDead_15_00");	//The dragons are dead.
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_19");	//I knew that Innos would give you the strength to defeat the dragons!
	AI_Output (self, other, "DIA_Lord_Hagen_AllDragonsDead_04_02");	//Where is the ore?
	AI_Output (other, self, "DIA_Lord_Hagen_AllDragonsDead_15_03");	//The orcs are still besieging the castle in the Valley of Mines. Garond stands no chance of leaving the castle before the siege is ended.
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_20");	//(furious) Damnit!
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_21");	//If Garond isn't capable of handling the situation, then I shall have to see to it myself.
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_22");	//A few orcs won't stop me! Not me!
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_23");	//I have already informed my men. We are preparing for departure.
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_24");	//We shall ALL go. I shall leave only a minimal guard on the ship.
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_25");	//That should be enough then to finally put an end to the orcs!
	MIS_SCvisitShip = LOG_Running;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"ShipFree");
};


instance DIA_Lord_Hagen_NeedShip(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 4;
	condition = DIA_Lord_Hagen_NeedShip_Condition;
	information = DIA_Lord_Hagen_NeedShip_Info;
	permanent = FALSE;
	description = "I need a ship.";
};


func int DIA_Lord_Hagen_NeedShip_Condition()
{
	if(MIS_SCKnowsWayToIrdorath == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_NeedShip_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_NeedShip_15_00");	//I need a ship.
	if (hero.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_Lord_Hagen_NeedShip_04_01");	//So do a lot of people, soldier.
	}
	else if(hero.guild == GIL_KDF)
	{
		AI_Output (self, other, "DIA_Lord_Hagen_NeedShip_04_02");	//(laughs) I hear that almost every day, reverend. But ...
	};
	AI_Output(self,other,"DIA_Lord_Hagen_NeedShip_04_03");	//You do not even have a captain, to say nothing of a crew.
	if((SCGotCaptain == TRUE) && (Crewmember_Count >= Min_Crew))
	{
		AI_Output(other,self,"DIA_Hanna_AnyNews_Yes_15_00");	//Yeah, sure I do.
	};
	AI_Output(other,self,"DIA_Lord_Hagen_NeedShip_15_04");	//What about the ship in the harbor?
	AI_Output (self, other, "DIA_Lord_Hagen_NeedShip_04_05");	//It belongs to me, and that's that. We shall transport the ore with this ship.
	AI_Output (self, other, "DIA_Lord_Hagen_NeedShip_04_06");	//Once that is done, then you can ask me again.
};


instance DIA_Lord_Hagen_GateOpen(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 5;
	condition = DIA_Lord_Hagen_GateOpen_Condition;
	information = DIA_Lord_Hagen_GateOpen_Info;
	permanent = FALSE;
	description = "The orcs have stormed the castle in the Valley of Mines!";
};


func int DIA_Lord_Hagen_GateOpen_Condition()
{
	if((MIS_OCGateOpen == TRUE) && Npc_KnowsInfo(other,DIA_Lord_Hagen_AllDragonsDead))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_GateOpen_Info()
{
	AI_Output (other, self, "DIA_Lord_Hagen_Add_15_29");	//The orcs have stormed the castle in the Valley of Mines!
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_30");	//By Innos! What exactly happened there?
	AI_Output (other, self, "DIA_Lord_Hagen_Add_15_31");	//Somehow the gate must have opened ...
	AI_Output (self, other, "DIA_Lord_Hagen_Add_04_32");	//Somehow?! How is that possible... There must have been a traitor in the castle!
	B_StartOtherRoutine(Schiffswache_212,"ShipFree");
	B_StartOtherRoutine(Schiffswache_213,"ShipFree");
	B_StartOtherRoutine(Girion,"WaitForShip");
	MIS_ShipIsFree = TRUE;
	B_CheckLog();
};


instance DIA_Lord_Hagen_Perm5(C_Info)
{
	npc = PAL_200_Hagen;
	nr = 5;
	condition = DIA_Lord_Hagen_Perm5_Condition;
	information = DIA_Lord_Hagen_Perm5_Info;
	permanent = TRUE;
	description = "What are you waiting for?";
};


func int DIA_Lord_Hagen_Perm5_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lord_Hagen_AllDragonsDead))
	{
		return TRUE;
	};
};

func void DIA_Lord_Hagen_Perm5_Info()
{
	AI_Output(other,self,"DIA_Lord_Hagen_Add_15_33");	//What are you waiting for?
	if(!Npc_KnowsInfo(other,DIA_Lord_Hagen_GateOpen))
	{
		AI_Output (self, other, "DIA_Lord_Hagen_Add_04_26");	//We are still waiting for our equipment and provisions. Then we set off!
	}
	else
	{
		AI_Output (self, other, "DIA_Lord_Hagen_Add_04_27");	//Now that the castle has been stormed, we need even more provisions.
		AI_Output (self, other, "DIA_Lord_Hagen_Add_04_28");	//But that will not delay our departure for long.
	};
};

