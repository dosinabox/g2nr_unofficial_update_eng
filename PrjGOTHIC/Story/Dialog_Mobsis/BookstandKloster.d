
func void Use_Bookstand_Rune_01_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"Page 1");
		Doc_PrintLine(nDocID,0,"The Runestones");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"Page 2");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		Doc_Show(nDocID);
	};
};

func void Use_Bookstand_Rune_02_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"Page 1");
		Doc_PrintLine(nDocID,0,"The Runes and their Ingredients");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"Page 2");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		Doc_Show(nDocID);
	};
};

func void Use_Bookstand_Innos_01_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"Page 1");
		Doc_PrintLine(nDocID,0,"Teachings of Innos");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"Page 2");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		Doc_Show(nDocID);
	};
};

func void Use_Bookstand_Innos_02_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"Page 1");
		Doc_PrintLine(nDocID,0,"Commandments of Innos");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"Page 2");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		Doc_Show(nDocID);
	};
};

func void Use_Bookstand_Kreise_01_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"THE FIRST CIRCLE");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"The runes of the 1st Circle and the ingredients required to create them.");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Light:");
		Doc_PrintLine(nDocID,0,"- Gold Coin");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Fire Arrow:");
		Doc_PrintLine(nDocID,0,"- Sulfur");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Small Lightning:");
		Doc_PrintLine(nDocID,0,"- Rock Crystal");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Goblin Skeleton:");
		Doc_PrintLine(nDocID,0,"- Goblin's Bone");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Heal Light Wounds:");
		Doc_PrintLine(nDocID,0,"- Healing Plant");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes2);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes3);
		Doc_Show(nDocID);
		SC_KnowsBlankRuneForFirebolt = TRUE;
	};
};

func void Use_Bookstand_Kreise_02_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"THE SECOND CIRCLE");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"The runes of the 2nd Circle and the ingredients required to create them.");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Fireball:");
		Doc_PrintLine(nDocID,0,"- Pitch");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Ice Arrow:");
		Doc_PrintLine(nDocID,0,"- Glacier Quartz");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Summon Wolf:");
		Doc_PrintLine(nDocID,0,"- Wolf Skin");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Wind Fist:");
		Doc_PrintLine(nDocID,0,"- Coal");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Sleep:");
		Doc_PrintLine(nDocID,0,"- Swampweed");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes2);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes3);
		Doc_Show(nDocID);
		SC_KnowsBlankRuneForFirebolt = TRUE;
	};
};

func void Use_Bookstand_Kreise_03_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"THE THIRD CIRCLE");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"The runes of the 3rd Circle and the ingredients required to create them.");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Heal Medium Wounds:");
		Doc_PrintLine(nDocID,0,"- Healing Herb");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Small Fire Storm:");
		Doc_PrintLine(nDocID,0,"- Pitch");
		Doc_PrintLine(nDocID,0,"- Sulfur");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Create Skeleton:");
		Doc_PrintLine(nDocID,0,"- Skeleton's Bone");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Fear:");
		Doc_PrintLine(nDocID,0,"- Black Pearl");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Ice Block:");
		Doc_PrintLine(nDocID,0,"- Glacier Quartz");
		Doc_PrintLine(nDocID,0,"- Aquamarine");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Ball Lightning:");
		Doc_PrintLine(nDocID,0,"- Rock Crystal");
		Doc_PrintLine(nDocID,0,"- Sulfur");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes2);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes3);
		Doc_Show(nDocID);
		SC_KnowsBlankRuneForFirebolt = TRUE;
	};
};

func void Use_Bookstand_Kreise_04_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"THE FOURTH CIRCLE");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"The runes of the 4th Circle and the ingredients required to create them.");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Large Fireball:");
		Doc_PrintLine(nDocID,0,"- Sulfur");
		Doc_PrintLine(nDocID,0,"- смола");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Sulfur:");
		Doc_PrintLine(nDocID,0,"- Rock Crystal");
		Doc_PrintLine(nDocID,0,"- Glacier Quartz");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Awaken Golem:");
		Doc_PrintLine(nDocID,0,"- Heart of a Stone Golem");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Destroy Undead:");
		Doc_PrintLine(nDocID,0,"- Holy Water");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes2);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes3);
		Doc_Show(nDocID);
		SC_KnowsBlankRuneForFirebolt = TRUE;
	};
};

func void Use_Bookstand_Kreise_05_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"THE FIFTH CIRCLE");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"The runes of the 5th Circle and the ingredients required to create them.");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Ice Wave:");
		Doc_PrintLine(nDocID,0,"- Glacier Quartz");
		Doc_PrintLine(nDocID,0,"- Aquamarine");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Large Fire Storm:");
		Doc_PrintLine(nDocID,0,"- Sulfur");
		Doc_PrintLine(nDocID,0,"- Tongue of Fire");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Summon Demon:");
		Doc_PrintLine(nDocID,0,"- Heart of a Demon");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Heal Heavy Wounds:");
		Doc_PrintLine(nDocID,0,"- Healing Root");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Shrink Monster:");
		Doc_PrintLine(nDocID,0,"- Goblin's Bone");
		Doc_PrintLine(nDocID,0,"- Troll Tusk");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes2);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes3);
		Doc_Show(nDocID);
		SC_KnowsBlankRuneForFirebolt = TRUE;
	};
};

func void Use_Bookstand_Kreise_06_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"THE SIXTH CIRCLE");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"The runes of the 6th Circle and the ingredients required to create them.");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Fire Rain:");
		Doc_PrintLine(nDocID,0,"- Pitch");
		Doc_PrintLine(nDocID,0,"- Sulfur");
		Doc_PrintLine(nDocID,0,"- Tongue of Fire");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Breath of Death:");
		Doc_PrintLine(nDocID,0,"- Coal");
		Doc_PrintLine(nDocID,0,"- Black Pearl");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Wave of Death:");
		Doc_PrintLine(nDocID,0,"- Skeleton's Bone");
		Doc_PrintLine(nDocID,0,"- Black Pearl");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Army of Darkness:");
		Doc_PrintLine(nDocID,0,"- Skeleton's Bone");
		Doc_PrintLine(nDocID,0,"- Black Pearl");
		Doc_PrintLine(nDocID,0,"- Heart of a Stone Golem");
		Doc_PrintLine(nDocID,0,"- Heart of a Demon");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes2);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes3);
		Doc_Show(nDocID);
		SC_KnowsBlankRuneForFirebolt = TRUE;
	};
};

func void Use_Bookstand_Rules_01_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"Page 1");
		Doc_PrintLine(nDocID,0,"Rules");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"Page 2");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		Doc_Show(nDocID);
	};
};

