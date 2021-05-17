
instance DIA_Garvell_EXIT(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 999;
	condition = DIA_Garvell_EXIT_Condition;
	information = DIA_Garvell_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Garvell_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Garvell_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Garvell_PICKPOCKET(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 900;
	condition = DIA_Garvell_PICKPOCKET_Condition;
	information = DIA_Garvell_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Garvell_PICKPOCKET_Condition()
{
	if(Npc_HasItems(self,ItSe_GoldPocket25))
	{
		return C_StealItem(10);
	};
	return FALSE;
};

func void DIA_Garvell_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Garvell_PICKPOCKET);
	Info_AddChoice(DIA_Garvell_PICKPOCKET,Dialog_Back,DIA_Garvell_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Garvell_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Garvell_PICKPOCKET_DoIt);
};

func void DIA_Garvell_PICKPOCKET_DoIt()
{
	B_StealItem(10,Hlp_GetInstanceID(ItSe_GoldPocket25));
	Info_ClearChoices(DIA_Garvell_PICKPOCKET);
};

func void DIA_Garvell_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Garvell_PICKPOCKET);
};


instance DIA_Garvell_GREET(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 2;
	condition = DIA_Garvell_GREET_Condition;
	information = DIA_Garvell_GREET_Info;
	description = "What are you doing here?";
};


func int DIA_Garvell_GREET_Condition()
{
	if(Wld_IsTime(5,0,19,10))
	{
		return TRUE;
	};
};

func void DIA_Garvell_GREET_Info()
{
	AI_Output (other, self, "DIA_Garvell_GREET_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Garvell_GREET_04_01");	//I'm building a ship because I want to get out of here - as fast as I can.
	AI_Output (self, other, "DIA_Garvell_GREET_04_02");	//But the way it looks right now, this ship will never be finished.
};


instance DIA_Garvell_eilig(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 2;
	condition = DIA_Garvell_eilig_Condition;
	information = DIA_Garvell_eilig_Info;
	description = "Why are you in such a hurry?";
};


func int DIA_Garvell_eilig_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Garvell_GREET))
	{
		return TRUE;
	};
};

func void DIA_Garvell_eilig_Info()
{
	AI_Output (other, self, "DIA_Garvell_eilig_15_00");	//Why are you in such a hurry?
	AI_Output (self, other, "DIA_Garvell_eilig_04_01");	//Soon the orcs will come and burn down the city.
	AI_Output (other, self, "DIA_Garvell_eilig_15_02");	//What makes you think that?
	AI_Output (self, other, "DIA_Garvell_eilig_04_03");	//Boy, have you noticed the paladins running around everywhere? Why do you think they're here?
	AI_Output (self, other, "DIA_Garvell_eilig_04_04");	//I tell you, they're here because the orcs will attack soon. And that won't be pretty.
};


instance DIA_Garvell_Schiff(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 99;
	condition = DIA_Garvell_Schiff_Condition;
	information = DIA_Garvell_Schiff_Info;
	description = "Why can't you finish your ship?";
};


func int DIA_Garvell_Schiff_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Garvell_GREET))
	{
		return TRUE;
	};
};

func void DIA_Garvell_Schiff_Info()
{
	AI_Output (other, self, "DIA_Garvell_Schiff_15_00");	//Why can't you finish your ship?
	AI_Output (self, other, "DIA_Garvell_Schiff_04_01");	//(dismissively) Oh, we have thousands of problems. The hull still isn't stable, and it's still missing a lot of boards.
	AI_Output (self, other, "DIA_Garvell_Schiff_04_02");	//But I have hardly any gold left to buy new material with, and the last delivery had bugs in it.
	AI_Output (self, other, "DIA_Garvell_Schiff_04_03");	//My boys don't work productively. One wants a fast ship above all else, the other one is worried about the figurehead!
	AI_Output (self, other, "DIA_Garvell_Schiff_04_04");	//As if we didn't have more important things to do!
	if(MissingPeopleReturnedHome == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Garvell_Schiff_04_00");	//Also, one of my people is simply not showing up for work any more. I'm beginning to fear that this will delay the construction even more.
	};
};


