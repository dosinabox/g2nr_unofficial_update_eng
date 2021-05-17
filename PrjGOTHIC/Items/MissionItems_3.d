
const int AM_EyeProtEdge = 10;
const int AM_EyeProtPoint = 10;
const int AM_EyeProtMage = 20;
const int AM_EyeProtFire = 30; //20

instance ItMi_InnosEye_MIS(C_Item)
{
	name = NAME_InnosEye;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET | ITEM_MISSION;
	value = 0;
	visual = "ItMi_InnosEye_MIS.3DS";
	material = MAT_METAL;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = name;
	on_equip = Equip_InnosEye;
	on_unequip = UnEquip_InnosEye;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
	text[0] = "Energy pulses through the Eye.";
	text[1] = NAME_Prot_Edge;
	count[1] = AM_EyeProtEdge;
	text[2] = NAME_Prot_Point;
	count[2] = AM_EyeProtPoint;
	text[3] = NAME_Prot_Fire;
	count[3] = AM_EyeProtFire;
	text[4] = NAME_Prot_Magic;
	count[4] = AM_EyeProtMage;
};


func void Equip_InnosEye()
{
	Wld_PlayEffect("spellFX_Innoseye",self,self,0,0,0,FALSE);
	Wld_PlayEffect("spellFX_LIGHTSTAR_RED",self,self,0,0,0,FALSE);
	Wld_PlayEffect("FX_EarthQuake",self,self,0,0,0,FALSE);
	AI_PlayAni(self,"T_MAGRUN_2_HEASHOOT");
	AI_Standup(self);
	Snd_Play("SFX_INNOSEYE");
	self.protection[PROT_EDGE] += AM_EyeProtEdge;
	self.protection[PROT_BLUNT] += AM_EyeProtEdge;
	self.protection[PROT_POINT] += AM_EyeProtPoint;
	self.protection[PROT_FIRE] += AM_EyeProtFire;
	self.protection[PROT_MAGIC] += AM_EyeProtMage;
	SC_IsWearingInnosEye = TRUE;
};

func void UnEquip_InnosEye()
{
	self.protection[PROT_EDGE] -= AM_EyeProtEdge;
	self.protection[PROT_BLUNT] -= AM_EyeProtEdge;
	self.protection[PROT_POINT] -= AM_EyeProtPoint;
	self.protection[PROT_FIRE] -= AM_EyeProtFire;
	self.protection[PROT_MAGIC] -= AM_EyeProtMage;
	SC_IsWearingInnosEye = FALSE;
};


instance ItMi_InnosEye_Discharged_Mis(C_Item)
{
	name = NAME_InnosEye;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET | ITEM_MISSION;
	value = 0;
	visual = "ItMi_InnosEye_Discharged_MIS.3DS";
	material = MAT_METAL;
	description = name;
	on_equip = Equip_ItMi_InnosEye_Discharged_Mis;
	text[0] = "The Eye is faded and does not shine.";
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};


func void Equip_ItMi_InnosEye_Discharged_Mis()
{
	Wld_PlayEffect("spellFX_Fear",self,self,0,0,0,FALSE);
	Snd_Play("MFX_FEAR_CAST");
};


instance ItMi_InnosEye_Broken_Mis(C_Item)
{
	name = NAME_InnosEye;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET | ITEM_MISSION;
	value = 0;
	visual = "ItMi_InnosEye_Broken_MIS.3DS";
	material = MAT_METAL;
	description = name;
	on_equip = Equip_ItMi_InnosEye_Broken_Mis;
	text[0] = TEXT_Innoseye_Setting;
	text[1] = TEXT_Innoseye_Gem;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};


func void Equip_ItMi_InnosEye_Broken_Mis()
{
	Wld_PlayEffect("spellFX_Fear",self,self,0,0,0,FALSE);
	Snd_Play("MFX_FEAR_CAST");
};


instance ItWr_PermissionToWearInnosEye_MIS(C_Item)
{
	name = "Letter for Pyrokar";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_PermissionToWearInnosEye;
	scemeName = "MAP";
	description = name;
	text[0] = "Letter of authorization.";
};


