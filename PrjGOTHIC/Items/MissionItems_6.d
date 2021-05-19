
instance ItSe_XardasNotfallBeutel_MIS(C_Item)
{
	name = NAME_Bag;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItMi_Bag.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	on_state[0] = Use_XardasNotfallBeutel;
	description = name;
	text[0] = "The bag seems to";
	text[1] = "contain a hard object";
	text[2] = "and a document.";
};


func void Use_XardasNotfallBeutel()
{
	B_PlayerFindItem(ItWr_XardasErmahnungFuerIdioten_MIS,1);
	B_PlayerFindItem(ItMi_InnosEye_Discharged_Mis,1);
	XardasDIBagOpened = TRUE;
};


instance ItWr_XardasErmahnungFuerIdioten_MIS(C_Item)
{
	name = "Xardas' Warning Letter";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_XardasErmahnungFuerIdioten;
	scemeName = "MAP";
	description = name;
};


func void Use_XardasErmahnungFuerIdioten()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "My young protégé, you disappoint me greatly. How could you leave on the ship and not take the Eye of Innos?");
	Doc_PrintLines (nDocID, 0, "I can only hope that there are limits to your negligence. Otherwise you will never rid the world of Evil and I will be forced to personally execute you for your stupidity.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"                      Xardas");
	Doc_Show(nDocID);
};


instance ItWr_Krypta_Garon(C_Item)
{
	name = "Old letter";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Krypta_Garon;
	scemeName = "MAP";
	description = name;
	text[3] = "In shaky handwriting.";
};


func void Use_Krypta_Garon()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "I have failed. In vain I have tried to keep Inubis on the path of Good.");
	Doc_PrintLines (nDocID, 0, "At first I believed I was dead. But there is strength left yet in Ivan's old bones.");
	Doc_PrintLines (nDocID, 0, "Inubis has arisen from the dead. Banished by the ancient order of the paladins, he now seeks revenge for his curse.");
	Doc_PrintLines (nDocID, 0, "Many of his followers are with him. I have no idea how a warlord like Inubis could become so evil.");
	Doc_PrintLines (nDocID, 0, "I found his tomb in this crypt. But I am uncertain whether I will ever be able to report my find. Therefore I write these lines and hope that they may be found.");
	Doc_PrintLines (nDocID, 0, "Be warned. A mighty enemy is reaching out for the souls of the just. Inubis will not be the last.");
	Doc_PrintLine (nDocID, 0, " ");
	Doc_PrintLine (nDocID, 0, "May Innos save your souls.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "                                 Ivan");
	Doc_SetMargins(nDocID,-1,200,50,50,50,1);
	Doc_Show(nDocID);
};


instance ItKe_OrkKnastDI_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = "Key of the Orcish Colonel";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_EVT_UNDEAD_01(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = "Key of Archol";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_EVT_UNDEAD_02(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = "Key of the Key Master";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_LastDoorToUndeadDrgDI_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = "Black Magician's Room Key";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_LastDoorToUndeadDrgDI_MIS(C_Item)
{
	name = "Black Magician's Scroll";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_ItWr_LastDoorToUndeadDrgDI_MIS;
	scemeName = "MAP";
	description = name;
};


func void Use_ItWr_LastDoorToUndeadDrgDI_MIS()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"KHADOSH");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"EMEM KADAR");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"The Eye of Power illuminate your path.");
	Doc_SetMargins(nDocID,-1,200,50,50,50,1);
	Doc_Show(nDocID);
	if(Read_LastDoorToUndeadDrgDI_MIS == FALSE)
	{
		B_LogEntry(TOPIC_HallenVonIrdorath,"The black magician's scroll contained the words KHADOSH EMEM KADAR. It sounds like some kind of magic formula, but what is it used for - and what is the Eye of Power?");
		Read_LastDoorToUndeadDrgDI_MIS = TRUE;
	};
};


instance ItKe_ChestMasterDementor_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = "Black Magician's Chest Key";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_Rezept_MegaDrink_MIS(C_Item)
{
	name = "Recipe 'Embarla Figastro'";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Recipe.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_RezeptFuerMegaTrank;
	scemeName = "MAP";
	description = name;
	text[0] = PRINT_RequiresAlchemyTalent;
};