instance DIA_Addon_Garvell_MissingPeople(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 5;
	condition = DIA_Addon_Garvell_MissingPeople_Condition;
	information = DIA_Addon_Garvell_MissingPeople_Info;
	description = "You're short a worker?";
};


func int DIA_Addon_Garvell_MissingPeople_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Garvell_Schiff) && (MissingPeopleReturnedHome == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Garvell_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Garvell_MissingPeople_15_00");	//You're short a worker?
	AI_Output (self, other, "DIA_Addon_Garvell_MissingPeople_04_01");	//Yes. His name's Monty. He's vanished into thin air.
	AI_Output (self, other, "DIA_Addon_Garvell_MissingPeople_04_02");	//That lazy pig is probably living the high life on a farm somewhere. I should never have paid him in advance.
	AI_Output(other,self,"DIA_Addon_Garvell_MissingPeople_wo_15_00");	//When was the last time you saw Monty?
	AI_Output(self,other,"DIA_Addon_Garvell_MissingPeople_wo_04_01");	//(angrily) He hasn't bothered to show up for work for at least two days.
	Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
	B_LogEntry(TOPIC_Addon_MissingPeople,"Garvell is complaining about his worker Monty who failed to show up for work one day. Garvell thinks that Monty is living the high life with the farmers.");
};

instance DIA_Addon_Garvell_MissingPeopleMore(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 5;
	condition = DIA_Addon_Garvell_MissingPeopleMore_Condition;
	information = DIA_Addon_Garvell_MissingPeopleMore_Info;
	description = "I've heard that other people have gone missing, too.";
};


