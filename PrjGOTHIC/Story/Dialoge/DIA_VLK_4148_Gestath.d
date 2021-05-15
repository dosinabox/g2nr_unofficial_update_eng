
instance DIA_Gestath_EXIT(C_Info)
{
	npc = VLK_4148_Gestath;
	nr = 999;
	condition = DIA_Gestath_EXIT_Condition;
	information = DIA_Gestath_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Gestath_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Gestath_EXIT_Info()
{
	if(ArmorEquipped(other,ITAR_DJG_Crawler))
	{
		AI_Output (self, other, "DIA_Gestath_EXIT_09_00");	//(dryly) Cool armor!
	};
	AI_StopProcessInfos(self);
};


var int Gestath_WhereIsWolf;
var int Gestath_WhatsInteresting;

func void B_BuildGestathDialog()
{
	Info_ClearChoices(DIA_Gestath_HALLO);
	if((Gestath_TeachAnimalTrophy == TRUE) && (Wolf_ProduceCrawlerArmor == TRUE))
	{
		Info_AddChoice(DIA_Gestath_HALLO,Dialog_Back,DIA_Gestath_HALLO_Back);
	};
	if(Wolf_ProduceCrawlerArmor == FALSE)
	{
		Info_AddChoice(DIA_Gestath_HALLO,"That's some armor you're wearing.",DIA_Gestath_HALLO_plate);
	};
	if(Gestath_WhatsInteresting == FALSE)
	{
		Info_AddChoice(DIA_Gestath_HALLO,"What is there to see here?",DIA_Gestath_HALLO_waszusehen);
	};
	if(Gestath_TeachAnimalTrophy == FALSE)
	{
		Info_AddChoice(DIA_Gestath_HALLO,"What are you doing up here?",DIA_Gestath_HALLO_was);
	};
	if((Gestath_WhereIsWolf == FALSE) && (Wolf_ProduceCrawlerArmor == TRUE))
	{
		Info_AddChoice(DIA_Gestath_HALLO,"Where's this Wolf now?",DIA_Gestath_HALLO_plate_woWolf);
	};
};

instance DIA_Gestath_HALLO(C_Info)
{
	npc = VLK_4148_Gestath;
	nr = 3;
	condition = DIA_Gestath_HALLO_Condition;
	information = DIA_Gestath_HALLO_Info;
	description = "What's up?";
};


func int DIA_Gestath_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Gestath_HALLO_Info()
{
	AI_Output (other, self, "DIA_Gestath_HALLO_15_00");	//How's it going?
	AI_Output (self, other, "DIA_Gestath_HALLO_09_01");	//(dryly) Brave of you to come here. You got lost, huh?
	B_BuildGestathDialog();
};

func void DIA_Gestath_HALLO_plate()
{
	AI_Output (other, self, "DIA_Gestath_HALLO_plate_15_00");	//That's some armor you're wearing.
	AI_Output (self, other, "DIA_Gestath_HALLO_plate_09_01");	//Yeah. Hard to get. It's made of minecrawler plates. A guy named Wolf made it for me.
	AI_Output (self, other, "DIA_Gestath_HALLO_plate_09_02");	//I used to be a convict here in the colony. Gave him a couple of minecrawler plates and a few days later the thing was finished. The guy's okay.
	Wolf_ProduceCrawlerArmor = TRUE;
	B_BuildGestathDialog();
};

func void DIA_Gestath_HALLO_plate_woWolf()
{
	AI_Output(other,self,"DIA_Gestath_HALLO_plate_woWolf_15_00");		//Where's this Wolf now?
	AI_Output (self, other, "DIA_Gestath_HALLO_plate_woWolf_09_01");	//It's been a while since I've seen him. Back then he was a mercenary here in the colony.
	AI_Output (self, other, "DIA_Gestath_HALLO_plate_woWolf_09_02");	//I suppose he still hangs around with the boys.
	Gestath_WhereIsWolf = TRUE;
	B_BuildGestathDialog();
};

func void DIA_Gestath_HALLO_was()
{
	AI_Output (other, self, "DIA_Gestath_HALLO_was_15_00");	//What are you doing up here?
	AI_Output (self, other, "DIA_Gestath_HALLO_was_09_01");	//I'm here to make money.
	AI_Output (other, self, "DIA_Gestath_HALLO_was_15_02");	//Here, in the middle of nowhere?
	AI_Output (self, other, "DIA_Gestath_HALLO_was_09_03");	//I'm a hunter. I specialize in difficult cases.
	AI_Output (self, other, "DIA_Gestath_HALLO_was_09_04");	//Fire lizards, minecrawlers, dragon snappers... Anything nobody else will hunt. That brings in the money.
	Gestath_TeachAnimalTrophy = TRUE;
	B_BuildGestathDialog();
};

func void DIA_Gestath_HALLO_waszusehen()
{
	AI_Output (other, self, "DIA_Gestath_HALLO_waszusehen_15_00");	//What is there to see here?
	AI_Output (self, other, "DIA_Gestath_HALLO_waszusehen_09_01");	//A bunch of fire lizards, orcs and I don't know what all. Haven't been farther up on the high plain.
	AI_Output (self, other, "DIA_Gestath_HALLO_waszusehen_09_02");	//I'd advise you against trying it. The things that live up there don't sound too friendly.
	Gestath_WhatsInteresting = TRUE;
	B_BuildGestathDialog();
};

func void DIA_Gestath_HALLO_Back()
{
	Info_ClearChoices(DIA_Gestath_HALLO);
};

instance DIA_Gestath_Drachen(C_Info)
{
	npc = VLK_4148_Gestath;
	nr = 3;
	condition = DIA_Gestath_Drachen_Condition;
	information = DIA_Gestath_Drachen_Info;
	permanent = TRUE;
	description = "Can you gut dragons, too?";
};


var int Gestath_DragonTrophy;

func int DIA_Gestath_Drachen_Condition()
{
	if((Gestath_DragonTrophy == FALSE) && (Gestath_TeachAnimalTrophy == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Gestath_Drachen_Info()
{
	AI_Output (other, self, "DIA_Gestath_Drachen_15_00");	//Can you gut dragons, too?
	if (Kapitel < 4)
	{
		AI_Output (self, other, "DIA_Gestath_Drachen_09_01");	//(laughs) Ask me again later, when you're ready for something like that, okay?
	}
	else
	{
		AI_Output(self,other,"DIA_Gestath_Drachen_09_02");	//Sure. Why not?
		Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_OutTeacher,"Gestath from Valley of Mines can teach me how to take trophies from dragons.");
		Gestath_DragonTrophy = TRUE;
	};
};


instance DIA_Gestath_TEACHHUNTING(C_Info)
{
	npc = VLK_4148_Gestath;
	nr = 12;
	condition = DIA_Gestath_TEACHHUNTING_Condition;
	information = DIA_Gestath_TEACHHUNTING_Info;
	permanent = TRUE;
	description = "Teach me how to gut animals.";
};


func int DIA_Gestath_TEACHHUNTING_Condition()
{
	if(Gestath_TeachAnimalTrophy == TRUE)
	{
		return TRUE;
	};
};


var int DIA_Gestath_TEACHHUNTING_OneTime;

func void DIA_Gestath_TEACHHUNTING_Info()
{
	AI_Output (other, self, "DIA_Gestath_TEACHHUNTING_15_00");	//Teach me how to gut animals.
	if ((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_FireTongue] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_CrawlerPlate] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Mandibles] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_DrgSnapperHorn] == FALSE) || ((Gestath_DragonTrophy == TRUE) && ((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_DragonScale] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_DragonBlood] == FALSE))))
	{
		if(DIA_Gestath_TEACHHUNTING_OneTime == FALSE)
		{
			Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
			B_LogEntry(TOPIC_OutTeacher,"Gestath from the Valley of Mines can teach me how to take trophies grom Fire Lizards, Minecrawlers and Dragon Snappers.");
			AI_Output(self,other,"DIA_Gestath_TEACHHUNTING_09_01");	//Why not? I've got enough at the moment.
			DIA_Gestath_TEACHHUNTING_OneTime = TRUE;
		}
		else
		{
			AI_Output (self, other, "DIA_Gestath_TEACHHUNTING_09_02");	//What do you want to know?
		};
		Info_AddChoice(DIA_Gestath_TEACHHUNTING,Dialog_Back,DIA_Gestath_TEACHHUNTING_BACK);
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_FireTongue] == FALSE)
		{
			Info_AddChoice(DIA_Gestath_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_FireTongue,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_FireTongue)),DIA_Gestath_TEACHHUNTING_FireTongue);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_CrawlerPlate] == FALSE)
		{
			Info_AddChoice(DIA_Gestath_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_CrawlerPlate,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_CrawlerPlate)),DIA_Gestath_TEACHHUNTING_CrawlerPlate);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Mandibles] == FALSE)
		{
			Info_AddChoice(DIA_Gestath_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_Mandibles,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Mandibles)),DIA_Gestath_TEACHHUNTING_Mandibles);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_DrgSnapperHorn] == FALSE)
		{
			Info_AddChoice(DIA_Gestath_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_DrgSnapperHorn,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_DrgSnapperHorn)),DIA_Gestath_TEACHHUNTING_DrgSnapperHorn);
		};
		if(Gestath_DragonTrophy == TRUE)
		{
			if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_DragonScale] == FALSE)
			{
				Info_AddChoice(DIA_Gestath_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_DragonScale,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_DragonScale)),DIA_Gestath_TEACHHUNTING_DragonScale);
			};
			if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_DragonBlood] == FALSE)
			{
				Info_AddChoice(DIA_Gestath_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_DragonBlood,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_DragonBlood)),DIA_Gestath_TEACHHUNTING_DragonBlood);
			};
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Gestath_TEACHHUNTING_09_03");	//At the moment, I don't know what I could still teach you.
	};
};

