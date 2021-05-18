
instance DIA_Harad_EXIT(C_Info)
{
	npc = VLK_412_Harad;
	nr = 999;
	condition = DIA_Harad_EXIT_Condition;
	information = DIA_Harad_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Harad_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Harad_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Harad_Hallo(C_Info)
{
	npc = VLK_412_Harad;
	nr = 2;
	condition = DIA_Harad_Hallo_Condition;
	information = DIA_Harad_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Harad_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_TalkedToPlayer] == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Harad_Hallo_Info()
{
	AI_Output (self, other, "DIA_Harad_Hallo_12_00");	//(grumpy) What do you want?
};


instance DIA_Harad_Arbeit(C_Info)
{
	npc = VLK_412_Harad;
	nr = 1;
	condition = DIA_Harad_Arbeit_Condition;
	information = DIA_Harad_Arbeit_Info;
	permanent = FALSE;
	description = "I'm looking for work.";
};


func int DIA_Harad_Arbeit_Condition()
{
	return TRUE;
};

func void DIA_Harad_Arbeit_Info()
{
	AI_Output (other, self, "DIA_Harad_Arbeit_15_00");	//I'm looking for work!
	AI_Output (self, other, "DIA_Harad_Arbeit_12_01");	//Hm - I could use a new apprentice.
	AI_Output (self, other, "DIA_Harad_Arbeit_12_02");	//Brian will have finished his apprenticeship soon, and then he'll leave the city.
	AI_Output (self, other, "DIA_Harad_Arbeit_12_03");	//Are you good for anything?
	AI_Output (other, self, "DIA_Harad_Arbeit_15_04");	//If you mean, do I know blacksmith's work ...
	AI_Output (self, other, "DIA_Harad_Arbeit_12_05");	//No. That's not what I meant.
	AI_Output (self, other, "DIA_Harad_Arbeit_12_06");	//Sooner or later, the orcs are going to lay siege to the city, and then the only men who will count will be those who are in a position to defend our city.
	if (other.guild == GIL_NONE)
	{
		AI_Output (self, other, "DIA_Harad_Arbeit_12_07");	//And I won't take on anyone as an apprentice who will disgrace me by fleeing the city with the women and the good-for-nothings, instead of holding the fort here with the men.
	};
	if(Player_IsApprentice == APP_NONE)
	{
		Log_CreateTopic(TOPIC_Lehrling,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Lehrling,LOG_Running);
	B_LogEntry (TOPIC_Lehrling, "If I can convince Harad that I'm not a good-for-nothing, he'll accept me as his apprentice.");
	};
};


instance DIA_Harad_Taugenichts(C_Info)
{
	npc = VLK_412_Harad;
	nr = 1;
	condition = DIA_Harad_Taugenichts_Condition;
	information = DIA_Harad_Taugenichts_Info;
	permanent = FALSE;
	description = "I'm not a good-for-nothing!";
};


func int DIA_Harad_Taugenichts_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Harad_Arbeit))
	{
		return TRUE;
	};
};

func void DIA_Harad_Taugenichts_Info()
{
	AI_Output (other, self, "DIA_Harad_Taugenichts_15_00");	//I'm not a good-for-nothing!
	AI_Output (self, other, "DIA_Harad_Taugenichts_12_01");	//Those are big words! Can you back them up with big deeds?
	AI_Output (other, self, "DIA_Harad_Taugenichts_15_02");	//What are you getting at?
	AI_Output (self, other, "DIA_Harad_Taugenichts_12_03");	//Bring me an orc's weapon.
	AI_Output (self, other, "DIA_Harad_Taugenichts_12_04");	//Orcs have been seen near the city. With a bit of luck, you won't have to search for long.
	AI_Output (self, other, "DIA_Harad_Taugenichts_12_05");	//If you manage to bring one down, I'll take you on as an apprentice.
	AI_Output (self, other, "DIA_Harad_Taugenichts_12_06");	//Provided the other masters agree.
	MIS_Harad_Orc = LOG_Running;
	Log_CreateTopic (TOPIC_HaradOrk, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_HaradOrk, LOG_Running);
	B_LogEntry (TOPIC_HaradOrk, "An orc has been sited outside the city. The smith Harad wants me to kill it. An orc weapon will be evidence enough.");
};


instance DIA_Harad_OrcRunning(C_Info)
{
	npc = VLK_412_Harad;
	nr = 1;
	condition = DIA_Harad_OrcRunning_Condition;
	information = DIA_Harad_OrcRunning_Info;
	permanent = FALSE;
	description = "Let's talk again about that orc thing ...";
};