func int DIA_Addon_Garvell_MissingPeopleMore_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Garvell_MissingPeople) && (MissingPeopleReturnedHome == FALSE) && (SC_HearedAboutMissingPeople == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Garvell_MissingPeopleMore_Info()
{
	AI_Output (other, self, "DIA_Addon_Garvell_MissingPeople_more_15_00");	//I've heard that other people have gone missing, too.
	AI_Output (self, other, "DIA_Addon_Garvell_MissingPeople_more_04_01");	//Just what I'm saying. That's where the evil starts.
	AI_Output (self, other, "DIA_Addon_Garvell_MissingPeople_more_04_02");	//Farim the fisherman told me something similar. His buddy William is no longer around.
	AI_Output (self, other, "DIA_Addon_Garvell_MissingPeople_more_04_03");	//I bet that the orcs are behind all this.
	SCKnowsFarimAsWilliamsFriend = TRUE;
	Log_CreateTopic(TOPIC_Addon_WhoStolePeople,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_WhoStolePeople,LOG_Running);
	B_LogEntry(TOPIC_Addon_WhoStolePeople,"Farim the fisherman seems to know a thing or two about the disappearance of his friend William.");
	if(!Npc_KnowsInfo(other,DIA_Addon_Farim_William))
	{
		Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
		B_LogEntry(TOPIC_Addon_MissingPeople,LogText_Addon_WilliamMissing);
	};
	Info_ClearChoices(DIA_Addon_Garvell_MissingPeopleMore);
	Info_AddChoice(DIA_Addon_Garvell_MissingPeopleMore,Dialog_Back,DIA_Addon_Garvell_MissingPeopleMore_BACK);
	Info_AddChoice(DIA_Addon_Garvell_MissingPeopleMore,"Where can I find this Farim?",DIA_Addon_Garvell_MissingPeopleMore_Farim);
};

func void DIA_Addon_Garvell_MissingPeopleMore_BACK()
{
	Info_ClearChoices(DIA_Addon_Garvell_MissingPeopleMore);
};

func void DIA_Addon_Garvell_MissingPeopleMore_Farim()
{
	AI_Output(other,self,"DIA_Addon_Garvell_MissingPeople_Farim_15_00");	//Where can I find this Farim?
	AI_Output(self,other,"DIA_Addon_Garvell_MissingPeople_Farim_04_01");	//He's a fisherman. I think that his hut is near the provisions store of the paladins. But I don't know for sure.
	B_LogEntry(TOPIC_Addon_WhoStolePeople,"Farim's hut is situated near the paladins' provisions store.");
};

instance DIA_Garvell_ReturnMonty(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 99;
	condition = DIA_Garvell_ReturnMonty_Condition;
	information = DIA_Garvell_ReturnMonty_Info;
	description = "And, how's it going NOW?";
};


func int DIA_Garvell_ReturnMonty_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Garvell_Schiff) && (MissingPeopleReturnedHome == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Garvell_ReturnMonty_Info()
{
	AI_Output(other,self,"DIA_Addon_Garvell_ReturnMonty_15_00");	//And, how's it going NOW?
	if(!Npc_IsDead(Monty_NW))
	{
	AI_Output (self, other, "DIA_Addon_Garvell_ReturnMonty_04_01");	//Monty is back! He's busy studying the plans.
	AI_Output (self, other, "DIA_Addon_Garvell_ReturnMonty_04_02");	//Maybe we can get the ship done now...
		B_GivePlayerXP(XP_Ambient);
	}
	else if(MIS_Garvell_Infos == LOG_Running)
	{
		AI_Output(self,other,"DIA_Garvell_Add_04_00");	//I need to know how much time I have left to finish the boat.
	}
	else if(MIS_Garvell_Infos == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Garvell_Success_04_00");	//Thanks for the information. The way it looks, we have all the time in the world for building our ship.
	}
	else
	{
		AI_Output(self,other,"DIA_Garvell_Schiff_04_01");	//(dismissively) Oh, we have thousands of problems. The hull still isn't stable, and it's still missing a lot of boards.
	};
};


instance DIA_Garvell_MISSION(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 2;
	condition = DIA_Garvell_MISSION_Condition;
	information = DIA_Garvell_MISSION_Info;
	permanent = FALSE;
	description = "Is there any way I can help you?";
};


func int DIA_Garvell_MISSION_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Garvell_eilig) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Garvell_MISSION_Info()
{
	AI_Output (other, self, "DIA_Garvell_MISSION_15_00");	//Can I help you somehow?
	AI_Output (self, other, "DIA_Garvell_MISSION_04_01");	//Yes you can. Find out what the paladins are planning. I want to know why they're here.
	AI_Output (self, other, "DIA_Garvell_MISSION_04_02");	//And I have to know if the orcs will attack - and how far from the city they are.
	AI_Output (self, other, "DIA_Garvell_MISSION_04_03");	//One of the bastards was even seen outside the city.
	AI_Output (self, other, "DIA_Garvell_MISSION_04_04");	//Just bring me all the information you can get.
	AI_Output (self, other, "DIA_Garvell_Add_04_00");	//I need to know how much time I have left to finish the boat.
	MIS_Garvell_Infos = LOG_Running;
	Knows_Ork = TRUE;
	Log_CreateTopic (TOPIC_Garvell, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Garvell, LOG_Running);
	B_LogEntry (TOPIC_Garvell, "Garvell wants information about the orcs, and he wants to know why the paladins are in town.");
};

func void B_GarvellInfoCheck()
{
	Tell_Garvell += 1;
	if(Tell_Garvell >= 3)
	{
		AI_Output(self,other,"DIA_Garvell_Success_04_00");	//Thanks for the information. The way it looks, we have all the time in the world for building our ship.
		MIS_Garvell_Infos = LOG_SUCCESS;
	}
	else
	{
		AI_Output(self,other,"DIA_Garvell_Weiter_04_00");	//Good. If you find out more, let me know.
	};
	if(EnterOW_Kapitel2 == FALSE)
	{
		B_GivePlayerXP(100);
	}
	else if(Kapitel == 2)
	{
		B_GivePlayerXP(75);
	}
	else if(Kapitel == 3)
	{
		B_GivePlayerXP(50);
	}
	else if(Kapitel > 3)
	{
		B_GivePlayerXP(25);
	};
};

instance DIA_Garvell_Orks(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 3;
	condition = DIA_Garvell_Orks_Condition;
	information = DIA_Garvell_Orks_Info;
	permanent = FALSE;
	description = "I've got some information about the orcs.";
};


