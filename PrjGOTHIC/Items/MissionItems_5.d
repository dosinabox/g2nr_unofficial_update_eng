
instance ItWr_XardasLetterToOpenBook_MIS(C_Item)
{
	name = "Xardas' Letter";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_XardasLetterToOpenBook;
	scemeName = "MAP";
	description = name;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_XardasLetterToOpenBook()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "I suspected one of the dragons in the Valley of Mines was the source of Evil.");
	Doc_PrintLines (nDocID, 0, "I was wrong.");
	Doc_PrintLines(nDocID,0,"If everything has come to pass as I expect, you should now be seeking the Halls of Irdorath.");
	Doc_PrintLines(nDocID,0,"The book you gave to Pyrokar contains all the clues you need.");
	Doc_PrintLines(nDocID,0,"I should have known why the Seekers wanted it so badly.");
	Doc_PrintLines(nDocID,0,"You must get it back!");
	Doc_PrintLines(nDocID,0,"The words 'XARAK BENDARDO' open it. Don't tell anyone about this!");
	Doc_PrintLines(nDocID,0,"I will attend to more important things now.");
	Doc_PrintLines (nDocID, 0, "I can't help you with your last task. Only you can defeat the source of Evil.");
	Doc_PrintLines (nDocID, 0, "We shall meet again!");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"                             Xardas.");
	Doc_Show(nDocID);
	if(MIS_Xardas_SCCanOpenIrdorathBook == FALSE)
	{
		B_LogEntry(TOPIC_BuchHallenVonIrdorath,"In his letter, Xardas informed me what words to speak to open the book THE HALLS OF IRDORATH.");
		MIS_Xardas_SCCanOpenIrdorathBook = TRUE;
	};
};


instance ItKe_MonastarySecretLibrary_Mis(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_04.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "From the book 'The Halls of Irdorath'.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 190;
};

instance ItWr_HallsofIrdorath_Mis(C_Item)
{
	name = "The Halls of Irdorath";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_03_03.3ds";
	material = MAT_LEATHER;
	scemeName = "MAPSEALED";
	description = name;
	on_state[0] = Use_HallsofIrdorath;
};


func void Use_HallsofIrdorath()
{
	if(MIS_Xardas_SCCanOpenIrdorathBook == TRUE)
	{
		B_Say(self,self,"$SCOPENSIRDORATHBOOK");
		Wld_PlayEffect("spellFX_LIGHTSTAR_WHITE",hero,hero,0,0,0,FALSE);
		Snd_Play("SFX_HealObsession");
		CreateInvItems(hero,ItWr_HallsofIrdorath_Open_Mis,1);
		CreateInvItems(hero,ItKe_MonastarySecretLibrary_Mis,1);
		CreateInvItems(hero,ItWr_UseLampIdiot_Mis,1);
		Print(PRINT_IrdorathBookHiddenKey);
		B_GivePlayerXP(XP_HallsofIrdorathIsOpen);
		ItWr_HallsofIrdorathIsOpen = TRUE;
		B_LogEntry(TOPIC_BuchHallenVonIrdorath,"I was able to open Xardas' book. It contained a secret message and a strange key. Who knows what else I might find in the monastery's cellar.");
	}
	else
	{
		CreateInvItems(hero,ItWr_HallsofIrdorath_Mis,1);
		Print(PRINT_IrdorathBookDoesntOpen);
		Wld_PlayEffect("spellFX_Fear",self,self,0,0,0,FALSE);
		Snd_Play("MFX_FEAR_CAST");
	};
};


instance ItWr_HallsofIrdorath_Open_Mis(C_Item)
{
	name = "The Halls of Irdorath";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_03_03.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = Use_HallsofIrdorath_Open;
};


func void Use_HallsofIrdorath_Open()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"... and so I concealed the entrance to the library behind a secret door, to protect my records of Beliar's temples.");
	Doc_PrintLines(nDocID,0,"If my brothers had known of these records, those fools would probably have destroyed them all.");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_SetFont(nDocID,1,FONT_Book);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"Now, all they know is that these temples used to exist.");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"Just to be sure, I have sworn some servants to protect the library.");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"The key opens the last door.");
	Doc_Show(nDocID);
	if(ItWr_SCReadsHallsofIrdorath == FALSE)
	{
		B_LogEntry(TOPIC_BuchHallenVonIrdorath,"I have read Xardas' book. It mentions a secret library. It must be somewhere here in the cellar of the monastery.");
		ItWr_SCReadsHallsofIrdorath = TRUE;
	};
};


instance ItWr_XardasSeamapBook_Mis(C_Item)
{
	name = "Dusty Book";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_XardasSeamapBook_Mis.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
	on_state[0] = Use_XardasSeamapBook_Mis;
};