func int DIA_Harad_OrcRunning_Condition()
{
	if((MIS_Harad_Orc == LOG_Running) && (Harad_HakonMission == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Harad_OrcRunning_Info()
{
	AI_Output (other, self, "DIA_Harad_OrcRunning_15_00");	//Let's talk again about that orc thing...
	AI_Output (self, other, "DIA_Harad_OrcRunning_12_01");	//(brusque) What?
	Info_ClearChoices (DIA_Harad_OrcRunning);
	Info_AddChoice (DIA_Harad_OrcRunning, "Your orc is as good as dead!", DIA_Harad_OrcRunning_Done);
	Info_AddChoice (DIA_Harad_OrcRunning, "An orc is a damn tough opponent...", DIA_Harad_OrcRunning_TooHard);
};

func void DIA_Harad_OrcRunning_TooHard()
{
	AI_Output (other, self, "DIA_Harad_OrcRunning_TooHard_15_00");	//But an orc is a damn tough opponent ...
	AI_Output (self, other, "DIA_Harad_OrcRunning_TooHard_12_01");	//Hm - looking at you, you might be right. You don't have much meat on your bones. But that can change.
	AI_Output (self, other, "DIA_Harad_OrcRunning_TooHard_12_02");	//Nevertheless, you have to prove to me that you have the courage to fight.
	AI_Output (other, self, "DIA_Harad_OrcRunning_TooHard_15_03");	//So couldn't it be something slightly smaller?
	AI_Output (self, other, "DIA_Harad_OrcRunning_TooHard_12_04");	//Hm - (considering) Hakon, the weapons dealer in the marketplace, told me that he was attacked by bandits a few days ago.
	AI_Output (self, other, "DIA_Harad_OrcRunning_TooHard_12_05");	//The bastards are said to be roaming around somewhere outside the east gate.
	AI_Output (self, other, "DIA_Harad_OrcRunning_TooHard_12_06");	//Those cowardly rogues shouldn't be terribly bright.
	AI_Output (self, other, "DIA_Harad_OrcRunning_TooHard_12_07");	//Hunt the bastards down! Every single one of them. Then I'll know that we can use you here in the city.
	Harad_HakonMission = TRUE;
	if(Player_IsApprentice == APP_NONE)
	{
		Log_CreateTopic(TOPIC_Lehrling,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Lehrling,LOG_Running);
		if(MIS_HakonBandits == FALSE)
		{
			B_LogEntry(TOPIC_Lehrling,"Harad told me bandits robbed the merchant Hakon outside the city. If I can hunt them down, he'll be convinced that I'm good. I should have a word with Hakon. Maybe he knows a bit more about where those bandits hang out.");
		}
		else
		{
			B_LogEntry(TOPIC_Lehrling,"Harad told me bandits robbed the merchant Hakon outside the city. If I can hunt them down, he'll be convinced that I'm good.");
		};
	};
	Info_ClearChoices(DIA_Harad_OrcRunning);
};

func void DIA_Harad_OrcRunning_Done()
{
	AI_Output (other, self, "DIA_Harad_OrcRunning_Done_15_00");	//Your orc is as good as dead!
	AI_Output (self, other, "DIA_Harad_OrcRunning_Done_12_01");	//Good! Then stop wasting your breath and let your deeds speak for themselves.
	Info_ClearChoices (DIA_Harad_OrcRunning);
};


func int C_ScHasOrcWeapon()
{
	if(Npc_HasItems(hero,ItMw_2H_OrcMace_01))
	{
		return TRUE;
	}
	else if(Npc_HasItems(hero,ItMw_2H_OrcSword_02))
	{
		return TRUE;
	}
	else if(Npc_HasItems(hero,ItMw_2H_OrcAxe_04))
	{
		return TRUE;
	}
	else if(Npc_HasItems(hero,ItMw_2H_OrcSword_01))
	{
		return TRUE;
	}
	else if(Npc_HasItems(hero,ItMw_2H_OrcAxe_03))
	{
		return TRUE;
	}
	else if(Npc_HasItems(hero,ItMw_2H_OrcAxe_02))
	{
		return TRUE;
	}
	else if(Npc_HasItems(hero,ItMw_2H_OrcAxe_01))
	{
		return TRUE;
	};
	return FALSE;
};

var int Harad_GotEliteOrcWeapon;

instance DIA_Harad_OrcSuccess(C_Info)
{
	npc = VLK_412_Harad;
	nr = 1;
	condition = DIA_Harad_OrcSuccess_Condition;
	information = DIA_Harad_OrcSuccess_Info;
	permanent = FALSE;
	description = "I've got the orc weapon you wanted.";
};


func int DIA_Harad_OrcSuccess_Condition()
{
	if((MIS_Harad_Orc == LOG_Running) && C_ScHasOrcWeapon())
	{
		return TRUE;
	};
};

func void DIA_Harad_OrcSuccess_Info()
{
	AI_Output (other, self, "DIA_Harad_OrcSuccess_15_00");	//I've got the orc weapon you wanted.
	AI_Output (self, other, "DIA_Harad_OrcSuccess_12_01");	//Show me...
	if(Npc_HasItems(other,ItMw_2H_OrcMace_01))
	{
		B_GiveInvItems(other,self,ItMw_2H_OrcMace_01,1);
		Harad_GotEliteOrcWeapon = TRUE;
	}
	else if(Npc_HasItems(other,ItMw_2H_OrcSword_02))
	{
		B_GiveInvItems(other,self,ItMw_2H_OrcSword_02,1);
		Harad_GotEliteOrcWeapon = TRUE;
	}
	else if(Npc_HasItems(other,ItMw_2H_OrcAxe_04))
	{
		B_GiveInvItems(other,self,ItMw_2H_OrcAxe_04,1);
		Harad_GotEliteOrcWeapon = TRUE;
	}
	else if(Npc_HasItems(other,ItMw_2H_OrcSword_01))
	{
		B_GiveInvItems(other,self,ItMw_2H_OrcSword_01,1);
	}
	else if(Npc_HasItems(other,ItMw_2H_OrcAxe_03))
	{
		B_GiveInvItems(other,self,ItMw_2H_OrcAxe_03,1);
	}
	else if(Npc_HasItems(other,ItMw_2H_OrcAxe_02))
	{
		B_GiveInvItems(other,self,ItMw_2H_OrcAxe_02,1);
	}
	else if(Npc_HasItems(other,ItMw_2H_OrcAxe_01))
	{
		B_GiveInvItems(other,self,ItMw_2H_OrcAxe_01,1);
	};
	B_InspectMeleeWeapon(self);
	if(Harad_HakonMission == TRUE)
	{
		AI_Output (self, other, "DIA_Harad_OrcSuccess_12_02");	//You did it AFTER ALL? Good man!
	};
	AI_Output(self,other,"DIA_Harad_OrcSuccess_12_03");	//It's been a while since I've had a weapon like this in my hands - I was a soldier back in the Orc War.
	AI_Output(self,other,"DIA_Harad_OrcSuccess_12_04");	//Those were tough times, I can tell you.
	if(Player_IsApprentice == APP_Harad)
	{
		AI_Output(self,other,"DIA_Harad_OrcSuccess_12_05");	//I knew there was a reason I took you on as an apprentice. Well done!
	}
	else if(Player_IsApprentice == APP_NONE)
	{
		AI_Output(self,other,"DIA_Harad_OrcSuccess_12_06");	//I didn't think you could do it. I'm impressed.
		B_LogEntry(TOPIC_Lehrling,"Harad will accept me as his apprentice if I can get the approval of the other masters.");
	}
	else
	{
		AI_Output(self,other,"DIA_Harad_OrcSuccess_12_07");	//Too bad you've decided on another path.
		AI_Output(self,other,"DIA_Harad_OrcSuccess_12_08");	//I could have really used you.
	};
	MIS_Harad_Orc = LOG_SUCCESS;
	if(Harad_GotEliteOrcWeapon == TRUE)
	{
		B_GivePlayerXP(XP_Harad_Orc * 3);
	}
	else
	{
		B_GivePlayerXP(XP_Harad_Orc);
	};
};


var int Harad_StartGuild;

instance DIA_Harad_LEHRLING(C_Info)
{
	npc = VLK_412_Harad;
	nr = 1;
	condition = DIA_Harad_LEHRLING_Condition;
	information = DIA_Harad_LEHRLING_Info;
	permanent = TRUE;
	description = "When can I start as your apprentice?";
};


func int DIA_Harad_LEHRLING_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Harad_Arbeit) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Harad_LEHRLING_Info()
{
	var int stimmen;
	stimmen = 0;
	AI_Output (other, self, "DIA_Harad_LEHRLING_15_00");	//When can I start as your apprentice?
	if ((MIS_Harad_Orc == LOG_SUCCESS) || ((MIS_HakonBandits == LOG_SUCCESS) && (Harad_HakonMission == TRUE)))
	{
		if(MIS_Harad_Orc == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_Harad_LEHRLING_12_01");	//We can really use a man around here who can beat an orc.
			if (MIS_HakonBandits == LOG_SUCCESS)
			{
				AI_Output (self, other, "DIA_Harad_LEHRLING_12_02");	//Moreover, Hakon told me how you settled the business with the bandits. Good man!
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Harad_LEHRLING_12_03");	//You didn't kill an orc, but Hakon told me how you settled the business with the bandits. Good man!
		};
		AI_Output(self,other,"DIA_Harad_LEHRLING_12_04");	//As far as I am concerned, you can start here right away.
		stimmen += 1;
		AI_Output(self,other,"DIA_Harad_LEHRLING_12_05");	//As for the other masters...
		if(Thorben.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			if(MIS_Thorben_GetBlessings == LOG_SUCCESS)
			{
				AI_Output(self,other,"DIA_Harad_LEHRLING_12_06");	//Thorben has given you his blessing.
				stimmen += 1;
			}
			else
			{
				AI_Output (self, other, "DIA_Harad_LEHRLING_12_07");	//Good old Thorben just wants you to get the blessing of the gods. I think that's a good idea.
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Harad_LEHRLING_12_08");	//Thorben says he's never spoken to you.
		};
		if(Bosper.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			AI_Output (self, other, "DIA_Harad_LEHRLING_12_09");	//Bosper tried to talk me out of it. He wants you as an apprentice for himself.
			if ((MIS_Bosper_Bogen == LOG_SUCCESS) || (MIS_Bosper_WolfFurs == LOG_SUCCESS))
			{
				AI_Output (self, other, "DIA_Harad_LEHRLING_12_10");	//I had a brief, but intense, discussion with him on this matter.
				AI_Output (self, other, "DIA_Harad_LEHRLING_12_11");	//In the end, he agreed.
				stimmen += 1;
			}
			else
			{
				AI_Output (self, other, "DIA_Harad_LEHRLING_12_12");	//He asked me to at least give him the opportunity to interest you in his profession.
				AI_Output (self, other, "DIA_Harad_LEHRLING_12_13");	//Take a look at it - you can always decide afterwards. Unless you don't want his vote, that is.
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Harad_LEHRLING_12_14");	//And Bosper doesn't know you yet.
		};
		if(Constantino.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			if(B_GetGreatestPetzCrime(self) == CRIME_NONE)
			{
				AI_Output(self,other,"DIA_Harad_LEHRLING_12_15");	//As usual, Constantino doesn't care about anything. He said that as far as he's concerned, you can start wherever you like.
				stimmen += 1;
			}
			else
			{
				AI_Output (self, other, "DIA_Harad_LEHRLING_12_16");	//Constantino says you are accused of a crime here in the city - is that true?
				AI_Output (self, other, "DIA_Harad_LEHRLING_12_17");	//If so, then you should get that straightened out immediately!
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Harad_LEHRLING_12_18");	//Constantino has never heard of you.
		};
		if(Matteo.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			if(MIS_Matteo_Gold == LOG_SUCCESS)
			{
				AI_Output(self,other,"DIA_Harad_LEHRLING_12_19");	//And Matteo says you brought him back his gold. Seems to me, you're an honorable young man.
				stimmen += 1;
			}
			else if(MIS_Matteo_Gold == LOG_Running)
			{
				AI_Output(self,other,"DIA_Harad_LEHRLING_12_20");	//And Matteo says you still owe him something. I don't know what there is between you, but you should get that straightened out.
			}
			else if(MIS_Matteo_Gold == LOG_FAILED)
			{
				AI_Output(self,other,"DIA_Harad_LEHRLING_12_22");	//And Matteo says he's never seen you in his shop.
			}
			else
			{
				AI_Output(self,other,"DIA_Harad_LEHRLING_12_21");	//And Matteo says he's never talked about this with you.
			};
		}
		else
		{
			AI_Output(self,other,"DIA_Harad_LEHRLING_12_22");	//And Matteo says he's never seen you in his shop.
		};
		if(stimmen >= 4)
		{
			if(stimmen == 5)
			{
				AI_Output (self, other, "DIA_Harad_LEHRLING_12_23");	//That means you have the approval of all the masters!
			}
			else
			{
				AI_Output (self, other, "DIA_Harad_LEHRLING_12_24");	//That means you have the approval of four masters. That's enough to be accepted as an apprentice.
			};
			AI_Output (self, other, "DIA_Harad_LEHRLING_12_25");	//Are you ready to start your apprenticeship with me?
			Info_ClearChoices (DIA_Harad_LEHRLING);
			Info_AddChoice (DIA_Harad_LEHRLING, "Good - I'll think about it.", DIA_Harad_LEHRLING_Later);
			Info_AddChoice (DIA_Harad_LEHRLING, "I'm in!", DIA_Harad_LEHRLING_OK);
		}
		else
		{
			AI_Output (self, other, "DIA_Harad_LEHRLING_12_26");	//You need the approval of at least four masters in order to be accepted as an apprentice in the lower part of town.
			AI_Output (self, other, "DIA_Harad_LEHRLING_12_27");	//So you should talk to all of them who still aren't convinced about you.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Harad_LEHRLING_12_28");	//Not before you've proven to me that you're good for something.
	};
};

func void DIA_Harad_LEHRLING_OK()
{
	AI_Output (other, self, "DIA_Harad_LEHRLING_OK_15_00");	//Count me in!
	AI_Output (self, other, "DIA_Harad_LEHRLING_OK_12_01");	//Good! I'll teach you how to forge a decent sword.
	if (PLAYER_TALENT_SMITH[WEAPON_Common] == TRUE)
	{
		AI_Output (other, self, "DIA_Harad_LEHRLING_OK_15_02");	//I already know how to do that!
		AI_Output (self, other, "DIA_Harad_LEHRLING_OK_12_03");	//Well, all the better!
	};
	if(other.attribute[ATR_STRENGTH] < (T_MED - 30))
	{
		AI_Output (self, other, "DIA_Harad_LEHRLING_OK_12_04");	//Besides that, it's time you got a bit stronger. You're wasting away before my very eyes!
	};
	Player_IsApprentice = APP_Harad;
	ApprenticeGoldCounter = 0;
	if(Hlp_IsValidNpc(Lothar) && !Npc_IsDead(Lothar))
	{
		Npc_ExchangeRoutine(Lothar,"START");
	};
	Harad_StartGuild = other.guild;
	Harad_Lehrling_Day = Wld_GetDay();
	Wld_AssignRoomToGuild("schmied",GIL_NONE);
	MIS_Apprentice = LOG_SUCCESS;
	B_GivePlayerXP(XP_Lehrling);
	Log_CreateTopic(Topic_Bonus,LOG_NOTE);
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
	{
		B_LogEntries(Topic_Bonus,"Harad has accepted me as his apprentice. I now have access to the upper quarter.");
	}
	else
	{
		B_LogEntries(Topic_Bonus,"Harad has accepted me as his apprentice.");
	};
	Log_AddEntry(Topic_Bonus,"Harad will buy the weapons I forge for a good price.");
	Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
	B_LogNextEntry(TOPIC_CityTeacher,"Harad can teach me the art of smithery. He can also help me become stronger.");
	Info_ClearChoices(DIA_Harad_LEHRLING);
};

func void DIA_Harad_LEHRLING_Later()
{
	AI_Output(other,self,"DIA_Harad_LEHRLING_Later_15_00");	//Good - I'll think about it.
	if(!Npc_IsDead(Brian))
	{
		AI_Output (self, other, "DIA_Harad_LEHRLING_Later_12_01");	//Take your time. Brian will still be here for a while.
	};
	Info_ClearChoices(DIA_Harad_LEHRLING);
};


instance DIA_Harad_Zustimmung(C_Info)
{
	npc = VLK_412_Harad;
	nr = 2;
	condition = DIA_Harad_Zustimmung_Condition;
	information = DIA_Harad_Zustimmung_Info;
	permanent = TRUE;
	description = "Can I sign on as an apprentice with a different master?";
};


func int DIA_Harad_Zustimmung_Condition()
{
	if((Player_IsApprentice == APP_NONE) && Npc_KnowsInfo(other,DIA_Harad_Arbeit))
	{
		return TRUE;
	};
};


var int DIA_Harad_Zustimmung_Permanent;

func void DIA_Harad_Zustimmung_Info()
{
	AI_Output (other, self, "DIA_Harad_Zustimmung_15_00");	//Can I sign on as an apprentice with a different master?
	if ((MIS_Harad_Orc == LOG_SUCCESS) || ((MIS_HakonBandits == LOG_SUCCESS) && (Harad_HakonMission == TRUE)))
	{
		AI_Output (self, other, "DIA_Harad_Zustimmung_12_01");	//You're a good man.
		if (MIS_HakonBandits == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_Harad_Zustimmung_12_02");	//Hakon told me how you handled the bandits.
		};
		AI_Output (self, other, "DIA_Harad_Zustimmung_12_03");	//I'll give you my approval.
		if (DIA_Harad_Zustimmung_Permanent == FALSE)
		{
			B_GivePlayerXP(XP_Zustimmung);
			B_LogEntry(TOPIC_Lehrling,"Harad will give his approval if I want to start as an apprentice somewhere.");
			DIA_Harad_Zustimmung_Permanent = TRUE;
		};
		if(!Npc_IsDead(Brian))
		{
			AI_Output (self, other, "DIA_Harad_Zustimmung_12_04");	//Brian will still be here for a while. And a strong lad to take his place will turn up in time.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Harad_Zustimmung_12_05");	//The other masters may well approve. But I will only give you my approval when you first prove that you're good for something!
	};
};


func void B_HaradCommentAnvilUses()
{
	if(HaradsAnvilUsed < 10)
	{
		AI_Output(self,other,"DIA_Harad_AlsLehrling_12_04_02_add");	//Even if you didn't spend a lot of time behind the anvil.@@@
	}
	else
	{
		AI_Output(self,other,"DIA_Harad_AlsLehrling_12_07");	//If you need anything from me, I'm here for you.
	};
};

var int Harad_MILKommentar;
var int Harad_PALKommentar;
var int Harad_INNOSKommentar;

instance DIA_Harad_AlsLehrling(C_Info)
{
	npc = VLK_412_Harad;
	nr = 1;
	condition = DIA_Harad_AlsLehrling_Condition;
	information = DIA_Harad_AlsLehrling_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Harad_AlsLehrling_Condition()
{
	if((Player_IsApprentice == APP_Harad) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Harad_AlsLehrling_Info()
{
	if((other.guild == GIL_MIL) && (Harad_StartGuild != GIL_MIL) && (Harad_MILKommentar == FALSE))
	{
		AI_Output (self, other, "DIA_Harad_AlsLehrling_12_00");	//You're with the militia now? I'm proud of you!
		AI_Output (self, other, "DIA_Harad_AlsLehrling_12_01");	//As long as you're in the army, naturally I won't expect you to fulfill your duties as an apprentice as well.
		AI_Output (self, other, "DIA_Harad_AlsLehrling_12_02");	//But if you need anything, you can come to me any time.
		Harad_MILKommentar = TRUE;
	}
	else if((other.guild == GIL_PAL) && (Harad_StartGuild != GIL_PAL) && (Harad_PALKommentar == FALSE))
	{
		AI_Output(self,other,"DIA_Harad_AlsLehrling_12_03");	//You managed to get accepted with the paladins!
		AI_Output(self,other,"DIA_Harad_AlsLehrling_12_04_01_add");	//I'm glad I took you on as an apprentice.@@@
		B_HaradCommentAnvilUses();
		Harad_PALKommentar = TRUE;
	}
	else if(((other.guild == GIL_NOV) || (other.guild == GIL_KDF)) && (Harad_StartGuild != GIL_NOV) && (Harad_StartGuild != GIL_KDF) && (Harad_INNOSKommentar == FALSE))
	{
		AI_Output (self, other, "DIA_Harad_AlsLehrling_12_05");	//So you've entered the monastery. I'd have preferred it if you'd stayed in the city. We need every good man.
		AI_Output (self, other, "DIA_Harad_AlsLehrling_12_06");	//But if you had to follow the call of Innos, then that's the way it is.
		B_HaradCommentAnvilUses();
		Harad_INNOSKommentar = TRUE;
	}
	else if((Harad_Lehrling_Day <= (Wld_GetDay() - 4)) && (Harad_MILKommentar == FALSE) && (Harad_PALKommentar == FALSE) && (Harad_INNOSKommentar == FALSE))
	{
		AI_Output (self, other, "DIA_Harad_AlsLehrling_12_08");	//It's been a while since the last time you were here. Where have you been hanging around, hm?
		Harad_Lehrling_Day = Wld_GetDay ();
	}
	else
	{
		AI_Output (self, other, "DIA_Harad_AlsLehrling_12_09");	//There you are again ...
		Harad_Lehrling_Day = Wld_GetDay ();
	};
};


instance DIA_Harad_Waffen(C_Info)
{
	npc = VLK_412_Harad;
	nr = 3;
	condition = DIA_Harad_Waffen_Condition;
	information = DIA_Harad_Waffen_Info;
	permanent = FALSE;
	description = "Do you sell weapons, too?";
};


func int DIA_Harad_Waffen_Condition()
{
	return TRUE;
};

func void DIA_Harad_Waffen_Info()
{
	AI_Output(other,self,"DIA_Harad_Waffen_15_00");	//Do you sell weapons, too?
	AI_Output(self,other,"DIA_Harad_Waffen_12_01");	//Forget it. Everything I make goes to the paladins or the militia.
	if(Kapitel == 1)
	{
		AI_Output(self,other,"DIA_Harad_Add_12_00");	//I have a commission for 100 swords from Lord Hagen. He wants to equip the city guard.
	};
};


instance DIA_Harad_Aufgaben(C_Info)
{
	npc = VLK_412_Harad;
	nr = 1;
	condition = DIA_Harad_Aufgaben_Condition;
	information = DIA_Harad_Aufgaben_Info;
	permanent = FALSE;
	description = "What are my tasks as an apprentice?";
};


func int DIA_Harad_Aufgaben_Condition()
{
	if(Player_IsApprentice == APP_Harad)
	{
		return TRUE;
	};
};

func void DIA_Harad_Aufgaben_Info()
{
	AI_Output (other, self, "DIA_Harad_Aufgaben_15_00");	//What are my tasks as an apprentice?
	AI_Output (self, other, "DIA_Harad_Aufgaben_12_01");	//Three guesses.
	AI_Output (other, self, "DIA_Harad_Aufgaben_15_02");	//Forge, forge, and forge?
	AI_Output (self, other, "DIA_Harad_Aufgaben_12_03");	//You aren't as dumb as you look. I pay per blade. If you don't work, there's no money. It's that simple.
	AI_Output (self, other, "DIA_Harad_Aufgaben_12_05");	//Furthermore, I'll teach you everything you need to know to make a plain sword.
	AI_Output (self, other, "DIA_Harad_Aufgaben_12_06");	//Making magic blades is only something for experienced smiths - and you're a long way from that ...
	AI_Output (self, other, "DIA_Harad_Aufgaben_12_07");	//If you need a place to sleep, you can bunk down somewhere in my house. Everything clear so far?
};


instance DIA_Harad_SellBlades(C_Info)
{
	npc = VLK_412_Harad;
	nr = 200;
	condition = DIA_Harad_SellBlades_Condition;
	information = DIA_Harad_SellBlades_Info;
	permanent = TRUE;
	description = "I want to sell the weapons I forged.";
};


func int DIA_Harad_SellBlades_Condition()
{
	if(Player_IsApprentice == APP_Harad)
	{
		return TRUE;
	};
};

func void DIA_Harad_SellBlades_Info()
{
	var C_Item EquipWeap;
	var int anzahl_common;
	var int anzahl_schwert1;
	var int anzahl_schwert4;
	var int anzahl_rubinklinge;
	var int anzahl_elbastardo;
	var int gesamt;
	var string concatText;
	var int lohn;
	AI_Output(other,self,"DIA_Harad_SellBlades_15_00");	//I want to sell the weapons I forged.
	EquipWeap = Npc_GetEquippedMeleeWeapon(other);
	anzahl_common = Npc_HasItems(other,ItMw_1H_Common_01);
	if(Hlp_IsItem(EquipWeap,ItMw_1H_Common_01))
	{
		if(anzahl_common > 1)
		{
			Npc_RemoveInvItem(other,ItMw_1H_Common_01);
		};
		anzahl_common -= 1;
	};
	anzahl_schwert1 = Npc_HasItems(other,ItMw_Schwert1);
	if(Hlp_IsItem(EquipWeap,ItMw_Schwert1))
	{
		if(anzahl_schwert1 > 1)
		{
			Npc_RemoveInvItem(other,ItMw_Schwert1);
		};
		anzahl_schwert1 -= 1;
	};
	anzahl_schwert4 = Npc_HasItems(other,ItMw_Schwert4);
	if(Hlp_IsItem(EquipWeap,ItMw_Schwert4))
	{
		if(anzahl_schwert4 > 1)
		{
			Npc_RemoveInvItem(other,ItMw_Schwert4);
		};
		anzahl_schwert4 -= 1;
	};
	anzahl_rubinklinge = Npc_HasItems(other,ItMw_Rubinklinge);
	if(Hlp_IsItem(EquipWeap,ItMw_Rubinklinge))
	{
		if(anzahl_rubinklinge > 1)
		{
			Npc_RemoveInvItem(other,ItMw_Rubinklinge);
		};
		anzahl_rubinklinge -= 1;
	};
	anzahl_elbastardo = Npc_HasItems(other,ItMw_ElBastardo);
	if(Hlp_IsItem(EquipWeap,ItMw_ElBastardo))
	{
		if(anzahl_elbastardo > 1)
		{
			Npc_RemoveInvItem(other,ItMw_ElBastardo);
		};
		anzahl_elbastardo -= 1;
	};
	gesamt = anzahl_common + anzahl_schwert1 + anzahl_schwert4 + anzahl_rubinklinge + anzahl_elbastardo;
	if(gesamt == 0)
	{
		if(Hlp_IsItem(EquipWeap,ItMw_1H_Common_01) || Hlp_IsItem(EquipWeap,ItMw_Schwert1) || Hlp_IsItem(EquipWeap,ItMw_Schwert4) || Hlp_IsItem(EquipWeap,ItMw_Rubinklinge) || Hlp_IsItem(EquipWeap,ItMw_ElBastardo))
		{
			AI_Output (self, other, "DIA_Harad_SellBlades_12_01");	//All you have is the one on your belt. You'd better keep it.
		}
		else
		{
			AI_Output (self, other, "DIA_Harad_SellBlades_12_04");	//Then make some! I'll only accept plain swords.
		};
	}
	else
	{
		AI_Output(self,other,"DIA_Harad_SellBlades_12_02");	//Good - give it here.
		Npc_RemoveInvItems(other,ItMw_1H_Common_01,anzahl_common);
		Npc_RemoveInvItems(other,ItMw_Schwert1,anzahl_schwert1);
		Npc_RemoveInvItems(other,ItMw_Schwert4,anzahl_schwert4);
		Npc_RemoveInvItems(other,ItMw_Rubinklinge,anzahl_rubinklinge);
		Npc_RemoveInvItems(other,ItMw_ElBastardo,anzahl_elbastardo);
		concatText = ConcatStrings(IntToString(gesamt),PRINT_ItemsGiven);
		AI_PrintScreen(concatText,-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
		AI_Output(self,other,"DIA_Harad_SellBlades_12_03");	//Fine, and here's your pay.
		lohn = ((anzahl_common * Value_Common1) + (anzahl_schwert1 * Value_Schwert1) + (anzahl_schwert4 * Value_Schwert4) + (anzahl_rubinklinge * Value_Rubinklinge) + (anzahl_elbastardo * Value_ElBastardo)) / 3;
		HaradSwordsCounter += gesamt;
		ApprenticeGoldCounter += lohn;
		B_GiveInvItems(self,other,ItMi_Gold,lohn);
	};
};

func void B_Harad_TeachSmith()
{
	AI_Output (self, other, "DIA_Harad_TeachCommon_12_01");	//It's quite simple, boy. Get a piece of raw steel and hold it in the fire until it glows.
	AI_Output (self, other, "DIA_Harad_TeachCommon_12_02");	//Then you pound the blade into shape on the anvil.
};

func void B_HaradSmithChoices()
{
	Info_ClearChoices(DIA_Harad_TeachSmith);
	Info_AddChoice(DIA_Harad_TeachSmith,Dialog_Back,DIA_Harad_TeachSmith_BACK);
	if((PLAYER_TALENT_SMITH[WEAPON_1H_Harad_04] == FALSE) && (PLAYER_TALENT_SMITH[WEAPON_1H_Harad_03] == TRUE))
	{
		Info_AddChoice(DIA_Harad_TeachSmith,B_BuildLearnString(NAME_Addon_Harad_04,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Harad_04)),DIA_Harad_TeachSmith_Harad04);
	};
	if((PLAYER_TALENT_SMITH[WEAPON_1H_Harad_03] == FALSE) && (PLAYER_TALENT_SMITH[WEAPON_1H_Harad_02] == TRUE))
	{
		Info_AddChoice(DIA_Harad_TeachSmith,B_BuildLearnString(NAME_Addon_Harad_03,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Harad_03)),DIA_Harad_TeachSmith_Harad03);
	};
	if((PLAYER_TALENT_SMITH[WEAPON_1H_Harad_02] == FALSE) && (PLAYER_TALENT_SMITH[WEAPON_1H_Harad_01] == TRUE))
	{
		Info_AddChoice(DIA_Harad_TeachSmith,B_BuildLearnString(NAME_Addon_Harad_02,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Harad_02)),DIA_Harad_TeachSmith_Harad02);
	};
	if((PLAYER_TALENT_SMITH[WEAPON_1H_Harad_01] == FALSE) && (PLAYER_TALENT_SMITH[WEAPON_Common] == TRUE))
	{
		Info_AddChoice(DIA_Harad_TeachSmith,B_BuildLearnString(NAME_Addon_Harad_01,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Harad_01)),DIA_Harad_TeachSmith_Harad01);
	};
	if(PLAYER_TALENT_SMITH[WEAPON_Common] == FALSE)
	{
		Info_AddChoice(DIA_Harad_TeachSmith,B_BuildLearnString(NAME_Skill_Smith,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_Common)),DIA_Harad_TeachSmith_Common);
	};
};


instance DIA_Harad_TeachSmith(C_Info)
{
	npc = VLK_412_Harad;
	nr = 50;
	condition = DIA_Harad_TeachSmith_Condition;
	information = DIA_Harad_TeachSmith_Info;
	permanent = TRUE;
	description = "Teach me how to forge a decent sword!";
};


func int DIA_Harad_TeachSmith_Condition()
{
	if(Player_IsApprentice == APP_Harad)
	{
		if((PLAYER_TALENT_SMITH[WEAPON_Common] == FALSE) || (PLAYER_TALENT_SMITH[WEAPON_1H_Harad_01] == FALSE) || (PLAYER_TALENT_SMITH[WEAPON_1H_Harad_02] == FALSE) || (PLAYER_TALENT_SMITH[WEAPON_1H_Harad_03] == FALSE) || (PLAYER_TALENT_SMITH[WEAPON_1H_Harad_04] == FALSE))
		{
			return TRUE;
		};
	};
};

func void DIA_Harad_TeachSmith_Info()
{
	AI_Output (other, self, "DIA_Harad_TeachCommon_15_00");	//Teach me how to forge a decent sword!
	B_HaradSmithChoices ();
};

func void DIA_Harad_TeachSmith_BACK()
{
	Info_ClearChoices(DIA_Harad_TeachSmith);
};

func void DIA_Harad_TeachSmith_Common()
{
	if(B_TeachPlayerTalentSmith(self,other,WEAPON_Common))
	{
		B_Harad_TeachSmith ();
		AI_Output (self, other, "DIA_Harad_TeachCommon_12_03");	//Your first swords won't be masterpieces, but you can learn everything else later.
	};
	B_HaradSmithChoices();
};

func void DIA_Harad_TeachSmith_Harad01()
{
	if(B_TeachPlayerTalentSmith(self,other,WEAPON_1H_Harad_01))
	{
		B_Harad_TeachSmith();
	};
	B_HaradSmithChoices();
};

func void DIA_Harad_TeachSmith_Harad02()
{
	if(B_TeachPlayerTalentSmith(self,other,WEAPON_1H_Harad_02))
	{
		B_Harad_TeachSmith();
	};
	B_HaradSmithChoices();
};

func void DIA_Harad_TeachSmith_Harad03()
{
	if(B_TeachPlayerTalentSmith(self,other,WEAPON_1H_Harad_03))
	{
		B_Harad_TeachSmith();
	};
	B_HaradSmithChoices();
};

func void DIA_Harad_TeachSmith_Harad04()
{
	if(B_TeachPlayerTalentSmith(self,other,WEAPON_1H_Harad_04))
	{
		B_Harad_TeachSmith();
	};
	B_HaradSmithChoices();
};


var int Harad_Merke_STR;

func void B_BuildLearnDialog_Harad()
{
	Info_ClearChoices(DIA_Harad_TeachSTR);
	Info_AddChoice(DIA_Harad_TeachSTR,Dialog_Back,DIA_Harad_TeachSTR_BACK);
	Info_AddChoice(DIA_Harad_TeachSTR,B_BuildLearnString(PRINT_LearnSTR1,B_GetLearnCostAttribute(other,ATR_STRENGTH)),DIA_Harad_TeachSTR_1);
	Info_AddChoice(DIA_Harad_TeachSTR,B_BuildLearnString(PRINT_LearnSTR5,B_GetLearnCostAttribute(other,ATR_STRENGTH) * 5),DIA_Harad_TeachSTR_5);
};

instance DIA_Harad_TeachSTR(C_Info)
{
	npc = VLK_412_Harad;
	nr = 100;
	condition = DIA_Harad_TeachSTR_Condition;
	information = DIA_Harad_TeachSTR_Info;
	permanent = TRUE;
	description = "I want to become stronger!";
};


func int DIA_Harad_TeachSTR_Condition()
{
	if(Player_IsApprentice == APP_Harad)
	{
		return TRUE;
	};
};

func void DIA_Harad_TeachSTR_Info()
{
	AI_Output (other, self, "DIA_Harad_TeachSTR_15_00");	//I want to become stronger!
	Harad_Merke_STR = other.aivar[REAL_STRENGTH];
	B_BuildLearnDialog_Harad();
};

func void DIA_Harad_TeachSTR_BACK()
{
	if(Harad_Merke_STR < other.aivar[REAL_STRENGTH])
	{
		AI_Output(self,other,"DIA_Harad_TeachSTR_BACK_12_01");	//You've already put on a bit of muscle.
	};
	if(other.aivar[REAL_STRENGTH] < T_MED)
	{
		AI_Output(self,other,"DIA_Harad_TeachSTR_BACK_12_02");	//Come back if you want to learn more.
	};
	Info_ClearChoices(DIA_Harad_TeachSTR);
};

func void DIA_Harad_TeachSTR_1()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,1,T_MED))
	{
		B_BuildLearnDialog_Harad();
	};
};

func void DIA_Harad_TeachSTR_5()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,5,T_MED))
	{
		B_BuildLearnDialog_Harad();
	};
};

instance DIA_Harad_ImmerNoch(C_Info)
{
	npc = VLK_412_Harad;
	nr = 3;
	condition = DIA_Harad_ImmerNoch_Condition;
	information = DIA_Harad_ImmerNoch_Info;
	permanent = FALSE;
	description = "Are you still working for the paladins?";
};


func int DIA_Harad_ImmerNoch_Condition()
{
	if(Kapitel >= 2)
	{
		return TRUE;
	};
};

func void DIA_Harad_ImmerNoch_Info()
{
	AI_Output (other, self, "DIA_Harad_Add_15_01");	//Are you still working for the paladins?
	AI_Output (self, other, "DIA_Harad_Add_12_02");	//I finished the commission from Lord Hagen.
	AI_Output (self, other, "DIA_Harad_Add_12_03");	//Now I'm making magic ore blades for him - but for pay this time.
	AI_Output (self, other, "DIA_Harad_Add_12_04");	//But I also have the time again to make a few weapons on the side for the merchants in the marketplace.
	AI_Output (self, other, "DIA_Harad_Add_12_05");	//So, if you're looking for a good blade, you should try with them.
};


instance DIA_Harad_AboutErzklingen(C_Info)
{
	npc = VLK_412_Harad;
	nr = 3;
	condition = DIA_Harad_AboutErzklingen_Condition;
	information = DIA_Harad_AboutErzklingen_Info;
	permanent = FALSE;
	description = "Tell me more about magic ore blades!";
};


func int DIA_Harad_AboutErzklingen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Harad_ImmerNoch))
	{
		return TRUE;
	};
};

