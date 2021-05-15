
instance DIA_Bosper_EXIT(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 999;
	condition = DIA_Bosper_EXIT_Condition;
	information = DIA_Bosper_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Bosper_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Bosper_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Bosper_HALLO(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 2;
	condition = DIA_Bosper_HALLO_Condition;
	information = DIA_Bosper_HALLO_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Bosper_HALLO_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Bosper_HALLO_Info()
{
	AI_Output (self, other, "DIA_Bosper_HALLO_11_00");	//Welcome to my shop, stranger!
	AI_Output (self, other, "DIA_Bosper_HALLO_11_01");	//I am Bosper. I craft bows and trade in furs.
	AI_Output (self, other, "DIA_Bosper_HALLO_11_02");	//What brings you to Khorinis?
	Log_CreateTopic (TOPIC_CityTrader, LOG_NOTE);
	B_LogEntry (TOPIC_CityTrader, "Bosper makes bows and trades in hides. His shop's at the eastern gate, in the lower part of town.");
};


instance DIA_Bosper_IntoOV(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 1;
	condition = DIA_Bosper_IntoOV_Condition;
	information = DIA_Bosper_IntoOV_Info;
	permanent = FALSE;
	description = "I need to get into the upper quarter ...";
};


func int DIA_Bosper_IntoOV_Condition()
{
	if((hero.guild == GIL_NONE) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Bosper_IntoOV_Info()
{
	AI_Output (other, self, "DIA_Bosper_IntoOV_15_00");	//I need to get into the upper quarter ...
	AI_Output (self, other, "DIA_Bosper_IntoOV_11_01");	//Where the paladins are? Forget it.
	AI_Output (self, other, "DIA_Bosper_IntoOV_11_02");	//You need to be a respected citizen here, or at least hold a decent job.
	AI_Output (self, other, "DIA_Bosper_IntoOV_11_03");	//As a stranger, you stand no chance of getting in.
	if (Torwache_305.aivar[AIV_TalkedToPlayer] == TRUE)
	{
		AI_Output (other, self, "DIA_Bosper_IntoOV_15_04");	//So I noticed ...
	};
	Log_CreateTopic (TOPIC_OV, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_OV, LOG_Running);
	B_LogEntry (TOPIC_OV, "To gain access to the upper quarter, I must either become a respectable citizen or get a job.");
};


instance DIA_Bosper_SeekWork(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 2;
	condition = DIA_Bosper_SeekWork_Condition;
	information = DIA_Bosper_SeekWork_Info;
	permanent = FALSE;
	description = "I'm looking for work.";
};


func int DIA_Bosper_SeekWork_Condition()
{
	return TRUE;
};

func void DIA_Bosper_SeekWork_Info()
{
	AI_Output (other, self, "DIA_Bosper_SeekWork_15_00");	//I'm looking for work!
	AI_Output (self, other, "DIA_Bosper_SeekWork_11_01");	//Mmh - I could use a new apprentice.
	AI_Output (self, other, "DIA_Bosper_SeekWork_11_02");	//The last one just gave up his job two days ago.
	AI_Output (self, other, "DIA_Bosper_SeekWork_11_03");	//Do you know anything about hunting, then?
	if (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE)
	{
		AI_Output (other, self, "DIA_Bosper_SeekWork_15_04");	//Weeell ...
		AI_Output (self, other, "DIA_Bosper_SeekWork_11_05");	//I could teach you how to skin animals.
		AI_Output (self, other, "DIA_Bosper_SeekWork_11_06");	//I'll pay you well for every skin you bring me.
	}
	else
	{
		AI_Output (other, self, "DIA_Bosper_SeekWork_15_07");	//I can get you some skins if that's what you mean.
		AI_Output (self, other, "DIA_Bosper_SeekWork_11_08");	//Excellent! Bring me as many animal skins as you can - I will buy them from you for a good price.
	};
	if(Player_IsApprentice == APP_NONE)
	{
		Log_CreateTopic(TOPIC_Lehrling,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Lehrling,LOG_Running);
		B_LogEntry(TOPIC_Lehrling,"Bosper's looking for a new apprentice. I could start work with him.");
	};
};


var int Bosper_HintToJob;
var int Bosper_StartGuild;

instance DIA_Bosper_LEHRLING(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 2;
	condition = DIA_Bosper_LEHRLING_Condition;
	information = DIA_Bosper_LEHRLING_Info;
	permanent = TRUE;
	description = "I want to start as your apprentice!";
};


func int DIA_Bosper_LEHRLING_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bosper_SeekWork) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Bosper_LEHRLING_Info()
{
	var int stimmen;
	stimmen = 0;
	AI_Output (other, self, "DIA_Bosper_LEHRLING_15_00");	//I want to start as your apprentice!
	if (MIS_Bosper_WolfFurs == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Bosper_LEHRLING_11_01");	//(grins) Great! You seem to know the basics already.
		stimmen += 1;
		if(Harad.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			if((MIS_Harad_Orc == LOG_SUCCESS) || (MIS_HakonBandits == LOG_SUCCESS))
			{
				AI_Output(self,other,"DIA_Bosper_LEHRLING_11_02");	//Harad thinks you're a good man.
				stimmen += 1;
			}
			else
			{
				AI_Output(self,other,"DIA_Bosper_LEHRLING_11_03");	//But Harad isn't convinced of your abilities.
			};
		}
		else
		{
			AI_Output(self,other,"DIA_Bosper_LEHRLING_11_04");	//But Harad says he's never seen you.
		};
		if(Thorben.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			if(MIS_Thorben_GetBlessings == LOG_SUCCESS)
			{
				AI_Output(self,other,"DIA_Bosper_LEHRLING_11_05");	//Thorben gave you his blessing. I'm not all that pious, but I'm fine with it.
				stimmen += 1;
			}
			else
			{
				AI_Output(self,other,"DIA_Bosper_LEHRLING_11_06");	//Thorben will only give you his approval with the blessing of the gods.
			};
			};
		}
		else
		{
			AI_Output(self,other,"DIA_Bosper_LEHRLING_11_07");	//Thorben has no idea who you are.
		};
		if(Constantino.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			if(B_GetGreatestPetzCrime(self) == CRIME_NONE)
			{
				AI_Output(self,other,"DIA_Bosper_LEHRLING_11_08");	//Constantino says you can sign up wherever you want for all he cares.
				stimmen += 1;
			}
			else
			{
				AI_Output (self, other, "DIA_Bosper_LEHRLING_11_09");	//Constantino says you're being accused of a crime here in town - I hope that this is something trivial?
				AI_Output (self, other, "DIA_Bosper_LEHRLING_11_10");	//See to it that the matter gets cleared up.
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Bosper_LEHRLING_11_11");	//Constantino has never even heard of you.
		};
		if(Matteo.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			if(MIS_Matteo_Gold == LOG_SUCCESS)
			{
				AI_Output(self,other,"DIA_Bosper_LEHRLING_11_12");	//And Matteo says you're worth your weight in gold.
				stimmen += 1;
			}
			else if(MIS_Matteo_Gold == LOG_Running)
			{
				AI_Output(self,other,"DIA_Bosper_LEHRLING_11_13");	//And Matteo mentioned some debts - whatever he meant by that, you had better talk to him.
			}
			else if(MIS_Matteo_Gold == LOG_FAILED)
			{
				AI_Output(self,other,"DIA_Bosper_LEHRLING_11_15");	//Matteo says he has never seen you before in his life.
			}
			else
			{
				AI_Output (self, other, "DIA_Bosper_LEHRLING_11_14");	//Matteo says he has not yet talked to you about this.
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Bosper_LEHRLING_11_15");	//Matteo says he has never seen you before in his life.
		};
		if(stimmen >= 4)
		{
			if(stimmen == 5)
			{
				AI_Output (self, other, "DIA_Bosper_LEHRLING_11_16");	//This means you have the approval of all masters!
			}
			else
			{
				AI_Output (self, other, "DIA_Bosper_LEHRLING_11_17");	//You now have the approval of four masters. That will suffice for you to be accepted as an apprentice.
			};
			AI_Output (self, other, "DIA_Bosper_LEHRLING_11_18");	//You can work for me at any time if you want.
			Info_ClearChoices (DIA_Bosper_LEHRLING);
			Info_AddChoice (DIA_Bosper_LEHRLING, "Good - I'll think about it.", DIA_Bosper_LEHRLING_Later);
			Info_AddChoice (DIA_Bosper_LEHRLING, "I'm in!", DIA_Bosper_LEHRLING_OK);
		}
		else
		{
			AI_Output (self, other, "DIA_Bosper_LEHRLING_11_19");	//You need the approval of at least four masters in order to be able to start an apprenticeship in the lower part of town.
			AI_Output (self, other, "DIA_Bosper_LEHRLING_11_20");	//This means that you should talk to all those who do not quite approve of you yet.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Bosper_LEHRLING_11_21");	//Before I take you on I need to know, of course, whether you're any good at all.
		if (MIS_Bosper_Bogen == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_Bosper_LEHRLING_11_22");	//You brought me back my bow, but that doesn't say much about your talent as a hunter.
		};
		Bosper_HintToJob = TRUE;
	};
};

func void DIA_Bosper_LEHRLING_OK()
{
	AI_Output (other, self, "DIA_Bosper_LEHRLING_OK_15_00");	//I'm in!
	AI_Output (self, other, "DIA_Bosper_LEHRLING_OK_11_01");	//You aren't going to regret this! I think we'll be able to work together well.
	Player_IsApprentice = APP_Bosper;
	if(Hlp_IsValidNpc(Lothar) && !Npc_IsDead(Lothar))
	{
		Npc_ExchangeRoutine(Lothar,"START");
	};
	Bosper_StartGuild = other.guild;
	Bosper_Lehrling_Day = Wld_GetDay();
	Wld_AssignRoomToGuild("gritta",GIL_NONE);
	MIS_Apprentice = LOG_SUCCESS;
	B_GivePlayerXP(XP_Lehrling);
	Log_CreateTopic(Topic_Bonus,LOG_NOTE);
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
	{
		B_LogEntry(Topic_Bonus,"Bosper has accepted me as his apprentice. I now have access to the upper quarter.");
	}
	else
	{
		B_LogEntry(Topic_Bonus,"Bosper has accepted me as his apprentice.");
	};
	Info_ClearChoices(DIA_Bosper_LEHRLING);
};

func void DIA_Bosper_LEHRLING_Later()
{
	AI_Output (other, self, "DIA_Bosper_LEHRLING_Later_15_00");	//Good - I'll think about it.
	AI_Output (self, other, "DIA_Bosper_LEHRLING_Later_11_01");	//Don't make the wrong decision! You'd be perfect for me.
	Info_ClearChoices (DIA_Bosper_LEHRLING);
};


instance DIA_Bosper_OtherMasters(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 3;
	condition = DIA_Bosper_OtherMasters_Condition;
	information = DIA_Bosper_OtherMasters_Info;
	permanent = FALSE;
	description = "What if I want to sign on with one of the other masters?";
};


func int DIA_Bosper_OtherMasters_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bosper_SeekWork) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Bosper_OtherMasters_Info()
{
	AI_Output (other, self, "DIA_Bosper_OtherMasters_15_00");	//What if I want to sign on with one of the other masters?
	AI_Output (self, other, "DIA_Bosper_OtherMasters_11_01");	//(grumpy) Balderdash!
	AI_Output (self, other, "DIA_Bosper_OtherMasters_11_02");	//Harad and Matteo already have apprentices.
	AI_Output (self, other, "DIA_Bosper_OtherMasters_11_03");	//Constantino the alchemist is a loner - and he hasn't taken an apprentice in years.
	AI_Output (self, other, "DIA_Bosper_OtherMasters_11_04");	//And as for Thorben - everyone knows he's dead broke - he probably couldn't even pay you.
	AI_Output (self, other, "DIA_Bosper_OtherMasters_11_05");	//I, on the other hand, am in urgent need of an apprentice - and I pay well, too.
	AI_Output (self, other, "DIA_Bosper_OtherMasters_11_06");	//But no matter where you want to sign on - you need the approval of all other masters from the lower part of town ...
};


instance DIA_Bosper_Bartok(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 4;
	condition = DIA_Bosper_Bartok_Condition;
	information = DIA_Bosper_Bartok_Info;
	permanent = FALSE;
	description = "Why did your apprentice give up his job?";
};


func int DIA_Bosper_Bartok_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bosper_SeekWork))
	{
		return TRUE;
	};
};

func void DIA_Bosper_Bartok_Info()
{
	AI_Output (other, self, "DIA_Bosper_Bartok_15_00");	//Why did your apprentice give up his job?
	AI_Output (self, other, "DIA_Bosper_Bartok_11_01");	//All he said was that it had become too dangerous out there.
	AI_Output (self, other, "DIA_Bosper_Bartok_11_02");	//If you're really interested, then you can ask him yourself.
	AI_Output (self, other, "DIA_Bosper_Bartok_11_03");	//His name is Bartok. He's probably hanging out near Coragon's pub.
	AI_Output (self, other, "DIA_Bosper_Bartok_11_04");	//Go through the underpass from the smithy, then you're headed straight for it.
};


instance DIA_Bosper_ZUSTIMMUNG(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 3;
	condition = DIA_Bosper_ZUSTIMMUNG_Condition;
	information = DIA_Bosper_ZUSTIMMUNG_Info;
	permanent = TRUE;
	description = "Will I get your approval to sign up with a different master?";
};


func int DIA_Bosper_ZUSTIMMUNG_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bosper_OtherMasters) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};


