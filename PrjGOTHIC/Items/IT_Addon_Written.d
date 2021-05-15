
instance ITWr_Addon_Hinweis_02(C_Item)
{
	name = "Important message";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
//	value = 250;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Hinweis_02;
	scemeName = "MAP";
	description = name;
	text[0] = "From the tavern in the bandit camp";
//	text[5] = NAME_Value;
//	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Hinweis_02()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Hey people,");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Lou has disappeared in the swamp.  He's probably been eaten by swampsharks.");
	Doc_PrintLines(nDocID,0,"Even worse - the key to the door disappeared with him.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Find it and you can keep Lou's stuff.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Snaf");
	Doc_Show(nDocID);
	EnteredBanditsCamp = TRUE;
};


instance ITWr_Addon_Health_04(C_Item)
{
	name = "Pure Healing Recipe";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 1000;
	visual = "ItWr_Recipe.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Heilrezept_04;
	scemeName = "MAP";
	description = name;
	text[0] = "To make a powerful potion";
	text[1] = "knowledge of elixirs of healing is required for use.";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_Heilrezept_04()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Creating a pure healing potion:");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"One meadow knotweed and three essences of healing are required.");
	Doc_PrintLines(nDocID,0,"Pour together and brew according to the recipe for healing elixirs.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"This potion can only be created by alchemists who know the recipe for healing elixirs.");
	Doc_Show(nDocID);
	if(Npc_IsPlayer(self))
	{
		if((PLAYER_TALENT_ALCHEMY[POTION_Health_03] == TRUE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_04] == FALSE))
		{
			B_LogEntry(TOPIC_TalentAlchemy,"Ингредиенты для 'ЧИСТОГО ЗДОРОВЬЯ': 1 луговой горец и 3 лечебные эссенции.");
			PLAYER_TALENT_ALCHEMY[POTION_Health_04] = TRUE;
		};
	};
};


instance ITWr_Addon_Mana_04(C_Item)
{
	name = "Pure Mana Recipe";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 1500;
	visual = "ItWr_Recipe.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Manarezept_04;
	scemeName = "MAP";
	description = name;
	text[0] = "To make a powerful potion";
	text[1] = "knowledge of mana elixirs is required for use.";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_Manarezept_04()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Creating a pure mana potion:");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"One meadow knotweed and three essences of magical power are required.");
	Doc_PrintLines(nDocID,0,"Pour together and brew according to the recipe for mana elixirs.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"This potion can only be created by alchemists who know the recipe for mana elixirs.");
	Doc_Show(nDocID);
	if(Npc_IsPlayer(self))
	{
		if((PLAYER_TALENT_ALCHEMY[POTION_Mana_03] == TRUE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_04] == FALSE))
		{
			B_LogEntry(TOPIC_TalentAlchemy,"Ингредиенты для 'ЧИСТОЙ МАНЫ': 1 луговой горец и 3 эссенции маны.");
			PLAYER_TALENT_ALCHEMY[POTION_Mana_04] = TRUE;
		};
	};
};


instance ITWr_Addon_Hinweis_01(C_Item)
{
	name = "Important hint";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
//	value = 250;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Hinweis_01;
	scemeName = "MAP";
	description = name;
	text[0] = "Hanging on a hut in the swamp.";
//	text[5] = NAME_Value;
//	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Hinweis_01()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine (nDocID,0,"Hey people,");
	Doc_PrintLines(nDocID,0,"The stuff in the chests is for emergencies.");
	Doc_PrintLines(nDocID,0,"And it's for EVERYONE. So only take something if you need it.");
	Doc_PrintLines(nDocID,0,"And only take as much as you need.");
	Doc_PrintLines(nDocID,0,"If everybody sticks to this, it will work.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Fletcher");
	Doc_Show(nDocID);
};