func void DIA_Harad_AboutErzklingen_Info()
{
	AI_Output (other, self, "DIA_Harad_Add_15_06");	//Tell me more about magic ore blades!
	AI_Output (self, other, "DIA_Harad_Waffen_12_02");	//Creating a magic blade is a very complicated and expensive process, but the result is a blade that's easy to handle and practically indestructible.
	AI_Output (self, other, "DIA_Harad_Waffen_12_03");	//The blade is certainly of good quality, but it will only show its true power in the hands of a paladin.
	AI_Output (self, other, "DIA_Harad_Waffen_12_04");	//A paladin's sword is consecrated by Innos. As a result, the magic blade becomes an enchanted weapon that does incomparable damage!
};


instance DIA_Harad_Erzklingen(C_Info)
{
	npc = VLK_412_Harad;
	nr = 3;
	condition = DIA_Harad_Erzklingen_Condition;
	information = DIA_Harad_Erzklingen_Info;
	permanent = TRUE;
	description = "I want to buy a magic ore blade.";
};


func int DIA_Harad_Erzklingen_Condition()
{
	if((OreBladeBought == FALSE) && Npc_KnowsInfo(other,DIA_Harad_AboutErzklingen))
	{
		return TRUE;
	};
};


var int OreBladeBought;

func void DIA_Harad_Erzklingen_Info()
{
	AI_Output (other, self, "DIA_Harad_Erzklingen_15_00");	//I want to buy a magic ore blade.
	if (hero.guild != GIL_PAL)
	{
		AI_Output (self, other, "DIA_Harad_Erzklingen_12_01");	//I can only sell magic blades to the paladins. And even then only one each.
	}
	else
	{
		AI_Output (self, other, "DIA_Harad_Erzklingen_12_02");	//You paladins can count yourselves lucky to be allowed to wield such excellent blades.
		AI_Output (self, other, "DIA_Harad_Erzklingen_12_03");	//By decree of Lord Hagen, I may only sell you a single magic weapon.
		AI_Output (self, other, "DIA_Harad_Erzklingen_12_04");	//So, what can I offer you?
		Info_ClearChoices (DIA_Harad_Erzklingen);
		Info_AddChoice (DIA_Harad_Erzklingen, Dialog_Back, DIA_Harad_Erzklingen_Back);
		Info_AddChoice (DIA_Harad_Erzklingen, "Two-handed sword (2000 gold)", DIA_Harad_Erzklingen_2h);
		Info_AddChoice (DIA_Harad_Erzklingen, "One-handed sword (2000 gold)", DIA_Harad_Erzklingen_1h);
	};
};

