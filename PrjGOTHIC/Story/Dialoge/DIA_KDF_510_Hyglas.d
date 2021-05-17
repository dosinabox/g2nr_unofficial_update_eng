
instance DIA_Hyglas_Kap1_EXIT(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 999;
	condition = DIA_Hyglas_Kap1_EXIT_Condition;
	information = DIA_Hyglas_Kap1_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Hyglas_Kap1_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Hyglas_Kap1_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Hyglas_Feuer(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 2;
	condition = DIA_Hyglas_Feuer_Condition;
	information = DIA_Hyglas_Feuer_Info;
	permanent = FALSE;
	description = "I demand the Test of Fire.";
};


func int DIA_Hyglas_Feuer_Condition()
{
	if((other.guild == GIL_NOV) && (KNOWS_FIRE_CONTEST == TRUE) && !Npc_KnowsInfo(other,DIA_Pyrokar_FIRE) && Npc_KnowsInfo(other,DIA_Hyglas_JOB))
	{
		return TRUE;
	};
};

func void DIA_Hyglas_Feuer_Info()
{
	AI_Output (other, self, "DIA_Hyglas_Feuer_15_00");	//I demand the Test of Fire.
	AI_Output (self, other, "DIA_Hyglas_Feuer_14_01");	//The Test of Fire is from the olden days and has not been held for a long time.
	AI_Output (self, other, "DIA_Hyglas_Feuer_14_02");	//What you are demanding is far too dangerous. So just don't think about it any more.
};


instance DIA_Hyglas_Hallo(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 2;
	condition = DIA_Hyglas_Hallo_Condition;
	information = DIA_Hyglas_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Hyglas_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Hyglas_Hallo_Info()
{
	AI_Output (self, other, "DIA_Hyglas_Hallo_14_00");	//I am Master Hyglas, Guardian of the Fire and Keeper of Knowledge.
	if (other.guild == GIL_NOV)
	{
		AI_Output (self, other, "DIA_Hyglas_Hallo_14_01");	//So Master Parlan has given you permission to study the scriptures.
		AI_Output (self, other, "DIA_Hyglas_Hallo_14_02");	//Then it's up to you now to do exactly that. Study, so that you may find enlightenment in the scriptures.
	};
};


instance DIA_Hyglas_JOB(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 2;
	condition = DIA_Hyglas_JOB_Condition;
	information = DIA_Hyglas_JOB_Info;
	permanent = FALSE;
	description = "What are you studying, Master?";
};


func int DIA_Hyglas_JOB_Condition()
{
	return TRUE;
};

func void DIA_Hyglas_JOB_Info()
{
	AI_Output (other, self, "DIA_Hyglas_JOB_15_00");	//What are you studying, Master?
	AI_Output (self, other, "DIA_Hyglas_JOB_14_01");	//My research focuses on fire - the power of Innos.
	AI_Output (self, other, "DIA_Hyglas_JOB_14_02");	//It is his gift and, at the same time, a mighty weapon - and I create runes which contain this power.
	if (other.guild == GIL_NOV)
	{
		AI_Output(other,self,"DIA_Hyglas_JOB_15_03");	//Very enlightening. Can you teach me that?
		AI_Output(self,other,"DIA_Hyglas_JOB_14_04");	//It is Innos who grants the magic. Only to his servants, the Magicians of Fire, is it given to learn how to wield this power.
		Log_CreateTopic(Topic_KlosterTeacher,LOG_NOTE);
		B_LogEntry(Topic_KlosterTeacher,"Master Hyglas can introduce me into the arcana of fire. But for that I need to be a Magician of Fire.");
	};
	if((other.guild == GIL_KDF) && !Npc_KnowsInfo(other,DIA_Pyrokar_Lernen))
	{
		Log_CreateTopic(Topic_KlosterTeacher,LOG_NOTE);
		B_LogEntry(Topic_KlosterTeacher,"Master Hyglas can introduce me into the arcana of fire.");
	};
};


instance DIA_Hyglas_CONTEST(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 9;
	condition = DIA_Hyglas_CONTEST_Condition;
	information = DIA_Hyglas_CONTEST_Info;
	permanent = FALSE;
	description = "I have demanded the Test of Fire.";
};


func int DIA_Hyglas_CONTEST_Condition()
{
	if((MIS_Rune == LOG_Running) && Npc_KnowsInfo(other,DIA_Hyglas_JOB))
	{
		return TRUE;
	};
};

func void DIA_Hyglas_CONTEST_Info()
{
	AI_Output (other, self, "DIA_Hyglas_CONTEST_15_00");	//I have demanded the Test of Fire. Ulthar gave me the task to create a fire arrow rune.
	AI_Output (self, other, "DIA_Hyglas_CONTEST_14_01");	//And now you want me to teach you the formula?
	AI_Output (other, self, "DIA_Hyglas_CONTEST_15_02");	//I don't know how else I could do it.
	AI_Output (self, other, "DIA_Hyglas_CONTEST_14_03");	//Hmm ...
	AI_Output (self, other, "DIA_Hyglas_CONTEST_14_04");	//All right, I shall teach you the formula. But first you need to find all the necessary ingredients.
	B_LogEntry (TOPIC_Rune, "Hyglas is willing to teach me the formula for the Fire Arrow rune once I've got all the ingredients.");
};


instance DIA_Hyglas_TALENT_FIREBOLT(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 800;
	condition = DIA_Hyglas_TALENT_FIREBOLT_Condition;
	information = DIA_Hyglas_TALENT_FIREBOLT_Info;
	permanent = TRUE;
	description = B_BuildLearnString("Fire Arrow rune",B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Firebolt));
};


func int DIA_Hyglas_TALENT_FIREBOLT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Hyglas_CONTEST) && (PLAYER_TALENT_RUNES[SPL_Firebolt] == FALSE))
	{
		return TRUE;
	};
};