instance ITWr_Addon_William_01(C_Item)
{
	name = "Записка";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_William_01;
	scemeName = "MAP";
	description = name;
	text[0] = "The fisherman William had this on him.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_William_01()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine (nDocID, 0, "William, ");
	Doc_PrintLines (nDocID, 0, "When the moon is full, the watch will be distracted.");
	Doc_PrintLines (nDocID, 0, "Sneak out - but be careful!");
	Doc_PrintLines (nDocID, 0, "If you follow the log road, you can leave the swamp.");
	Doc_PrintLines (nDocID, 0, "The pirate camp is on the other side of the valley far to the west.");
	Doc_PrintLines (nDocID, 0, "From there it should be easy to get away with the boat.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"A well-wisher");
	Doc_Show(nDocID);
	if(FoundDeadWilliam == FALSE)
	{
		if(Sklaven_Flucht == FALSE)
		{
			Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
		};
		B_LogEntry(TOPIC_Addon_MissingPeople,"Рыбак из Хориниса Вильям мертв. Я нашел его тело в Яркендаре.");
		FoundDeadWilliam = TRUE;
	};
};


instance ITWr_Addon_MCELIXIER_01(C_Item)
{
	name = "Recipe for Potion of Mental Alteration";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 250;
	visual = "ItWr_Recipe.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_MCELIXIER_01;
	scemeName = "MAP";
	description = name;
	text[0] = "This potion helps restore lost memories.";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_MCELIXIER_01()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,NAME_Geist);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "The secretion from two bloodfly stingers is required to create this potion.");
	Doc_PrintLines (nDocID, 0, "Add to that one mana extract and one essence of healing.");
	Doc_PrintLines (nDocID, 0, "Finally, stir a bag of red tear-pepper into the boiling decoction.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLines (nDocID, 0, "Only an expert alchemist who knows how to extract the secretion from the stingers should try this potion.");
	Doc_Show(nDocID);
	if(Npc_IsPlayer(self))
	{
		if(Knows_MCELIXIER == FALSE)
		{
			Log_CreateTopic(TOPIC_TalentAlchemy,LOG_NOTE);
			B_LogEntry(TOPIC_TalentAlchemy,"Ингредиенты для 'ЭЛИКСИРА ИЗМЕНЕНИЯ СОЗНАНИЯ': 2 жала кровавой мухи, 1 экстракт маны, 1 лечебная эссенция и 1 красный жгучий перец.");
			Knows_MCELIXIER = TRUE;
		};
	};
};


instance ITWr_Addon_Pirates_01(C_Item)
{
	name = "Greasy note";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
//	value = 250;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Pirates_01;
	scemeName = "MAP";
	description = name;
	text[0] = "Angus had this note in his pocket.";
//	text[5] = NAME_Value;
//	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Pirates_01()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"Pirates,");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Get the last delivery meant for us.");
	Doc_PrintLines(nDocID,0,"Then bring it to your cave. We'll meet there.");
	Doc_PrintLines(nDocID,0,"I will pay double the value in gold.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"That's the way to do it.");
	Doc_PrintLine(nDocID,0,"Tom");
	Doc_Show(nDocID);
//	Read_JuansText = TRUE;
};


instance ITWr_Addon_Joint_01(C_Item)
{
	name = "Recipe for 'Green Novice'";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 250;
	visual = "ItWr_Recipe.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Joint_Rezept_01;
	scemeName = "MAP";
	description = name;
	text[0] = "From Fortuno's chest.";
//	text[1] = PRINT_RequiresAlchemyTalent;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_Joint_Rezept_01()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"The Green Novice");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"(...) The reefers roll really well, but what we had in the Swamp Camp was of a whole different caliber.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"If I use the essence of two swampweed plants and add a meadow knotweed, then I have a reefer with the effect of the 'Green Novice'.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"'The 'Green Novice' helps against all sorts of pain and clears the head.");
	Doc_Show(nDocID);
	if(Npc_IsPlayer(self))
	{
		if(Green_Extrem == FALSE)
		{
			Log_CreateTopic(TOPIC_TalentAlchemy,LOG_NOTE);
			B_LogEntry(TOPIC_TalentAlchemy,"Ингредиенты для 'ЗЕЛЕНОГО ПОСЛУШНИКА': 2 болотных травы и 1 луговой горец.");
			EnteredBanditsCamp = TRUE;
			Green_Extrem = TRUE;
		};
	};
};


instance ITWr_Addon_Lou_Rezept(C_Item)
{
	name = "Recipe for 'Lou's Hammer'";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 70;
	visual = "ItWr_Recipe.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseLouRezept;
	scemeName = "MAP";
	description = name;
	text[0] = PRINT_RequiresAlchemyTalent;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseLouRezept()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"Lou's Hammer");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Ingredients for brewing a Hammer:");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "Take a water bottle, two turnips and a decent portion of swampweed.");
	Doc_PrintLines (nDocID, 0, "Add the ground teeth of a swampshark.");
	Doc_PrintLines (nDocID, 0, "Put it all in the bottle and boil with a shot of rum.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Cheers.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"According to the old blind man, it is healthier not to breathe the steam!");
	Doc_Show(nDocID);
	if(Npc_IsPlayer(self))
	{
		if(Npc_GetTalentSkill(hero,NPC_TALENT_ALCHEMY) && (Knows_LousHammer == FALSE))
		{
			B_LogEntry(TOPIC_TalentAlchemy,"Ингредиенты для 'МОЛОТА ЛУ': 1 вода, 2 репы, 1 болотная трава, 1 зуб болотной акулы и 1 ром.");
			Knows_LousHammer = TRUE;
		};
		Opened_LousHammer = TRUE;
	};
};


instance ITWr_Addon_Lou_Rezept2(C_Item)
{
	name = "Recipe for 'Lou's Double Hammer'";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 140;
	visual = "ItWr_Recipe.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseLouRezept2;
	scemeName = "MAP";
	description = name;
	text[0] = PRINT_RequiresAlchemyTalent;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseLouRezept2()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"Lou's 'Double Hammer'");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "Take a good old Lou's Hammer and distill it again.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLines (nDocID, 0, "This mixture should only be made by experienced boozemakers.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLines (nDocID, 0, "If a layman tries it, he won't only be blind, but also dead.");
	Doc_Show(nDocID);
	if(Npc_IsPlayer(self))
	{
		if(Npc_GetTalentSkill(hero,NPC_TALENT_ALCHEMY) && (Knows_Schlafhammer == FALSE))
		{
			B_LogEntry(TOPIC_TalentAlchemy,"Ингредиенты для двойного 'МОЛОТА ЛУ': 1 'Молот Лу' и 1 ром.");
			Knows_Schlafhammer = TRUE;
		};
		Opened_Schlafhammer = TRUE;
	};
};