func void DIA_Harad_Erzklingen_Back()
{
	Info_ClearChoices(DIA_Harad_Erzklingen);
};

func void B_Harad_NotEnoughGold()
{
	AI_Output (self, other, "B_Harad_NotEnoughGold_12_00");	//You don't have enough gold.
};

func void B_Harad_HaveFunWithYourSword()
{
	AI_Output (self, other, "B_Harad_HaveGunWithYourSword_12_00");	//Take good care of your new weapon. It's worth a fortune.
	OreBladeBought = TRUE;
	Info_ClearChoices(DIA_Harad_Erzklingen);
};

func void DIA_Harad_Erzklingen_2h()
{
	AI_Output (other, self, "DIA_Harad_Erzklingen_2h_15_00");	//I'll take the two-handed sword!
	if (Npc_HasItems (other, ItMi_Gold) >= Value_Blessed_2H_1)
	{
		B_GiveInvItems(other,self,ItMi_Gold,Value_Blessed_2H_1);
		CreateInvItems(self,ItMw_2H_Blessed_01,1);
		B_GiveInvItems(self,other,ItMw_2H_Blessed_01,1);
		B_Harad_HaveFunWithYourSword();
	}
	else
	{
		B_Harad_NotEnoughGold ();
		Info_ClearChoices (DIA_Harad_Erzklingen);
		Info_AddChoice (DIA_Harad_Erzklingen, Dialog_Back, DIA_Harad_Erzklingen_Back);
		Info_AddChoice (DIA_Harad_Erzklingen, "Two-handed sword (2000 gold)", DIA_Harad_Erzklingen_2h);
		Info_AddChoice (DIA_Harad_Erzklingen, "One-handed sword (2000 gold)", DIA_Harad_Erzklingen_1h);
	};
};

