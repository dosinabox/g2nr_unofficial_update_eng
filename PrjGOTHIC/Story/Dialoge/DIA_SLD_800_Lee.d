
var int Lee_Teleport;

func void B_Lee_Teleport()
{
	if((Lee_Teleport == FALSE) && (Kapitel >= 3))
	{
		AI_Output (self, other, "DIA_Lee_Add_04_05");	//Ah. It's good that you've come.
		AI_Output (other, self, "DIA_Lee_Add_15_06");	//What's up?
		AI_Output (self, other, "DIA_Lee_Add_04_07");	//I found this in the old chapel.
		B_GiveInvItems(self,other,ItRu_TeleportFarm,1);
		AI_Output (self, other, "DIA_Lee_Add_04_08");	//It's a magic rune. I think it will teleport you straight back here to the farm.
		AI_Output (self, other, "DIA_Lee_Add_04_09");	//I thought you might be able to use it.
		Lee_Teleport = TRUE;
	};
};

var int Lee_Sends_To_Buster;

func void B_Lee_Sends_To_Buster()
{
	if((Kapitel >= 3) && (Kapitel < 5) && (Lee_Sends_To_Buster == FALSE) && !Npc_IsDead(Buster) && !Npc_KnowsInfo(other,DIA_Buster_SHADOWBEASTS) && ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG)))
	{
		AI_Output(self,other,"DIA_Lee_DoAboutBennet_04_07");	//Oh, yes. Before I forget ... Buster wants to talk to you. He wouldn't tell me what it was about. Maybe you should go see him!
		Lee_Sends_To_Buster = TRUE;
	};
};

instance DIA_Lee_EXIT(C_Info)
{
	npc = SLD_800_Lee;
	nr = 999;
	condition = DIA_Lee_EXIT_Condition;
	information = DIA_Lee_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Lee_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Lee_EXIT_Info()
{
	B_Lee_Teleport();
	B_Lee_Sends_To_Buster();
	AI_StopProcessInfos(self);
};


var int Lee_LastPetzCounter;
var int Lee_LastPetzCrime;

instance DIA_Lee_PMSchulden(C_Info)
{
	npc = SLD_800_Lee;
	nr = 1;
	condition = DIA_Lee_PMSchulden_Condition;
	information = DIA_Lee_PMSchulden_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Lee_PMSchulden_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Lee_Schulden > 0) && (B_GetGreatestPetzCrime(self) <= Lee_LastPetzCrime))
	{
		return TRUE;
	};
};

func void DIA_Lee_PMSchulden_Info()
{
	var int diff;
	AI_Output(self,other,"DIA_Lee_PMSchulden_04_00");	//Are you here to bring the money for Onar?
	if(B_GetTotalPetzCounter(self) > Lee_LastPetzCounter)
	{
		AI_Output(self,other,"DIA_Lee_PMSchulden_04_01");	//I already told you not to do anything stupid here.
		AI_Output(self,other,"DIA_Lee_PMSchulden_04_02");	//Onar has heard that you've earned yourself quite a record in the meanwhile.
		if(Lee_Schulden < 1000)
		{
			AI_Output (self, other, "DIA_Lee_PMSchulden_04_03");	//Accordingly, he wants more money now.
			AI_Output (other, self, "DIA_Lee_PMAdd_15_00");	//How much?
			diff = B_GetTotalPetzCounter (self) - Lee_LastPetzCounter;
			if (diff > 0)
			{
				Lee_Schulden += diff * 50;
			};
			if(Lee_Schulden > 1000)
			{
				Lee_Schulden = 1000;
			};
			B_Say_Gold(self,other,Lee_Schulden);
		}
		else
		{
			AI_Output (self, other, "DIA_Lee_PMSchulden_04_04");	//I thought you were smarter than that.
		};
	}
	else if(B_GetGreatestPetzCrime(self) < Lee_LastPetzCrime)
	{
		AI_Output (self, other, "DIA_Lee_PMSchulden_04_05");	//Then I have good news for you.
		if (Lee_LastPetzCrime == CRIME_MURDER)
		{
			AI_Output (self, other, "DIA_Lee_PMSchulden_04_06");	//Suddenly, there is no one left who saw you commit murder.
		};
		if((Lee_LastPetzCrime == CRIME_THEFT) || ((Lee_LastPetzCrime > CRIME_THEFT) && (B_GetGreatestPetzCrime(self) < CRIME_THEFT)))
		{
			AI_Output (self, other, "DIA_Lee_PMSchulden_04_07");	//None of the people will now testify that they saw you stealing.
		};
		if((Lee_LastPetzCrime == CRIME_ATTACK) || ((Lee_LastPetzCrime > CRIME_ATTACK) && (B_GetGreatestPetzCrime(self) < CRIME_ATTACK)))
		{
			AI_Output (self, other, "DIA_Lee_PMSchulden_04_08");	//There is no one left who SAW how you beat up one of the farmers.
		};
		if(B_GetGreatestPetzCrime(self) == CRIME_NONE)
		{
			AI_Output (self, other, "DIA_Lee_PMSchulden_04_09");	//Apparently, all the charges against you have dissolved into thin air.
		};
		AI_Output (self, other, "DIA_Lee_PMSchulden_04_10");	//That's one way of getting around problems like that.
		if (B_GetGreatestPetzCrime (self) == CRIME_NONE)
		{
			AI_Output (self, other, "DIA_Lee_PMSchulden_04_11");	//In any case, you no longer have to pay.
			AI_Output (self, other, "DIA_Lee_PMSchulden_04_12");	//But mind your step in future.
			Lee_Schulden = 0;
			Lee_LastPetzCounter = 0;
			Lee_LastPetzCrime = CRIME_NONE;
		}
		else
		{
			AI_Output (self, other, "DIA_Lee_PMSchulden_04_13");	//One thing is clear: You must, nevertheless, pay your fines in full.
			B_Say_Gold (self, other, Lee_Schulden);
			AI_Output (self, other, "DIA_Lee_PMSchulden_04_14");	//So, what about it?
		};
	};
	if(B_GetGreatestPetzCrime(self) != CRIME_NONE)
	{
		Info_ClearChoices (DIA_Lee_PMSchulden);
		Info_ClearChoices (DIA_Lee_PETZMASTER);
		Info_AddChoice (DIA_Lee_PMSchulden, "I haven't got enough gold!", DIA_Lee_PETZMASTER_PayLater);
		Info_AddChoice (DIA_Lee_PMSchulden, "How much was that again?", DIA_Lee_PMSchulden_HowMuchAgain);
		if (Npc_HasItems (other, ItMi_Gold) >= Lee_Schulden)
		{
			Info_AddChoice (DIA_Lee_PMSchulden, "I want to pay the penalty!", DIA_Lee_PETZMASTER_PayNow);
		};
	};
};

func void DIA_Lee_PMSchulden_HowMuchAgain()
{
	AI_Output (other, self, "DIA_Lee_PMSchulden_HowMuchAgain_15_00");	//How much was that again?
	B_Say_Gold (self, other, Lee_Schulden);
	Info_ClearChoices (DIA_Lee_PMSchulden);
	Info_ClearChoices (DIA_Lee_PETZMASTER);
	Info_AddChoice (DIA_Lee_PMSchulden, "I haven't got enough gold!", DIA_Lee_PETZMASTER_PayLater);
	Info_AddChoice (DIA_Lee_PMSchulden, "How much was that again?", DIA_Lee_PMSchulden_HowMuchAgain);
	if (Npc_HasItems (other, ItMi_Gold) >= Lee_Schulden)
	{
		Info_AddChoice (DIA_Lee_PMSchulden, "I want to pay the penalty!", DIA_Lee_PETZMASTER_PayNow);
	};
};