func void DIA_Gestath_TEACHHUNTING_BACK()
{
	Info_ClearChoices(DIA_Gestath_TEACHHUNTING);
};

func void DIA_Gestath_TEACHHUNTING_FireTongue()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_FireTongue))
	{
		AI_Output (self, other, "DIA_Gestath_TEACHHUNTING_FireTongue_09_00");	//You cut a fire lizard's tongue out of its mouth with one stroke of the knife, while you hold it with your other hand.
	};
	Info_ClearChoices(DIA_Gestath_TEACHHUNTING);
};

func void DIA_Gestath_TEACHHUNTING_CrawlerPlate()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_CrawlerPlate))
	{
		AI_Output (self, other, "DIA_Gestath_TEACHHUNTING_CrawlerPlate_09_00");	//You have to peel crawler plates off the beasts' backs with a sturdy knife.
	};
	Info_ClearChoices(DIA_Gestath_TEACHHUNTING);
};

func void DIA_Gestath_TEACHHUNTING_Mandibles()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Mandibles))
	{
		AI_Output (self, other, "DIA_Gestath_TEACHHUNTING_Mandibles_09_00");	//Mandibles are lodged rather deeply in the skull of a field raider or minecrawler. It takes some effort to pry them out.
	};
	Info_ClearChoices(DIA_Gestath_TEACHHUNTING);
};