var int Bosper_Zustimmung_Once;

func void DIA_Bosper_ZUSTIMMUNG_Info()
{
	AI_Output (other, self, "DIA_Bosper_ZUSTIMMUNG_15_00");	//Will I get your approval to sign up with a different master?
	if ((MIS_Bosper_Bogen == LOG_SUCCESS) || (MIS_Bosper_WolfFurs == LOG_SUCCESS))
	{
		AI_Output (self, other, "DIA_Bosper_ZUSTIMMUNG_11_01");	//(disappointed) I had hoped you would choose me.
		AI_Output (self, other, "DIA_Bosper_ZUSTIMMUNG_11_02");	//But if that's the way you want it ...
		AI_Output (other, self, "DIA_Bosper_ZUSTIMMUNG_15_03");	//Does that mean you'll vote for me?
		AI_Output (self, other, "DIA_Bosper_ZUSTIMMUNG_11_04");	//If none of the other masters objects - yes.
		if (MIS_Bosper_Bogen == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_Bosper_ZUSTIMMUNG_11_05");	//You brought back my bow, after all.
		};
		if(MIS_Bosper_WolfFurs == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_Bosper_ZUSTIMMUNG_11_06");	//But you would certainly have made a good hunter.
		};
		if(Bosper_Zustimmung_Once == FALSE)
		{
			B_LogEntry(TOPIC_Lehrling,"Bosper will give me his approval to become apprentice of one of the other masters.");
			B_GivePlayerXP(XP_Zustimmung);
			Bosper_Zustimmung_Once = TRUE;
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Bosper_ZUSTIMMUNG_11_07");	//(sighs) All right! You shall have my approval - but on one condition.
		AI_Output (self, other, "DIA_Bosper_ZUSTIMMUNG_11_08");	//Work for me, at least for a short time.
		AI_Output (self, other, "DIA_Bosper_ZUSTIMMUNG_11_09");	//That way you can find out for yourself whether you like my craft or not.
		AI_Output (self, other, "DIA_Bosper_ZUSTIMMUNG_11_10");	//And who knows - maybe you'll end up liking it, and you'll stay with me.
		AI_Output (self, other, "DIA_Bosper_ZUSTIMMUNG_11_11");	//If you're good enough to sign on with ME, you're also good enough for all others here.
		Bosper_HintToJob = TRUE;
	};
};


instance DIA_Bosper_Job(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 2;
	condition = DIA_Bosper_Job_Condition;
	information = DIA_Bosper_Job_Info;
	permanent = FALSE;
	description = "What do you want me to do for you?";
};


func int DIA_Bosper_Job_Condition()
{
	if(Bosper_HintToJob == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Bosper_Job_Info()
{
	AI_Output(other,self,"DIA_Bosper_Job_15_00");	//What do you want me to do for you?
	Log_CreateTopic(TOPIC_BosperWolf,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_BosperWolf,LOG_Running);
	if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE)
	{
		AI_Output(self,other,"DIA_Bosper_Job_11_01");	//I will teach you how to skin an animal, and you will bring me - let's say - half a dozen wolf skins.
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntries(TOPIC_CityTeacher,"Bosper can teach me to skin animals.");
		B_LogNextEntry(TOPIC_BosperWolf,"I'm to bring Bosper six wolf skins. Then I can either work for him, or he'll give his approval so I can work for one of the other masters. But for that I will need to learn how to skin animals first.");
	}
	else
	{
		AI_Output(self,other,"DIA_Bosper_Job_11_02");	//Bring me half a dozen wolf skins.
		B_LogEntry(TOPIC_BosperWolf,"I'm to bring Bosper six wolf skins. Then I can either work for him, or he'll give his approval so I can work for one of the other masters.");
	};
	AI_Output (self, other, "DIA_Bosper_Job_11_03");	//Then I'll know that you have learned your trade.
	AI_Output (self, other, "DIA_Bosper_Job_11_04");	//If it doesn't take you forever and if the skins are in acceptable condition, I will take you on if you like.
	if (Npc_KnowsInfo (other, DIA_Bosper_OtherMasters))
	{
		AI_Output (self, other, "DIA_Bosper_Job_11_05");	//Or (sighs) you can start with one of the other masters - if that's what you really want.
	};
	MIS_Bosper_WolfFurs = LOG_Running;
};


instance DIA_Bosper_BringFur(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 102;
	condition = DIA_Bosper_BringFur_Condition;
	information = DIA_Bosper_BringFur_Info;
	permanent = TRUE;
	description = "About the wolf skins ...";
};


func int DIA_Bosper_BringFur_Condition()
{
	if(MIS_Bosper_WolfFurs == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Bosper_BringFur_Info()
{
	AI_Output (other, self, "DIA_Bosper_BringFur_15_00");	//About the wolf skins ...
	if (Player_IsApprentice > APP_NONE)
	{
		AI_Output (self, other, "DIA_Bosper_BringFur_11_01");	//You're already apprenticed to a different master now. I will buy the skins from you for the regular price.
		MIS_Bosper_WolfFurs = LOG_OBSOLETE;
		//return;
	}
	else if(B_GiveInvItems(other,self,ItAt_WolfFur,6))
	{
		AI_Output (other, self, "DIA_Bosper_BringFur_15_02");	//I've got them - here.
		AI_Output (self, other, "DIA_Bosper_BringFur_11_03");	//Great! I knew you would be suitable for this job.
		AI_Output (self, other, "DIA_Bosper_BringFur_11_04");	//Here's the pay I promised you.
		B_GiveInvItems(self,other,ItMi_Gold,Value_WolfFur * 6);
		BosperFurCounter += 6;
		ApprenticeGoldCounter += Value_WolfFur * 6;
		AI_Output(self,other,"DIA_Bosper_BringFur_11_05");	//And? What do you think? Isn't this better work than banging away at swords all day, or filling little bottles in a dusty chamber?
		MIS_Bosper_WolfFurs = LOG_SUCCESS;
		B_LogEntry(TOPIC_Lehrling,"Bosper will accept me as his apprentice if the other masters approve.");
	}
	else
	{
		AI_Output (self, other, "DIA_Bosper_BringFur_11_06");	//We had agreed on half a dozen - but you've still got time. Go and get those skins.
	};
};


instance DIA_Bosper_TeachFUR(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 2;
	condition = DIA_Bosper_TeachFUR_Condition;
	information = DIA_Bosper_TeachFUR_Info;
	permanent = TRUE;
//	description = B_BuildLearnString("Teach me how to skin animals! (5 LP)",B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALFUR,TROPHY_Fur));
	description = B_BuildLearnString(NAME_TROPHY_Fur,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALFUR,TROPHY_Fur));
};


func int DIA_Bosper_TeachFUR_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bosper_Job) && (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Bosper_TeachFUR_Info()
{
	AI_Output (other, self, "DIA_Bosper_TeachFUR_15_00");	//Teach me how to skin animals!
	if (B_TeachPlayerTalentTakeAnimalTrophy (self, other, TROPHY_Fur))
	{
		AI_Output (self, other, "DIA_Bosper_TeachFUR_11_01");	//Right. Listen. It's quite easy, really.
		AI_Output (self, other, "DIA_Bosper_TeachFUR_11_02");	//You take a sharp blade and cut open the animal's belly. Then make a few small incisions on the inside of the legs, and you can peel off the skin.
		if (MIS_Bosper_WolfFurs == LOG_Running)
		{
			AI_Output (self, other, "DIA_Bosper_TeachFUR_11_03");	//Bring me the wolf skins and we shall see ...
			B_LogEntry (TOPIC_BosperWolf, "Bosper has taught me to skin animals.");
		};
	};
};


instance DIA_Bosper_Trade(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 700;
	condition = DIA_Bosper_Trade_Condition;
	information = DIA_Bosper_Trade_Info;
	permanent = TRUE;
	description = DIALOG_TRADE_v4;
};


func int DIA_Bosper_Trade_Condition()
{
	if(MIS_Bosper_WolfFurs != LOG_Running)
	{
		DIA_Bosper_Trade.trade = TRUE;
	};
	return TRUE;
};

func void DIA_Bosper_Trade_Info()
{
	AI_Output(other,self,"DIA_Bosper_Trade_15_00");	//Show me your wares.
	if(DIA_Bosper_Trade.trade == TRUE)
	{
		B_GiveTradeInv(self);
		if(TradersHaveLimitedAmmo == TRUE)
		{
			if(Bosper_Ammo_Day <= Wld_GetDay())
			{
				B_RefreshAmmo(self,50);
				Bosper_Ammo_Day = Wld_GetDay() + 1;
			};
		}
		else
		{
			B_RefreshAmmo(self,50);
		};
		if(MIS_Serpentes_MinenAnteil_KDF == LOG_Running)
		{
			BosperMinenAnteil = TRUE;
		};
		Trade_IsActive = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Bosper_Trade_11_01");	//You're not here to browse through my wares, you're supposed to get me those skins!
		AI_Output (self, other, "DIA_Bosper_Trade_11_02");	//So get going!
	};
};


instance DIA_Bosper_BogenRunning(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 5;
	condition = DIA_Bosper_BogenRunning_Condition;
	information = DIA_Bosper_BogenRunning_Info;
	permanent = FALSE;
	description = "I've heard that someone stole from you.";
};


func int DIA_Bosper_BogenRunning_Condition()
{
	if(MIS_Bosper_Bogen == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Bosper_BogenRunning_Info()
{
	AI_Output (other, self, "DIA_Bosper_BogenRunning_15_00");	//I've heard that someone stole from you.
	AI_Output (self, other, "DIA_Bosper_BogenRunning_11_01");	//Who told you that? Probably Bartok, huh? Didn't he have anything better to tell you? Oh well.
	AI_Output (self, other, "DIA_Bosper_BogenRunning_11_02");	//Let me tell you, if I get hold of this bastard he can say his prayers!
	AI_Output (self, other, "DIA_Bosper_BogenRunning_11_03");	//I left the shop only for a moment. When I came back, I could only just see him leave - with my bow on his shoulder.
	AI_Output (self, other, "DIA_Bosper_BogenRunning_11_04");	//I called the guards right away, but the lowlife ran towards the harbor. And they lost him there.
	AI_Output (self, other, "DIA_Bosper_BogenRunning_11_05");	//I lit a bonfire under their asses then, and they searched the entire harbor district. But they didn't find a thing.
	if(other.guild != GIL_MIL)
	{
		AI_Output(self,other,"DIA_Bosper_BogenRunning_11_06");	//Those bumbling lackeys!
	};
	AI_Output (self, other, "DIA_Bosper_BogenRunning_11_07");	//I bet my bow is still in town somewhere. I informed the guards on both city gates, and they haven't seen anyone leave with my bow.
	AI_Output (self, other, "DIA_Bosper_BogenRunning_11_08");	//When I get my hands on that bastard...
	Log_CreateTopic(TOPIC_BosperBogen,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_BosperBogen,LOG_Running);
	B_LogEntry(TOPIC_BosperBogen,"Bosper had a bow stolen from him. The thief ran off to the harbor, but then he got away. The militia searched the harbor district, but they couldn't find anything, even though the bow must still be in town.");
};


instance DIA_Bosper_BogenSuccess(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 6;
	condition = DIA_Bosper_BogenSuccess_Condition;
	information = DIA_Bosper_BogenSuccess_Info;
	permanent = FALSE;
	description = "I think this bow belongs to you ...";
};


func int DIA_Bosper_BogenSuccess_Condition()
{
	if(Npc_HasItems(other,ItRw_Bow_L_03_MIS))
	{
		return TRUE;
	};
};

func void DIA_Bosper_BogenSuccess_Info()
{
	AI_Output (other, self, "DIA_Bosper_BogenSuccess_15_00");	//I think this bow belongs to you ...
	B_GiveInvItems (other, self, ItRw_Bow_L_03_MIS, 1);
	AI_Output (self, other, "DIA_Bosper_BogenSuccess_11_01");	//My bow! Where did you find it?
	AI_Output (other, self, "DIA_Bosper_BogenSuccess_15_02");	//In a dark hole full of rats.
	AI_Output (self, other, "DIA_Bosper_BogenSuccess_11_03");	//I hope you didn't get into trouble ...
	AI_Output (other, self, "DIA_Bosper_BogenSuccess_15_04");	//No - I've done this kind of thing before.
	AI_Output (self, other, "DIA_Bosper_BogenSuccess_11_05");	//Hm - thank you anyway. I owe you for this!
	MIS_Bosper_Bogen = LOG_SUCCESS;
	B_GivePlayerXP(XP_Bosper_Bogen);
	Npc_RemoveInvItems(self,ItRw_Bow_L_03_MIS,1);
};


var int Bosper_Island;

instance DIA_Bosper_PERM(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 10;
	condition = DIA_Bosper_PERM_Condition;
	information = DIA_Bosper_PERM_Info;
	permanent = TRUE;
	description = "How are things in town?";
};


func int DIA_Bosper_PERM_Condition()
{
	if(Kapitel >= 2)
	{
		return TRUE;
	};
};

func void DIA_Bosper_PERM_Info()
{
	AI_Output (other, self, "DIA_Bosper_PERM_15_00");	//How are things in town?
	if (Bosper_Island == FALSE)
	{
		AI_Output (self, other, "DIA_Bosper_PERM_11_01");	//If the orcs really show up to besiege us, it's going to get unpleasant around here.
		AI_Output (self, other, "DIA_Bosper_PERM_11_02");	//There's only one ship - and the paladins are guarding it. And I don't think they'll use it to rescue the citizens.
		AI_Output (other, self, "DIA_Bosper_PERM_15_03");	//Is there no other way of getting out of here?
		AI_Output (self, other, "DIA_Bosper_PERM_11_04");	//No, none of us can leave this island without a ship.
		Bosper_Island = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Bosper_PERM_11_05");	//There's nothing new so far. Drop in again later.
	};
};


var int Bosper_MILKommentar;
var int Bosper_PALKommentar;
var int Bosper_INNOSKommentar;

instance DIA_Bosper_AlsLehrling(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 1;
	condition = DIA_Bosper_AlsLehrling_Condition;
	information = DIA_Bosper_AlsLehrling_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Bosper_AlsLehrling_Condition()
{
	if((Player_IsApprentice == APP_Bosper) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Bosper_AlsLehrling_Info()
{
	if((other.guild == GIL_MIL) && (Bosper_StartGuild != GIL_MIL) && (Bosper_MILKommentar == FALSE))
	{
		AI_Output (self, other, "DIA_Bosper_AlsLehrling_11_00");	//You up and joined the militia, eh?
		AI_Output (self, other, "DIA_Bosper_AlsLehrling_11_01");	//Not that I care. Just as long as, besides orcs and bandits, you hunt a few wolves as well. (grins)
		Bosper_MILKommentar = TRUE;
	}
	else if((other.guild == GIL_PAL) && (Bosper_StartGuild != GIL_PAL) && (Bosper_PALKommentar == FALSE))
	{
		AI_Output (self, other, "DIA_Bosper_AlsLehrling_11_02");	//Looks like your career took off like a rocket. Paladin of the King!
		AI_Output (self, other, "DIA_Bosper_AlsLehrling_11_03");	//Wherever you go from here, don't forget your old master ...
		Bosper_PALKommentar = TRUE;
	}
	else if(((other.guild == GIL_NOV) || (other.guild == GIL_KDF)) && (Bosper_StartGuild != GIL_NOV) && (Bosper_StartGuild != GIL_KDF) && (Bosper_INNOSKommentar == FALSE))
	{
		AI_Output (self, other, "DIA_Bosper_AlsLehrling_11_04");	//You went and entered the monastery, huh? I hope they let you out often enough so you can keep me supplied with skins ...
		Bosper_INNOSKommentar = TRUE;
	}
	else if((Bosper_Lehrling_Day <= (Wld_GetDay() - 4)) && (other.guild != GIL_PAL) && (other.guild != GIL_KDF))
	{
		AI_Output (self, other, "DIA_Bosper_AlsLehrling_11_05");	//Where have you been gadding about for so long?
		AI_Output (self, other, "DIA_Bosper_AlsLehrling_11_06");	//I need more skins, did you bring any?
		Bosper_Lehrling_Day = Wld_GetDay ();
	}
	else
	{
		AI_Output (self, other, "DIA_Bosper_AlsLehrling_11_07");	//There you are again ...
		Bosper_Lehrling_Day = Wld_GetDay ();
	};
};


instance DIA_Bosper_Aufgaben(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 1;
	condition = DIA_Bosper_Aufgaben_Condition;
	information = DIA_Bosper_Aufgaben_Info;
	permanent = FALSE;
	description = "What are my tasks as an apprentice?";
};


func int DIA_Bosper_Aufgaben_Condition()
{
	if(Player_IsApprentice == APP_Bosper)
	{
		return TRUE;
	};
};

func void DIA_Bosper_Aufgaben_Info()
{
	AI_Output (other, self, "DIA_Bosper_Aufgaben_15_00");	//What are my tasks as an apprentice?
	AI_Output (self, other, "DIA_Bosper_Aufgaben_11_01");	//That's easy. Bring me as many pelts as you can get.
	AI_Output (self, other, "DIA_Bosper_Aufgaben_11_02");	//I'll pay you a better price for them than any of the other traders would give you.
	AI_Output (self, other, "DIA_Bosper_Aufgaben_11_03");	//Apart from that, you needn't show up here in the shop. I can get along just fine by myself.
	if (other.guild == GIL_NONE)
	{
		AI_Output (other, self, "DIA_Bosper_Aufgaben_15_04");	//And where am I supposed to sleep?
		AI_Output (self, other, "DIA_Bosper_Aufgaben_11_05");	//I don't have any room for you here. They're bound to have a bed for you in the hotel at the marketplace.
	};
	Log_CreateTopic (Topic_Bonus, LOG_NOTE);
	B_LogEntry (Topic_Bonus, "Bosper will pay an extremely good price for animal hides.");
};


var int Bosper_TrollFurSold;

instance DIA_Bosper_SellFur(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 600;
	condition = DIA_Bosper_SellFur_Condition;
	information = DIA_Bosper_SellFur_Info;
	permanent = TRUE;
	description = "I've got a few skins for you ...";
};


func int DIA_Bosper_SellFur_Condition()
{
	if(Player_IsApprentice == APP_Bosper)
	{
		return TRUE;
	};
};

func void DIA_Bosper_SellFur_Info()
{
	var int furs;
	AI_Output(other,self,"DIA_Bosper_SellFur_15_00");	//I've got a few skins for you...
	furs = Npc_HasItems(other,ItAt_Addon_KeilerFur) + Npc_HasItems(other,ItAt_SheepFur) + Npc_HasItems(other,ItAt_WolfFur) + Npc_HasItems(other,ItAt_IceWolfFur) + Npc_HasItems(other,ItAt_WargFur) + Npc_HasItems(other,ItAt_ShadowFur) + Npc_HasItems(other,ItAt_TrollFur) + Npc_HasItems(other,ItAt_TrollBlackFur);
	if(furs > 0)
	{
		BosperFurCounter += furs;
		ApprenticeGoldCounter += (Npc_HasItems(other,ItAt_Addon_KeilerFur) * Value_Keilerfur) + (Npc_HasItems(other,ItAt_SheepFur) * Value_SheepFur) + (Npc_HasItems(other,ItAt_WolfFur) * Value_WolfFur) + (Npc_HasItems(other,ItAt_IceWolfFur) * Value_IceWolfFur) + (Npc_HasItems(other,ItAt_WargFur) * Value_WargFur) + (Npc_HasItems(other,ItAt_ShadowFur) * Value_ShadowFur) + (Npc_HasItems(other,ItAt_TrollFur) * Value_TrollFur) + (Npc_HasItems(other,ItAt_TrollBlackFur) * Value_TrollBlackFur);
		if(Npc_HasItems(other,ItAt_Addon_KeilerFur))
		{
			B_Say(self,other,"$ABS_GOOD");
			B_GiveInvItems(self,other,ItMi_Gold,Npc_HasItems(other,ItAt_Addon_KeilerFur) * Value_Keilerfur);
			B_GiveInvItems(other,self,ItAt_Addon_KeilerFur,Npc_HasItems(other,ItAt_Addon_KeilerFur));
		};
		if(Npc_HasItems(other,ItAt_SheepFur))
		{
			AI_Output (self, other, "DIA_Bosper_SellFur_11_01");	//A sheep skin? You didn't go slaughter some farmer's sheep in the pasture, did you?
			AI_Output (other, self, "DIA_Bosper_SellFur_15_02");	//I wouldn't dream of doing that...
			B_GiveInvItems(self,other,ItMi_Gold,Npc_HasItems(other,ItAt_SheepFur) * Value_SheepFur);
			B_GiveInvItems(other,self,ItAt_SheepFur,Npc_HasItems(other,ItAt_SheepFur));
		};
		if(Npc_HasItems(other,ItAt_WolfFur))
		{
			AI_Output(self,other,"DIA_Bosper_SellFur_11_03");	//Wolf skin, that's good...
			B_GiveInvItems(self,other,ItMi_Gold,Npc_HasItems(other,ItAt_WolfFur) * Value_WolfFur);
			B_GiveInvItems(other,self,ItAt_WolfFur,Npc_HasItems(other,ItAt_WolfFur));
		};
		if(Npc_HasItems(other,ItAt_IceWolfFur))
		{
			B_Say(self,other,"$NOTBAD");
			B_GiveInvItems(self,other,ItMi_Gold,Npc_HasItems(other,ItAt_IceWolfFur) * Value_IceWolfFur);
			B_GiveInvItems(other,self,ItAt_IceWolfFur,Npc_HasItems(other,ItAt_IceWolfFur));
		};
		if(Npc_HasItems(other,ItAt_WargFur))
		{
			AI_Output(self,other,"DIA_Bosper_SellFur_11_04");	//A warg skin? Those beasts are tough...
			B_GiveInvItems(self,other,ItMi_Gold,Npc_HasItems(other,ItAt_WargFur) * Value_WargFur);
			B_GiveInvItems(other,self,ItAt_WargFur,Npc_HasItems(other,ItAt_WargFur));
		};
		if(Npc_HasItems(other,ItAt_ShadowFur))
		{
			AI_Output(self,other,"DIA_Bosper_SellFur_11_05");	//Ah, even a shadowbeast skin - those are worth a lot.
			B_GiveInvItems(self,other,ItMi_Gold,Npc_HasItems(other,ItAt_ShadowFur) * Value_ShadowFur);
			B_GiveInvItems(other,self,ItAt_ShadowFur,Npc_HasItems(other,ItAt_ShadowFur));
		};
		if(Npc_HasItems(other,ItAt_TrollFur) || Npc_HasItems(other,ItAt_TrollBlackFur))
		{
			if(Bosper_TrollFurSold == FALSE)
			{
				AI_Output (self, other, "DIA_Bosper_SellFur_11_06");	//What the hell is THIS skin?
				AI_Output (other, self, "DIA_Bosper_SellFur_15_07");	//I ripped a troll off for that one.
				AI_Output (self, other, "DIA_Bosper_SellFur_11_08");	//That... that is worth a small fortune.
				Bosper_TrollFurSold == TRUE;
			}
			else
			{
				AI_Output (self, other, "DIA_Bosper_SellFur_11_09");	//Another huge troll hide... are you hunting those things down?
				AI_Output (other, self, "DIA_Bosper_SellFur_15_10");	//Whenever I stumble upon one, I seize the opportunity ...
			};
			if(Npc_HasItems(other,ItAt_TrollFur))
			{
				B_GiveInvItems(self,other,ItMi_Gold,Npc_HasItems(other,ItAt_TrollFur) * Value_TrollFur);
				B_GiveInvItems(other,self,ItAt_TrollFur,Npc_HasItems(other,ItAt_TrollFur));
			};
			if(Npc_HasItems(other,ItAt_TrollBlackFur))
			{
				AI_Output (self, other, "DIA_Bosper_SellFur_11_11");	//And the hide of a black troll, at that!
				B_GiveInvItems (self, other, ItMi_Gold, Npc_HasItems (other, ItAt_TrollBlackFur) * Value_TrollBlackFur);
				B_GiveInvItems (other, self, ItAt_TrollBlackFur, Npc_HasItems (other, ItAt_TrollBlackFur));
			};
		};
		AI_Output (self, other, "DIA_Bosper_SellFur_11_12");	//Good work. Come see me again when you have more ...
	}
	else
	{
		AI_Output (self, other, "DIA_Bosper_SellFur_11_13");	//But you know - I'm only interested in the skins of wolves, shadowbeasts and the like ...
	};
};


instance DIA_Bosper_Minenanteil(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 3;
	condition = DIA_Bosper_Minenanteil_Condition;
	information = DIA_Bosper_Minenanteil_Info;
	description = "I see that you have mining shares for sale.";
};


func int DIA_Bosper_Minenanteil_Condition()
{
	//if((hero.guild == GIL_KDF) && (MIS_Serpentes_MinenAnteil_KDF == LOG_Running))
	if((hero.guild == GIL_KDF) && (MIS_Serpentes_MinenAnteil_KDF == LOG_Running) && (BosperMinenAnteil == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Bosper_Minenanteil_Info()
{
	AI_Output(other,self,"DIA_Bosper_Minenanteil_15_00");	//I see that you have mining shares for sale.
	if(Npc_HasItems(self,ItWr_MinenAnteil_Mis) && (Player_IsApprentice == APP_Bosper))
	{
		AI_Output(self,other,"DIA_Bosper_Minenanteil_11_01");	//Ahem. I know nothing about that. You can have them if you want.
		B_GiveInvItems(self,other,ItWr_MinenAnteil_Mis,Npc_HasItems(self,ItWr_MinenAnteil_Mis));
	}
	else
	{
		AI_Output(self,other,"DIA_Bosper_Minenanteil_11_01_add");	//’м-м, € ничего не знаю об этом.@@@
	};
	B_GivePlayerXP(XP_Ambient);
};


instance DIA_Bosper_PICKPOCKET(C_Info)
{
	npc = VLK_413_Bosper;
	nr = 900;
	condition = DIA_Bosper_PICKPOCKET_Condition;
	information = DIA_Bosper_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Bosper_PICKPOCKET_Condition()
{
	return C_Beklauen(67,120);
};

func void DIA_Bosper_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Bosper_PICKPOCKET);
	Info_AddChoice(DIA_Bosper_PICKPOCKET,Dialog_Back,DIA_Bosper_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Bosper_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Bosper_PICKPOCKET_DoIt);
};

func void DIA_Bosper_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Bosper_PICKPOCKET);
};

func void DIA_Bosper_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Bosper_PICKPOCKET);
};