func void DIA_Harad_Erzklingen_1h()
{
	AI_Output (other, self, "DIA_Harad_Erzklingen_1h_15_00");	//I'll take the one-handed sword!
	if (Npc_HasItems (other, ItMi_Gold) >= Value_Blessed_1H_1)
	{
		B_GiveInvItems(other,self,ItMi_Gold,Value_Blessed_1H_1);
		CreateInvItems(self,ItMw_1H_Blessed_01,1);
		B_GiveInvItems(self,other,ItMw_1H_Blessed_01,1);
		B_Harad_HaveFunWithYourSword();
	}
	else
	{
		B_Harad_NotEnoughGold ();
		Info_ClearChoices (DIA_Harad_Erzklingen);
		Info_AddChoice (DIA_Harad_Erzklingen, Dialog_Back, DIA_Harad_Erzklingen_Back);
		Info_AddChoice (DIA_Harad_Erzklingen, "Two-handed sword (2000 gold)", DIA_Harad_Erzklingen_2h);
		Info_AddChoice (DIA_Harad_Erzklingen, "One-handed sword (2000 gold)", DIA_Harad_Erzklingen_1h);
	};
};


instance DIA_Harad_RepairNecklace(C_Info)
{
	npc = VLK_412_Harad;
	nr = 8;
	condition = DIA_Harad_RepairNecklace_Condition;
	information = DIA_Harad_RepairNecklace_Info;
	permanent = FALSE;
	description = "Can you repair jewelry?";
};