func void Use_PermissionToWearInnosEye()
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
	Doc_PrintLines (nDocID, 0, "The bearer of this note is to be granted entry into the sacred halls of the monastery.");
	Doc_PrintLines (nDocID, 0, "His wishes regarding the possession of the Eye of Innos are to be fulfilled immediately.");
	Doc_PrintLines (nDocID, 0, "These orders are to be regarded as valid through the strength of my position as lord of the island and representative of the King, as well as through the treaty of the division of the Church of Innos in year 2 of the Fire.");
	Doc_PrintLines (nDocID, 0, "I will make no further statements to this end and expect my instructions to be abided by.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "Innos bless the King.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "        Lord Hagen");
	Doc_Show(nDocID);
};


instance ItWr_XardasBookForPyrokar_Mis(C_Item)
{
	name = "The Halls of Irdorath";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_03_03.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = Use_XardasBookForPyrokar;
};


func void Use_XardasBookForPyrokar()
{
	Print(PRINT_IrdorathBookDoesntOpen);
	Wld_PlayEffect("spellFX_Fear",self,self,0,0,0,FALSE);
	Snd_Play("MFX_FEAR_CAST");
};


instance ItKe_CHEST_SEKOB_XARDASBOOK_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "For the chest on Sekob's farm.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_CorneliusTagebuch_Mis(C_Item)
{
	name = "Cornelius' Diary";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_01.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = UseCorneliusTagebuch;
};


func void UseCorneliusTagebuch()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Brown_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Brown_R.tga",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"If Larius keeps on like that, I'm going to look out for another position.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Something strange happened to me last night. I was visited in my home by one of those guys in black hoods we hear so much about lately. I wasn't really nervous, even though they're supposed to be so evil. You could almost feel the power those men have. But the voice was calm and kind of made you want to trust the guy.");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"He offered me 20,000 pieces of gold to make sure one of the mercenary's gets convicted. He said I'd know what he meant when it happened.");
	Doc_PrintLines(nDocID,1,"Of course I agreed right away, those mercenaries don't deserve any better anyway. If it weren't for them everything would be just fine for me here. And the gold will let me settle down to a comfortable retirement.");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"It's happened, they've arrested one of those mercenaries. It should be easy to keep my word.");
	Doc_Show(nDocID);
	if(Cornelius_IsLiar == FALSE)
	{
		B_LogEntry(TOPIC_RescueBennet,"The diary is the evidence I need to prove Bennet's innocence.");
		Cornelius_IsLiar = TRUE;
	};
};


instance ITWR_DementorObsessionBook_MIS(C_Item)
{
	name = "Almanac of the Possessed";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_03_05.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = Use_DementorObsessionBook;
};


func void Use_DementorObsessionBook()
{
	var int nDocID;
	Wld_PlayEffect("spellFX_Fear",hero,hero,0,0,0,FALSE);
	Snd_Play("MFX_FEAR_CAST");
	SC_ObsessionCounter = 100;
	B_SCIsObsessed(hero);
	if(hero.guild == GIL_KDF)
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_SetFont(nDocID,0,FONT_Book);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"edef Kon dirandorix");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"in Sparady bell");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"el utoy");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Kho ray xaondron");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"em piratoram endro");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_SetFont(nDocID,1,FONT_Book);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		if(Kapitel >= 3)
		{
			if(Vino_isAlive_Kap3 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"           VINO");
			};
			if(Fernando_isAlive_Kap3 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"FERNANDO");
			};
			if(Malak_isAlive_Kap3 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"");
				Doc_PrintLine(nDocID,1,"        MALAK");
			};
			if(Bromor_isAlive_Kap3 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"");
				Doc_PrintLine(nDocID,1,"BROMOR");
			};
		};
		if(Kapitel >= 4)
		{
			if(Engrom_isAlive_Kap4 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"    ENGROM");
				Doc_PrintLine(nDocID,1,"");
			};
			if(Randolph_isAlive_preKap4 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"");
				Doc_PrintLine(nDocID,1,"        RANDOLPH");
			};
			Doc_PrintLine(nDocID,1,"");
		};
		if(Kapitel >= 5)
		{
			Doc_PrintLine(nDocID,1,"");
			if(Sekob_isAlive_Kap5 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"");
				Doc_PrintLine(nDocID,1,"SEKOB");
			};
			Doc_PrintLine(nDocID,1,"");
			Doc_PrintLine(nDocID,1,"");
			if(Brutus_isAlive_preKap5 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"");
				Doc_PrintLine(nDocID,1,"            BRUTUS");
			};
			Doc_PrintLine(nDocID,1,"");
		};
		if((Kapitel == 6) && (Mario_IsOnBoard == LOG_SUCCESS) && (OrkSturmDI == TRUE))
		{
			Doc_PrintLine(nDocID,1,"");
			Doc_PrintLine(nDocID,1,"МАРИО");
		};
		Doc_Show(nDocID);
	};
};