instance ITWr_Addon_Piratentod(C_Item)
{
	name = "Recipe for 'Hasty Herring'";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 250;
	visual = "ItWr_Recipe.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseRezeptPiratentod;
	scemeName = "MAP";
	description = name;
	text[0] = PRINT_RequiresAlchemyTalent;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseRezeptPiratentod()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"Hasty Herring");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Small pick-me-up for real men");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"As usual, you need a water bottle. Fill this with a measure of rum and add a fresh fish.");
	Doc_PrintLines(nDocID,0,"As soon as the liquid begins to turn yellow, take out the fish and add a bundle of");
	Doc_PrintLine(nDocID,0,"freshly picked snapperweed for flavor.");
	Doc_PrintLines(nDocID,0,"Careful. The stuff has a powerful kick.");
	Doc_Show(nDocID);
	if(Npc_IsPlayer(self))
	{
		if(Npc_GetTalentSkill(hero,NPC_TALENT_ALCHEMY) && (Knows_SchnellerHering == FALSE))
		{
			B_LogEntry(TOPIC_TalentAlchemy,"Ингредиенты для 'БЫСТРОЙ СЕЛЕДКИ': 1 вода, 1 ром, 1 рыба и 1 снеппер-трава.");
			Knows_SchnellerHering = TRUE;
		};
		Opened_SchnellerHering = TRUE;
	};
};


instance ItWr_MushroomMana(C_Item)
{
	name = "Рецепт грибного экстракта";
	mainflag = ITEM_KAT_DOCS;
	flags = 0;
	value = 50;
	visual = "ItWr_Recipe.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseMushroomManaRecipe;
	scemeName = "MAP";
	description = name;
	text[0] = PRINT_RequiresAlchemyTalent;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseMushroomManaRecipe()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Создание грибного экстракта:");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Черные грибы полезны сами по себе, но нехитрая обработка позволит усилить их свойства и создать более эффективный жидкий концентрат.");
	Doc_PrintLines(nDocID,0,"Необходимо 50 черных грибов и одна луговая ягода.");
	Doc_PrintLines(nDocID,0,"Грибы очищаются от грязи и варятся около часа. Полученный отвар охлаждается и в него добавляется высушенная и измельченная луговая ягода.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Если после добавления ягоды в емкости не выпал осадок, то все сделано правильно.");
	Doc_Show(nDocID);
	if(Npc_IsPlayer(self))
	{
		if(Npc_GetTalentSkill(hero,NPC_TALENT_ALCHEMY) && (Knows_MushroomMana == FALSE))
		{
			B_LogEntry(TOPIC_TalentAlchemy,"Ингредиенты для 'ГРИБНОГО ЭКСТРАКТА': 50 черных грибов и 1 луговая ягода.");
			Knows_MushroomMana = TRUE;
		};
		Opened_MushroomMana = TRUE;
	};
};


