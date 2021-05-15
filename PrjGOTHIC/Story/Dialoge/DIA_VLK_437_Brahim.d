
var int Brahim_ShowedMaps;

func void B_BrahimNewMaps()
{
	if((Brahim_ShowedMaps == TRUE) && (self.aivar[AIV_LastFightAgainstPlayer] != FIGHT_LOST))
	{
		AI_Output (self, other, "B_BrahimNewMaps_07_00");	//Come back again later. I'm sure to have something new for you then.
	};
};


instance DIA_Brahim_EXIT(C_Info)
{
	npc = VLK_437_Brahim;
	nr = 999;
	condition = DIA_Brahim_EXIT_Condition;
	information = DIA_Brahim_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Brahim_EXIT_Condition()
{
	if(Kapitel <= 2)
	{
		return TRUE;
	};
};

func void DIA_Brahim_EXIT_Info()
{
	B_BrahimNewMaps();
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Brahim_PICKPOCKET(C_Info)
{
	npc = VLK_437_Brahim;
	nr = 900;
	condition = DIA_Brahim_PICKPOCKET_Condition;
	information = DIA_Brahim_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Brahim_PICKPOCKET_Condition()
{
	return C_Beklauen(15,15);
};

func void DIA_Brahim_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Brahim_PICKPOCKET);
	Info_AddChoice(DIA_Brahim_PICKPOCKET,Dialog_Back,DIA_Brahim_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Brahim_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Brahim_PICKPOCKET_DoIt);
};

func void DIA_Brahim_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Brahim_PICKPOCKET);
};

func void DIA_Brahim_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Brahim_PICKPOCKET);
};


instance DIA_Brahim_GREET(C_Info)
{
	npc = VLK_437_Brahim;
	nr = 2;
	condition = DIA_Brahim_GREET_Condition;
	information = DIA_Brahim_GREET_Info;
	permanent = FALSE;
	description = "What are you doing here?";
};


func int DIA_Brahim_GREET_Condition()
{
	return TRUE;
};

func void DIA_Brahim_GREET_Info()
{
	AI_Output (other, self, "DIA_Brahim_GREET_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Brahim_GREET_07_01");	//My name is Brahim. I draw maps, and sell them.
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
	{
	AI_Output (self, other, "DIA_Brahim_GREET_07_02");	//Since you're new here, maybe you could use a map of the city.
	AI_Output (self, other, "DIA_Brahim_GREET_07_03");	//It's quite affordable - and very useful until you know your way around.
	};
	if(DIA_Kardif_Lernen_permanent == FALSE)
	{
		Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
		B_LogEntry(TOPIC_CityTrader,"Brahim draws and sells maps near the harbor.");
	};
};


instance DIA_Addon_Brahim_MissingPeople(C_Info)
{
	npc = VLK_437_Brahim;
	nr = 5;
	condition = DIA_Addon_Brahim_MissingPeople_Condition;
	information = DIA_Addon_Brahim_MissingPeople_Info;
	description = "Is it true that some townspeople have simply vanished?";
};


func int DIA_Addon_Brahim_MissingPeople_Condition()
{
	if((SC_HearedAboutMissingPeople == TRUE) && (MissingPeopleReturnedHome == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Brahim_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Brahim_MissingPeople_15_00");	//Is it true that some townspeople have simply vanished?
	AI_Output (self, other, "DIA_Addon_Brahim_MissingPeople_07_01");	//So I've heard. But I'm not sure whether it's really true.
	AI_Output (self, other, "DIA_Addon_Brahim_MissingPeople_07_02");	//Just look around you. Does this rathole look like the place where you want to spend your golden years?
	AI_Output (self, other, "DIA_Addon_Brahim_MissingPeople_07_03");	//Small wonder that people are getting themselves out of here.
};


instance DIA_Brahim_BUY(C_Info)
{
	npc = VLK_437_Brahim;
	nr = 9;
	condition = DIA_Brahim_BUY_Condition;
	information = DIA_Brahim_BUY_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "Show me your maps.";
};


func int DIA_Brahim_BUY_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Brahim_GREET))
	{
		return TRUE;
	};
};

func void DIA_Brahim_BUY_Info()
{
	AI_Output(other,self,"DIA_Brahim_BUY_15_00");	//Show me your maps.
	B_GiveTradeInv(self);
	if(hero.guild == GIL_KDF)
	{
		AI_Output(self,other,"DIA_Brahim_BUY_07_01");	//You won't find better in that monastery of yours.
	};
	if(hero.guild == GIL_PAL)
	{
		AI_Output(self,other,"DIA_Brahim_BUY_07_02");	//Good maps are important, especially for people who come from the mainland, Mr. Paladin.
	};
	Brahim_ShowedMaps = TRUE;
	Trade_IsActive = TRUE;
};


