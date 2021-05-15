
instance DIA_MiltenOW_EXIT(C_Info)
{
	npc = PC_Mage_OW;
	nr = 999;
	condition = DIA_MiltenOW_EXIT_Condition;
	information = DIA_MiltenOW_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_MiltenOW_EXIT_Condition()
{
	return TRUE;
};

func void DIA_MiltenOW_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_MiltenOW_Hello(C_Info)
{
	npc = PC_Mage_OW;
	nr = TRUE;
	condition = DIA_MiltenOW_Hello_Condition;
	information = DIA_MiltenOW_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_MiltenOW_Hello_Condition()
{
	return TRUE;
};

func void DIA_MiltenOW_Hello_Info()
{
	AI_Output (self, other, "DIA_MiltenOW_Hello_03_00");	//Look who has returned! Our hero from the barrier!
	Info_ClearChoices (DIA_MiltenOW_Hello);
	Info_AddChoice (DIA_MiltenOW_Hello, "Good to see you, Milten.", DIA_MiltenOW_Hello_YES);
	Info_AddChoice (DIA_MiltenOW_Hello, "Do I know you?", DIA_MiltenOW_Hello_NO);
};

func void B_Milten_GornDiegoLester()
{
	AI_Output (self, other, "DIA_MiltenOW_Hello_NO_03_02");	//Do you remember Gorn, Diego and Lester?
};

func void DIA_MiltenOW_Hello_YES()
{
	AI_Output (other, self, "DIA_MiltenOW_Hello_YES_15_00");	//Good to see you, Milten. Are you still here, or here again?
	AI_Output (self, other, "DIA_MiltenOW_Hello_YES_03_01");	//Again. After the Barrier collapsed I entered the monastery of the Magicians of Fire.
	AI_Output (self, other, "DIA_MiltenOW_Hello_YES_03_02");	//But once it was clear that the paladins wanted to come here, my experience and knowledge of the place proved to be quite useful.
	AI_Output (self, other, "DIA_MiltenOW_Hello_YES_03_03");	//So they decided then and there to entrust me with the holy mission of providing magical support to this expedition.
	B_Milten_GornDiegoLester ();
	Info_ClearChoices (DIA_MiltenOW_Hello);
	Info_AddChoice (DIA_MiltenOW_Hello, "Of course I remember the boys.", DIA_MiltenOW_Hello_Friends);
	Info_AddChoice (DIA_MiltenOW_Hello, "Those names don't ring a bell at all.", DIA_MiltenOW_Hello_Forget);
};

func void DIA_MiltenOW_Hello_NO()
{
	AI_Output (other, self, "DIA_MiltenOW_Hello_NO_15_00");	//Am I supposed to know them?
	AI_Output (self, other, "DIA_MiltenOW_Hello_NO_03_01");	//You've been through a lot, huh?
	B_Milten_GornDiegoLester ();
	Info_ClearChoices (DIA_MiltenOW_Hello);
	Info_AddChoice (DIA_MiltenOW_Hello, "So what is there to report?", DIA_MiltenOW_Hello_Friends);
	Info_AddChoice (DIA_MiltenOW_Hello, "Those names don't ring a bell at all.", DIA_MiltenOW_Hello_Forget);
};

func void DIA_MiltenOW_Hello_Friends()
{
	AI_Output (other, self, "DIA_MiltenOW_Hello_Friends_15_00");	//Of course I remember the boys.
	AI_Output (self, other, "DIA_MiltenOW_Hello_Friends_03_01");	//Well, Gorn and Diego didn't get far. They were picked up by the paladins here in the valley.
	AI_Output (self, other, "DIA_MiltenOW_Hello_Friends_03_02");	//Lester has vanished, though - I have no idea where he's hanging around.
	if (Npc_KnowsInfo (other, DIA_Lester_Hello))
	{
		if(Npc_KnowsInfo(other,DIA_Lester_SEND_XARDAS))
		{
			AI_Output(other,self,"DIA_MiltenOW_Hello_Friends_15_03");	//I've met Lester - he's with Xardas now.
		}
		else
		{
			AI_Output(other,self,"DIA_MiltenOW_Hello_Friends_15_03_add");	//Я встретил Лестера. Он в порядке.@@@
		};
		AI_Output(self,other,"DIA_MiltenOW_Hello_Friends_03_04");	//One bit of good news, at least.
	};
	AI_Output(self,other,"DIA_MiltenOW_Hello_Friends_03_05");	//Well, I have nothing pleasant to report.
	Knows_Diego = TRUE;
	Info_ClearChoices(DIA_MiltenOW_Hello);
};

func void DIA_MiltenOW_Hello_Forget()
{
	AI_Output (other, self, "DIA_MiltenOW_Hello_Forget_15_00");	//Those names don't ring a bell at all.
	AI_Output (self, other, "DIA_MiltenOW_Hello_Forget_03_01");	//You have forgotten a great deal, haven't you? Well, let's leave the past in peace and devote ourselves to the here and now.
	AI_Output (self, other, "DIA_MiltenOW_Hello_Forget_03_02");	//Even if there isn't anything pleasant to report.
	Info_ClearChoices(DIA_MiltenOW_Hello);
};


instance DIA_MiltenOW_Bericht(C_Info)
{
	npc = PC_Mage_OW;
	nr = 3;
	condition = DIA_MiltenOW_Bericht_Condition;
	information = DIA_MiltenOW_Bericht_Info;
	permanent = FALSE;
	description = "So what is there to report?";
};


func int DIA_MiltenOW_Bericht_Condition()
{
	if(Npc_KnowsInfo(other,DIA_MiltenOW_Hello))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Bericht_Info()
{
	AI_Output (other, self, "DIA_MiltenOW_Bericht_15_00");	//So what is there to report?
	AI_Output (self, other, "DIA_MiltenOW_Bericht_03_01");	//The paladins came here with the intention of getting the magic ore.
	AI_Output (self, other, "DIA_MiltenOW_Bericht_03_02");	//But with the dragon attacks and the orcs - I can't imagine the paladins will march out of here with the ore.
	AI_Output (self, other, "DIA_MiltenOW_Bericht_03_03");	//No, by Innos - I feel the presence of something dark ... something evil, growing here. Something that emanates from this valley.
	AI_Output (self, other, "DIA_MiltenOW_Bericht_03_04");	//We paid a high price for the annihilation of the Sleeper. The destruction of the Barrier has ruined this place as well.
	AI_Output (self, other, "DIA_MiltenOW_Bericht_03_05");	//We can all count ourselves lucky if we survive this.
};


instance DIA_MiltenOW_Erz(C_Info)
{
	npc = PC_Mage_OW;
	nr = 4;
	condition = DIA_MiltenOW_Erz_Condition;
	information = DIA_MiltenOW_Erz_Info;
	permanent = FALSE;
	description = "How much ore have you stored away so far?";
};


func int DIA_MiltenOW_Erz_Condition()
{
	if(Npc_KnowsInfo(other,DIA_MiltenOW_Bericht))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Erz_Info()
{
	AI_Output (other, self, "DIA_MiltenOW_Erz_15_00");	//How much ore have you stored away so far?
	AI_Output (self, other, "DIA_MiltenOW_Erz_03_01");	//How much ore ... ? Not one chest! We haven't had contact with the scrapers for some time.
	AI_Output (self, other, "DIA_MiltenOW_Erz_03_02");	//It wouldn't amaze me if they were all long dead. And we are being attacked by dragons and besieged by orcs!
	AI_Output (self, other, "DIA_MiltenOW_Erz_03_03");	//This expedition is a complete disaster.
};


instance DIA_MiltenOW_Wo(C_Info)
{
	npc = PC_Mage_OW;
	nr = 5;
	condition = DIA_MiltenOW_Wo_Condition;
	information = DIA_MiltenOW_Wo_Info;
	permanent = FALSE;
	description = "Where are Gorn and Diego now?";
};


func int DIA_MiltenOW_Wo_Condition()
{
	if(Npc_KnowsInfo(other,DIA_MiltenOW_Hello) && (Knows_Diego == TRUE))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Wo_Info()
{
	AI_Output(other,self,"DIA_MiltenOW_Wo_Forget_15_00");	//Where are Gorn and Diego now?
	if(MIS_RescueGorn != LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_MiltenOW_Wo_Forget_03_01");	//Well, Gorn is sitting here in the dungeon - because he resisted arrest.
	}
	else
	{
		AI_Output(self,other,"DIA_MiltenNW_FourFriends_03_01");	//Gorn seems to have coped with his stay in Garond's dungeon very well.
	};
	AI_Output(self,other,"DIA_MiltenOW_Wo_Forget_03_02");	//They assigned Diego to a troop of scrapers - ask the paladin Parcival, he assembled the groups.
	KnowsAboutGorn = TRUE;
	SearchForDiego = LOG_Running;
};


instance DIA_MiltenOW_Gorn(C_Info)
{
	npc = PC_Mage_OW;
	nr = 5;
	condition = DIA_MiltenOW_Gorn_Condition;
	information = DIA_MiltenOW_Gorn_Info;
	permanent = FALSE;
	description = "Let's go and free Gorn!";
};


func int DIA_MiltenOW_Gorn_Condition()
{
	if((KnowsAboutGorn == TRUE) && (Kapitel == 2))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Gorn_Info()
{
	AI_Output (other, self, "DIA_MiltenOW_Gorn_15_00");	//Let's go and free Gorn!
	AI_Output (self, other, "DIA_MiltenOW_Gorn_03_01");	//Well, the problem in this matter is that Gorn is a convicted prisoner.
	AI_Output (self, other, "DIA_MiltenOW_Gorn_03_02");	//But if we're lucky, Garond will agree on a deal, and we can buy his freedom.
	AI_Output (other, self, "DIA_MiltenOW_Gorn_15_03");	//Yes, maybe ...
	AI_Output (self, other, "DIA_MiltenOW_Gorn_03_04");	//Keep me in the picture.
	Log_CreateTopic (TOPIC_RescueGorn, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_RescueGorn, LOG_Running);
	B_LogEntry (TOPIC_RescueGorn, "Comander Garond has had Gorn locked up. Maybe he'll enter into a little arrangement, so we can bail him out.");
};


instance DIA_MiltenOW_Preis(C_Info)
{
	npc = PC_Mage_OW;
	nr = 5;
	condition = DIA_MiltenOW_Preis_Condition;
	information = DIA_MiltenOW_Preis_Info;
	permanent = FALSE;
	description = "Garond wants 1000 gold pieces for Gorn.";
};


func int DIA_MiltenOW_Preis_Condition()
{
	if((MIS_RescueGorn == LOG_Running) && (Kapitel == 2))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Preis_Info()
{
	AI_Output (other, self, "DIA_MiltenOW_Preis_15_00");	//Garond wants 1000 gold pieces for Gorn.
	AI_Output (self, other, "DIA_MiltenOW_Preis_03_01");	//A nice sum. I can chip in 250 gold pieces.
	B_GiveInvItems (self, other, ItMi_Gold, 250);
	B_LogEntry (TOPIC_RescueGorn, "Milten gave me 250 pieces of gold to pay for Gorn's release.");
};


instance DIA_MiltenOW_Mehr(C_Info)
{
	npc = PC_Mage_OW;
	nr = 5;
	condition = DIA_MiltenOW_Mehr_Condition;
	information = DIA_MiltenOW_Mehr_Info;
	permanent = FALSE;
	description = "I need more gold to buy Gorn's freedom.";
};


func int DIA_MiltenOW_Mehr_Condition()
{
	if((MIS_RescueGorn == LOG_Running) && (Kapitel == 2) && Npc_KnowsInfo(other,DIA_MiltenOW_Preis))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Mehr_Info()
{
	AI_Output (other, self, "DIA_MiltenOW_Mehr_15_00");	//I need more gold to buy Gorn's freedom.
	AI_Output (self, other, "DIA_MiltenOW_Mehr_03_01");	//Getting more gold ... hm. Diego knows a lot about that - but he isn't here.
	AI_Output (self, other, "DIA_MiltenOW_Mehr_03_02");	//Maybe Gorn has some gold hidden somewhere himself - we should find out.
	AI_Output (self, other, "DIA_MiltenOW_Mehr_03_03");	//I'll write him a note - here, try to smuggle it into the dungeon.
	B_GiveInvItems (self, other, ItWr_LetterForGorn_MIS, 1);
	B_LogEntry (TOPIC_RescueGorn, "Milten has given me a message for Gorn. If I can just smuggle it into the jail, he may be able to tell us whether he's got any gold stashed away somewhere.");
};


instance DIA_MiltenOW_Equipment(C_Info)
{
	npc = PC_Mage_OW;
	nr = 5;
	condition = DIA_MiltenOW_Equipment_Condition;
	information = DIA_MiltenOW_Equipment_Info;
	permanent = FALSE;
	description = "Can you give me some equipment?";
};


func int DIA_MiltenOW_Equipment_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Garond_Equipment) && (other.guild == GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Equipment_Info()
{
	AI_Output (other, self, "DIA_MiltenOW_Equipmentt_15_00");	//Can you give me some equipment? Garond has asked me to go to the mining sites.
	AI_Output (self, other, "DIA_MiltenOW_Equipment_03_01");	//Where am I supposed to get that? The only thing I can give you is a valuable runestone.
	B_GiveInvItems (self, other, ItMi_RuneBlank, 1);
};


instance DIA_MiltenOW_Versteck(C_Info)
{
	npc = PC_Mage_OW;
	nr = 1;
	condition = DIA_MiltenOW_Versteck_Condition;
	information = DIA_MiltenOW_Versteck_Info;
	permanent = FALSE;
	important = FALSE;
	description = "I got an answer from Gorn ...";
};


func int DIA_MiltenOW_Versteck_Condition()
{
	if((GornsTreasure == TRUE) && !Npc_HasItems(other,ItMi_GornsTreasure_MIS) && (Gorns_Beutel == FALSE) && (Kapitel == 2) && (MIS_RescueGorn == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Versteck_Info()
{
	AI_Output (other, self, "DIA_MiltenOW_Versteck_15_00");	//I got an answer from Gorn. He says the gold is at the south gate.
	AI_Output (self, other, "DIA_MiltenOW_Versteck_03_01");	//(bitter) Former south gate, you mean to say. The dragon has reduced it to rubble.
	AI_Output (other, self, "DIA_MiltenOW_Versteck_15_02");	//How do I get there?
	AI_Output (self, other, "DIA_MiltenOW_Versteck_03_03");	//That is near the orcs' ram. The south gate was to the right of that.
	AI_Output (self, other, "DIA_MiltenOW_Versteck_03_04");	//It won't be easy - so keep your head down and hurry.
	B_LogEntry (TOPIC_RescueGorn, "The former south gate is to the right of the orc's ram. Gorn's gold is somewhere around there.");
};


instance DIA_MiltenOW_Frei(C_Info)
{
	npc = PC_Mage_OW;
	nr = 5;
	condition = DIA_MiltenOW_Frei_Condition;
	information = DIA_MiltenOW_Frei_Info;
	permanent = FALSE;
	description = "I have freed Gorn.";
};


func int DIA_MiltenOW_Frei_Condition()
{
	if((MIS_RescueGorn == LOG_SUCCESS) && (Kapitel == 2))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Frei_Info()
{
	AI_Output (other, self, "DIA_MiltenOW_Frei_15_00");	//I have freed Gorn.
	AI_Output (self, other, "DIA_MiltenOW_Frei_03_01");	//Good. Then we should think about what happens next.
};


instance DIA_MiltenOW_Lehren(C_Info)
{
	npc = PC_Mage_OW;
	nr = 9;
	condition = DIA_MiltenOW_Lehren_Condition;
	information = DIA_MiltenOW_Lehren_Info;
	permanent = FALSE;
	description = "Can you teach me something?";
};


func int DIA_MiltenOW_Lehren_Condition()
{
	if((other.guild == GIL_KDF) && (Kapitel == 2))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Lehren_Info()
{
	AI_Output(other,self,"DIA_MiltenOW_Lehren_15_00");	//Can you teach me something?
	AI_Output(self,other,"DIA_MiltenOW_Lehren_03_01");	//I can instruct you in some magic from the second Circle of Magic, or I can help you to increase your magic power.
	AI_Output(self,other,"DIA_MiltenOW_Lehren_03_02");	//If you feel ready to increase your power, then I can instruct you.
};


instance DIA_MiltenOW_TeachCircle1(C_Info)
{
	npc = PC_Mage_OW;
	nr = 91;
	condition = DIA_MiltenOW_TeachCircle1_Condition;
	information = DIA_MiltenOW_TeachCircle1_Info;
	permanent = TRUE;
	description = B_BuildLearnString("First Circle of Magic",B_GetLearnCostTalent(other,NPC_TALENT_MAGE,1));
};


func int DIA_MiltenOW_TeachCircle1_Condition()
{
	if((other.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_MiltenOW_Lehren) && (Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 0))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_TeachCircle1_Info()
{
	DIA_Common_TeachMe_FirstMagicCirlce();
	if(B_TeachMagicCircle(self,other,1))
	{
		DIA_Milten_RunesComment_01();
		DIA_Milten_RunesComment_02();
		DIA_Milten_RunesComment_03();
	};
};


instance DIA_MiltenOW_TeachCircle2(C_Info)
{
	npc = PC_Mage_OW;
	nr = 91;
	condition = DIA_MiltenOW_TeachCircle2_Condition;
	information = DIA_MiltenOW_TeachCircle2_Info;
	permanent = TRUE;
//	description = B_BuildLearnString("Обучи меня второму Кругу магии",B_GetLearnCostTalent(other,NPC_TALENT_MAGE,2));
	description = B_BuildLearnString("Second Circle of Magic",B_GetLearnCostTalent(other,NPC_TALENT_MAGE,2));
};


func int DIA_MiltenOW_TeachCircle2_Condition()
{
	if((other.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_MiltenOW_Lehren) && (Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 1))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_TeachCircle2_Info()
{
	AI_Output (other, self, "DIA_Milten_Add_15_00");	//Teach me the second Circle of Magic!
	AI_Output (self, other, "DIA_Milten_Add_03_01");	//This is normally the privilege of the teachers of our order.
	AI_Output (self, other, "DIA_Milten_Add_03_02");	//But I think that, in this case, we can make an exception ...
	if (B_TeachMagicCircle (self, other, 2))
	{
		AI_Output (self, other, "DIA_Milten_Add_03_03");	//I don't know if I quite remember the official words ...
		AI_Output (self, other, "DIA_Milten_Add_03_04");	//Enter now the second Circle. Er... It will show you the way - but your deeds form the path - or something along those lines ...
		AI_Output (self, other, "DIA_Milten_Add_03_05");	//I think you understand what this is about...
	};
};


instance DIA_MiltenOW_Teach(C_Info)
{
	npc = PC_Mage_OW;
	nr = 90;
	condition = DIA_MiltenOW_Teach_Condition;
	information = DIA_MiltenOW_Teach_Info;
	permanent = TRUE;
	description = "I want to learn some new spells.";
};


func int DIA_MiltenOW_Teach_Condition()
{
	if((other.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_MiltenOW_Lehren) && (Kapitel == 2))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Teach_Info()
{
	DIA_Common_WantToLearnNewRunes();
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 0)
	{
		AI_Output(self,other,"DIA_MiltenOW_Teach_03_01");	//You still haven't reached the second Circle of Magic. I can't teach you anything.
	}
	else
	{
		Info_ClearChoices(DIA_MiltenOW_Teach);
		Info_AddChoice(DIA_MiltenOW_Teach,Dialog_Back,DIA_MiltenOW_Teach_BACK);
		if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 1)
		{
			if(PLAYER_TALENT_RUNES[SPL_Light] == FALSE)
			{
				Info_AddChoice(DIA_MiltenOW_Teach,B_BuildLearnString(NAME_SPL_Light,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Light)),DIA_MiltenOW_Teach_Light);
			};
			if(PLAYER_TALENT_RUNES[SPL_LightHeal] == FALSE)
			{
				Info_AddChoice(DIA_MiltenOW_Teach,B_BuildLearnString(NAME_SPL_LightHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_LightHeal)),DIA_MiltenOW_Teach_Heal);
			};
		};
		if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 2)
		{
			if(PLAYER_TALENT_RUNES[SPL_WindFist] == FALSE)
			{
				Info_AddChoice(DIA_MiltenOW_Teach,B_BuildLearnString(NAME_SPL_WINDFIST,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_WindFist)),DIA_MiltenOW_Teach_Windfist);
			};
			if(PLAYER_TALENT_RUNES[SPL_InstantFireball] == FALSE)
			{
				Info_AddChoice(DIA_MiltenOW_Teach,B_BuildLearnString(NAME_SPL_InstantFireball,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_InstantFireball)),DIA_MiltenOW_Teach_Feuerball);
			};
			if(PLAYER_TALENT_RUNES[SPL_Icebolt] == FALSE)
			{
				Info_AddChoice(DIA_MiltenOW_Teach,B_BuildLearnString(NAME_SPL_Icebolt,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Icebolt)),DIA_MiltenOW_Teach_Eispfeil);
			};
		};
	};
};

func void DIA_MiltenOW_Teach_BACK()
{
	Info_ClearChoices(DIA_MiltenOW_Teach);
};

func void DIA_MiltenOW_Teach_Windfist()
{
	B_TeachPlayerTalentRunes(self,other,SPL_WindFist);
};

func void DIA_MiltenOW_Teach_Feuerball()
{
	B_TeachPlayerTalentRunes(self,other,SPL_InstantFireball);
};

func void DIA_MiltenOW_Teach_Eispfeil()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Icebolt);
};

func void DIA_MiltenOW_Teach_Heal()
{
	B_TeachPlayerTalentRunes(self,other,SPL_LightHeal);
};

func void DIA_MiltenOW_Teach_Light()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Light);
};

var int Milten_OW_TeachMANA_NoPerm;

func void B_BuildLearnDialog_Milten_OW()
{
	if(other.aivar[REAL_MANA_MAX] >= T_MED)
	{
		AI_Output(self,other,"DIA_MiltenOW_Mana_03_00");	//Your magic power is great. Too great for me to be able to help you to increase it.
		Milten_OW_TeachMANA_NoPerm = TRUE;
	}
	else
	{
		Info_ClearChoices(DIA_MiltenOW_Mana);
		Info_AddChoice(DIA_MiltenOW_Mana,Dialog_Back,DIA_MiltenOW_Mana_BACK);
		Info_AddChoice(DIA_MiltenOW_Mana,B_BuildLearnString(PRINT_LearnMANA1,B_GetLearnCostAttribute(other,ATR_MANA_MAX)),DIA_MiltenOW_Mana_1);
		Info_AddChoice(DIA_MiltenOW_Mana,B_BuildLearnString(PRINT_LearnMANA5,B_GetLearnCostAttribute(other,ATR_MANA_MAX) * 5),DIA_MiltenOW_Mana_5);
	};
};

instance DIA_MiltenOW_Mana(C_Info)
{
	npc = PC_Mage_OW;
	nr = 100;
	condition = DIA_MiltenOW_Mana_Condition;
	information = DIA_MiltenOW_Mana_Info;
	permanent = TRUE;
	description = "I want to increase my magic powers.";
};


func int DIA_MiltenOW_Mana_Condition()
{
	if((other.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_MiltenOW_Lehren) && (Kapitel == 2) && (Milten_OW_TeachMANA_NoPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Mana_Info()
{
	AI_Output(other,self,"DIA_MiltenOW_Mana_15_00");	//I want to increase my magic powers.
	B_BuildLearnDialog_Milten_OW();
};

func void DIA_MiltenOW_Mana_BACK()
{
	Info_ClearChoices(DIA_MiltenOW_Mana);
};

func void DIA_MiltenOW_Mana_1()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,1,T_MED))
	{
		B_BuildLearnDialog_Milten_OW();
	};
};

func void DIA_MiltenOW_Mana_5()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,5,T_MED))
	{
		B_BuildLearnDialog_Milten_OW();
	};
};

instance DIA_MiltenOW_Perm(C_Info)
{
	npc = PC_Mage_OW;
	nr = 101;
	condition = DIA_MiltenOW_Perm_Condition;
	information = DIA_MiltenOW_Perm_Info;
	permanent = TRUE;
	description = "What's your job here?";
};


func int DIA_MiltenOW_Perm_Condition()
{
	if((Kapitel == 2) && !Npc_KnowsInfo(other,DIA_MiltenOW_Frei))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Perm_Info()
{
	AI_Output (other, self, "DIA_MiltenOW_Perm_15_00");	//What is your task here?
	AI_Output (self, other, "DIA_MiltenOW_Perm_03_01");	//Originally, I was supposed to assay the magic ore. But we haven't seen much of that so far.
	AI_Output (self, other, "DIA_MiltenOW_Perm_03_02");	//Now I'm concentrating on the study of alchemy.
};


instance DIA_MiltenOW_Plan(C_Info)
{
	npc = PC_Mage_OW;
	nr = 101;
	condition = DIA_MiltenOW_Plan_Condition;
	information = DIA_MiltenOW_Plan_Info;
	permanent = TRUE;
	description = "What are your plans?";
};


func int DIA_MiltenOW_Plan_Condition()
{
	if((Kapitel == 2) && Npc_KnowsInfo(other,DIA_MiltenOW_Frei))
	{
		return TRUE;
	};
};

func void DIA_MiltenOW_Plan_Info()
{
	AI_Output (other, self, "DIA_MiltenOW_Plan_15_00");	//What are your plans?
	AI_Output (self, other, "DIA_MiltenOW_Plan_03_01");	//I shall return. I will wait for a while, but now that Gorn is free, I can take off together with him.
	AI_Output (self, other, "DIA_MiltenOW_Plan_03_02");	//It is more than necessary that Pyrokar learns of the situation here.
	AI_Output (other, self, "DIA_MiltenOW_Plan_15_03");	//If you think so.
	AI_Output (self, other, "DIA_MiltenOW_Plan_03_04");	//I hope that Lord Hagen will recognize the threat that emanates from this valley. Not to think of what will happen if the orcs come over the pass.
	AI_Output (other, self, "DIA_MiltenOW_Plan_15_05");	//Well, then, have a safe trip.
};


instance DIA_MiltenOW_PICKPOCKET(C_Info)
{
	npc = PC_Mage_OW;
	nr = 888;
	condition = DIA_MiltenOW_PICKPOCKET_Condition;
	information = DIA_MiltenOW_PICKPOCKET_Info;
	permanent = TRUE;
	description = "(It would be difficult to steal his potion)";
};


func int DIA_MiltenOW_PICKPOCKET_Condition()
{
//	return C_StealItems(80,Hlp_GetInstanceID(ItPo_Perm_Mana),1);
	if(Npc_HasItems(self,ItPo_Perm_Mana))
	{
		return C_StealItem(80);
	};
	return FALSE;
};

func void DIA_MiltenOW_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_MiltenOW_PICKPOCKET);
	Info_AddChoice(DIA_MiltenOW_PICKPOCKET,Dialog_Back,DIA_MiltenOW_PICKPOCKET_BACK);
	Info_AddChoice(DIA_MiltenOW_PICKPOCKET,DIALOG_PICKPOCKET,DIA_MiltenOW_PICKPOCKET_DoIt);
};

func void DIA_MiltenOW_PICKPOCKET_DoIt()
{
//	B_StealItems(80,Hlp_GetInstanceID(ItPo_Perm_Mana),1);
	B_StealItem(80,Hlp_GetInstanceID(ItPo_Perm_Mana));
	Info_ClearChoices(DIA_MiltenOW_PICKPOCKET);
};

func void DIA_MiltenOW_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_MiltenOW_PICKPOCKET);
};