instance Fakescroll_Addon(C_Item)
{
	name = "Клочок бумаги";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
/*	hp = 5;
	hp_max = 5;
	weight = 1;
	value = 0; */
//	visual = "Fakescroll.3ds";
	visual = "ItWr_Scroll_01.3ds";
	material = MAT_LEATHER;
	scemeName = "MAPSEALED";
	description = name;
//	text[5] = NAME_Value;
//	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};

instance ItWr_Addon_AxtAnleitung(C_Item)
{
	name = "Схема бандитского топора";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 250;
//	visual = "ItWr_Scroll_01.3DS";
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseAxtAnleitung;
	scemeName = "MAP";
	description = name;
	text[0] = "Для его изготовления нужно";
	text[1] = "знание основ кузнечного дела.";
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseAxtAnleitung()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,NAME_ItMw_Banditenaxt);
	Doc_SetFont(nDocID,0,FONT_Book);
//	Doc_PrintLine(nDocID,0,"Легкий боевой топор");
//	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Этот топор может выковать любой, знакомый с основами кузнечного дела.");
	Doc_PrintLines(nDocID,0,"Необходимы два куска раскаленной сырой стали, один кусок руды и три зуба волка, снеппера или подобного им зверя.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Перекуйте на наковальне руду и зубы вместе со сталью.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Такой топор очень легок и наносит значительный урон.");
	Doc_Show(nDocID);
	if(Npc_IsPlayer(self))
	{
		if((Npc_GetTalentSkill(self,NPC_TALENT_SMITH) > 0) && (Knows_Banditenaxt == FALSE))
		{
			B_LogEntry(TOPIC_TalentSmith,"Для бандитского топора мне нужен 1 кусок руды, 3 зуба и 1 дополнительная стальная заготовка.");
			Knows_Banditenaxt = TRUE;
		};
		Opened_Banditenaxt = TRUE;
	};
};


instance ItWr_Addon_SUMMONANCIENTGHOST(C_Item)
{
	name = "Вызов Куарходрона";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
//	value = 250;
	value = 0;
//	visual = "ItWr_Scroll_01.3DS";
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseSummonAncientGhost;
	scemeName = "MAP";
	description = name;
	text[0] = "С помощью этого свитка можно вызвать Куарходрона.";
//	text[5] = NAME_Value;
//	count[5] = value;
};


func void UseSummonAncientGhost()
{
	if(SC_SummonedAncientGhost == FALSE)
	{
		B_Say(self,self,"$ADDON_SUMMONANCIENTGHOST");
		if(Npc_GetDistToWP(self,"ADW_ANCIENTGHOST") < 1000)
		{
			Wld_InsertNpc(NONE_ADDON_111_Quarhodron,"ADW_ANCIENTGHOST");
			Wld_PlayEffect("spellFX_Maya_Ghost",NONE_ADDON_111_Quarhodron,NONE_ADDON_111_Quarhodron,0,0,0,FALSE);
			Wld_PlayEffect("SPELLFX_LIGHTSTAR_WHITE",NONE_ADDON_111_Quarhodron,NONE_ADDON_111_Quarhodron,0,0,0,FALSE);
			Snd_Play("MFX_GhostVoice");
			Snd_Play("MFX_Firestorm_Cast");
			Snd_Play("MFX_Lightning_Origin");
			B_InitNpcGlobals();
			SC_SummonedAncientGhost = TRUE;
		}
		else
		{
			B_CannotUse_Addon();
			B_Say(self,self,"$ADDON_ANCIENTGHOST_NOTNEAR");
		};
	};
};


instance ItWr_Map_AddonWorld(C_Item)
{
	name = "Забытая долина зодчих";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 250;
	visual = "ItWr_Map_AW.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_Map_AddonWorld;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Map_AddonWorld()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWr_Map_AddonWorld);
	};
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_AddonWorld.tga",TRUE);
	Doc_SetLevel(Document,"Addon\AddonWorld.zen");
	Doc_SetLevelCoords(Document,-47783,36300,43949,-32300);
	Doc_Show(Document);
};