func void Use_XardasSeamapBook_Mis()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Wood_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Wood_R.tga",0);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLines(nDocID,0,"... I am now certain that the building is the Halls of Irdorath. They are located on an island quite near the harbor of Khorinis. Beliar's interest in the ore mines is obvious ...");
	Doc_PrintLine(nDocID,0,"");
	if(hero.guild == GIL_PAL)
	{
		Doc_PrintLines(nDocID,0,"... The stronger they are, the more valuable they seem to be to him as undead servants. These converted paladins are very hard for any warrior to defeat. One of them has fallen into my hands. I only hope the others won't notice his presence down here ...");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_SetFont(nDocID,1,FONT_Book);
		Doc_PrintLines(nDocID,1,"...the converted paladin no longer seems to react to any stimuli. I have stored his armor and the rest of his belongings in the back room. The door can only be opened from inside. I have built a teleport rune to get into the room. I have placed the instructions for it in the almanac so that the One can find them...");
	};
	if(hero.guild == GIL_KDF)
	{
		Doc_PrintLines(nDocID,0,"... The signs are unmistakable! When the One comes, he will need all the help we can give him. Beliar is already too strong. If have succeeded in obtaining some valuable artifacts which I will keep down here just in case. I suspect the Chosen One will come from among our ranks,");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_SetFont(nDocID,1,FONT_Book);
		Doc_PrintLines(nDocID,1,"I suspect the Chosen One will come from among our ranks, so I have written instructions in the almanac for him.");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"... I am now certain. We cannot stay the hand of fate. As soon as Beliar feels strong enough, he will arise and seek to rule the world. I must find the One, else we are all doomed.");
	};
	if(hero.guild == GIL_DJG)
	{
		Doc_PrintLines(nDocID,0,"... There will be war, a war for the fate of the world. I seem to be the only one capable of interpreting the signs. All around me seem to ignore them. The One will come, and his coming will herald the beginning of the war. It is a war as old as time itself, but the end appears to be coming into view.");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_SetFont(nDocID,1,FONT_Book);
		Doc_PrintLines(nDocID,1,"I will not stand idly by and watch as others take the fate of the world into their hands.");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"... I have studied the ancient writings and I have found out how to create the legendary weapons of the ancient Dragon Lords. However, I have no idea how to obtain the ingredients. I have entered the recipe in the almanac just in case. Who knows what terrors the future may bring - maybe even dragons.");
	};
	Doc_Show(nDocID);
};


instance ItWr_UseLampIdiot_Mis(C_Item)
{
	name = "Crumpled Letter";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseItWr_UseLampIdiot_Mis;
	scemeName = "MAP";
	description = name;
	text[0] = "From the book 'The Halls of Irdorath'.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void UseItWr_UseLampIdiot_Mis()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"               The lamp carries light");
	Doc_PrintLine(nDocID,0,"               into the lower regions.");
	Doc_Show(nDocID);
};


instance ItWr_Seamap_Irdorath(C_Item)
{
	name = "Sea Chart to Isle of Irdorath";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 50;
	visual = "ItWr_Map_DI.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_Seamap_Irdorath;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Seamap_Irdorath()
{
	var int nDocID;
	nDocID = Doc_CreateMap();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"Map_NewWorld_Seamap.tga",1);
	Doc_Show(nDocID);
	if(MIS_SCKnowsWayToIrdorath == FALSE)
	{
		Log_CreateTopic(Topic_Crew,LOG_MISSION);
		Log_SetTopicStatus(Topic_Crew,LOG_Running);
		B_LogEntries(Topic_Crew,"In order to sail to the enemy's island, I need a crew for my ship.");
		Log_CreateTopic(Topic_Captain,LOG_MISSION);
		Log_SetTopicStatus(Topic_Captain,LOG_Running);
		B_LogNextEntry(Topic_Captain,"In order to sail to the enemy's island, I need a captain willing to follow me on a deadly mission.");
		if(MIS_ShipIsFree == FALSE)
		{
			Log_CreateTopic(Topic_Ship,LOG_MISSION);
			Log_SetTopicStatus(Topic_Ship,LOG_Running);
			B_LogNextEntry(Topic_Ship,"It appears I must reach the enemy's strange island. But for that I need a ship.");
		};
		if(Kapitel < 6)
		{
			B_Say(self,self,"$IRDORATHTHEREYOUARE");
		};
		MIS_SCKnowsWayToIrdorath = TRUE;
		B_GivePlayerXP(XP_SCKnowsWayToIrdorath);
	};
};


instance ITWr_ForgedShipLetter_MIS(C_Item)
{
	name = "Ship Bill";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseITWr_ForgedShipLetter_MIS;
	scemeName = "MAP";
	description = name;
	text[0] = "Letter of Authorization";
	text[1] = "for the paladins' ship.";
};


func void UseITWr_ForgedShipLetter_MIS()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Letter of Authorization");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLines(nDocID,0,"This document entitles the bearer to move freely on Lord Hagen's royal war galley and to guide the ship for an unlimited time period.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"    Royal Seal");
	Doc_SetMargins(nDocID,-1,200,50,50,50,1);
	Doc_Show(nDocID);
};


