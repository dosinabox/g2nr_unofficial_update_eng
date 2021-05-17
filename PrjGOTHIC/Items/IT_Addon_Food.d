
const int Value_Rum = 20;
const int Mana_Rum = 10;
const int Value_Grog = 10;
const int HP_Grog = 10;
const int Value_SchnellerHering = 30;
const int Value_LousHammer = 30;
const int Mana_LousHammer = 1;
const int Value_SchlafHammer = 60;
const int Value_BonusFood = 40;
const int STR_FireStew = 1;
const int HP_FireStew = 5;
const int STR_MeatSoup = 1;
const int Value_Shellflesh = 10;
const int HP_Shellflesh = 20;

instance ItFo_Addon_Shellflesh(C_Item)
{
	name = "Clam Meat";
	mainflag = ITEM_KAT_FOOD;
	flags = ITEM_MULTI;
	value = Value_Shellflesh;
	visual = "ItAt_Shellflesh.3DS";
	material = MAT_LEATHER;
	scemeName = "FOODHUGE";
	on_state[0] = Use_Shellflesh;
	description = name;
	text[0] = "Juicy clam meat. Can be eaten raw.";
	text[1] = NAME_Bonus_HP;
	count[1] = HP_Shellflesh;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = 190;
};


func void Use_Shellflesh()
{
	Npc_ChangeAttribute(self,ATR_HITPOINTS,HP_Shellflesh);
};