func int DIA_Harad_RepairNecklace_Condition()
{
	if((MIS_Bennet_InnosEyeRepairedSetting != LOG_SUCCESS) && (Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) || (MIS_SCKnowsInnosEyeIsBroken == TRUE)))
	{
		if(!Npc_KnowsInfo(other,DIA_Bennet_ShowInnosEye))
		{
			return TRUE;
		};
	};
};

func void DIA_Harad_RepairNecklace_Info()
{
	DIA_Common_CanYouRepairJewelry();
	AI_Output (self, other, "DIA_Harad_RepairNecklace_12_01");	//I'm a weapon smith, not a goldsmith. You probably won't find anyone here in the city who can help you.
	AI_Output (self, other, "DIA_Harad_RepairNecklace_12_02");	//People don't have money in their pockets any more, and nobody's gotten rich here in quite a while.
	AI_Output (self, other, "DIA_Harad_RepairNecklace_12_03");	//Most of them are just glad if they have enough to eat.
	MIS_SCKnowsInnosEyeIsBroken = TRUE;
};


instance DIA_Harad_Goldsmith(C_Info)
{
	npc = VLK_412_Harad;
	nr = 8;
	condition = DIA_Harad_Goldsmith_Condition;
	information = DIA_Harad_Goldsmith_Info;
	permanent = FALSE;
	description = "Where can I find a goldsmith?";
};