instance ItKe_OC_MainGate_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "Main Gate Guard's Tower Key.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_Ship_Levelchange_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "Key to Captain's Quarters.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItPo_PotionOfDeath_01_Mis(C_Item)
{
	name = NAME_Trank;
	mainflag = ITEM_KAT_POTIONS;
	flags = ITEM_MULTI;
	value = 0;
	visual = "ItPo_Special_03.3ds";
	material = MAT_GLAS;
	on_state[0] = UseItPo_PotionOfDeath;
	scemeName = "POTIONFAST";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "The Tears of Innos";
	text[1] = PRINT_UnknownEffect;
};


func void UseItPo_PotionOfDeath()
{
	if(self.guild == GIL_KDF)
	{
		Wld_PlayEffect("spellFX_LIGHTSTAR_BLUE",self,self,0,0,0,FALSE);
		Snd_Play("SFX_HealObsession");
		self.attribute[ATR_HITPOINTS] = self.attribute[ATR_HITPOINTS_MAX];
		self.attribute[ATR_MANA] = self.attribute[ATR_MANA_MAX];
		Npc_ChangeAttribute(self,ATR_STRENGTH,5);
		self.aivar[REAL_STRENGTH] += 5;
		Npc_ChangeAttribute(self,ATR_DEXTERITY,5);
		self.aivar[REAL_DEXTERITY] += 5;
		PrintScreen(PRINT_LearnSTR5,-1,43,FONT_Screen,2);
		PrintScreen(PRINT_LearnDEX5,-1,48,FONT_Screen,2);
		PrintScreen(PRINT_FullyHealed,-1,53,FONT_Screen,2);
		Mdl_ApplyOverlayMdsTimed(self,"HUMANS_SPRINT.MDS",Time_Speed);
	}
	else
	{
		self.aivar[AIV_ReadyForPainfulDeath] = TRUE;
		AI_StartState(self,ZS_MagicFreeze,0,"");
	};
};


instance ItPo_PotionOfDeath_02_Mis(C_Item)
{
	name = NAME_Trank;
	mainflag = ITEM_KAT_POTIONS;
	flags = ITEM_MULTI;
	value = 0;
	visual = "ItPo_Special_03.3ds";
	material = MAT_GLAS;
	on_state[0] = UseItPo_PotionOfDeath;
	scemeName = "POTIONFAST";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "The Tears of Innos";
	text[0] = "The potion lends Fire Mages special powers.";
	text[1] = "Any other user will find his death in it.";
};

instance ItAm_AmulettOfDeath_Mis(C_Item)
{
	name = NAME_Amulett;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET;
	value = 1000;
	visual = "ItAm_AmulettOfDeath_Mis.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItAm_AmulettOfDeath_Mis;
	on_unequip = UnEquip_ItAm_AmulettOfDeath_Mis;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "The divine aura of Innos.";
	text[0] = "This amulet protects the bearer from all forms of damage.";
	text[1] = NAME_Prot_Edge;
	count[1] = 30;
	text[2] = NAME_Prot_Point;
	count[2] = 30;
	text[3] = NAME_Prot_Fire;
	count[3] = 30;
	text[4] = NAME_Prot_Magic;
	count[4] = 30;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};


func void Equip_ItAm_AmulettOfDeath_Mis()
{
	self.protection[PROT_EDGE] += 30;
	self.protection[PROT_BLUNT] += 30;
	self.protection[PROT_POINT] += 30;
	self.protection[PROT_FIRE] += 30;
	self.protection[PROT_MAGIC] += 30;
	Wld_PlayEffect("spellFX_LIGHTSTAR_WHITE",self,self,0,0,0,FALSE);
	Wld_PlayEffect("FX_EarthQuake",self,self,0,0,0,FALSE);
	Wld_PlayEffect("spellFX_INCOVATION_WHITE",self,self,0,0,0,FALSE);
	AI_PlayAni(self,"T_MAGRUN_2_HEASHOOT");
	AI_Standup(self);
	Snd_Play("MFX_FIRERAIN_INVEST");
};

func void UnEquip_ItAm_AmulettOfDeath_Mis()
{
	self.protection[PROT_EDGE] -= 30;
	self.protection[PROT_BLUNT] -= 30;
	self.protection[PROT_POINT] -= 30;
	self.protection[PROT_FIRE] -= 30;
	self.protection[PROT_MAGIC] -= 30;
};


instance ItPo_HealRandolph_MIS(C_Item)
{
	name = NAME_Trank;
	mainflag = ITEM_KAT_POTIONS;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 300;
	visual = "ItPo_HealRandolph.3ds";
	material = MAT_GLAS;
	on_state[0] = Use_HealRandolph;
	scemeName = "POTIONFAST";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Healing of Addiction";
	text[1] = NAME_Bonus_HP;
	count[1] = HP_Essenz;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_HealRandolph()
{
	Npc_ChangeAttribute(self,ATR_HITPOINTS,HP_Essenz);
};