func void DIA_Gestath_TEACHHUNTING_DrgSnapperHorn()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_DrgSnapperHorn))
	{
		AI_Output (self, other, "DIA_Gestath_TEACHHUNTING_DrgSnapperHorn_09_00");	//The best place to separate a dragon snapper's horn from the skull is at the top of its forehead. Use a sturdy knife.
	};
	Info_ClearChoices(DIA_Gestath_TEACHHUNTING);
};

func void DIA_Gestath_TEACHHUNTING_DragonScale()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_DragonScale))
	{
		AI_Output (self, other, "DIA_Gestath_TEACHHUNTING_DragonScale_09_00");	//Dragon scales are really stubborn, but just when you think you can't do it, the thing comes right off the dragon's back.
	};
	Info_ClearChoices(DIA_Gestath_TEACHHUNTING);
};

func void DIA_Gestath_TEACHHUNTING_DragonBlood()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_DragonBlood))
	{
		AI_Output (self, other, "DIA_Gestath_TEACHHUNTING_DragonBlood_09_00");	//The best place to take blood is from its underside. Look for a soft spot and stab with a sharp knife.
	};
	Info_ClearChoices(DIA_Gestath_TEACHHUNTING);
};

instance DIA_Gestath_PICKPOCKET(C_Info)
{
	npc = VLK_4148_Gestath;
	nr = 900;
	condition = DIA_Gestath_PICKPOCKET_Condition;
	information = DIA_Gestath_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Gestath_PICKPOCKET_Condition()
{
	return C_Beklauen(81,350);
};

func void DIA_Gestath_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Gestath_PICKPOCKET);
	Info_AddChoice(DIA_Gestath_PICKPOCKET,Dialog_Back,DIA_Gestath_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Gestath_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Gestath_PICKPOCKET_DoIt);
};

func void DIA_Gestath_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Gestath_PICKPOCKET);
};

func void DIA_Gestath_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Gestath_PICKPOCKET);
};