var int Firebolt_Scroll_Once;

func void DIA_Hyglas_TALENT_FIREBOLT_Info()
{
	AI_Output(other,self,"DIA_Hyglas_TALENT_FIREBOLT_15_00");	//Teach me to create the FIRE ARROW rune.
	if(Npc_HasItems(other,ItSc_Firebolt) && Npc_HasItems(other,ItMi_RuneBlank) && Npc_HasItems(other,ItMi_Sulfur))
	{
		if(B_TeachPlayerTalentRunes(self,other,SPL_Firebolt))
		{
			AI_Output (self, other, "DIA_Hyglas_TALENT_FIREBOLT_14_01");	//In order to create a fire arrow rune, you need to join the sulphur with the runestone at the rune table.
			AI_Output (self, other, "DIA_Hyglas_TALENT_FIREBOLT_14_02");	//The power of the fire arrow spell scroll will flow into the rune, and you will possess a tool of Innos.
			AI_Output (self, other, "DIA_Hyglas_TALENT_FIREBOLT_14_03");	//So, once you have all the raw materials, walk over to the rune table and create your rune.
		};
	}
	else
	{
		AI_Output(self,other,"DIA_Hyglas_CONTEST_14_04");	//All right, I shall teach you the formula. But first you need to find all the necessary ingredients.
		if(Firebolt_Scroll_Once == FALSE)
		{
			if(!Npc_HasItems(other,ItSc_Firebolt))
			{
				B_LogEntry(TOPIC_Rune,"I don't have a fire arrow scroll, Hyglas will not teach me until I get one.+");
				if(!Npc_IsDead(Gorax))
				{
					CreateInvItem(Gorax,ItSc_Firebolt);
					B_LogEntry(TOPIC_Rune,"I can probably but the scroll from Gorax.");
				}
				else
				{
					Wld_InsertItem(ItSc_Firebolt,"FP_ITEM_KLOSTER_01");
					B_LogEntry(TOPIC_Rune,"It looks like I will have to scour the entire monastery for this scroll.");
				};
				Firebolt_Scroll_Once = TRUE;
			};
		};
		AI_StopProcessInfos(self);
	};
};


instance DIA_Hyglas_FIREBOLT(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 9;
	condition = DIA_Hyglas_FIREBOLT_Condition;
	information = DIA_Hyglas_FIREBOLT_Info;
	permanent = TRUE;
	description = "What ingredients do I need for a fire arrow rune?";
};


func int DIA_Hyglas_FIREBOLT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Hyglas_CONTEST) && (PLAYER_TALENT_RUNES[SPL_Firebolt] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Hyglas_FIREBOLT_Info()
{
	AI_Output(other,self,"DIA_Hyglas_FIREBOLT_15_00");	//What ingredients do I need for a fire arrow rune?
	AI_Output(self,other,"DIA_Hyglas_FIREBOLT_14_01");	//Read up on it - it's right there in the books.
};


instance DIA_Hyglas_BLANK_RUNE(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 9;
	condition = DIA_Hyglas_BLANK_RUNE_Condition;
	information = DIA_Hyglas_BLANK_RUNE_Info;
	permanent = FALSE;
	description = "Where can I find a runestone?";
};


func int DIA_Hyglas_BLANK_RUNE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Hyglas_CONTEST) && (MIS_Rune == LOG_Running) && !Npc_HasItems(other,ItMi_RuneBlank) && (PLAYER_TALENT_RUNES[SPL_Firebolt] == FALSE))
	{
		if(SC_KnowsBlankRuneForFirebolt == TRUE)
		{
			return TRUE;
		};
	};
};