instance DIA_Lee_PETZMASTER(C_Info)
{
	npc = SLD_800_Lee;
	nr = 1;
	condition = DIA_Lee_PETZMASTER_Condition;
	information = DIA_Lee_PETZMASTER_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Lee_PETZMASTER_Condition()
{
	if(B_GetGreatestPetzCrime(self) > Lee_LastPetzCrime)
	{
		return TRUE;
	};
};

func void DIA_Lee_PETZMASTER_Info()
{
	Lee_Schulden = 0;
	if(self.aivar[AIV_TalkedToPlayer] == FALSE)
	{
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_00");	//Who the devil let YOU in here - (surprised) - YOU are the new fellow who has been causing trouble?
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_01");	//I had heard from Gorn that you were still alive, but that you would come here ... anyway ...
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_MURDER)
	{
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_02");	//It is good that you have come to me before everything becomes even worse for you.
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_03");	//The mercenaries are tough lads and the farmers here aren't exactly squeamish, but you can't just go around killing people.
		Lee_Schulden = B_GetTotalPetzCounter(self) * 50 + 500;
		if((PETZCOUNTER_Farm_Theft + PETZCOUNTER_Farm_Attack + PETZCOUNTER_Farm_Sheepkiller) > 0)
		{
			AI_Output (self, other, "DIA_Lee_PETZMASTER_04_04");	//To say nothing of the other mischief you've done here.
		};
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_05");	//I can help you get out of this mess with a clean slate.
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_06");	//It's gonna cost you, though. Onar is a greedy man, and only if HE turns a blind eye will the matter be forgotten.
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_THEFT)
	{
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_07");	//It's a good thing you've come. I have heard that you stole something here.
		if (PETZCOUNTER_Farm_Attack > 0)
		{
			AI_Output (self, other, "DIA_Lee_PETZMASTER_04_08");	//And knocked the farmers around.
		};
		if(PETZCOUNTER_Farm_Sheepkiller > 0)
		{
			AI_Output (self, other, "DIA_Lee_PETZMASTER_04_09");	//AND killed a few sheep.
		};
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_10");	//You just can't pull that kind of thing around here. In such cases, Onar insists that I bring the culprit to account.
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_11");	//That means: you pay, and he pockets the cash - but then at least the matter is forgotten.
		Lee_Schulden = B_GetTotalPetzCounter (self) * 50;
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_ATTACK)
	{
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_12");	//If you get involved in a duel with the mercenaries, that's one thing ...
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_13");	//But if you beat up a farmer, they run straight to Onar. And he expects me to do something.
		if (PETZCOUNTER_Farm_Sheepkiller > 0)
		{
			AI_Output (self, other, "DIA_Lee_PETZMASTER_04_14");	//Not to mention that he isn't exactly thrilled when someone kills his sheep.
		};
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_15");	//You'll have to pay a penalty. Onar pockets the money himself as a rule - but it's the only way to settle the matter.
		Lee_Schulden = B_GetTotalPetzCounter (self) * 50;
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_SHEEPKILLER)
	{
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_16");	//Onar expects me to protect his farm. And that includes his sheep.
		AI_Output (self, other, "DIA_Lee_PETZMASTER_04_17");	//You will have to pay him compensation!
		Lee_Schulden = 100;
	};
	AI_Output (other, self, "DIA_Lee_PETZMASTER_15_18");	//How much?
	if (Lee_Schulden > 1000)
	{
		Lee_Schulden = 1000;
	};
	B_Say_Gold (self, other, Lee_Schulden);
	Info_ClearChoices (DIA_Lee_PMSchulden);
	Info_ClearChoices (DIA_Lee_PETZMASTER);
	Info_AddChoice (DIA_Lee_PETZMASTER, "I haven't got enough gold!", DIA_Lee_PETZMASTER_PayLater);
	if (Npc_HasItems (other, ItMi_Gold) >= Lee_Schulden)
	{
		Info_AddChoice (DIA_Lee_PETZMASTER, "I want to pay the penalty!", DIA_Lee_PETZMASTER_PayNow);
	};
};

func void DIA_Lee_PETZMASTER_PayNow()
{
	AI_Output (other, self, "DIA_Lee_PETZMASTER_PayNow_15_00");	//I want to pay the penalty!
	B_GiveInvItems (other, self, ItMi_Gold, Lee_Schulden);
	AI_Output (self, other, "DIA_Lee_PETZMASTER_PayNow_04_01");	//Good! I'll see to it that Onar gets the money. You can consider the matter forgotten.
	B_GrantAbsolution (LOC_FARM);
	Lee_Schulden = 0;
	Lee_LastPetzCounter = 0;
	Lee_LastPetzCrime = CRIME_NONE;
	Info_ClearChoices(DIA_Lee_PETZMASTER);
	Info_ClearChoices(DIA_Lee_PMSchulden);
};

func void DIA_Lee_PETZMASTER_PayLater()
{
	AI_Output (other, self, "DIA_Lee_PETZMASTER_PayLater_15_00");	//I don't have enough gold!
	AI_Output (self, other, "DIA_Lee_PETZMASTER_PayLater_04_01");	//Then go get it as soon as possible.
	AI_Output (self, other, "DIA_Lee_PETZMASTER_PayLater_04_02");	//But just don't think you can steal it here on the farm. If you get caught, things will be even worse for you.
	Lee_LastPetzCounter = B_GetTotalPetzCounter (self);
	Lee_LastPetzCrime = B_GetGreatestPetzCrime (self);
	AI_StopProcessInfos (self);
};


instance DIA_Lee_Hallo(C_Info)
{
	npc = SLD_800_Lee;
	nr = 1;
	condition = DIA_Lee_Hallo_Condition;
	information = DIA_Lee_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Lee_Hallo_Condition()
{
	if(self.aivar[AIV_TalkedToPlayer] == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Lee_Hallo_Info()
{
	AI_Output (self, other, "DIA_Lee_Hallo_04_00");	//Who the devil let YOU in here - (surprised) - What are you doing here? I thought you were dead!
	AI_Output (other, self, "DIA_Lee_Hallo_15_01");	//What makes you think that?
	AI_Output (self, other, "DIA_Lee_Hallo_04_02");	//Gorn told me that it was you who brought down the Barrier.
	AI_Output (other, self, "DIA_Lee_Hallo_15_03");	//Yes, that was me all right.
	AI_Output (self, other, "DIA_Lee_Hallo_04_04");	//I never would have thought that a man could survive something like that. What brings you here? You aren't here without a reason ...
};


instance DIA_Lee_Paladine(C_Info)
{
	npc = SLD_800_Lee;
	nr = 2;
	condition = DIA_Lee_Paladine_Condition;
	information = DIA_Lee_Paladine_Info;
	permanent = FALSE;
	description = "I absolutely must talk to the paladins in town ...";
};


func int DIA_Lee_Paladine_Condition()
{
	if(other.guild == GIL_NONE)
	{
		return TRUE;
	};
};

func void DIA_Lee_Paladine_Info()
{
	AI_Output (other, self, "DIA_Lee_Paladine_15_00");	//I absolutely must talk to the paladins in town. Can you help me get to them?
	AI_Output (self, other, "DIA_Lee_Paladine_04_01");	//(distrustful) What's your business with the paladins?
	AI_Output (other, self, "DIA_Lee_Paladine_15_02");	//That's a long story ...
	AI_Output (self, other, "DIA_Lee_Paladine_04_03");	//I've got time.
	AI_Output (other, self, "DIA_Lee_Paladine_15_04");	//(sighs) Xardas sent me on a mission. He wants me to obtain  a powerful amulet, the Eye of Innos.
	AI_Output (self, other, "DIA_Lee_Paladine_04_05");	//So you're still allied with that necromancer. I see. And the paladins have this amulet?
	AI_Output (other, self, "DIA_Lee_Paladine_15_06");	//As far as I know - yes.
	AI_Output (self, other, "DIA_Lee_Paladine_04_07");	//I can help you get to the paladins. But first you need to become one of us.
};


instance DIA_Lee_PaladineHOW(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_PaladineHOW_Condition;
	information = DIA_Lee_PaladineHOW_Info;
	permanent = FALSE;
	description = "How can you help me get to the paladins?";
};


func int DIA_Lee_PaladineHOW_Condition()
{
	if((other.guild == GIL_NONE) && Npc_KnowsInfo(other,DIA_Lee_Paladine))
	{
		if(GuildlessMode == FALSE)
		{
			return TRUE;
		};
	};
};

func void DIA_Lee_PaladineHOW_Info()
{
	AI_Output (other, self, "DIA_Lee_PaladineHOW_15_00");	//How can you help me get to the paladins?
	AI_Output (self, other, "DIA_Lee_PaladineHOW_04_01");	//Trust me. I've got a plan. I think you're the right man for it ...
	AI_Output (self, other, "DIA_Lee_PaladineHOW_04_02");	//I'll take you to the paladins and you'll do me a favor. But first, join us!
};


instance DIA_Lee_LeesPlan(C_Info)
{
	npc = SLD_800_Lee;
	nr = 4;
	condition = DIA_Lee_LeesPlan_Condition;
	information = DIA_Lee_LeesPlan_Info;
	permanent = FALSE;
	description = "What exactly are you doing here?";
};


func int DIA_Lee_LeesPlan_Condition()
{
	if(Lee_IsOnBoard == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Lee_LeesPlan_Info()
{
	AI_Output (other, self, "DIA_Lee_LeesPlan_15_00");	//What exactly are you doing here?
	AI_Output (self, other, "DIA_Lee_LeesPlan_04_01");	//Quite simple: I'm gonna see to it that we all get off this island.
	if(MIS_Lee_Friedensangebot != LOG_SUCCESS)
	{
	AI_Output (self, other, "DIA_Lee_LeesPlan_04_02");	//Onar hired us to defend his farm, and that's exactly what we're gonna do.
	AI_Output (self, other, "DIA_Lee_LeesPlan_04_03");	//But our reward is more than just our pay. By helping the farmers, we cut the city off from its provisions.
	AI_Output (self, other, "DIA_Lee_LeesPlan_04_04");	//And the less the paladins have to eat, the sooner they'll listen when I finally make them an offer of peace.
		if((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL))
		{
			AI_Output(self,other,"DIA_Lee_LeesPlan_04_05");	//Too bad that you had to join up with them of all people.
		};
		if(MIS_Lee_Friedensangebot == FALSE)
		{
			AI_Output(other,self,"DIA_Lee_LeesPlan_15_06");	//What is your offer going to look like?
			if((other.guild == GIL_NONE) || (other.guild == GIL_SLD))
			{
				AI_Output(self,other,"DIA_Lee_LeesPlan_04_07");	//Essentially, it will be about our pardons and free passage to the mainland. You'll learn more when the time comes.
			}
			else
			{
				AI_Output(self,other,"DIA_Lee_LeesPlan_04_07_add");	//≈стественно, условием будет наше помилование и свободный путь на материк.@@@
			};
		};
	};
};


instance DIA_Lee_WannaJoin(C_Info)
{
	npc = SLD_800_Lee;
	nr = 5;
	condition = DIA_Lee_WannaJoin_Condition;
	information = DIA_Lee_WannaJoin_Info;
	permanent = FALSE;
	description = "I want to join you!";
};


func int DIA_Lee_WannaJoin_Condition()
{
	if(other.guild == GIL_NONE)
	{
		return TRUE;
	};
};

func void DIA_Lee_WannaJoin_Info()
{
	AI_Output (other, self, "DIA_Lee_WannaJoin_15_00");	//I want to join you!
	AI_Output (self, other, "DIA_Lee_WannaJoin_04_01");	//I'd hoped you'd say that! I can use every able man here.
	AI_Output (self, other, "DIA_Lee_WannaJoin_04_02");	//The last mercenaries I accepted have done nothing but stir up trouble!
	AI_Output (self, other, "DIA_Lee_WannaJoin_04_03");	//In principle, you can start right away. Well, first there's one or two things that we need to get straight, but it's no big deal ...
};


instance DIA_Lee_ClearWhat(C_Info)
{
	npc = SLD_800_Lee;
	nr = 6;
	condition = DIA_Lee_ClearWhat_Condition;
	information = DIA_Lee_ClearWhat_Info;
	permanent = FALSE;
	description = "What do I have to 'get straight' before I can join you?";
};


func int DIA_Lee_ClearWhat_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lee_WannaJoin) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Lee_ClearWhat_Info()
{
	AI_Output (other, self, "DIA_Lee_ClearWhat_15_00");	//What do I have to 'get straight' before I can join you?
	AI_Output (self, other, "DIA_Lee_ClearWhat_04_01");	//Onar, the landowner, is the one who employs us. You can only stay on the farm with his approval.
	AI_Output (self, other, "DIA_Lee_ClearWhat_04_02");	//And then there's the boys. I can only accept you if a majority of the mercenaries agree that you join us.
	AI_Output (self, other, "DIA_Lee_ClearWhat_04_03");	//But don't go to Onar before everything is straightened out. He's a very impatient fellow...
	SCKnowsSLDVotes = TRUE;
	SLD_Aufnahme = LOG_Running;
	Log_CreateTopic(TOPIC_BecomeSLD,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_BecomeSLD,LOG_Running);
	B_LogEntry(TOPIC_BecomeSLD,"To be accepted as a mercenary, I have to get Onar's approval once I've persuaded the mercenaries.");
};


instance DIA_Lee_OtherSld(C_Info)
{
	npc = SLD_800_Lee;
	nr = 7;
	condition = DIA_Lee_OtherSld_Condition;
	information = DIA_Lee_OtherSld_Info;
	permanent = FALSE;
	description = "How can I convince the mercenaries to vote me in?";
};


func int DIA_Lee_OtherSld_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lee_ClearWhat) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Lee_OtherSld_Info()
{
	AI_Output (other, self, "DIA_Lee_OtherSld_15_00");	//How can I convince the mercenaries to vote me in?
	AI_Output (self, other, "DIA_Lee_OtherSld_04_01");	//By doing what is expected of you as a mercenary, I should say.
	AI_Output (self, other, "DIA_Lee_OtherSld_04_02");	//Talk to Torlof. He's usually outside in front of the house. He'll put you to the test.
	AI_Output (self, other, "DIA_Lee_OtherSld_04_03");	//If you can pass that, you should have earned a large part of the necessary respect.
	AI_Output (self, other, "DIA_Lee_OtherSld_04_04");	//He'll tell you everything else you need to know.
	Log_CreateTopic(TOPIC_BecomeSLD,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_BecomeSLD,LOG_Running);
	B_LogEntry(TOPIC_BecomeSLD,"To be accepted as a mercenary, I have to let Torlof put me to the test and earn the respect of the other mercenaries.");
};


instance DIA_Addon_Lee_Ranger(C_Info)
{
	npc = SLD_800_Lee;
	nr = 2;
	condition = DIA_Addon_Lee_Ranger_Condition;
	information = DIA_Addon_Lee_Ranger_Info;
	description = "What do you know about the 'Ring of Water'?";
};


func int DIA_Addon_Lee_Ranger_Condition()
{
	if(SC_KnowsRanger == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Lee_Ranger_Info()
{
	AI_Output (other, self, "DIA_Addon_Lee_Ranger_15_00");	//What do you know about the 'Ring of Water'?
	AI_Output (self, other, "DIA_Addon_Lee_Ranger_04_01");	//(laughs) I might have known. You just have to mingle in everything, don't you?
	AI_Output (other, self, "DIA_Addon_Lee_Ranger_15_02");	//Come on, tell me.
	AI_Output (self, other, "DIA_Addon_Lee_Ranger_04_03");	//I'm only marginally involved in this. I know that this secret guild exists here and that the Water Mages are behind it.
	AI_Output (self, other, "DIA_Addon_Lee_Ranger_04_04");	//Since the fall of the Barrier, I am no longer bound to the agreement that I came to with the Water Mages back then.
	AI_Output (self, other, "DIA_Addon_Lee_Ranger_04_05");	//Of course, I still help when I can. But most of the time, I have my own problems and barely any time for other things.
	AI_Output (self, other, "DIA_Addon_Lee_Ranger_04_06");	//If you want to know more about it, you should probably talk to Cord. He's one of them, as far as I know.
	B_Lee_Teleport();
//	RangerHelp_gildeSLD = TRUE;
	SC_KnowsCordAsRangerFromLee = TRUE;
};


var int Lee_ProbeOK;
var int Lee_StimmenOK;
var int Lee_OnarOK;

instance DIA_Lee_JoinNOW(C_Info)
{
	npc = SLD_800_Lee;
	nr = 8;
	condition = DIA_Lee_JoinNOW_Condition;
	information = DIA_Lee_JoinNOW_Info;
	permanent = TRUE;
	description = "I'm ready to join you!";
};


func int DIA_Lee_JoinNOW_Condition()
{
	if((other.guild == GIL_NONE) && Npc_KnowsInfo(other,DIA_Lee_OtherSld) && (Lee_OnarOK == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lee_JoinNOW_Info()
{
	AI_Output (other, self, "DIA_Lee_JoinNOW_15_00");	//I'm ready to join you!
	if (Lee_ProbeOK == FALSE)
	{
		if((MIS_Torlof_HolPachtVonSekob != LOG_SUCCESS) && (MIS_Torlof_BengarMilizKlatschen != LOG_SUCCESS))
		{
			AI_Output (self, other, "DIA_Lee_JoinNOW_04_01");	//Not before you have passed Torlof's test.
		}
		else
		{
			AI_Output (self, other, "DIA_Lee_JoinNOW_04_02");	//Then you've passed Torlof's test?
			AI_Output (other, self, "DIA_Lee_JoinNOW_15_03");	//Yes.
			AI_Output (self, other, "DIA_Lee_JoinNOW_04_04");	//That's good.
			Lee_ProbeOK = TRUE;
		};
	};
	if((Lee_ProbeOK == TRUE) && (Lee_StimmenOK == FALSE))
	{
		AI_Output (self, other, "DIA_Lee_JoinNOW_04_05");	//What do the other mercenaries say?
		if (Torlof_GenugStimmen == FALSE)
		{
			AI_Output (other, self, "DIA_Lee_JoinNOW_15_06");	//I'm not quite sure whether enough of them are on my side.
			AI_Output (self, other, "DIA_Lee_JoinNOW_04_07");	//Then talk to Torlof, he knows just about everything that's being said here on the farm.
		}
		else
		{
			AI_Output (other, self, "DIA_Lee_JoinNOW_15_08");	//Most of them are on my side.
			Lee_StimmenOK = TRUE;
		};
	};
	if((Lee_StimmenOK == TRUE) && (Lee_OnarOK == FALSE))
	{
		if(Onar_Approved == FALSE)
		{
			AI_Output (self, other, "DIA_Lee_JoinNOW_04_09");	//Good, then go see Onar now. I've already talked with him.
			AI_Output (self, other, "DIA_Lee_JoinNOW_04_10");	//But you'll have to negotiate your pay yourself.
			if(Lee_SendToOnar == FALSE)
			{
				B_LogEntry(TOPIC_BecomeSLD,"All I need now is Onar's approval.");
				Lee_SendToOnar = TRUE;
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Lee_JoinNOW_04_11");	//Have you seen Onar?
			AI_Output (other, self, "DIA_Lee_JoinNOW_15_12");	//He agrees.
			Lee_OnarOK = TRUE;
			AI_Output (self, other, "DIA_Lee_JoinNOW_04_13");	//Welcome aboard, lad!
			AI_Output (self, other, "DIA_Lee_JoinNOW_04_14");	//Here, take some decent armor first!
			B_SetGuild(hero,GIL_SLD);
			B_GiveArmor(ITAR_SLD_L);
			Snd_Play("LEVELUP");
			if(Hlp_IsValidNpc(Lothar) && !Npc_IsDead(Lothar))
			{
				Npc_ExchangeRoutine(Lothar,"START");
			};
			if(Hlp_IsValidNpc(Babo) && !Npc_IsDead(Babo))
			{
				Npc_ExchangeRoutine(Babo,"FAVOUR");
			};
			KDF_Aufnahme = LOG_OBSOLETE;
			SLD_Aufnahme = LOG_SUCCESS;
			MIL_Aufnahme = LOG_OBSOLETE;
			B_GivePlayerXP(XP_BecomeMercenary);
			AI_Output(self,other,"DIA_Lee_JoinNOW_04_15");	//I'm glad to have you with us.
			if(MIS_Lee_Friedensangebot == FALSE)
			{
			AI_Output (self, other, "DIA_Lee_JoinNOW_04_16");	//I already have your first assignment.
			AI_Output (self, other, "DIA_Lee_JoinNOW_04_17");	//It has to do with the paladins. It's time you went to see them.
				if(Npc_KnowsInfo(other,DIA_Lee_Paladine))
				{
					AI_Output(self,other,"DIA_Lee_JoinNOW_04_18");	//You wanted to go there anyway.
				};
			};
			if(MIS_Addon_Daron_GetStatue == LOG_Running)
			{
				Log_CreateTopic(TOPIC_Addon_HelpDaron,LOG_MISSION);
				Log_SetTopicStatus(TOPIC_Addon_HelpDaron,LOG_Running);
				Log_AddEntry(TOPIC_Addon_HelpDaron,TOPIC_Addon_DaronGobbos);
			};
		};
	};
};


instance DIA_Lee_KeinSld(C_Info)
{
	npc = SLD_800_Lee;
	nr = 4;
	condition = DIA_Lee_KeinSld_Condition;
	information = DIA_Lee_KeinSld_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Lee_KeinSld_Condition()
{
	if(((other.guild == GIL_MIL) || (other.guild == GIL_PAL) || (other.guild == GIL_NOV) || (other.guild == GIL_KDF)) && (Lee_IsOnBoard == FALSE) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Lee_KeinSld_Info()
{
	if((other.guild == GIL_MIL) || (other.guild == GIL_PAL))
	{
		AI_Output (self, other, "DIA_Lee_KeinSld_04_00");	//I see you've placed yourself in the service of the paladins.
	};
	if((other.guild == GIL_NOV) || (other.guild == GIL_KDF))
	{
		AI_Output (self, other, "DIA_Lee_KeinSld_04_01");	//You entered the monastery? (laughs) I'd have expected anything but that.
	};
	AI_Output (self, other, "DIA_Lee_KeinSld_04_02");	//Well, you can't become a mercenary any more now.
	AI_Output (self, other, "DIA_Lee_KeinSld_04_03");	//But who knows, maybe you can do one or two things for me - or me for you.
	AI_Output (self, other, "DIA_Lee_KeinSld_04_04");	//We'll see. In any case, I wish you all the best.
	AI_Output (self, other, "DIA_Lee_KeinSld_04_05");	//But don't even think of pulling the wool over my eyes, got it?
};


instance DIA_Lee_ToHagen(C_Info)
{
	npc = SLD_800_Lee;
	nr = 4;
	condition = DIA_Lee_ToHagen_Condition;
	information = DIA_Lee_ToHagen_Info;
	permanent = FALSE;
	description = "And how can I get to the paladins now?";
};


func int DIA_Lee_ToHagen_Condition()
{
	if(other.guild == GIL_SLD)
	{
		return TRUE;
	};
	if((GuildlessMode == TRUE) && Npc_KnowsInfo(other,DIA_Lee_Paladine))
	{
		return TRUE;
	};
};

func void DIA_Lee_ToHagen_Info()
{
	AI_Output (other, self, "DIA_Lee_ToHagen_15_00");	//And how can I get to the paladins now?
	AI_Output (self, other, "DIA_Lee_ToHagen_04_01");	//Very simple. You'll take our peace offering to them.
	if(!Npc_KnowsInfo(other,DIA_Lee_LeesPlan))
	{
		AI_Output(other,self,"DIA_Lee_LeesPlan_15_06");	//What is your offer going to look like?
	};
	AI_Output (self, other, "DIA_Lee_ToHagen_04_02");	//I know Lord Hagen, the commander of the paladins, from my time in the royal army.
	AI_Output (self, other, "DIA_Lee_ToHagen_04_03");	//I know how he thinks - he doesn't have enough men. He'll accept the offer. At least he'll listen to you.
	AI_Output (self, other, "DIA_Lee_ToHagen_04_04");	//I've written a letter - here.
	B_GiveInvItems(self,other,ItWr_Passage_MIS,1);
	AI_Output(self,other,"DIA_Lee_ToHagen_04_05");	//In any case, that should get you admitted to see the leader of the paladins.
	Player_KnowsLordHagen = TRUE;
	MIS_Lee_Friedensangebot = LOG_Running;
	Log_CreateTopic(TOPIC_Frieden,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Frieden,LOG_Running);
	B_LogEntry(TOPIC_Frieden,"Lee's sending me to take an offer of peace to Lord Hagen. That way I can get to the paladins.");
};


instance DIA_Lee_AngebotSuccess(C_Info)
{
	npc = SLD_800_Lee;
	nr = 1;
	condition = DIA_Lee_AngebotSuccess_Condition;
	information = DIA_Lee_AngebotSuccess_Info;
	permanent = FALSE;
	description = "I brought Lord Hagen your peace offering.";
};


func int DIA_Lee_AngebotSuccess_Condition()
{
	if(Hagen_FriedenAbgelehnt == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Lee_AngebotSuccess_Info()
{
	AI_Output (other, self, "DIA_Lee_AngebotSuccess_15_00");	//I brought Lord Hagen your peace offering.
	AI_Output (self, other, "DIA_Lee_AngebotSuccess_04_01");	//What did he say?
	AI_Output (other, self, "DIA_Lee_AngebotSuccess_15_02");	//He said we would grant absolution to you, but not to your people.
	AI_Output (self, other, "DIA_Lee_AngebotSuccess_04_03");	//That stubborn fool. Most of the men in the KING's army are bigger cut-throats than my men.
	AI_Output (other, self, "DIA_Lee_AngebotSuccess_15_04");	//What are you going to do now?
	AI_Output (self, other, "DIA_Lee_AngebotSuccess_04_05");	//I'll have to find another way to get us out of here. If need be, we'll capture the ship. I'll have to think about it.
	AI_Output (self, other, "DIA_Lee_AngebotSuccess_04_06");	//Pulling my own head out of the noose and abandoning my men is out of the question.
	MIS_Lee_Friedensangebot = LOG_SUCCESS;
};


instance DIA_Lee_Background(C_Info)
{
	npc = SLD_800_Lee;
	nr = 1;
	condition = DIA_Lee_Background_Condition;
	information = DIA_Lee_Background_Info;
	permanent = FALSE;
	description = "Why do you want to go to the mainland so badly?";
};


func int DIA_Lee_Background_Condition()
{
	if(MIS_Lee_Friedensangebot == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Lee_Background_Info()
{
	AI_Output (other, self, "DIA_Lee_Add_15_10");	//Why do you want to go to the mainland so badly?
	AI_Output (self, other, "DIA_Lee_Add_04_11");	//As you know, I served the King as a general.
	AI_Output (self, other, "DIA_Lee_Add_04_12");	//But his sycophants betrayed me, because I knew something I shouldn't have known.
	AI_Output (self, other, "DIA_Lee_Add_04_13");	//They tossed me into the mining colony, and the King allowed it.
	AI_Output (self, other, "DIA_Lee_Add_04_14");	//I've had a lot of time to think about it.
	AI_Output (self, other, "DIA_Lee_Add_04_15");	//I shall avenge myself.
	AI_Output (other, self, "DIA_Lee_Add_15_16");	//(astonished) On the King?
	AI_Output (self, other, "DIA_Lee_Add_04_17");	//(determined) On the King! And on all his sycophants. They will all bitterly regret what they did to me ...
};


instance DIA_Lee_RescueGorn(C_Info)
{
	npc = SLD_800_Lee;
	nr = 2;
	condition = DIA_Lee_RescueGorn_Condition;
	information = DIA_Lee_RescueGorn_Info;
	permanent = FALSE;
	description = "I'm going to head for the Valley of Mines.";
};


func int DIA_Lee_RescueGorn_Condition()
{
	if((Hagen_BringProof == TRUE) && (Kapitel < 3) && (other.guild == GIL_SLD))
	{
		return TRUE;
	};
};

func void DIA_Lee_RescueGorn_Info()
{
	AI_Output (other, self, "DIA_Lee_RescueGorn_15_00");	//I'm going to head for the Valley of Mines.
	AI_Output (self, other, "DIA_Lee_RescueGorn_04_01");	//I didn't think you would stay on the farms for long.
	if(MIS_RescueGorn != LOG_SUCCESS)
	{
	AI_Output (self, other, "DIA_Lee_RescueGorn_04_02");	//If you go back to the colony, keep an eye out for Gorn. The paladins are holding him prisoner there.
	AI_Output (self, other, "DIA_Lee_RescueGorn_04_03");	//Gorn is a good man and I could really use him here, so if you get a chance to free him, take it.
		KnowsAboutGorn = TRUE;
	};
};


instance DIA_Lee_Success(C_Info)
{
	npc = SLD_800_Lee;
	nr = 2;
	condition = DIA_Lee_Success_Condition;
	information = DIA_Lee_Success_Info;
	permanent = FALSE;
	description = "I have freed Gorn.";
};


func int DIA_Lee_Success_Condition()
{
//	if((MIS_RescueGorn == LOG_SUCCESS) && (Kapitel >= 3) && (other.guild == GIL_SLD))
	if((MIS_RescueGorn == LOG_SUCCESS) && ((other.guild == GIL_SLD) || (other.guild == GIL_DJG)))
	{
		return TRUE;
	};
};

func void DIA_Lee_Success_Info()
{
	AI_Output(other,self,"DIA_Lee_Success_15_00");	//I have freed Gorn.
	if(Kapitel >= 3)
	{
		AI_Output(self,other,"DIA_Lee_Success_04_01");	//Yes, he already told me. Good work.
	}
	else
	{
		AI_Output(self,other,"DIA_Lee_AnyNews_04_02");	//Good work.
	};
	AI_Output(self,other,"DIA_Lee_Success_04_02");	//He's worth more than Sylvio and his boys put together.
	B_Lee_Teleport();
	B_GivePlayerXP(XP_AmbientKap5);
};


func void B_Lee_AboutGorn()
{
	AI_Output (self, other, "DIA_Lee_AboutGorn_Yes_04_01");	//He got caught by the paladins and was sent back to the Valley of Mines with a penal convoy.
	AI_Output (self, other, "DIA_Lee_AboutGorn_Yes_04_02");	//If the road to the Valley of Mines weren't plastered with paladins and orcs, I'd have sent a couple of the boys already to free him.
	AI_Output (self, other, "DIA_Lee_AboutGorn_Yes_04_03");	//But the way things are, there's no point. Poor devil.
	KnowsAboutGorn = TRUE;
};

instance DIA_Lee_AboutGorn(C_Info)
{
	npc = SLD_800_Lee;
	nr = 5;
	condition = DIA_Lee_AboutGorn_Condition;
	information = DIA_Lee_AboutGorn_Info;
	permanent = FALSE;
	description = "Gorn told you about me?? What happened to him?";
};


func int DIA_Lee_AboutGorn_Condition()
{
	if((Kapitel < 3) && !Npc_KnowsInfo(other,DIA_Lee_RescueGorn))
	{
		return TRUE;
	};
};

func void DIA_Lee_AboutGorn_Info()
{
	AI_Output (other, self, "DIA_Lee_AboutGorn_15_00");	//Gorn told you about me?? What happened to him?
	AI_Output (self, other, "DIA_Lee_AboutGorn_04_01");	//You remember him, don't you?
	Info_ClearChoices (DIA_Lee_AboutGorn);
	Info_AddChoice (DIA_Lee_AboutGorn, "Let me think ...", DIA_Lee_AboutGorn_Who);
	Info_AddChoice (DIA_Lee_AboutGorn, "Sure.", DIA_Lee_AboutGorn_Yes);
};

func void DIA_Lee_AboutGorn_Yes()
{
	AI_Output(other,self,"DIA_Lee_AboutGorn_Yes_15_00");	//Sure.
	B_Lee_AboutGorn();
	Info_ClearChoices(DIA_Lee_AboutGorn);
};

func void DIA_Lee_AboutGorn_Who()
{
	AI_Output (other, self, "DIA_Lee_AboutGorn_Who_15_00");	//Let me think ...
	AI_Output (self, other, "DIA_Lee_AboutGorn_Who_04_01");	//Big, dark, bad, with a big axe - he reconquered our ore mine with you back in the colony.
	AI_Output(other,self,"DIA_MiltenNW_KAP3_Hello_15_06");	//Oh well.
	B_Lee_AboutGorn();
	Info_ClearChoices(DIA_Lee_AboutGorn);
};


instance DIA_Lee_WegenBullco(C_Info)
{
	npc = SLD_800_Lee;
	nr = 6;
	condition = DIA_Lee_WegenBullco_Condition;
	information = DIA_Lee_WegenBullco_Info;
	permanent = FALSE;
	description = "Onar now has a few sheep less thanks to Bullco ...";
};


func int DIA_Lee_WegenBullco_Condition()
{
	if(MIS_Pepe_KillWolves == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Lee_WegenBullco_Info()
{
	AI_Output (other, self, "DIA_Lee_Add_15_00");	//Onar now has a few sheep less thanks to Bullco ...
	AI_Output (self, other, "DIA_Lee_Add_04_01");	//Oh, leave me alone with that shit! I have enough trouble as it is.
	if ((Bullco_scharf == TRUE) && !Npc_IsDead (Bullco))
	{
		AI_Output (other, self, "DIA_Lee_Add_15_02");	//Me too. Bullco seems to have a problem with me. He wants me to leave the farm ...
		AI_Output (self, other, "DIA_Lee_Add_04_03");	//Yes, and? Assert yourself.
		AI_Output (self, other, "DIA_Lee_Add_04_04");	//You can tell him he should restrain himself, otherwise I'll deduct the lost sheep from his pay ...
	};
};


instance DIA_Lee_Report(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_Report_Condition;
	information = DIA_Lee_Report_Info;
//	permanent = TRUE;
	permanent = FALSE;
	description = "I've come from the Valley of Mines ...";
};


func int DIA_Lee_Report_Condition()
{
//	if((EnterOW_Kapitel2 == TRUE) && (Kapitel <= 3))
	if(Enter_OldWorld_FirstTime_Trigger_OneTime == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Lee_Report_Info()
{
	AI_Output (other, self, "DIA_Lee_Add_15_18");	//I've come from the Valley of Mines. The castle there was attacked by dragons!
	AI_Output (self, other, "DIA_Lee_Add_04_19");	//So it's true! Lares said that rumors about dragons are circulating through the city ... I didn't believe it ...
	AI_Output (self, other, "DIA_Lee_Add_04_20");	//What about the paladins?
	AI_Output (other, self, "DIA_Lee_Add_15_21");	//They've been thoroughly decimated.
	if(MIS_Lee_Friedensangebot == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Lee_Add_04_22");	//Good! Maybe now Lord Hagen will think again about my offer...
	}
	else
	{
		AI_Output(self,other,"DIA_Lee_Add_04_24");	//Good! Maybe that will make Lord Hagen move to the Valley of Mines with his men...
		if(other.guild != GIL_PAL)
		{
			AI_Output(self,other,"DIA_Lee_Add_04_25");	//The fewer paladins stay here, the better.
		};
	};
	AI_Output(self,other,"DIA_Lee_Add_04_23");	//ј если нет... (жестко) “огда мы найдем другой способ вырватьс€ отсюда...@@@
};


var int Lee_Give_Sld_M;

instance DIA_Lee_ArmorM(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_ArmorM_Condition;
	information = DIA_Lee_ArmorM_Info;
	permanent = TRUE;
	description = "What about some better armor?";
};


func int DIA_Lee_ArmorM_Condition()
{
	if((Kapitel == 2) && (other.guild == GIL_SLD) && (Lee_Give_Sld_M == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lee_ArmorM_Info()
{
	DIA_Common_WhatAboutBetterArmor();
	if((MIS_Torlof_BengarMilizKlatschen == LOG_SUCCESS) && (MIS_Torlof_HolPachtVonSekob == LOG_SUCCESS))
	{
		AI_Output (self, other, "DIA_Lee_ArmorM_04_01");	//You fulfilled your assignment.
		AI_Output (self, other, "DIA_Lee_ArmorM_04_02");	//I have some better armor for you here. That is, if you have the wherewithal.
		Lee_Give_Sld_M = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Lee_ArmorM_04_03");	//Torlof has an assignment from Onar that should have been taken care of some time ago.
		AI_Output (self, other, "DIA_Lee_ArmorM_04_04");	//Take care of that first - then we'll talk about better armor!
	};
};


instance DIA_Lee_BuyArmorM(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_BuyArmorM_Condition;
	information = DIA_Lee_BuyArmorM_Info;
	permanent = TRUE;
	description = "Buy Medium Mercenary Armor. Protection: 50/50/0/5. (Cost: 1000 gold)";
};


func int DIA_Lee_BuyArmorM_Condition()
{
	if((Lee_Give_Sld_M == TRUE) && (Lee_SldMGiven == FALSE) && (other.guild == GIL_SLD))
	{
		return TRUE;
	};
};

func void DIA_Lee_BuyArmorM_Info()
{
	DIA_Common_GiveMeThatArmor();
	if(B_GiveInvItems(other,self,ItMi_Gold,1000))
	{
		AI_Output(self,other,"DIA_Lee_BuyArmorM_04_01");	//Here you go. Some good armor.
		B_GiveArmor(ITAR_SLD_M);
		Lee_SldMGiven = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Lee_BuyArmorM_04_02");	//But it isn't a gift! First I want to see some gold!
	};
};


instance DIA_Lee_ArmorH(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_ArmorH_Condition;
	information = DIA_Lee_ArmorH_Info;
	permanent = FALSE;
	description = "Do you have better armor for me?";
};


func int DIA_Lee_ArmorH_Condition()
{
	if((Kapitel == 3) && (other.guild == GIL_SLD))
	{
		return TRUE;
	};
};

func void DIA_Lee_ArmorH_Info()
{
	AI_Output (other, self, "DIA_Lee_ArmorH_15_00");	//Do you have better armor for me?
	AI_Output (self, other, "DIA_Lee_ArmorH_04_01");	//I sure do.
	B_Lee_Teleport();
};


instance DIA_Lee_BuyArmorH(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_BuyArmorH_Condition;
	information = DIA_Lee_BuyArmorH_Info;
	permanent = TRUE;
	description = "Buy Heavy Mercenary Armor. Protection: 80/80/5/10. (Cost: 2500 gold)";
};


func int DIA_Lee_BuyArmorH_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lee_ArmorH) && (Lee_SldHGiven == FALSE) && (other.guild == GIL_SLD))
	{
		return TRUE;
	};
};

func void DIA_Lee_BuyArmorH_Info()
{
	AI_Output(other,self,"DIA_Lee_BuyArmorH_15_00");	//Give me the heavy armor.
	if(B_GiveInvItems(other,self,ItMi_Gold,2500))
	{
		AI_Output(self,other,"DIA_Lee_BuyArmorH_04_01");	//Here. Very good armor. It's the same that I wear.
		B_GiveArmor(ITAR_SLD_H);
		Lee_SldHGiven = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Lee_BuyArmorH_04_02");	//You know how it works. First the gold!
	};
};


instance DIA_Lee_Richter(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_Richter_Condition;
	information = DIA_Lee_Richter_Info;
	permanent = FALSE;
	description = "Don't you have anything else for me to do?";
};


func int DIA_Lee_Richter_Condition()
{
	if((Kapitel >= 3) && ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG)) && !Npc_IsDead(Richter))
	{
		return TRUE;
	};
};

func void DIA_Lee_Richter_Info()
{
	AI_Output (other, self, "DIA_Lee_Richter_15_00");	//Don't you have anything else for me to do?
	AI_Output (self, other, "DIA_Lee_Richter_04_01");	//You can't get enough, eh? You're in plenty of trouble as it is. What else do you want, then?
	AI_Output (other, self, "DIA_Lee_Richter_15_02");	//Another assignment. I'm a mercenary, remember?
	AI_Output (self, other, "DIA_Lee_Richter_04_03");	//All right. I've got something. It's just the thing for you.
	AI_Output (self, other, "DIA_Lee_Richter_04_04");	//I have a debt to settle with the judge in town. I'd actually prefer to do it myself.
	AI_Output (self, other, "DIA_Lee_Richter_04_05");	//But the paladins wouldn't let me within a stone's throw of his house.
	AI_Output (self, other, "DIA_Lee_Richter_04_06");	//The thing has to be handled with a bit of consideration. So pay attention. You'll go to the judge and offer him your services.
	AI_Output (self, other, "DIA_Lee_Richter_04_07");	//You'll try to win his trust and carry out some dirty work for him, until you find something to incriminate him.
	AI_Output (self, other, "DIA_Lee_Richter_04_08");	//The swine has done so many dirty jobs that it stinks to high heaven.
	AI_Output (self, other, "DIA_Lee_Richter_04_09");	//Bring me something I can use to blacken his name with the militia, so that he spends the rest of his life molding in the slammer.
	AI_Output (self, other, "DIA_Lee_Richter_04_10");	//But I don't want you to kill him. That would be too quick. I want him to suffer, understand?
	AI_Output (self, other, "DIA_Lee_Richter_04_11");	//Do you think you can do that?
	Log_CreateTopic (TOPIC_RichterLakai, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_RichterLakai, LOG_Running);
	B_LogEntry (TOPIC_RichterLakai, "Lee wants me to find some incriminating evidence against the judge of Khorinis. For that I have to offer my services to the judge and keep my eyes peeled.");
	MIS_Lee_JudgeRichter = LOG_Running;
	Info_ClearChoices (DIA_Lee_Richter);
	Info_AddChoice (DIA_Lee_Richter, "I'm not going to do that.", DIA_Lee_Richter_nein);
	Info_AddChoice (DIA_Lee_Richter, "No problem. How much?", DIA_Lee_Richter_wieviel);
};

func void DIA_Lee_Richter_wieviel()
{
	AI_Output (other, self, "DIA_Lee_Richter_wieviel_15_00");	//No problem. How much?
	AI_Output (self, other, "DIA_Lee_Richter_wieviel_04_01");	//Your reward depends on what you bring me. So make an effort.
	B_Lee_Teleport();
	Info_ClearChoices(DIA_Lee_Richter);
};

func void DIA_Lee_Richter_nein()
{
	AI_Output (other, self, "DIA_Lee_Richter_nein_15_00");	//I'm not going to do that. I won't play doormat for that swine.
	AI_Output (self, other, "DIA_Lee_Richter_nein_04_01");	//Don't make such a fuss. Anyway, he's the one who busted you and had you tossed through the Barrier. Or have you forgotten that?
	AI_Output (self, other, "DIA_Lee_Richter_nein_04_02");	//Do what you want, but I think you'll make the right decision.
	Info_ClearChoices (DIA_Lee_Richter);
};


instance DIA_Lee_RichterBeweise(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_RichterBeweise_Condition;
	information = DIA_Lee_RichterBeweise_Info;
	description = "I found something to incriminate the judge.";
};


func int DIA_Lee_RichterBeweise_Condition()
{
	if((Kapitel >= 3) && (MIS_Lee_JudgeRichter == LOG_Running) && Npc_HasItems(other,ItWr_RichterKomproBrief_MIS) && ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG)))
	{
		return TRUE;
	};
};

func void DIA_Lee_RichterBeweise_Info()
{
	AI_Output (other, self, "DIA_Lee_RichterBeweise_15_00");	//I found something to incriminate the judge.
	AI_Output (self, other, "DIA_Lee_RichterBeweise_04_01");	//Really? What is it?
	AI_Output (other, self, "DIA_Lee_RichterBeweise_15_02");	//He hired a few thugs to mug the governor of Khorinis.
	AI_Output (other, self, "DIA_Lee_RichterBeweise_15_03");	//Shortly afterwards, he had them arrested and pocketed all the gold.
	AI_Output (other, self, "DIA_Lee_RichterBeweise_15_04");	//I brought you the written order the judge gave those thugs as evidence.
	AI_Output (self, other, "DIA_Lee_RichterBeweise_04_05");	//Show me.
	B_GiveInvItems(other,self,ItWr_RichterKomproBrief_MIS,1);
	B_UseFakeScroll();
	if(!Npc_IsDead(Richter))
	{
		AI_Output (self, other, "DIA_Lee_RichterBeweise_04_06");	//At last. That should be enough to make him bleed. I'm impressed.
		AI_Output (self, other, "DIA_Lee_RichterBeweise_04_07");	//I'm willing to shell out quite a bit for that. Here's your reward.
		CreateInvItems (self, ItMi_Gold, 500);
		B_GiveInvItems (self, other, ItMi_Gold, 500);
		MIS_Lee_JudgeRichter = LOG_SUCCESS;
		B_GivePlayerXP (XP_JudgeRichter);
		AI_Output (self, other, "DIA_Lee_RichterBeweise_04_08");	//And not a word about this to anyone, got it?
	}
	else
	{
		AI_Output (self, other, "DIA_Lee_RichterBeweise_04_09");	//That's terrific. But the matter has resolved itself. The judge is dead.
		AI_Output (self, other, "DIA_Lee_RichterBeweise_04_10");	//Some idiot blew him away. Oh, well. That's fine with me, too.
		AI_Output (self, other, "DIA_Lee_RichterBeweise_04_11");	//Here's a few coins. That's all this note is worth to me now.
		CreateInvItems (self, ItMi_Gold, 50);
		B_GiveInvItems (self, other, ItMi_Gold, 50);
		MIS_Lee_JudgeRichter = LOG_FAILED;
		B_GivePlayerXP(XP_Ambient);
	};
};


instance DIA_Lee_TalkAboutBennet(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_TalkAboutBennet_Condition;
	information = DIA_Lee_TalkAboutBennet_Info;
	permanent = FALSE;
	description = "What about Bennet?";
};


func int DIA_Lee_TalkAboutBennet_Condition()
{
	if((MIS_RescueBennet == LOG_Running) && (Kapitel == 3))
	{
		return TRUE;
	};
};

func void DIA_Lee_TalkAboutBennet_Info()
{
	AI_Output (other, self, "DIA_Lee_TalkAboutBennet_15_00");	//What about Bennet?
	AI_Output (self, other, "DIA_Lee_TalkAboutBennet_04_01");	//So you heard about that. The bastards have locked him up, just like that.
	AI_Output(self,other,"DIA_Lee_TalkAboutBennet_04_02");	//As if I didn't have enough problems with my own people - now I have to take care of the paladins, too.
	B_Lee_Teleport();
};


instance DIA_Lee_DoAboutBennet(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_DoAboutBennet_Condition;
	information = DIA_Lee_DoAboutBennet_Info;
	permanent = FALSE;
	description = "What will you do about Bennet?";
};


func int DIA_Lee_DoAboutBennet_Condition()
{
	if((MIS_RescueBennet == LOG_Running) && Npc_KnowsInfo(other,DIA_Lee_TalkAboutBennet))
	{
		return TRUE;
	};
};

func void DIA_Lee_DoAboutBennet_Info()
{
	AI_Output (other, self, "DIA_Lee_DoAboutBennet_15_00");	//What will you do about Bennet?
	AI_Output (self, other, "DIA_Lee_DoAboutBennet_04_01");	//I don't know yet. A few of the boys would like to run to the city and knock Lord Hagen's teeth down his throat.
	AI_Output (self, other, "DIA_Lee_DoAboutBennet_04_02");	//Luckily, we don't have enough people for an operation like that, and besides it's not my style.
	AI_Output (other, self, "DIA_Lee_DoAboutBennet_15_03");	//Are you going to stay here and see what happens, then?
	AI_Output (self, other, "DIA_Lee_DoAboutBennet_04_04");	//Certainly not.
	B_LogEntry (TOPIC_RescueBennet, "If can't prove Bennet's innocence quickly enough, Lee can't be held responsible for anything that happens. His people won't hesitate to attack the town at any moment and get Bennet out by force.");
	if (!Npc_IsDead (Lares))
	{
		AI_Output (self, other, "DIA_Lee_DoAboutBennet_04_05");	//Lares is still in the city and trying to find out how we can get Bennet out of there.
		AI_Output (self, other, "DIA_Lee_DoAboutBennet_04_06");	//Until that happens, I'm trying to calm my people. I only hope that Lares doesn't take too long.
	};
};


instance DIA_Lee_CanHelpYou(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_CanHelpYou_Condition;
	information = DIA_Lee_CanHelpYou_Info;
	permanent = FALSE;
	description = "Can I help you in this matter with Bennet?";
};


func int DIA_Lee_CanHelpYou_Condition()
{
	if((MIS_RescueBennet == LOG_Running) && Npc_KnowsInfo(other,DIA_Lee_DoAboutBennet))
	{
		return TRUE;
	};
};

func void DIA_Lee_CanHelpYou_Info()
{
	AI_Output (other, self, "DIA_Lee_CanHelpYou_15_00");	//Can I help you in this matter with Bennet?
	AI_Output (self, other, "DIA_Lee_CanHelpYou_04_01");	//Sure, a bit of intelligence and sanity certainly wouldn't hurt in this matter.
	AI_Output (self, other, "DIA_Lee_CanHelpYou_04_02");	//Innos knows, there are enough idiots running around here.
	AI_Output (self, other, "DIA_Lee_CanHelpYou_04_03");	//Go to the city and see if you can find a way to get Bennet out of there.
	AI_Output (self, other, "DIA_Lee_CanHelpYou_04_04");	//But don't be too long about it, I don't know how much longer I can keep the men under control.
};


var int DIA_Lee_AnyNews_OneTime;

instance DIA_Lee_AnyNews(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_AnyNews_Condition;
	information = DIA_Lee_AnyNews_Info;
	permanent = TRUE;
	description = "Any news about Bennet?";
};


func int DIA_Lee_AnyNews_Condition()
{
	if((MIS_RescueBennet != FALSE) && Npc_KnowsInfo(other,DIA_Lee_DoAboutBennet) && (DIA_Lee_AnyNews_OneTime == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lee_AnyNews_Info()
{
	AI_Output (other, self, "DIA_Lee_AnyNews_15_00");	//Any news about Bennet?
	if (MIS_RescueBennet == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Lee_AnyNews_04_01");	//At least he doesn't seem to have suffered any lasting damage in jail.
		AI_Output (self, other, "DIA_Lee_AnyNews_04_02");	//Good work.
		B_Lee_Teleport();
		if(DIA_Lee_AnyNews_OneTime == FALSE)
		{
			B_GivePlayerXP(XP_AmbientKap3);
			DIA_Lee_AnyNews_OneTime = TRUE;
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Lee_AnyNews_04_03");	//No, we still don't know enough.
	};
};


instance DIA_Lee_SYLVIO(C_Info)
{
	npc = SLD_800_Lee;
	nr = 3;
	condition = DIA_Lee_SYLVIO_Condition;
	information = DIA_Lee_SYLVIO_Info;
	description = "What has happened in the meantime?";
};


func int DIA_Lee_SYLVIO_Condition()
{
	if(MIS_ReadyforChapter4 == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Lee_SYLVIO_Info()
{
	AI_Output (other, self, "DIA_Lee_SYLVIO_15_00");	//What has happened in the meantime?
	AI_Output (self, other, "DIA_Lee_SYLVIO_04_01");	//Sylvio, the bastard, has heard about the dragons in the Valley of Mines and has made everyone here on the farm totally crazy about it.
	AI_Output (self, other, "DIA_Lee_SYLVIO_04_02");	//He's tried to convince the boys to follow him to the Valley of Mines. He's promised them fame, honor, gold and all sorts of things.
	AI_Output (self, other, "DIA_Lee_SYLVIO_04_03");	//A lot of them have no interest in getting killed for Sylvio, but there were quite a few idiots who fell for his drivel.
	AI_Output (self, other, "DIA_Lee_SYLVIO_04_04");	//The end of the story is that they got outfitted by Bennet and then set off.
	AI_Output (self, other, "DIA_Lee_SYLVIO_04_05");	//(dismissively) Ah. Basically, I'm glad that Sylvio is finally gone from the farm.
	B_Lee_Teleport();
};


var int DIA_Lee_Teacher_permanent;
var int Lee_Labercount;
var int DIA_Lee_TeachState_2H;

func void B_Lee_CommentFightSkill()
{
	if(Lee_Labercount == 0)
	{
		AI_Output(self,other,"DIA_Lee_DI_Teach_1H_5_04_00");	//Your wrists are still much too stiff. You have to hold the weapon loosely.
		Lee_Labercount = 1;
	}
	else if(Lee_Labercount == 1)
	{
		AI_Output(self,other,"DIA_DIA_Lee_DI_Teach_2H_1_04_00");	//Always remember, the swing comes from the hips, not the wrists.
		Lee_Labercount = 2;
	}
	else if(Lee_Labercount == 2)
	{
		AI_Output(self,other,"DIA_Lee_DI_Teach_2H_5_04_00");	//The strongest blow is useless if it doesn't hit anything. So use your strength wisely.
		Lee_Labercount = 0;
	};
};

func void B_Lee_TeachNoMore()
{
		AI_Output (self, other, "DIA_Lee_Teach_2H_5_04_00");	//Now you are a real master in two-handed combat.
		AI_Output (self, other, "DIA_Lee_Teach_2H_5_04_01");	//You no longer need a teacher.
};

instance DIA_Lee_CanTeach(C_Info)
{
	npc = SLD_800_Lee;
	nr = 10;
	condition = DIA_Lee_CanTeach_Condition;
	information = DIA_Lee_CanTeach_Info;
	permanent = TRUE;
	description = "Could you train me?";
};


func int DIA_Lee_CanTeach_Condition()
{
//	if((Kapitel >= 4) && (Lee_TeachPlayer == FALSE))
	if(Lee_TeachPlayer == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Lee_CanTeach_Info()
{
	AI_Output(other,self,"DIA_Lee_CanTeach_15_00");	//Can you train me?
	if(RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Lee)
	{
		B_Lee_TeachNoMore();
		Lee_TeachPlayer = TRUE;
		DIA_Lee_Teacher_permanent = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Lee_CanTeach_04_01");	//I can show you how to fight with a two-hander.
		if(!TeacherCanTrainTalent(NPC_TALENT_2H,TeachCondition_2H_Lee))
		{
		AI_Output (self, other, "DIA_Lee_CanTeach_04_02");	//But I don't have the time to teach you the basics as well.
		AI_Output (self, other, "DIA_Lee_CanTeach_04_03");	//As soon as you have reached a certain level of skill, I'll take you in hand. Until then, you'll have to find another teacher.
		}
		else
		{
			AI_Output(self,other,"DIA_Lee_CanTeach_04_04");	//I've heard you're pretty good. But I bet I can still teach you a thing or two.
			if((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
			{
				Lee_TeachPlayer = TRUE;
				Log_CreateTopic(TOPIC_SoldierTeacher,LOG_NOTE);
				B_LogEntry(TOPIC_SoldierTeacher,"Lee will teach me to wield two-handed weapons.");
			}
			else
			{
					AI_Output (self, other, "DIA_Lee_CanTeach_04_05");	//So, if you want, I can teach you something. That'll cost you a bit, though.
					AI_Output (other, self, "DIA_Lee_CanTeach_15_06");	//How much?
					AI_Output (self, other, "DIA_Lee_CanTeach_04_07");	//1000 gold pieces and we're in business.
				Info_ClearChoices(DIA_Lee_CanTeach);
				Info_AddChoice(DIA_Lee_CanTeach,"That's too expensive for me.",DIA_Lee_CanTeach_No);
				if(Npc_HasItems(other,ItMi_Gold) >= 1000)
				{
					Info_AddChoice(DIA_Lee_CanTeach,"Deal. Here's the gold.",DIA_Lee_CanTeach_Yes);
				};
			};
		};
	};
};

func void DIA_Lee_CanTeach_No()
{
	AI_Output (other, self, "DIA_Lee_CanTeach_No_15_00");	//That's too expensive for me.
	AI_Output (self, other, "DIA_Lee_CanTeach_No_04_01");	//Think about it. Teachers of my caliber are hard to find.
	Info_ClearChoices (DIA_Lee_CanTeach);
};

func void DIA_Lee_CanTeach_Yes()
{
	AI_Output (other, self, "DIA_Lee_CanTeach_Yes_15_00");	//Deal. Here's the gold.
	AI_Output (self, other, "DIA_Lee_CanTeach_Yes_04_01");	//All right, I promise you: I'm worth the price.
	B_GiveInvItems (other, self, ItMi_Gold, 1000);
	Lee_TeachPlayer = TRUE;
	Info_ClearChoices(DIA_Lee_CanTeach);
	Log_CreateTopic(TOPIC_SoldierTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_SoldierTeacher,"Lee will teach me to wield two-handed weapons.");
};

func void B_BuildLearnDialog_Lee()
{
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Lee)
	{
		Info_ClearChoices(DIA_Lee_Teach);
		Info_AddChoice(DIA_Lee_Teach,Dialog_Back,DIA_Lee_Teach_Back);
		Info_AddChoice(DIA_Lee_Teach,B_BuildLearnString(PRINT_Learn2h1,B_GetLearnCostTalent(other,NPC_TALENT_2H,1)),DIA_Lee_Teach_2H_1);
		Info_AddChoice(DIA_Lee_Teach,B_BuildLearnString(PRINT_Learn2h5,B_GetLearnCostTalent(other,NPC_TALENT_2H,5)),DIA_Lee_Teach_2H_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Lee)
		{
			DIA_Lee_Teacher_permanent = TRUE;
		};
		PrintScreen(PRINT_NoLearnOverMAX,-1,53,FONT_Screen,2);
		B_Lee_TeachNoMore();
		AI_StopProcessInfos(self);
	};
};

instance DIA_Lee_Teach(C_Info)
{
	npc = SLD_800_Lee;
	nr = 10;
	condition = DIA_Lee_Teach_Condition;
	information = DIA_Lee_Teach_Info;
	permanent = TRUE;
	description = "Let's start with the training.";
};


func int DIA_Lee_Teach_Condition()
{
	if((Lee_TeachPlayer == TRUE) && (DIA_Lee_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lee_Teach_Info()
{
	AI_Output(other,self,"DIA_Lee_Teach_15_00");	//Let's start with the training.
	B_BuildLearnDialog_Lee();
};

func void DIA_Lee_Teach_Back()
{
	Info_ClearChoices(DIA_Lee_Teach);
};

func void DIA_Lee_Teach_2H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,1,TeachLimit_2H_Lee))
	{
		B_Lee_CommentFightSkill();
		B_BuildLearnDialog_Lee();
	};
};

func void DIA_Lee_Teach_2H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,5,TeachLimit_2H_Lee))
	{
		B_Lee_CommentFightSkill();
		B_BuildLearnDialog_Lee();
	};
};


instance DIA_Lee_DRACHENEI(C_Info)
{
	npc = SLD_800_Lee;
	nr = 4;
	condition = DIA_Lee_DRACHENEI_Condition;
	information = DIA_Lee_DRACHENEI_Info;
	description = "The lizard people are distributing dragon eggs all over the country.";
};


func int DIA_Lee_DRACHENEI_Condition()
{
	if(Npc_HasItems(other,ItAt_DragonEgg_MIS) && (Kapitel >= 4))
	{
		return TRUE;
	};
};

func void DIA_Lee_DRACHENEI_Info()
{
	AI_Output(other,self,"DIA_Lee_DRACHENEI_15_00");	//The lizard people are distributing dragon eggs all over the country.
	AI_Output(self,other,"DIA_Lee_DRACHENEI_04_01");	//I might have known. It's time we got out of here.
	if(hero.guild == GIL_DJG)
	{
		AI_Output (other, self, "DIA_Lee_DRACHENEI_15_02");	//So what am I supposed to do with them?
		AI_Output (self, other, "DIA_Lee_DRACHENEI_04_03");	//Smash them. What else?
		AI_Output (self, other, "DIA_Lee_DRACHENEI_04_04");	//Maybe the shells can be used for making armor or something like that.
		AI_Output (self, other, "DIA_Lee_DRACHENEI_04_05");	//They look pretty stable. Talk to Bennet about it.
		B_LogEntry (TOPIC_DRACHENEIER, "There wasn't much Lee could do with the dragon egg. He sent me to Bennet the smith.");
	};
	B_GivePlayerXP(XP_AmbientKap5);
};


instance DIA_Lee_KAP4_Perm(C_Info)
{
	npc = SLD_800_Lee;
	nr = 49;
	condition = DIA_Lee_KAP4_Perm_Condition;
	information = DIA_Lee_KAP4_Perm_Info;
	permanent = TRUE;
	description = "How's it going on the farm?";
};


func int DIA_Lee_KAP4_Perm_Condition()
{
	if((Kapitel >= 4) && (Lee_IsOnBoard != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Lee_KAP4_Perm_Info()
{
	AI_Output (other, self, "DIA_Lee_KAP4_Perm_15_00");	//How's it going on the farm?
	AI_Output (self, other, "DIA_Lee_KAP4_Perm_04_01");	//Well, since Sylvio left, we've finally had some peace around here.
	AI_Output (other, self, "DIA_Lee_KAP4_Perm_15_02");	//That doesn't sound too bad.
	AI_Output (self, other, "DIA_Lee_KAP4_Perm_04_03");	//Unfortunately, we don't have less work. The men are becoming more and more discontent, because they now have to do the work of Sylvio's men on top of their own.
	AI_Output (self, other, "DIA_Lee_KAP4_Perm_04_04");	//But let me worry about that. I can handle it.
	B_Lee_Teleport();
};


instance DIA_Lee_GetShip(C_Info)
{
	npc = SLD_800_Lee;
	nr = 4;
	condition = DIA_Lee_GetShip_Condition;
	information = DIA_Lee_GetShip_Info;
	description = "Do you have an idea how I could take over the paladins' ship?";
};


func int DIA_Lee_GetShip_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && (MIS_ShipIsFree == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lee_GetShip_Info()
{
	AI_Output (other, self, "DIA_Lee_GetShip_15_00");	//Do you have an idea how I could take over the paladins' ship?
	AI_Output (self, other, "DIA_Lee_GetShip_04_01");	//Do you think I'd still be here if I did? That thing is better guarded than the ore transports were in the Old Camp.
	AI_Output (other, self, "DIA_Lee_GetShip_15_02");	//There must be a way to get on the ship.
	AI_Output (self, other, "DIA_Lee_GetShip_04_03");	//Sure. Getting on board is easy.
	if((MIS_Lee_JudgeRichter == LOG_SUCCESS) && !Npc_IsDead(Richter))
	{
		AI_Output (self, other, "DIA_Lee_GetShip_04_04");	//After all, we have the judge in our power. You should go to him and squeeze a letter of authorization for the ship out of him.
		MIS_RichtersPermissionForShip = LOG_Running;
		B_LogEntry (Topic_Ship, "Lee reckons the best way to get aboard the paladins' ship is to obtain a letter of authorization from the judge. But he's not likely to give me one of his own free will.");
	}
	else if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Lee_GetShip_04_05");	//I have a forged letter of authorization here. With that the ship's guards will let you pass.
		B_LogEntry (Topic_Ship, "Good old Lee. He's got a forged letter that will enable me to board the paladins' ship.");
	};
	AI_Output (self, other, "DIA_Lee_GetShip_04_06");	//But that isn't everything. To navigate the ship, you need a captain, a crew and so on.
	AI_Output (self, other, "DIA_Lee_GetShip_04_07");	//There's a whole string of requirements involved.
	Info_ClearChoices(DIA_Lee_GetShip);
	Info_AddChoice(DIA_Lee_GetShip,Dialog_Back,DIA_Lee_GetShip_back);
	Info_AddChoice(DIA_Lee_GetShip,"Who should I hire as a crew?",DIA_Lee_GetShip_crew);
	if(!Npc_IsDead(Torlof) && (SCGotCaptain == FALSE))
	{
		Info_AddChoice (DIA_Lee_GetShip, "Do you know anyone who could navigate the ship?", DIA_Lee_GetShip_torlof);
	};
};

func void DIA_Lee_GetShip_torlof()
{
	AI_Output (other, self, "DIA_Lee_GetShip_torlof_15_00");	//Do you know anyone who could navigate the ship?
	AI_Output (self, other, "DIA_Lee_GetShip_torlof_04_01");	//As far as I know, Torlof used to go to sea. He knows what's what.
	TorlofIsSailor = TRUE;	
B_LogEntry (Topic_Captain, "Torlof is an old sailor, maybe he wants to be my captain.");
};

func void DIA_Lee_GetShip_crew()
{
	AI_Output (other, self, "DIA_Lee_GetShip_crew_15_00");	//Who should I hire as a crew?
	AI_Output (self, other, "DIA_Lee_GetShip_crew_04_01");	//You'll have to decide that for yourself. But I would only take people that I trust. Do you have enough people you can trust?
	AI_Output (self, other, "DIA_Lee_GetShip_crew_04_02");	//If you need a smith in your crew, you should ask Bennet. He is certainly the best you'll find.
	if(SCToldBennetHeKnowWhereEnemy == FALSE)
	{
		B_LogEntry(Topic_Crew,"As for my crew, there wasn't much Lee could do for me there. But he did say I should only take people I can trust. Also, I'm to ask Bennet, he might be interested.");
	}
	else
	{
		B_LogEntry(Topic_Crew,"As for my crew, there wasn't much Lee could do for me there. But he did say I should only take people I can trust.");
	};	
};

func void DIA_Lee_GetShip_back()
{
	Info_ClearChoices(DIA_Lee_GetShip);
};


instance DIA_Lee_GotRichtersPermissionForShip(C_Info)
{
	npc = SLD_800_Lee;
	nr = 4;
	condition = DIA_Lee_GotRichtersPermissionForShip_Condition;
	information = DIA_Lee_GotRichtersPermissionForShip_Info;
	description = "The written authorization did the trick.";
};


func int DIA_Lee_GotRichtersPermissionForShip_Condition()
{
	if(MIS_RichtersPermissionForShip == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Lee_GotRichtersPermissionForShip_Info()
{
	AI_Output (other, self, "DIA_Lee_GotRichtersPermissionForShip_15_00");	//The written authorization did the trick. The ship's mine now. The judge was very cooperative.
	AI_Output (self, other, "DIA_Lee_GotRichtersPermissionForShip_04_01");	//Well. Your long period of humiliation with the bastard has finally paid off.
	B_GivePlayerXP(XP_AmbientKap5);
};


instance DIA_Lee_StealShip(C_Info)
{
	npc = SLD_800_Lee;
	nr = 4;
	condition = DIA_Lee_StealShip_Condition;
	information = DIA_Lee_StealShip_Info;
	permanent = FALSE;
	description = "I want to steal the ship.";
};


func int DIA_Lee_StealShip_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lee_GetShip) && (MIS_RichtersPermissionForShip == FALSE) && ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG)))
	{
		return TRUE;
	};
};

func void DIA_Lee_StealShip_Info()
{
	AI_Output (other, self, "DIA_Lee_StealShip_15_00");	//I want to steal the ship.
	AI_Output (self, other, "DIA_Lee_StealShip_04_01");	//And how is that supposed to happen?
	AI_Output (other, self, "DIA_Lee_StealShip_15_02");	//Piece of cake - I go there, show them your papers, and take the ship.
	AI_Output (self, other, "DIA_Lee_StealShip_04_03");	//If you say so. Here, I hope you know what you're doing.
	CreateInvItems (self, ITWr_ForgedShipLetter_MIS, 1);
	B_GiveInvItems (self, other, ITWr_ForgedShipLetter_MIS, 1);
};


instance DIA_Lee_KnowWhereEnemy(C_Info)
{
	npc = SLD_800_Lee;
	nr = 4;
	condition = DIA_Lee_KnowWhereEnemy_Condition;
	information = DIA_Lee_KnowWhereEnemy_Info;
	permanent = TRUE;
	description = "Would you accompany me on the ship?";
};


func int DIA_Lee_KnowWhereEnemy_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && (Lee_IsOnBoard == FALSE))
	{
		if(Npc_KnowsInfo(other,DIA_Lee_GetShip) || (MIS_ShipIsFree == TRUE))
		{
			return TRUE;
		};
	};
};

var int SCToldLeeHeKnowWhereEnemy;

func void DIA_Lee_KnowWhereEnemy_Info()
{
	AI_Output (other, self, "DIA_Lee_KnowWhereEnemy_15_00");	//Would you accompany me on the ship?
	AI_Output (self, other, "DIA_Lee_KnowWhereEnemy_04_01");	//Are you kidding? Of course I'm in. I have a few old scores to settle on the mainland.
	AI_Output (self, other, "DIA_Lee_KnowWhereEnemy_04_02");	//Besides, I can teach you one and two-handed combat. I could be very useful to you.
	if(SCToldLeeHeKnowWhereEnemy == FALSE)
	{
		B_LogEntry(Topic_Crew,"Lee's eager to see the mainland again. He's offered to support me. I'd be hard put to find as good a combat trainer as he is anywhere else.");
		SCToldLeeHeKnowWhereEnemy = TRUE;
	};
	if(Crewmember_Count >= Max_Crew)
	{
		AI_Output(other,self,"DIA_Lee_KnowWhereEnemy_15_03");	//The ship is full now, but I'll be back if there is an opening.
	}
	else
	{
		Info_ClearChoices(DIA_Lee_KnowWhereEnemy);
		if(!Npc_KnowsInfo(other,DIA_Lee_GetShip) && !Npc_IsDead(Torlof) && (SCGotCaptain == FALSE) && (TorlofIsSailor == FALSE))
		{
			Info_AddChoice(DIA_Lee_KnowWhereEnemy,"Do you know anyone who could navigate the ship?",DIA_Lee_GetShip_torlof);
		};
		Info_AddChoice(DIA_Lee_KnowWhereEnemy,"I'll let you know if I can use you.",DIA_Lee_KnowWhereEnemy_No);
		Info_AddChoice(DIA_Lee_KnowWhereEnemy,"Go pack your things, then!",DIA_Lee_KnowWhereEnemy_Yes);
	};
};

func void DIA_Lee_KnowWhereEnemy_Yes()
{
	AI_Output (other, self, "DIA_Lee_KnowWhereEnemy_Yes_15_00");	//Go pack your things, then!
	AI_Output (self, other, "DIA_Lee_KnowWhereEnemy_Yes_04_01");	//What? Right now?
	AI_Output (other, self, "DIA_Lee_KnowWhereEnemy_Yes_15_02");	//Yes, I'm planning to get out of here, and if you want to join me, come down to the harbor. We'll meet at the ship.
	AI_Output (self, other, "DIA_Lee_KnowWhereEnemy_Yes_04_03");	//I've waited a long time for this moment. I'll be there.
	B_JoinShip(self);
};

func void DIA_Lee_KnowWhereEnemy_No()
{
	AI_Output (other, self, "DIA_Lee_KnowWhereEnemy_No_15_00");	//I'll let you know if I can use you.
	AI_Output (self, other, "DIA_Lee_KnowWhereEnemy_No_04_01");	//You must know what you want. But you can never have enough good fighters around.
	AI_Output (self, other, "DIA_Lee_KnowWhereEnemy_No_04_02");	//(grins) Unless they're utter morons like Sylvio.
	Lee_IsOnBoard = LOG_OBSOLETE;
	Info_ClearChoices(DIA_Lee_KnowWhereEnemy);
};


instance DIA_Lee_LeaveMyShip(C_Info)
{
	npc = SLD_800_Lee;
	nr = 4;
	condition = DIA_Lee_LeaveMyShip_Condition;
	information = DIA_Lee_LeaveMyShip_Info;
	permanent = TRUE;
	description = "I can't use you after all!";
};


func int DIA_Lee_LeaveMyShip_Condition()
{
	if((Lee_IsOnBoard == LOG_SUCCESS) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lee_LeaveMyShip_Info()
{
	AI_Output (other, self, "DIA_Lee_LeaveMyShip_15_00");	//I can't use you after all!
	AI_Output (self, other, "DIA_Lee_LeaveMyShip_04_01");	//Suit yourself, you know where to find me!
	Lee_IsOnBoard = LOG_OBSOLETE;
	Crewmember_Count -= 1;
	Lee_Nerver += 1;
	Npc_ExchangeRoutine(self,"ShipOff");
};


instance DIA_Lee_StillNeedYou(C_Info)
{
	npc = SLD_800_Lee;
	nr = 4;
	condition = DIA_Lee_StillNeedYou_Condition;
	information = DIA_Lee_StillNeedYou_Info;
	permanent = TRUE;
	description = "I can use you after all!";
};


func int DIA_Lee_StillNeedYou_Condition()
{
	if(((Lee_IsOnBoard == LOG_OBSOLETE) || (Lee_IsOnBoard == LOG_FAILED)) && (Crewmember_Count < Max_Crew))
	{
		return TRUE;
	};
};

func void DIA_Lee_StillNeedYou_Info()
{
	AI_Output(other,self,"DIA_Lee_StillNeedYou_15_00");	//I can use you after all!
	if((Lee_IsOnBoard == LOG_OBSOLETE) && (Lee_Nerver <= 2))
	{
		AI_Output(self,other,"DIA_Lee_StillNeedYou_04_01");	//I knew you needed me! I'll see you on the ship.
		B_JoinShip(self);
	}
	else
	{
		AI_Output (self, other, "DIA_Lee_StillNeedYou_04_02");	//You know what, screw you. First you say I should come, then you send me away again.
		AI_Output (self, other, "DIA_Lee_StillNeedYou_04_03");	//Find yourself another idiot!
		AI_StopProcessInfos(self);
		Lee_IsOnBoard = LOG_FAILED;
	};
	B_CheckLog();
};
//@@@Lee would not turn it down just like this, it's out of character for him.