instance DIA_Brahim_Kap3_EXIT(C_Info)
{
	npc = VLK_437_Brahim;
	nr = 999;
	condition = DIA_Brahim_Kap3_EXIT_Condition;
	information = DIA_Brahim_Kap3_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Brahim_Kap3_EXIT_Condition()
{
	if((Kapitel >= 3) && (Npc_KnowsInfo(other,DIA_Brahim_Kap3_First_EXIT) || !Npc_HasItems(other,ItWr_ShatteredGolem_MIS)))
	{
		return TRUE;
	};
};

func void DIA_Brahim_Kap3_EXIT_Info()
{
	if(Kapitel <= 4)
	{
		B_BrahimNewMaps();
	};
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Brahim_Kap3_First_EXIT(C_Info)
{
	npc = VLK_437_Brahim;
	nr = 999;
	condition = DIA_Brahim_Kap3_First_EXIT_Condition;
	information = DIA_Brahim_Kap3_First_EXIT_Info;
	permanent = FALSE;
	description = Dialog_Ende;
};


func int DIA_Brahim_Kap3_First_EXIT_Condition()
{
	if(Kapitel >= 3)
	{
		if(Npc_HasItems(other,ItWr_ShatteredGolem_MIS) || (MIS_HannaRetrieveLetter == LOG_SUCCESS))
		{
			return TRUE;
		};
	};
};

func void DIA_Brahim_Kap3_First_EXIT_Info()
{
	if(self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_NONE)
	{
	AI_Output (self, other, "DIA_Brahim_Kap3_First_EXIT_07_00");	//I knew this piece would interest you.
	AI_Output (other, self, "DIA_Brahim_Kap3_First_EXIT_15_01");	//What piece would that be?
	AI_Output (self, other, "DIA_Brahim_Kap3_First_EXIT_07_02");	//Well, that old map you just bought.
	};
	AI_Output(self,other,"DIA_Brahim_Kap3_First_EXIT_07_03");	//I know your kind. You go for any chance of finding riches.
	if(self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_NONE)
	{
		Info_ClearChoices(DIA_Brahim_Kap3_First_EXIT);
		Info_AddChoice(DIA_Brahim_Kap3_First_EXIT,Dialog_Back,DIA_Brahim_Kap3_First_EXIT_BACK);
		Info_AddChoice(DIA_Brahim_Kap3_First_EXIT,"Where did you get that document?",DIA_Brahim_Kap3_First_EXIT_WhereGetIt);
		Info_AddChoice(DIA_Brahim_Kap3_First_EXIT,"What kind of document is that?",DIA_Brahim_Kap3_First_EXIT_Content);
		Info_AddChoice(DIA_Brahim_Kap3_First_EXIT,"Why don't you keep it for yourself",DIA_Brahim_Kap3_First_EXIT_KeepIt);
	}
	else
	{
		AI_StopProcessInfos(self);
	};
};

func void DIA_Brahim_Kap3_First_EXIT_BACK()
{
	Info_ClearChoices(DIA_Brahim_Kap3_First_EXIT);
};

func void DIA_Brahim_Kap3_First_EXIT_WhereGetIt()
{
	AI_Output (other, self, "DIA_Brahim_Kap3_First_EXIT_WhereGetIt_15_00");	//Where did you get this map?
	AI_Output (self, other, "DIA_Brahim_Kap3_First_EXIT_WhereGetIt_07_01");	//Oh, I found that in a stack of old maps which I bought recently.
	AI_Output (self, other, "DIA_Brahim_Kap3_First_EXIT_WhereGetIt_07_02");	//The seller must have overlooked it.
};

func void DIA_Brahim_Kap3_First_EXIT_Content()
{
	AI_Output (other, self, "DIA_Brahim_Kap3_First_EXIT_Content_15_00");	//What kind of a map is it?
	AI_Output (self, other, "DIA_Brahim_Kap3_First_EXIT_Content_07_01");	//It seems to be a treasure map or the like.
	AI_Output (self, other, "DIA_Brahim_Kap3_First_EXIT_Content_07_02");	//But you look to me like one who will get to the heart of this matter himself.
};

func void DIA_Brahim_Kap3_First_EXIT_KeepIt()
{
	AI_Output (other, self, "DIA_Brahim_Kap3_First_EXIT_KeepIt_15_00");	//Why don't you keep it for yourself?
	AI_Output (self, other, "DIA_Brahim_Kap3_First_EXIT_KeepIt_07_01");	//I'm an old man, and the times when I set out myself are long past.
	AI_Output (self, other, "DIA_Brahim_Kap3_First_EXIT_KeepIt_07_02");	//I leave that to younger people.
};