func void DIA_Hyglas_BLANK_RUNE_Info()
{
	AI_Output (other, self, "DIA_Hyglas_BLANK_RUNE_15_00");	//Where can I find a runestone?
	AI_Output (self, other, "DIA_Hyglas_BLANK_RUNE_14_01");	//Hey, it's you who demanded the test of the Fire - not I. Finding that out is part of the test.
};


instance DIA_Hyglas_GOTRUNE(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 2;
	condition = DIA_Hyglas_GOTRUNE_Condition;
	information = DIA_Hyglas_GOTRUNE_Info;
	permanent = FALSE;
	description = "I've created the rune.";
};


func int DIA_Hyglas_GOTRUNE_Condition()
{
	if((MIS_Rune == LOG_Running) && Npc_HasItems(other,ItRu_FireBolt) && !Npc_KnowsInfo(other,DIA_Ulthar_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Hyglas_GOTRUNE_Info()
{
	AI_Output (other, self, "DIA_Hyglas_GOTRUNE_15_00");	//I've created the rune.
	AI_Output (self, other, "DIA_Hyglas_GOTRUNE_14_01");	//Well, well. You seem to have passed this test. That wasn't so hard, after all.
	AI_Output (self, other, "DIA_Hyglas_GOTRUNE_14_02");	//Then go to Ulthar now and show him your work.
	B_LogEntry (TOPIC_Rune, "I have created a Fire Arrow rune.");
};


instance DIA_Hyglas_TEACH(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 15;
	condition = DIA_Hyglas_TEACH_Condition;
	information = DIA_Hyglas_TEACH_Info;
	permanent = TRUE;
	description = "Teach me.";
};


func int DIA_Hyglas_TEACH_Condition()
{
	if((other.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_Hyglas_JOB))
	{
		return TRUE;
	};
};

func void DIA_Hyglas_TEACH_Info()
{
	var int abletolearn;
	abletolearn = 0;
	DIA_Common_WantToLearnNewRunes();
	Info_ClearChoices(DIA_Hyglas_TEACH);
	Info_AddChoice(DIA_Hyglas_TEACH,Dialog_Back,DIA_Hyglas_TEACH_BACK);
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 2) && (PLAYER_TALENT_RUNES[SPL_InstantFireball] == FALSE))
	{
		Info_AddChoice(DIA_Hyglas_TEACH,B_BuildLearnString(NAME_SPL_InstantFireball,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_InstantFireball)),DIA_Hyglas_TEACH_InstantFireball);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 3) && (PLAYER_TALENT_RUNES[SPL_Firestorm] == FALSE))
	{
		Info_AddChoice(DIA_Hyglas_TEACH,B_BuildLearnString(NAME_SPL_Firestorm,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Firestorm)),DIA_Hyglas_TEACH_Firestorm);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 4) && (PLAYER_TALENT_RUNES[SPL_ChargeFireball] == FALSE))
	{
		Info_AddChoice(DIA_Hyglas_TEACH,B_BuildLearnString(NAME_SPL_ChargeFireball,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_ChargeFireball)),DIA_Hyglas_TEACH_ChargeFireball);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 5) && (PLAYER_TALENT_RUNES[SPL_Pyrokinesis] == FALSE))
	{
		Info_AddChoice(DIA_Hyglas_TEACH,B_BuildLearnString(NAME_SPL_Pyrokinesis,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Pyrokinesis)),DIA_Hyglas_TEACH_Pyrokinesis);
		abletolearn += 1;
	};
	if((Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 6) && (PLAYER_TALENT_RUNES[SPL_Firerain] == FALSE))
	{
		Info_AddChoice(DIA_Hyglas_TEACH,B_BuildLearnString(NAME_SPL_Firerain,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Firerain)),DIA_Hyglas_TEACH_Firerain);
		abletolearn += 1;
	};
	if(abletolearn < 1)
	{
		if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 0)
		{
			B_Say(self,other,"$NOLEARNNOPOINTS");
			PrintScreen(PRINT_MAGCIRCLES_NEEDFIRST,-1,-1,FONT_ScreenSmall,2);
		}
		else
		{
			B_Say(self,other,"$NOLEARNOVERPERSONALMAX");
		};
		Info_ClearChoices(DIA_Hyglas_TEACH);
	};
};