func void Use_RezeptFuerMegaTrank()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "I have revived an ancient art. I fear Feodaron would not be impressed with my achievement.");
	Doc_PrintLines (nDocID, 0, "It means, quite simply, that I would have to mix his entire brood in my laboratory into a potion. If only he didn't sit on his eggs like some chicken all the time, I'd have tried it out. But he still inspires me with some respect.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,NAME_MegaDrink);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"10 dragon eggs, one powderized black pearl and a pinch of sulfur.");
	Doc_PrintLines (nDocID, 0, "The emulsion is brought to the boil and must be stirred constantly as it passes through the distiller.");
	Doc_PrintLines (nDocID, 0, "The elixir must be used with care. It has strong side effects and can upset the entire mana system.");
	Doc_Show(nDocID);
	if(Npc_IsPlayer(self))
	{
		if(Npc_GetTalentSkill(hero,NPC_TALENT_ALCHEMY) && (PLAYER_TALENT_ALCHEMY[POTION_MegaDrink] == FALSE))
		{
			B_LogEntry(TOPIC_TalentAlchemy,"Ingredients for 'EMBARLA FIGASTRO': 10 Dragon Eggs, 1 Black Pearl and 1 Sulfur.");
			PLAYER_TALENT_ALCHEMY[POTION_MegaDrink] = TRUE;
		};
		Opened_MegaDrink = TRUE;
	};
};


instance ItWr_Diary_BlackNovice_MIS(C_Item)
{
	name = "Diary";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_03_04.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	text[0] = "Diary of the Black Magician's apprentice.";
	on_state[0] = Use_Diary_BlackNovice;
};


var int Use_Diary_BlackNovice_Once;

func void Use_Diary_BlackNovice()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Wood_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Wood_R.tga",0);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "I've been waiting to be called up for 36 days now. I'm beginning to doubt they'll take me on. But I've done all they asked me to. I've fetched and carried for them like some old housemaid.");
	Doc_PrintLines (nDocID, 0, "The key master instructed me to seal the bars. I still haven't gotten around to it. If things go on this way, anyone might just stroll in through the gate.");
	Doc_PrintLines (nDocID, 0, "It's a shame I can't remember the combinations.");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_SetFont(nDocID,1,FONT_Book);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"I'd have sneaked into the great Hall ages ago. I can hardly wait to see the Master. I wonder if they'll let me see him once I'm one of them.");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"I tried my luck yesterday. But I failed the two lever chambers before I could even press the three switches in the west wing in the right order. That dog locked the chambers! Tomorrow I'm going to try and get the key off him...");
	Doc_Show(nDocID);
	if(Use_Diary_BlackNovice_Once == FALSE)
	{
		B_LogEntry(TOPIC_HallenVonIrdorath,"The diary of the novice black magician talks about lever chambers, key masters, switch combinations and other things. I should keep that in the back of my mind, it could be useful later.");
		Use_Diary_BlackNovice_Once = TRUE;
	};
};


instance ItWr_ZugBruecke_MIS(C_Item)
{
	name = "Old letter";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_ZugBruecke;
	scemeName = "MAP";
	description = name;
	text[0] = "From the huge cave in on the Isle of Irdorath.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_ZugBruecke()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"   Last warning!");
	Doc_SetMargins(nDocID,-1,50,50,70,50,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "I don't care if you can cross the bridge from the other side or not. If I had any say, you'd all rot in hell.");
	Doc_PrintLines (nDocID, 0, "I'm gonna leave the bridge drawn in as long as I'm in my domain. And if I catch one more person trying to hit the switches with a bow and arrow to get over, I will personally hang the idiot from the nearest tree!");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"                      Archol");
	Doc_Show(nDocID);
};


instance ItMi_PowerEye(C_Item)
{
	name = "Eye of Power";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItMi_StoneOfKnowlegde_MIS.3ds";
	material = MAT_METAL;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = name;
};