instance ItFo_Addon_Rum(C_Item)
{
	name = "Ром";
	mainflag = ITEM_KAT_FOOD;
	flags = ITEM_MULTI;
	value = Value_Rum;
	visual = "ItMi_Rum_01.3ds";
	material = MAT_STONE;
	on_state[0] = UseRum;
	scemeName = "POTIONFAST";
	description = name;
	text[0] = "White Rum.";
	text[1] = NAME_Bonus_Mana;
	count[1] = Mana_Rum;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseRum()
{
	B_NpcSetDrunk(50);
	Npc_ChangeAttribute(self,ATR_MANA,Mana_Rum);
};


instance ItFo_Addon_Grog(C_Item)
{
	name = "Grog";
	mainflag = ITEM_KAT_FOOD;
	flags = ITEM_MULTI;
	value = Value_Grog;
	visual = "ItMi_Rum_02.3ds";
	material = MAT_STONE;
	on_state[0] = UseGrog;
	scemeName = "POTIONFAST";
	description = name;
	text[0] = "Genuine seaman's grog.";
	text[1] = NAME_Bonus_HP;
	count[1] = HP_Grog;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseGrog()
{
	B_NpcSetDrunk(40);
	Npc_ChangeAttribute(self,ATR_HITPOINTS,HP_Grog);
};


var int Hammer_Once;

instance ItFo_Addon_LousHammer(C_Item)
{
	name = "Lou's Hammer";
	mainflag = ITEM_KAT_FOOD;
	flags = ITEM_MULTI;
	value = Value_LousHammer;
	visual = "ItMi_Rum_04.3ds";
	material = MAT_STONE;
	on_state[0] = UseLouHammer;
	scemeName = "POTIONFAST";
	description = name;
	text[1] = TEXT_LousHammer_Setting;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseLouHammer()
{
	if(Hammer_Once == FALSE)
	{
		B_RaiseAttribute(self,ATR_MANA_MAX,Mana_LousHammer);
		TEXT_LousHammer_Setting = PRINT_LousHammerNoEffect;
		Hammer_Once = TRUE;
	};
	if(Npc_IsPlayer(self))
	{
		Mdl_ApplyOverlayMdsTimed(self,"Humans_Drunken.mds",70000);
	};
};


instance ItFo_Addon_SchlafHammer(C_Item)
{
	name = "Double Hammer";
	mainflag = ITEM_KAT_FOOD;
	flags = ITEM_MULTI;
	value = Value_SchlafHammer;
	visual = "ItMi_Rum_05.3ds";
	material = MAT_STONE;
	on_state[0] = UseSchlafHammer;
	scemeName = "POTIONFAST";
	description = name;
	text[0] = "Makes the toughest drinker sleepy...";
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseSchlafHammer()
{
	if(self.attribute[ATR_HITPOINTS] > 2)
	{
		self.attribute[ATR_HITPOINTS] /= 2;
	};
	if(Npc_IsPlayer(self))
	{
		AI_StartState(self,ZS_MagicSleep,1,"");
	};
};


const int Time_SchnellerHering = 120000;

instance ItFo_Addon_SchnellerHering(C_Item)
{
	name = "Hasty Herring";
	mainflag = ITEM_KAT_FOOD;
	flags = ITEM_MULTI;
	value = Value_SchnellerHering;
	visual = "ItMi_Rum_03.3ds";
	material = MAT_STONE;
	on_state[0] = UseSchnellerHering;
	scemeName = "POTIONFAST";
	description = name;
//	text[1] = "Looks dangerous!";
//	text[2] = "Effects unknown.";
//	text[3] = "Probable side-effects.";
	text[0] = PRINT_Speed;
	text[1] = NAME_Duration;
	count[1] = Time_SchnellerHering / 60000;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseSchnellerHering()
{
	if(Npc_IsPlayer(self))
	{
		Mdl_ApplyOverlayMdsTimed(self,"HUMANS_SPRINT.MDS",Time_SchnellerHering);
	};
	Player_KnowsSchnellerHering = TRUE;
};


instance ItFo_Addon_Liquor(C_Item)
{
	name = "Liquor";
	mainflag = ITEM_KAT_FOOD;
	flags = ITEM_MULTI;
	value = Value_Rum;
	visual = "ItFo_Liquor.3ds";
	material = MAT_GLAS;
	on_state[0] = UseLiquor;
	scemeName = "POTIONFAST";
	description = name;
	text[0] = "Sweet and strong.";
	text[1] = NAME_Bonus_HP;
	count[1] = HP_Grog;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseLiquor()
{
	B_NpcSetDrunk(20);
	Npc_ChangeAttribute(self,ATR_HITPOINTS,HP_Grog);
};


instance ItFo_Addon_Pfeffer_01(C_Item)
{
	name = "Pepper Bag";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 100;
	visual = "ItMi_RedPepper.3ds";
	material = MAT_LEATHER;
	description = name;
	text[0] = "Red tear-pepper";
	text[1] = "From the southern islands.";
	text[3] = "CAREFUL, HOT!";
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = 190;
};

instance ItFo_Addon_FireStew(C_Item)
{
	name = "Fire Strips";
	mainflag = ITEM_KAT_FOOD;
	flags = ITEM_MULTI;
	value = Value_BonusFood;
	visual = "ItFo_FireStew.3ds";
	material = MAT_WOOD;
	scemeName = "RICE";
	on_state[0] = Use_FireStew;
	description = name;
	text[1] = NAME_Bonus_HpMax;
	count[1] = HP_FireStew;
	text[2] = NAME_Bonus_Str;
	count[2] = STR_FireStew;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_FireStew()
{
	var string concatText;
	B_RaiseAttribute(self,ATR_HITPOINTS_MAX,HP_FireStew);
	self.attribute[ATR_STRENGTH] += STR_FireStew;
	if(IgnoreBonuses == FALSE)
	{
		B_RaiseRealAttributeLearnCounter(self,ATR_STRENGTH,STR_FireStew);
	};
	concatText = ConcatStrings(PRINT_LearnSTR,IntToString(STR_FireStew));
	PrintScreen(concatText,-1,53,FONT_Screen,2);
};


instance ItFo_Addon_Meatsoup(C_Item)
{
	name = "Meat Stew";
	mainflag = ITEM_KAT_FOOD;
	flags = ITEM_MULTI;
	value = Value_BonusFood;
	visual = "ItFo_MeatSoup.3ds";
	material = MAT_WOOD;
	scemeName = "RICE";
	on_state[0] = Use_MeatSoup;
	description = name;
	text[0] = "Steaming meat stew.";
	text[1] = NAME_Bonus_HP;
	count[1] = HP_Stew;
	text[2] = NAME_Bonus_Str;
	count[2] = STR_MeatSoup;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_MeatSoup()
{
	Npc_ChangeAttribute(self,ATR_HITPOINTS,HP_Stew);
	if(Npc_IsPlayer(self))
	{
		B_RaiseAttribute(self,ATR_STRENGTH,STR_MeatSoup);
	};
};