func void DIA_Hyglas_TEACH_BACK()
{
	Info_ClearChoices(DIA_Hyglas_TEACH);
};

func void DIA_Hyglas_TEACH_InstantFireball()
{
	B_TeachPlayerTalentRunes(self,other,SPL_InstantFireball);
};

func void DIA_Hyglas_TEACH_ChargeFireball()
{
	B_TeachPlayerTalentRunes(self,other,SPL_ChargeFireball);
};

func void DIA_Hyglas_TEACH_Pyrokinesis()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Pyrokinesis);
};

func void DIA_Hyglas_TEACH_Firestorm()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Firestorm);
};

func void DIA_Hyglas_TEACH_Firerain()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Firerain);
};

instance DIA_Hyglas_BringBook(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 38;
	condition = DIA_Hyglas_BringBook_Condition;
	information = DIA_Hyglas_BringBook_Info;
	permanent = FALSE;
	description = "Any news?";
};


func int DIA_Hyglas_BringBook_Condition()
{
	if((Kapitel >= 3) && (hero.guild != GIL_SLD) && (hero.guild != GIL_DJG))
	{
		return TRUE;
	};
};

func void DIA_Hyglas_BringBook_Info()
{
	AI_Output (other, self, "DIA_Hyglas_BringBook_15_00");	//Any news?
	AI_Output (self, other, "DIA_Hyglas_BringBook_14_01");	//Hm, yes. Well, you have probably noticed those black-robed figures.
	AI_Output (other, self, "DIA_Hyglas_BringBook_15_02");	//I've met them.
	AI_Output (self, other, "DIA_Hyglas_BringBook_14_03");	//This brings us to the core of the matter. At the moment, we are observing a very rare constellation of stars.
	AI_Output (self, other, "DIA_Hyglas_BringBook_14_04");	//To be more exact, the sign of the Ox currently stands in direct correlation with the sign of the Warrior. I suppose that you know what that means.
	AI_Output (other, self, "DIA_Hyglas_BringBook_15_05");	//Hmm. Well, to be honest ...
	AI_Output (self, other, "DIA_Hyglas_BringBook_14_06");	//Yes, right, I see. Well, I cannot explain the entire background to you now, but it definitely signifies great changes. And I do not like changes.
	AI_Output (self, other, "DIA_Hyglas_BringBook_14_07");	//Therefore, I want you to get me a book from town. It is called 'The divine power of the stars'. You may have to rummage around for it a bit, but I'm sure that you can find it.
	Info_ClearChoices (DIA_Hyglas_BringBook);
	Info_AddChoice (DIA_Hyglas_BringBook, "Get the book yourself.", DIA_Hyglas_BringBook_GetItYourself);
	Info_AddChoice (DIA_Hyglas_BringBook, "What's in it for me?", DIA_Hyglas_BringBook_GetForIt);
	Info_AddChoice (DIA_Hyglas_BringBook, "I'll see whether I can find it.", DIA_Hyglas_BringBook_Yes);
};

func void DIA_Hyglas_BringBook_GetItYourself()
{
	AI_Output (other, self, "DIA_Hyglas_BringBook_GetItYourself_15_00");	//Get the book yourself.
	AI_Output (self, other, "DIA_Hyglas_BringBook_GetItYourself_14_01");	//You dare speak to me in such a tone? Your behavior does not show the respect that is due to me.
	AI_Output (self, other, "DIA_Hyglas_BringBook_GetItYourself_14_02");	//Get out of my sight and think about your behavior.
	MIS_HyglasBringBook = LOG_OBSOLETE;
	Info_ClearChoices(DIA_Hyglas_BringBook);
};

func void DIA_Hyglas_BringBook_GetForIt()
{
	AI_Output (other, self, "DIA_Hyglas_BringBook_GetForIt_15_00");	//What's in it for me?
	AI_Output (self, other, "DIA_Hyglas_BringBook_GetForIt_14_01");	//What do you mean?
	AI_Output (other, self, "DIA_Hyglas_BringBook_GetForIt_15_02");	//I'd like to know what you'll give me if I bring you the book.
	AI_Output (self, other, "DIA_Hyglas_BringBook_GetForIt_14_03");	//Nothing. What were you expecting to get? If you have time to run an errand in town for me, it is even your duty to help me.
	Info_ClearChoices (DIA_Hyglas_BringBook);
};