instance ItWr_PyrokarsObsessionList(C_Item)
{
	name = "Pyrokar's Magic Letter";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_PyrokarsObsessionList;
	scemeName = "MAP";
	description = name;
};


func void Use_PyrokarsObsessionList()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"The Possessed");
	Doc_SetFont(nDocID,0,FONT_Book);
	if(Kapitel >= 3)
	{
		Doc_PrintLine(nDocID,0,"");
		if(Fernando_isAlive_Kap3 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"FERNANDO");
		};
		if(Vino_isAlive_Kap3 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"VINO");
		};
		if(Malak_isAlive_Kap3 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"MALAK");
		};
		if(Bromor_isAlive_Kap3 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"BROMOR");
		};
	};
	if(Kapitel >= 4)
	{
		if(Engrom_isAlive_Kap4 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"ENGROM");
		};
		if(Randolph_isAlive_preKap4 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"RANDOLPH");
		};
	};
	if(Kapitel >= 5)
	{
		if(Sekob_isAlive_Kap5 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"SEKOB");
		};
		if(Brutus_isAlive_preKap5 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"BRUTUS");
		};
	};
	if((Kapitel == 6) && (Mario_IsOnBoard == LOG_SUCCESS) && (OrkSturmDI == TRUE))
	{
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"MARIO");
	};
	Doc_Show(nDocID);
};