func int DIA_Harad_Goldsmith_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Harad_RepairNecklace) && !Npc_KnowsInfo(other,DIA_Bennet_ShowInnosEye))
	{
		return TRUE;
	};
};

func void DIA_Harad_Goldsmith_Info()
{
	AI_Output (other, self, "DIA_Harad_Goldsmith_15_00");	//Where can I find a goldsmith?
	AI_Output (self, other, "DIA_Harad_Goldsmith_12_01");	//There's supposed to be a good smith with the mercenaries on Onar's farm.
	AI_Output (self, other, "DIA_Harad_Goldsmith_12_02");	//Maybe you should look there.
};


instance DIA_Harad_PICKPOCKET(C_Info)
{
	npc = VLK_412_Harad;
	nr = 900;
	condition = DIA_Harad_PICKPOCKET_Condition;
	information = DIA_Harad_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Harad_PICKPOCKET_Condition()
{
	return C_Beklauen(14,35);
};

func void DIA_Harad_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Harad_PICKPOCKET);
	Info_AddChoice(DIA_Harad_PICKPOCKET,Dialog_Back,DIA_Harad_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Harad_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Harad_PICKPOCKET_DoIt);
};

func void DIA_Harad_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Harad_PICKPOCKET);
};

func void DIA_Harad_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Harad_PICKPOCKET);
};