func void DIA_Hyglas_BringBook_Yes()
{
	AI_Output (other, self, "DIA_Hyglas_BringBook_Yes_15_00");	//I'll see whether I can find it.
	AI_Output (self, other, "DIA_Hyglas_BringBook_Yes_14_01");	//That's good - it frees up my time so I can follow some other trails as well.
	AI_Output (self, other, "DIA_Hyglas_BringBook_Yes_14_02");	//But don't take too much time. Time, I'm afraid, is what we have the least of.
	MIS_HyglasBringBook = LOG_Running;
	Info_ClearChoices (DIA_Hyglas_BringBook);
	Log_CreateTopic (TOPIC_HyglasBringBook, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_HyglasBringBook, LOG_Running);
	B_LogEntry (TOPIC_HyglasBringBook, "Hyglas wants me to get him the book 'The Divine Power of the Stars'. I'm to look for it among the merchants in town.");
};


instance DIA_Hyglas_HaveBook(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 38;
	condition = DIA_Hyglas_HaveBook_Condition;
	information = DIA_Hyglas_HaveBook_Info;
	permanent = FALSE;
	description = "I've got the book for you.";
};


func int DIA_Hyglas_HaveBook_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Hyglas_BringBook) && Npc_HasItems(other,ItWr_Astronomy_Mis))
	{
		return TRUE;
	};
};

func void DIA_Hyglas_HaveBook_Info()
{
	AI_Output (other, self, "DIA_Hyglas_HaveBook_15_00");	//I've got the book for you.
	if (MIS_HyglasBringBook == LOG_Running)
	{
		AI_Output (self, other, "DIA_Hyglas_HaveBook_14_01");	//Very good, give here.
	}
	else
	{
		AI_Output (self, other, "DIA_Hyglas_HaveBook_14_02");	//So you changed your mind after all. Very good. So where do you have the book?
	};
	B_GiveInvItems(other,self,ItWr_Astronomy_Mis,1);
	MIS_HyglasBringBook = LOG_SUCCESS;
	B_GivePlayerXP(XP_HyglasBringBook);
	AI_Output(self,other,"DIA_Hyglas_HaveBook_14_03");	//You may withdraw now. I shall retire and study.
};


instance DIA_Hyglas_Kap4_PERM(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 49;
	condition = DIA_Hyglas_Kap4_PERM_Condition;
	information = DIA_Hyglas_Kap4_PERM_Info;
	permanent = TRUE;
	description = "Found anything out yet?";
};


func int DIA_Hyglas_Kap4_PERM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Hyglas_BringBook))
	{
		return TRUE;
	};
};

func void DIA_Hyglas_Kap4_PERM_Info()
{
	AI_Output (other, self, "DIA_Hyglas_Kap4_PERM_15_00");	//Found anything out yet?
	if (MIS_HyglasBringBook == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Hyglas_Kap4_PERM_14_01");	//Well, I cannot be completely sure, but the current constellation of the stars seems to indicate many dangers.
		AI_Output (other, self, "DIA_Hyglas_Kap4_PERM_15_02");	//What kind of dangers?
		AI_Output (self, other, "DIA_Hyglas_Kap4_PERM_14_03");	//Well, the structure between the worlds seems to be very weak. It only takes a small portion of the power that would be necessary otherwise to tear a hole into this structure.
		AI_Output (self, other, "DIA_Hyglas_Kap4_PERM_14_04");	//Demons could use those portals to enter our world without encountering resistance.
//		Hyglas_SendsToKarras = TRUE;
	}
	else if(MIS_HyglasBringBook == LOG_Running)
	{
		AI_Output (self, other, "DIA_Hyglas_Kap4_PERM_14_05");	//No, I am still waiting for that book.
	}
	else
	{
		AI_Output (self, other, "DIA_Hyglas_Kap4_PERM_14_06");	//I told you that I am still doing some research, but of course that will take longer if I do not have the necessary materials.
	};
};


instance DIA_Hyglas_PICKPOCKET(C_Info)
{
	npc = KDF_510_Hyglas;
	nr = 900;
	condition = DIA_Hyglas_PICKPOCKET_Condition;
	information = DIA_Hyglas_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Hyglas_PICKPOCKET_Condition()
{
	return C_Beklauen(73,200);
};

func void DIA_Hyglas_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Hyglas_PICKPOCKET);
	Info_AddChoice(DIA_Hyglas_PICKPOCKET,Dialog_Back,DIA_Hyglas_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Hyglas_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Hyglas_PICKPOCKET_DoIt);
};

func void DIA_Hyglas_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Hyglas_PICKPOCKET);
};

func void DIA_Hyglas_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Hyglas_PICKPOCKET);
};