func int DIA_Garvell_Orks_Condition()
{
	if((MIS_Garvell_Infos == LOG_Running) && ((RangarToldAboutPaladins == TRUE) || Npc_KnowsInfo(other,DIA_Garond_NeedProof)))
	{
		return TRUE;
	};
};

func void DIA_Garvell_Orks_Info()
{
	AI_Output (other, self, "DIA_Garvell_Orks_15_00");	//I've got some information about the orcs.
	AI_Output (self, other, "DIA_Garvell_Orks_04_01");	//Let's hear it.
	AI_Output (other, self, "DIA_Garvell_Orks_15_02");	//They're stuck in the Valley of Mines, and it looks like they're going to stay there.
	AI_Output (other, self, "DIA_Garvell_Orks_15_03");	//To be on the safe side, the paladins are guarding the pass.
	B_GarvellInfoCheck();
};


instance DIA_Garvell_Paladine(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 2;
	condition = DIA_Garvell_Paladine_Condition;
	information = DIA_Garvell_Paladine_Info;
	permanent = FALSE;
	description = "I know why the paladins are here.";
};


func int DIA_Garvell_Paladine_Condition()
{
	if((MIS_Garvell_Infos == LOG_Running) && (KnowsPaladins_Ore == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Garvell_Paladine_Info()
{
	AI_Output (other, self, "DIA_Garvell_Paladine_15_00");	//I know why the paladins are here.
	AI_Output (self, other, "DIA_Garvell_Paladine_04_01");	//Really? Tell me!
	AI_Output (other, self, "DIA_Garvell_Paladine_15_02");	//The paladins are here to get the magical ore from the Valley of Mines, not because they expect the orcs to attack the city.
	AI_Output (other, self, "DIA_Garvell_Paladine_15_03");	//As soon as they've got the ore, they're going to return to the mainland.
	B_GarvellInfoCheck();
};


instance DIA_Garvell_City(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 4;
	condition = DIA_Garvell_City_Condition;
	information = DIA_Garvell_City_Info;
	permanent = FALSE;
	description = "As to that orc outside of town ...";
};


func int DIA_Garvell_City_Condition()
{
	if((MIS_Garvell_Infos == LOG_Running) && ((RangarToldAboutOrc == TRUE) || Npc_IsDead(CityOrc)))
	{
		return TRUE;
	};
};

func void DIA_Garvell_City_Info()
{
	AI_Output (other, self, "DIA_Garvell_City_15_00");	//As to that orc outside of town...
	AI_Output (self, other, "DIA_Garvell_City_04_01");	//Yeees... ?
	if(Npc_IsDead(CityOrc))
	{
		DIA_Common_HeIsDead();
	}
	else
	{
		AI_Output(other,self,"DIA_Garvell_City_15_02");	//Don't worry about him. The city guard is going to take care of him.
	};
	B_GarvellInfoCheck();
};


instance DIA_Garvell_Perm(C_Info)
{
	npc = VLK_441_Garvell;
	nr = 13;
	condition = DIA_Garvell_Perm_Condition;
	information = DIA_Garvell_Perm_Info;
	permanent = TRUE;
	description = "What's going on at the harbor?";
};


func int DIA_Garvell_Perm_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Garvell_MISSION))
	{
		return TRUE;
	};
};

func void DIA_Garvell_Perm_Info()
{
	AI_Output (other, self, "DIA_Garvell_Perm_15_00");	//What's going on at the harbor?
	if (MIS_Garvell_Infos != LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Garvell_Perm_04_01");	//The orcs are breathing down our necks and you're asking about the harbor?
		AI_Output (other, self, "DIA_Garvell_Perm_15_02");	//I only wanted to ...
		AI_Output (self, other, "DIA_Garvell_Perm_04_03");	//The biggest problem we have is that there aren't enough ships in the harbor to get us out of here.
		AI_Output (self, other, "DIA_Garvell_Perm_04_04");	//To be honest, there's only one ship here, and that belongs to the paladins. They certainly won't let us get out of here with it.
	}
	else
	{
		AI_Output (self, other, "DIA_Garvell_Perm_04_05");	//Look around for yourself, there's nothing going on here.
	};
};