instance ItPo_HealHilda_MIS(C_Item)
{
	name = NAME_Trank;
	mainflag = ITEM_KAT_POTIONS;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = Value_HpEssenz;
	visual = "ItPo_HealHilda.3ds";
	material = MAT_GLAS;
	on_state[0] = Use_HealHilda;
	scemeName = "POTIONFAST";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Healing of the Black Fever";
	text[1] = NAME_Bonus_HP;
	count[1] = HP_Essenz;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_HealHilda()
{
	Npc_ChangeAttribute(self,ATR_HITPOINTS,HP_Essenz);
	if(MIS_HealHilda == LOG_RUNNING)
	{
		MIS_HealHilda = LOG_FAILED;
		B_CheckLog();
	};
};


instance ItMw_MalethsGehstock_MIS(C_Item)
{
	name = "Walking Stick";
	mainflag = ITEM_KAT_NF;
	flags = ITEM_AXE;
	material = MAT_WOOD;
	value = 15;
	damageTotal = 10;
	damagetype = DAM_BLUNT;
	range = 80;
	cond_atr[2] = ATR_STRENGTH;
	cond_value[2] = Condition_VLKMace;
	visual = "Itmw_008_1h_pole_02.3ds";
	description = name;
	text[0] = "The letter 'M' has been";
	text[1] = "engraved at the top.";
	text[2] = NAME_Damage;
	count[2] = damageTotal;
	text[3] = NAME_Str_needed;
	count[3] = cond_value[2];
	text[4] = NAME_OneHanded;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_MalethsBanditGold(C_Item)
{
	name = NAME_Bag;
	mainflag = ITEM_KAT_NONE;
	flags = 0;
	value = 300;
	visual = "ItMi_Bag.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = Use_MalethsBanditGold;
	description = name;
	text[0] = "This bag is completely filled with gold!";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_MalethsBanditGold()
{
	B_PlayerFindItem(ItMi_Gold,300);
};


instance ItMi_Moleratlubric_MIS(C_Item)
{
	name = "Molerat Fat";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = Value_Pitch * 3;
	visual = "ItMi_Moleratlubric.3ds";
	material = MAT_STONE;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItWr_BabosLetter_MIS(C_Item)
{
	name = "Letter to Babo";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_BabosLetter;
	scemeName = "MAP";
	description = name;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_BabosLetter()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine (nDocID, 0, "Dear Babo,");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLines (nDocID, 0, "No doubt you're wondering how we came to write you this letter. We took all our savings to Master Marlas and asked him to write these lines for you. We wish you all the best for the future and are sending you a picture as a farewell gift, so that you'll always remember us during those long nights at the monastery.");
	Doc_PrintLines (nDocID, 0, "Good luck. Hope you like the picture.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLiness (nDocID, 0, "Feht and Bonka");
	Doc_Show(nDocID);
};


instance ItWr_BabosPinUp_MIS(C_Item)
{
	name = "Sketch";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
//	visual = "ItWr_Scroll_01.3DS";
	visual = "ItWr_BabosPinUp_MIS.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_BabosPinUp;
	scemeName = "MAP";
	description = name;
	text[0] = "A picture of a nude woman.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_BabosPinUp()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"Map_Pinup.TGA",0);
	Doc_Show(nDocID);
};


instance ItWr_BabosDocs_MIS(C_Item)
{
	name = "Bundle of Papers";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_BabosDocs;
	scemeName = "MAPSEALED";
	description = name;
	text[0] = "Several documents rolled together.";
	text[1] = "";
};


func void Use_BabosDocs()
{
	Snd_Play("MOB_BOOK_TURNPAGE_A1");
	BabosDocsOpen = TRUE;
	AI_PrintScreen("Получено письмо и рисунок",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	CreateInvItems(self,ItWr_BabosLetter_MIS,1);
	CreateInvItems(self,ItWr_BabosPinUp_MIS,1);
};


instance ItKe_IgarazChest_Mis(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key to a chest";
	text[1] = "belonging to Igaraz";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_Astronomy_Mis(C_Item)
{
	name = "The Divine Power of the Stars";
	mainflag = ITEM_KAT_DOCS;
	//flags = ITEM_MISSION;
	flags = 0;
	value = 400;
	visual = "ItWr_Book_02_02.3ds";
	material = MAT_LEATHER;
	on_state[0] = Use_Astronomy;
	scemeName = "MAP";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};


var int Astronomy_Once;

func void Use_Astronomy()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"... but when the strength of an ox is combined with the principles of a warrior, then beware of the events that may come to pass.");
	Doc_PrintLines(nDocID,0,"The unbound strength of the ox and the perseverance of the warrior can topple the ancient balance of the powers. The cosmic boundary between the dimensions grows weak - so weak that it becomes easy for the shadow creatures of Beliar to enter our world.");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"What would ensue from this is shown to us by the wars of ancient times, when the link between the worlds was still strong. The henchmen of Evil brought death and destruction to the world, and only the help of Innos and the Chosen One could ward off Evil from mankind.");
	Doc_PrintLines(nDocID,1,"If such a threat should ever exist again, then may Innos protect us, for there has not been another Chosen of Innos for over a hundred years.");
	Doc_Show(nDocID);
	if(Astronomy_Once == FALSE)
	{
		B_RaiseAttribute(self,ATR_MANA_MAX,2);
		Print(Print_ReadAstronomy);
		Snd_Play("LEVELUP");
		Astronomy_Once = TRUE;
	};
};


var int SC_ObsessionTimes;

instance ItPo_HealObsession_MIS(C_Item)
{
	name = NAME_Trank;
	mainflag = ITEM_KAT_POTIONS;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = Value_HpEssenz;
	visual = "ItPo_HealObsession.3ds";
	material = MAT_GLAS;
	on_state[0] = Use_HealObsession;
	scemeName = "POTIONFAST";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Healing of Possession";
	text[1] = NAME_Bonus_HP;
	count[1] = HP_Essenz;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_HealObsession()
{
	Npc_ChangeAttribute(self,ATR_HITPOINTS,HP_Essenz);
	if(SC_IsObsessed == TRUE)
	{
		SC_ObsessionTimes += 1;
		B_ClearSCObsession(self);
		Wld_PlayEffect("spellFX_LIGHTSTAR_VIOLET",hero,hero,0,0,0,FALSE);
//		Wld_PlayEffect("spellFX_LIGHTSTAR_GREEN",hero,hero,0,0,0,FALSE);
		Snd_Play("SFX_HealObsession");
	};
};


instance ItSe_Golemchest_Mis(C_Item)
{
	name = NAME_Beutel;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 50;
	visual = "ItMi_Pocket.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = Use_GolemChest;
	description = name;
	text[0] = PRINT_Pocket_50;
	text[1] = "It seems that it contains something";
	text[1] = "besides gold.
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_GolemChest()
{
	B_PlayerFindItem(ItMi_Gold,50);
	B_PlayerFindItem(ItRi_Prot_Total_02,1);
};


instance ItWr_ShatteredGolem_MIS(C_Item)
{
	name = "A very old map.";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 150;
	visual = "ItWr_Map_NW_02.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_ShatteredGolem_Mis;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_ShatteredGolem_Mis()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWr_ShatteredGolem_MIS);
	};
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_NewWorld_ShatteredGolem.tga",TRUE);
	Doc_SetLevel(Document,"NewWorld\NewWorld.zen");
	Doc_SetLevelCoords(Document,-28000,50500,95500,-42500);
	Doc_Show(Document);
};


instance ItWr_DiegosLetter_MIS(C_Item)
{
	name = "Letter from Diego";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_DiegosLetter_Mis;
	scemeName = "MAP";
	description = "Diego's letter to Gerbrandt.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_DiegosLetter_Mis()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine (nDocID, 0, "Gerbrandt,");
	Doc_PrintLines (nDocID, 0, "You know, you should have killed me.");
	Doc_PrintLines (nDocID, 0, "I'm back in town and looking for you. And when I find you, I'm gonna slice you like a pudding. You've known me long enough to be sure I won't be fooled lightly.");
	Doc_PrintLines (nDocID, 0, "I guess when you had me thrown in the Barrier, you never dreamed I might come back. Well, you were wrong.");
	Doc_PrintLines (nDocID, 0, "I've come for what's owed to me.");
	Doc_PrintLines (nDocID, 0, "Your only chance to stay alive is to beat it fast and leave your business to me. That'd make us quits.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "Diego");
	Doc_Show(nDocID);
};


instance ItSe_DiegosTreasure_Mis(C_Item)
{
	name = NAME_Beutel;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = DiegosTreasure;
	visual = "ItMi_Pocket_Mis.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = Use_DiegosTreasure;
	description = name;
	text[0] = PRINT_Pocket_MIS;
	text[1] = "Diego's old leather bag.";
	text[2] = "It's full of gold!";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_DiegosTreasure()
{
	B_PlayerFindItem(ItMi_Gold,DiegosTreasure);
	OpenedDiegosBag = TRUE;
};


instance ItMi_UltharsHolyWater_Mis(C_Item)
{
	name = "Ulthar's Holy Water";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = Value_HolyWater;
	visual = "ItMi_UltharsHolyWater.3ds";
	material = MAT_GLAS;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};


instance ItWr_MinenAnteil_Mis(C_Item)
{
	name = "Khorinis Ore Mine Share";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 50;
	visual = "ItWr_Scroll_02.3DS";
//	visual = "Fakescroll.3ds";
	material = MAT_LEATHER;
	on_state[0] = Use_MinenAnteil_Mis;
	scemeName = "MAP";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_MinenAnteil_Mis()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"Акция рудника");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "By the King's Bill of Property gained from Royal Lands, the bearer of this document is granted prospecting rights on the King's land.");
	Doc_PrintLines (nDocID, 0, "He must limit his scraping to the area of one small royal realmlot.");
	Doc_PrintLines (nDocID, 0, "According to the Bill of Scrapeland Size, small royal realmlots measure 16 paces in horizontal and 3 paces in vertical extension.");
	Doc_PrintLines (nDocID, 0, "The Prospector of the Realm is unbound by any duties of free access and protection of scraping cells.");
	Doc_PrintLines (nDocID, 0, "If the tenant is unable to pay the rent due, all rights to the land are returned to the Realm.");
	Doc_PrintLine (nDocID, 0, "         Signed");
	Doc_PrintLine (nDocID, 0, "      Prospector of the King");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "                Salandril");
	Doc_Show(nDocID);
	if(SC_KnowsProspektorSalandril == FALSE)
	{
		if(!Npc_IsDead(Salandril))
		{
			B_LogEntry(TOPIC_MinenAnteileKDF,"The guy who sold the mine shares to the merchants is called Salandril. I'll probably find him in the upper quarter of Khorinis, unless he's already running away from justice..");
		}
		else
		{
			B_LogEntry(TOPIC_MinenAnteileKDF,"The guy who sold the mine shares to the merchants is called Salandril. Now he's dead. I should report back to Serpentes.");
			Log_SalandrilIsDead = TRUE;
		};
		SC_KnowsProspektorSalandril = TRUE;
	};
};


instance ItAm_Prot_BlackEye_Mis(C_Item)
{
	name = NAME_Amulett;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET | ITEM_MISSION;
	value = Value_Am_HpMana;
//	visual = "ItAm_Hp_Mana_01.3ds";
	visual = "ItAm_Prot_BlackEye_Mis.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Soul Summoning Amulet";
	text[2] = "Protection from the Black Look.";
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};

instance ItMi_KarrasBlessedStone_Mis(C_Item)
{
	name = "Stone";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 0;
//	visual = "ItMi_Rockcrystal.3ds";
	visual = "ItMi_KarrasBlessedStone.3ds";
	visual_skin = 0;
	material = MAT_STONE;
	description = "Stone from Blessed Soil";
	inv_zbias = 190;
};

instance ItWr_RichterKomproBrief_MIS(C_Item)
{
	name = "Judge's Assignment";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_RichterKomproBrief;
	scemeName = "MAP";
	description = name;
};


func void Use_RichterKomproBrief()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "Morgahard, you good-for-nothing wretch. Carry out my orders, or I'll have to change my tune and arrest the lot of you.");
	Doc_PrintLines (nDocID, 0, "It's gotta happen tomorrow night. Larius is getting suspicious.");
	Doc_PrintLines (nDocID, 0, "If we don't drag the money out of his pockets now, it may be too late. I'll make sure you meet him on the marketplace this evening.");
	Doc_PrintLines (nDocID, 0, "But don't make a show of it, or you'll have the militia down on you before you know what's happening.");
	Doc_PrintLines (nDocID, 0, "By the way: If he happens to peg out in the process, that's fine by me.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "          Chief Judge and ");
	Doc_PrintLine (nDocID, 0, "          King's Secretary");
	Doc_Show(nDocID);
	if(SCKnowsRichterKomproBrief == FALSE)
	{
		B_LogEntry(TOPIC_RichterLakai,"Interesting, will Larius believe me if I tell him he was robbed on Judge's orders?");
		SCKnowsRichterKomproBrief = TRUE;
	};
};


instance ItWr_MorgahardTip(C_Item)
{
	name = NAME_Letter;
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_MorgahardTip;
	scemeName = "MAP";
	description = name;
	text[0] = "It belonged to escaped convict.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_MorgahardTip()
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
	Doc_PrintLines (nDocID, 0, "I've gone on ahead. I hope we'll all meet again when things have calmed down a mite.");
	Doc_PrintLines (nDocID, 0, "Don't worry, boys. If all else fails, I'll ask Onar to see to it for us.");
	Doc_PrintLines (nDocID, 0, "It'll be all right.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"                     M.");
//	Doc_PrintLine(nDocID,0,"");
	Doc_Show(nDocID);
};


instance ItWr_Map_Shrine_MIS(C_Item)
{
	name = "Map of the Holy Shrines";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 200;
	visual = "ItWr_Map_NW_01.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_Map_NewWorld_Shrine_MIS;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Map_NewWorld_Shrine_MIS()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWr_Map_Shrine_MIS);
	};
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_NewWorld_Shrine.tga",TRUE);
	Doc_SetLevel(Document,"NewWorld\NewWorld.zen");
	Doc_SetLevelCoords(Document,-28000,50500,95500,-42500);
	Doc_Show(Document);
};


instance ItWr_VinosKellergeister_Mis(C_Item)
{
	name = "The Spirit of the Wine";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_02_05.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = Use_VinosKellergeister_Mis;
};


func void Use_VinosKellergeister_Mis()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Red_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Red_R.tga",0);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_PrintLines(nDocID,0,"Power of the Grape");
	Doc_PrintLine(nDocID,0,"");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"... I've tried a lot in my time, but this fruit that was brought to me from abroad last week has exceeded all expectations ...");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"... the juice of this grape is fruitier than any you'll find in this part of the country ...");
	Doc_PrintLine(nDocID,0,"");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_SetFont(nDocID,1,FONT_Book);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"... so far so good. But it still makes me nervous to think what might happen if I'm caught in my secret still. I've no idea what the militia will do to me if they find me here. They might even throw me through the Barrier ...");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"... They've gotten suspicious. I'm going to go and leave all this until things have calmed down a bit and get back to work when I can be sure they're not onto me any more ...");
	Doc_Show(nDocID);
};


