
instance ItWr_SaturasFirstMessage_Addon_Sealed(C_Item)
{
	name = NAME_LetterSealed;
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_SaturasFirstMessage_Sealed;
	scemeName = "MAPSEALED";
	description = name;
	text[0] = "This message was carefully sealed.";
};


var int Use_SaturasFirstMessage_OneTime;

func void Use_SaturasFirstMessage()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Dear Vatras,");
	Doc_PrintLines (nDocID, 0, "We have adanced to the portal. You were correct.");
	Doc_PrintLines (nDocID, 0, "It indeed appears that they were believers in Adanos. I ask you to verify this once again with the help of my notes.");
	Doc_PrintLines (nDocID, 0, "We have not spotted any of those curious stone beings for days.");
	Doc_PrintLines (nDocID, 0, "Nevertheless, the earth continues to quake for no apparent reason.");
	Doc_PrintLines (nDocID, 0, "I suspect that our studies will soon bring us more enlightenment.");
	Doc_PrintLines (nDocID, 0, "The ornament which we found has a far more important significance than we first thought. It seems to be a crucial key artifact. Alas, it is not complete. We must study it further.");
	Doc_PrintLines (nDocID, 0, "Dispatch one of our children from the 'Ring of Water' to bring it back to us. If possible, do not send Cavalorn.");
	Doc_PrintLines (nDocID, 0, "I have assigned him to deliver this letter to you. I think that is enough for him to do. ");
	Doc_PrintLines (nDocID, 0, "I hope we are doing the right thing.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Saturas");
	Doc_Show(nDocID);
	if((Use_SaturasFirstMessage_OneTime == FALSE) && (MIS_Addon_Cavalorn_Letter2Vatras != LOG_SUCCESS))
	{
		Log_CreateTopic(TOPIC_Addon_KDW,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_KDW,LOG_Running);
		if(SC_KnowsRanger == FALSE)
		{
			B_LogEntries(TOPIC_Addon_KDW,"I took a message that Cavalorn was supposed to deliver to the Water Mage Vatras from a bandit. Now it is my task.");
		}
		else
		{
			B_LogEntry(TOPIC_Addon_KDW,"I took a message that Cavalorn was supposed to deliver to the Water Mage Vatras from a bandit. Now it is my task.");
		};
		Use_SaturasFirstMessage_OneTime = TRUE;
	};
	if(SC_KnowsRanger == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_RingOfWater,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_RingOfWater,LOG_Running);
		B_LogNextEntry(TOPIC_Addon_RingOfWater,"There is a community that calls itself the 'Ring of Water'. The Water Mages seem to be the commanders of this community.");
	};
	if(SC_IsRanger == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_RingOfWater,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_RingOfWater,LOG_Running);
		Log_AddEntry(TOPIC_Addon_RingOfWater,"Cavalorn belongs to the 'Ring of Water'.");
	};
	SC_KnowsRanger = TRUE;
};

func void Use_SaturasFirstMessage_Sealed()
{
	Snd_Play("PICKLOCK_BROKEN");
	CreateInvItems(self,ItWr_SaturasFirstMessage_Addon,1);
	SaturasFirstMessageOpened = TRUE;
	Use_SaturasFirstMessage();
};


instance ItWr_SaturasFirstMessage_Addon(C_Item)
{
	name = NAME_Letter;
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_SaturasFirstMessage;
	scemeName = "MAP";
	description = name;
	text[0] = "Saturas' letter to Vatras.";
	text[1] = "The seal was broken.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};

instance ItMi_Ornament_Addon(C_Item)
{
	name = "Ornament";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 0;
	visual = "ItMi_PortalRing_05.3DS";
	material = MAT_STONE;
	description = name;
	text[0] = "Fragment of a large ornamental ring.";
	inv_zbias = 270;
};

instance ItMi_Ornament_Addon_Vatras(C_Item)
{
	name = "Ornament";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 0;
	visual = "ItMi_PortalRing_05.3DS";
	material = MAT_STONE;
	description = name;
	text[0] = "Fragment of a large ornamental ring.";
	text[1] = "It was given to me by Vatras.";
	inv_zbias = 270;
};

instance ItWr_Map_NewWorld_Ornaments_Addon(C_Item)
{
	name = "Nefarius' map";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MULTI;
	value = 200;
	visual = "ItWr_Map_NW_01.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_Map_NewWorld_Ornaments;
	description = name;
	text[0] = "The places where Nefarius assumes the missing";
	text[1] = "ornaments can be found are marked on this map";
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Map_NewWorld_Ornaments()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWr_Map_NewWorld_Ornaments_Addon);
	};
	SC_SAW_ORNAMENT_MAP = TRUE;
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_NewWorld_Ornaments.tga",TRUE);
	Doc_SetLevel(Document,"NewWorld\NewWorld.zen");
	Doc_SetLevelCoords(Document,-28000,50500,95500,-42500);
	Doc_Show(Document);
};


instance ItWr_Map_NewWorld_Dexter(C_Item)
{
	name = "Land Map of Khorinis";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MULTI;
	value = 200;
	visual = "ItWr_Map_NW_01.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_Map_NewWorld_Dexter;
	description = name;
	text[0] = "Skip has marked the place";
	text[1] = "where I can find the bandit chief - Dexter.";
	text[2] = "";
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Map_NewWorld_Dexter()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWr_Map_NewWorld_Dexter);
	};
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_NewWorld_Dexter.tga",TRUE);
	Doc_SetLevel(Document,"NewWorld\NewWorld.zen");
	Doc_SetLevelCoords(Document,-28000,50500,95500,-42500);
	Doc_Show(Document);
};


prototype Rangerring_Prototype(C_Item)
{
	name = "Aquamarine ring";
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING | ITEM_MISSION;
	value = Value_Ri_HpMana;
	visual = "ItRi_Rangerring.3ds";
	visual_skin = 0;
	material = MAT_METAL;
//	on_equip = Equip_ItRi_Ranger_Addon;
//	on_unequip = UnEquip_ItRi_Ranger_Addon;
	description = name;
	text[0] = "Recognition sign of the 'Ring of Water'";
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};

func void Equip_ItRi_Ranger_Lares()
{
	if(Npc_IsPlayer(self))
	{
		RangerRingIsLaresRing = TRUE;
		Print(PRINT_Addon_SCIsWearingRangerRing);
	};
};

func void UnEquip_ItRi_Ranger_Lares()
{
	if(Npc_IsPlayer(self))
	{
		RangerRingIsLaresRing = FALSE;
	};
};

func void Equip_ItRi_Ranger_My()
{
	if(Npc_IsPlayer(self))
	{
		RangerRingIsMyRing = TRUE;
		Print(PRINT_Addon_SCIsWearingRangerRing);
	};
};

func void UnEquip_ItRi_Ranger_My()
{
	if(Npc_IsPlayer(self))
	{
		RangerRingIsMyRing = FALSE;
	};
};

func void Equip_ItRi_Ranger_Lance()
{
	if(Npc_IsPlayer(self))
	{
		RangerRingIsLanceRing = TRUE;
		Print(PRINT_Addon_SCIsWearingRangerRing);
	};
};

func void UnEquip_ItRi_Ranger_Lance()
{
	if(Npc_IsPlayer(self))
	{
		RangerRingIsLanceRing = FALSE;
	};
};

instance ItRi_Ranger_Lares_Addon(Rangerring_Prototype)
{
	on_equip = Equip_ItRi_Ranger_Lares;
	on_unequip = UnEquip_ItRi_Ranger_Lares;
	text[1] = "This ring belongs to Lares.";
};

instance ItRi_Ranger_Addon(Rangerring_Prototype)
{
	on_equip = Equip_ItRi_Ranger_My;
	on_unequip = UnEquip_ItRi_Ranger_My;
	text[1] = "This ring belongs to me.";
};

instance ItRi_Ranger_Lance_Addon(Rangerring_Prototype)
{
	on_equip = Equip_ItRi_Ranger_Lance;
	on_unequip = UnEquip_ItRi_Ranger_Lance;
	text[1] = "This ring belongs to Lance";
};

instance ItMi_PortalRing_Addon(C_Item)
{
	name = "Ornamental ring";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItMi_PortalRing_01.3DS";
	material = MAT_STONE;
	description = name;
	text[0] = "This ring opens the portal.";
	inv_zbias = 190;
};

instance ItWr_Martin_MilizEmpfehlung_Addon(C_Item)
{
	name = "Martin's letter of recommendation";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_MartinMilizEmpfehlung_Addon;
	scemeName = "MAP";
	description = name;
	text[0] = "This letter should help me be";
	text[1] = "accepted in the militia";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_MartinMilizEmpfehlung_Addon()
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
	Doc_PrintLine(nDocID,0,"Honored Lord Andre");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "With this letter I send a new recruit for our militia to you.");
	Doc_PrintLines (nDocID, 0, "He has already been of service to me in some difficult and important matters.");
	Doc_PrintLines (nDocID, 0, "I am sure that he is very well suited to protect the King and the welfare of the citizens of this city.");
	Doc_PrintLine (nDocID, 0, "Innos bless the King.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"     Provisions Master Martin");
	Doc_Show(nDocID);
};


instance ItWr_RavensKidnapperMission_Addon(C_Item)
{
	name = "Orders";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_RavensKidnapperMission_Addon;
	scemeName = "MAP";
	description = name;
	text[0] = "I took this letter from";
	text[1] = "the bandit Dexter.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


var int Use_RavensKidnapperMission_Addon_OneTime;

func void Use_RavensKidnapperMission_Addon()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Dexter, you bastard!");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "You weren't so unreliable when I was still an ore baron.");
	Doc_PrintLines (nDocID, 0, "If you can't manage to kidnap more citizens from the city and send them to me, then we will soon have a serious problem with the boys in our hideout.");
	Doc_PrintLines (nDocID, 0, "I need more slaves here or the boys will start a revolt. And I don't have to tell you what that means, do I?");
	Doc_PrintLines (nDocID, 0, "I am about to get inside the temple. With that, I can't afford disturbances of this sort.");
	Doc_PrintLines (nDocID, 0, "And one more problem:");
	Doc_PrintLines (nDocID, 0, "Sooner or later we have to find a way over the high mountains in the northeast of Khorinis. The pirates won't handle the transport much longer if we don't pay them any more.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"     Raven");
	Doc_Show(nDocID);
	SCKnowsMissingPeopleAreInAddonWorld = TRUE;
	if((Use_RavensKidnapperMission_Addon_OneTime == FALSE) && (MIS_Addon_Vatras_WhereAreMissingPeople != FALSE))
	{
		Log_CreateTopic(TOPIC_Addon_WhoStolePeople,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_WhoStolePeople,LOG_Running);
		B_LogEntry(TOPIC_Addon_WhoStolePeople,"Now I have it in writing. Raven, the former ore baron, is behind the kidnapping of the citizens of Khorinis. Raven's hideout is somewhere behind the mountains in the northeast of Khorinis. Vatras should see this document.");
		Use_RavensKidnapperMission_Addon_OneTime = TRUE;
	};
};


instance ItWr_Vatras_KDFEmpfehlung_Addon(C_Item)
{
	name = "Vatras' letter of recommendation";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_VatrasKDFEmpfehlung_Addon;
	scemeName = "MAP";
	description = name;
	text[0] = "This letter should help me get into";
	text[1] = "the Fire Magicians' monastery";
	text[2] = "without tribute.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_VatrasKDFEmpfehlung_Addon()
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
	Doc_PrintLines(nDocID,0,"Brothers of the Fire");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "It has just been reported to me that you require a tribute for admission into your realm.");
	Doc_PrintLines (nDocID, 0, "I send along with this letter a devout man who wishes to become a novice in your ranks.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"     Vatras");
	Doc_Show(nDocID);
};


instance ItMi_LostInnosStatue_Daron(C_Item)
{
	name = "Valuable Statue of Innos";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = Value_InnosStatue;
	visual = "ItMi_InnosStatue.3DS";
	material = MAT_METAL;
	description = name;
	text[0] = "Bottom part is engraved with";
	text[1] = "with the symbol of fire mages.";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItWr_LuciasLoveLetter_Addon(C_Item)
{
	name = "Lucia's farewell letter";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_LuciasLoveLetter_Addon;
	scemeName = "MAP";
	description = name;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_LuciasLoveLetter_Addon()
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
	Doc_PrintLines(nDocID,0,"Dearest Elvrich");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "I cannot find the words to describe how sorry I am.");
	Doc_PrintLines (nDocID, 0, "I know that you will not understand but I have come to the conclusion that it is better for both of us if you find a more respectable girl than I am.");
	Doc_PrintLines (nDocID, 0, "I won't be coming back from where I am going now. Forget me. A wench like me isn't right for an upright fellow like you. Farewell.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"     Lucia");
	Doc_Show(nDocID);
	if(MIS_LuciasLetter == FALSE)
	{
		if(!Npc_IsDead(Elvrich))
		{
			Log_CreateTopic(TOPIC_Addon_LuciasLetter,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_Addon_LuciasLetter,LOG_Running);
			B_LogEntries(TOPIC_Addon_LuciasLetter,"Lucia wrote a farewell letter to Elvrich. That should interest him.");
		};
		MIS_LuciasLetter = LOG_Running;
	};
	if(MIS_LookingForLucia == LOG_Running)
	{
		B_LogNextEntry(TOPIC_Addon_Lucia,"Lucia wrote a farewell letter to Elvrich. That should interest him.");
	};
	LuciaMentionedInKhorinis = TRUE;
};


prototype EffectItemPrototype_Addon(C_Item)
{
	name = "Stone";
//	mainflag = ITEM_KAT_NONE;
	mainflag = ITEM_KAT_LIGHT;
	flags = ITEM_MULTI;
	value = 15;
	visual = "ItMi_Coal.3ds";
	material = MAT_STONE;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_MISC_STANDARD;
};

instance ItMi_AmbossEffekt_Addon(EffectItemPrototype_Addon)
{
};

instance ItMi_OrnamentEffekt_FARM_Addon(EffectItemPrototype_Addon)
{
};

instance ItMi_OrnamentEffekt_FOREST_Addon(EffectItemPrototype_Addon)
{
};

instance ItMi_OrnamentEffekt_BIGFARM_Addon(EffectItemPrototype_Addon)
{
};

instance ItMi_Rake(C_Item)
{
	name = "Pick";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = Value_Rake;
	visual = "ItMi_Rake.3DS";
	material = MAT_WOOD;
	scemeName = "RAKE";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};

instance ItRi_Addon_BanditTrader(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING | ITEM_MISSION;
	value = 70;
	visual = "ItRi_Addon_BanditTrader.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	description = "Guild ring";
	text[0] = "Engraved ring of the";
	text[1] = "overseas-trader guild Araxos";
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};

instance ItWr_Addon_BanditTrader(C_Item)
{
	name = "Delivery";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_ItWr_Addon_BanditTrader;
	scemeName = "MAP";
	description = name;
	text[0] = "I found this letter with the";
	text[1] = "bandits behind Sekob's farm.";
};


var int Use_ItWr_Addon_BanditTrader_OneTime;

func void Use_ItWr_Addon_BanditTrader()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "15 short swords");
	Doc_PrintLines (nDocID, 0, "20 rapiers");
	Doc_PrintLines (nDocID, 0, "25 loaves of bread");
	Doc_PrintLines (nDocID, 0, "15 bottles of wine");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"That was the last time.");
	Doc_PrintLines(nDocID,0,"This thing is getting too hot.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"FERNANDO");
	Doc_Show(nDocID);
	if((MIS_Vatras_FindTheBanditTrader != FALSE) && (Use_ItWr_Addon_BanditTrader_OneTime == FALSE))
	{
		B_LogEntry(TOPIC_Addon_Bandittrader,"I found a document that can prove that Fernando is the weapons dealer I am looking for.");
		Use_ItWr_Addon_BanditTrader_OneTime = TRUE;
	};
	BanditTrader_Lieferung_Gelesen = TRUE;
};


instance ItWr_Vatras2Saturas_FindRaven(C_Item)
{
	name = NAME_LetterSealed;
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Vatras2Saturas_FindRaven_Sealed;
	scemeName = "MAPSEALED";
	description = name;
	text[0] = "Vatras' letter for Saturas";
};


func void Use_Vatras2Saturas_FindRaven()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"Dear Saturas");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "I hope that you will soon reach your goal. Our situation here in the city appears to have relaxed somewhat at the moment. But I fear that the quiet is deceptive. You should hurry. I need you here.");
	Doc_PrintLines (nDocID, 0, "I have studied your records and can confirm your suspicion. The writing does indeed point to an Adanos-worshipping culture. Be careful and do not allow yourselves to be blinded by false prophets.");
	Doc_PrintLines (nDocID, 0, "The missing citizens of Khorinis were dragged by the former ore baron Raven to the region where the portal obviously leads.");
	Doc_PrintLines (nDocID, 0, "One more thing: I have sent you help. The bearer of this message is somebody very special. He has such a remarkable gleam in his eyes. I am not certain, but it could be HE, even if we had imagined him differently.");
	Doc_PrintLines (nDocID, 0, "Test him. I think I am right.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Vatras");
	Doc_Show(nDocID);
};

func void Use_Vatras2Saturas_FindRaven_Sealed()
{
	Snd_Play("PICKLOCK_BROKEN");
	CreateInvItems(self,ItWr_Vatras2Saturas_FindRaven_opened,1);
	Vatras2Saturas_FindRaven_Open = TRUE;
	Use_Vatras2Saturas_FindRaven();
};


instance ItWr_Vatras2Saturas_FindRaven_opened(C_Item)
{
	name = NAME_Letter;
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Vatras2Saturas_FindRaven;
	scemeName = "MAP";
	description = name;
	text[0] = "Vatras' letter for Saturas";
	text[1] = "The seal was broken.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};

instance ItAm_Addon_WispDetector(C_Item)
{
	name = NAME_Amulett;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET;
	value = Value_Am_DexStrg;
	visual = "ItAm_Addon_WispDetector.3ds";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_WEAKGLIMMER_BLUE";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_WispDetector;
	on_unequip = UnEquip_WispDetector;
	description = name;
	text[0] = "Ore amulet of the searching will-o'-the-wisp.";
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};


var int Equip_WispDetector_OneTime;

func void Equip_WispDetector()
{
	var C_Npc DetWsp;
	if(Equip_WispDetector_OneTime == FALSE)
	{
		PLAYER_TALENT_WISPDETECTOR[WISPSKILL_NF] = TRUE;
		WispSearching = WispSearch_NF;
		Equip_WispDetector_OneTime = TRUE;
	};
	DetWsp = Hlp_GetNpc(Wisp_Detector);
	AI_Teleport(DetWsp,"TOT");
	Wld_SpawnNpcRange(self,Wisp_Detector,1,500);
	Wld_PlayEffect("spellFX_LIGHTSTAR_WHITE",Wisp_Detector,Wisp_Detector,0,0,0,FALSE);
	Snd_Play("MFX_Transform_Cast");
};

func void UnEquip_WispDetector()
{
	var C_Npc DetWsp;
	DetWsp = Hlp_GetNpc(Wisp_Detector);
	if(!Npc_IsDead(DetWsp))
	{
		Snd_Play("WSP_Dead_A1");
	};
	AI_Teleport(DetWsp,"TOT");
	B_MoveNpcToMorgue(DetWsp);
	AI_Teleport(DetWsp,"TOT");
};


instance ItFo_Addon_Krokofleisch_Mission(C_Item)
{
	name = "Swamprat Meat";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = Value_Rawmeat;
	visual = "ItFoMuttonRaw.3DS";
	material = MAT_LEATHER;
	scemeName = "MEAT";
	description = name;
	text[0] = "Smells fishy somehow!";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItRi_Addon_MorgansRing_Mission(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING | ITEM_MISSION;
	value = 500;
	visual = "ItRi_Addon_MorgansRing.3DS";
	material = MAT_METAL;
//	on_equip = Equip_MorgansRing;
//	on_unequip = UnEquip_MorgansRing;
	on_equip = Equip_1H_10;
	on_unequip = UnEquip_1H_10;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Morgan's ring";
	text[0] = "The ring is decorated with many fine runes.";
	text[2] = NAME_ADDON_BONUS_1H;
	count[2] = Waffenbonus_10;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};

/*
func void Equip_MorgansRing()
{
	B_AddFightSkill(self,NPC_TALENT_1H,10);
};

func void UnEquip_MorgansRing()
{
	B_AddFightSkill(self,NPC_TALENT_1H,-10);
};
*/

instance ItMi_Focus(C_Item)
{
	name = "Focus stone";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 0;
	visual = "ItMi_Focus.3DS";
	material = MAT_STONE;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_MANAPOTION";
	description = name;
};

instance ItMi_Addon_Steel_Paket(C_Item)
{
	name = "Steel Package";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 300;
	visual = "ItMi_Packet.3ds";
	material = MAT_STONE;
	description = name;
	text[0] = "This package is REALLY heavy";
	text[1] = "It contains a fat lump of steel";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItWr_StonePlateCommon_Addon(C_Item)
{
	name = "Old Stone Tablet";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = value_StonePlateCommon;
	visual = "ItMi_StonePlate_Read_06.3ds";
	material = MAT_STONE;
	on_state[0] = Use_StonePlateCommon;
	scemeName = "MAP";
	inv_rotx = -90;
	inv_roty = 0;
	inv_rotz = 0;
	description = name;
	text[0] = "A gray stone tablet.";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_StonePlateCommon()
{
	var int nDocID;
	if(PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_1] == TRUE)
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,1);
		Doc_SetPage(nDocID,0,"Maya_Stoneplate_03.TGA",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,-1,70,50,90,50,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines (nDocID, 0, "The caste of the warriors called down the wrath of our god.");
		Doc_PrintLine (nDocID, 0, "");
		Doc_PrintLines (nDocID, 0, "RHADEMES, the successor of Quarhodron, was banished. But his evil power reached us even from the place of his exile.");
		Doc_PrintLine (nDocID, 0, "");
		Doc_PrintLines (nDocID, 0, "We were powerless against it.");
		Doc_PrintLine (nDocID, 0, "");
		Doc_PrintLines (nDocID, 0, "ADANOS' wrath struck JHERENDAR!");
	}
	else
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,1);
		Doc_SetPage(nDocID,0,"Maya_Stoneplate_02.TGA",0);
		B_CannotUse_Addon();
		B_Say(self,self,"$CANTREADTHIS");
	};
	Doc_Show(nDocID);
};

instance ItMi_Addon_Stone_01(C_Item)
{
	name = "Red Stone Tablet";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItMi_StonePlate_Read_03.3ds";
	material = MAT_STONE;
	on_state[0] = Use_Addon_Stone_01;
	scemeName = "MAP";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_WEAKGLIMMER";
	inv_rotx = -90;
	inv_roty = 0;
	inv_rotz = 0;
	description = name;
};

func void Use_Addon_Stone_01()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"Adanos_Stoneplate_02.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,70,50,90,50,1);
	Doc_PrintLine(nDocID,0,"");
	if(PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_1] == TRUE)
	{
//		Doc_PrintLines(nDocID,0,"Мы, последние трое из Совета Пяти, установили в храме ловушки и спрятали вход, чтобы меч больше никогда не покинул храм.");
		Doc_PrintLines(nDocID,0,"We, the last three leaders of the Council of Five, have provided the chambers of the temple with traps and hidden the entrance so that the sword will never again see the light of day.");
	}
	else
	{
		Doc_PrintLines(nDocID,0,"Erfjkemvfj Hwoqmnyhan ckh. Fjewheege Egdgsmkd Ygc slje asdkjhnead Gkjsdhad Uhndter rygilliambwe ewzbfujbwe Iuhdfb. Revfnbrebuiwe ewohjfribwe wef. Sebnejbuwd Weinfiwjf Ihwqpjrnn.");
		B_CannotUse_Addon();
		B_Say(self,self,"$CANTREADTHIS");
	};
	Doc_Show(nDocID);
};

instance ItMi_Addon_Stone_02(C_Item)
{
	name = "Yellow Stone Tablet";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItMi_StonePlate_Read_02.3ds";
	material = MAT_STONE;
	on_state[0] = Use_Addon_Stone_02;
	scemeName = "MAP";
	inv_rotx = -90;
	inv_roty = 0;
	inv_rotz = 0;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_WEAKGLIMMER";
	description = name;
};

func void Use_Addon_Stone_02()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"Adanos_Stoneplate_05.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,70,50,90,50,1);
	Doc_PrintLine(nDocID,0,"");
	if(PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_1] == TRUE)
	{
		Doc_PrintLines (nDocID, 0, "It was also Quarhodron who sealed the outer gate of the temple with the help of KHARDIMON. Neither of them survived the ritual.");
		Doc_PrintLine (nDocID, 0, "");
		Doc_PrintLines (nDocID, 0, "Only I remain to tell the tale.");
		Doc_PrintLine (nDocID, 0, "");
		Doc_PrintLines (nDocID, 0, "I hope that RHADEMES rots for eternity in the temple!");
	}
	else
	{
		Doc_PrintLines(nDocID,0,"QUARHODRON Ygc slje asdkjhnead. KHARDIMON Weinfiwjf Ihwqpjrnn. Erfjkemvfj Hwoqmnyhan ckh. Fjewheege Egdgsmkd Esfjwedbwe asdkjhnead. Gkjsdhad Uhnd.");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"Revfnbrebuiwe ewohjfribwe wef. Sebnejbuwd Weinfiwjf Ihwqpjrnn.");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"Erfjkemvfj RHADEMES Fjewheege Egdgsmkd!");
		B_CannotUse_Addon();
		B_Say(self,self,"$CANTREADTHIS");
	};
	Doc_Show(nDocID);
};

instance ItMi_Addon_Stone_03(C_Item)
{
	name = "Blue Stone Tablet";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItMi_StonePlate_Read_05.3ds";
	material = MAT_STONE;
	on_state[0] = Use_Addon_Stone_03;
	scemeName = "MAP";
	inv_rotx = -90;
	inv_roty = 0;
	inv_rotz = 0;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_WEAKGLIMMER";
	description = name;
};

func void Use_Addon_Stone_03()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"Adanos_Stoneplate_03.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,70,50,90,50,1);
	Doc_PrintLine(nDocID,0,"");
	if(PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_1] == TRUE)
	{
		Doc_PrintLines(nDocID,0,"KHARDIMON devised the second trap. And only he who follows the way of Light to the end will reach the third chamber.");
	}
	else
	{
		Doc_PrintLines(nDocID,0,"KHARDIMON Weinfiwjf Ihwqpjrnn. Erfjkemvfj Hwoqmnyhan ckh. Gkjsdhad Uhnd Esfjwedbwe ewzbfujbwe.");
		B_CannotUse_Addon();
		B_Say(self,self,"$CANTREADTHIS");
	};
	Doc_Show(nDocID);
};

instance ItMi_Addon_Stone_04(C_Item)
{
	name = "Green Stone Tablet";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItMi_StonePlate_Read_01.3ds";
	material = MAT_STONE;
	on_state[0] = Use_Addon_Stone_04;
	scemeName = "MAP";
	inv_rotx = -90;
	inv_roty = 0;
	inv_rotz = 0;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_WEAKGLIMMER";
	description = name;
};

func void Use_Addon_Stone_04()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"Adanos_Stoneplate_04.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,70,50,90,50,1);
	Doc_PrintLine(nDocID,0,"");
	if(PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_1] == TRUE)
	{
		Doc_PrintLines(nDocID,0,"The third trap was built by QUARHODRON and only he knows how to open the portal.");
		SC_KnowsRhademesTrapDetails = TRUE;
	}
	else
	{
		Doc_PrintLines(nDocID,0,"Esfjwedbwe ewzbfujbwe. Fjewheege QUARHODRON Ygc slje asdkjhnead. Sebnejbuwd Weinfiwjf Ihwqpjrnn. Gkjsdhad Uhnd.");
		B_CannotUse_Addon();
		B_Say(self,self,"$CANTREADTHIS");
	};
	Doc_Show(nDocID);
};

instance ItMi_Addon_Stone_05(C_Item)
{
	name = "Purple Stone Tablet";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItMi_StonePlate_Read_04.3ds";
	material = MAT_STONE;
	on_state[0] = Use_Addon_Stone_05;
	scemeName = "MAP";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_WEAKGLIMMER";
	inv_rotx = -90;
	inv_roty = 0;
	inv_rotz = 0;
	description = name;
};

func void Use_Addon_Stone_05()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"Adanos_Stoneplate_01.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,70,50,90,50,1);
	Doc_PrintLine(nDocID,0,"");
	if(PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_1] == TRUE)
	{
		Doc_PrintLines(nDocID,0,"I, who was against the decision of the Three, built the first trap. And only I know the correct doorway.");
	}
	else
	{
		Doc_PrintLines(nDocID,0,"Fjewheege Egdgsmkd Ygc slje asdkjhnead Gkjsdhad Uhnd Esfjwedbwe ewzbfujbwe Iuhdfb. Sebnejbuwd Weinfiwjf Ihwqpjrnn. Erfjkemvfj Hwoqmnyhan ckh.");
		B_CannotUse_Addon();
		B_Say(self,self,"$CANTREADTHIS");
	};
	Doc_Show(nDocID);
};

instance ItMI_Addon_Kompass_Mis(C_Item)
{
	name = "Golden Compass";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 500;
	visual = "ItMi_Compass_01.3DS";
	material = MAT_METAL;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItSE_Addon_FrancisChest(C_Item)
{
	name = "Treasure Chest";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 750;
	visual = "ItSE_Addon_FrancisChest.3ds";
	scemeName = "MAPSEALED";
	material = MAT_METAL;
	on_state[0] = FrancisChest;
	description = name;
	text[0] = "The chest is very heavy.";
	text[5] = NAME_Value;
	count[5] = value;
};


func void FrancisChest()
{
	CreateInvItems(hero,ITWR_Addon_FrancisAbrechnung_Mis,1);
	CreateInvItems(hero,ItMw_1h_Pir_Dagger,1);
	CreateInvItems(hero,ItMi_Gold,153);
	CreateInvItems(hero,ItMi_GoldCup,1);
	CreateInvItems(hero,ItMi_SilverNecklace,1);
	CreateInvItems(hero,ItSE_Addon_EmptyFrancisChest,1);
	AI_PrintScreen("Received: Paybook",-1,49,FONT_ScreenSmall,4);
	AI_PrintScreen("Received: Good Dagger",-1,40,FONT_ScreenSmall,4);
	AI_PrintScreen("Received: 153 gold",-1,52,FONT_ScreenSmall,4);
	AI_PrintScreen("Received: Gold Chalice",-1,43,FONT_ScreenSmall,4);
	AI_PrintScreen("Received: Silver Necklace",-1,46,FONT_ScreenSmall,4);
	Snd_Play("Geldbeutel");
};


instance ItSE_Addon_EmptyFrancisChest(C_Item)
{
	name = "Empty Chest";
	mainflag = ITEM_KAT_NONE;
	value = 200;
	visual = "ItSE_Addon_FrancisChest.3ds";
	material = MAT_METAL;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};


instance ITWR_Addon_FrancisAbrechnung_Mis(C_Item)
{
	name = "Paybook";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_02_04.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = UseFrancisAbrechnung_Mis;
};


func void UseFrancisAbrechnung_Mis()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Brown_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Brown_R.tga",0);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Merchantman 'Mermaid'");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Total booty: 14560 gold.");
	Doc_PrintLine(nDocID,0,"-----------------------");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine (nDocID, 0, "Crew: 9840");
	Doc_PrintLine (nDocID, 0, "Officers: 2500");
	Doc_PrintLine (nDocID, 0, "Captain: 1000");
	Doc_PrintLine (nDocID, 0, "-----------------------");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "Personal share: 2220");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Merchant vessel 'Miriam'");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Total booty: 4890 gold.");
	Doc_PrintLine(nDocID,0,"-----------------------");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine (nDocID, 0, "Crew: 2390");
	Doc_PrintLine (nDocID, 0, "Officers: 500");
	Doc_PrintLine (nDocID, 0, "Captain: 500");
	Doc_PrintLine(nDocID,0,"----------------------");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Personal share: 1000.");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_SetFont(nDocID,1,FONT_Book);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"Merchant ship 'Nico'.");
	Doc_SetFont(nDocID,1,FONT_Book);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"Total booty: 9970.");
	Doc_PrintLine(nDocID,1,"----------------------");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine (nDocID, 1, "Crew: 5610");
	Doc_PrintLine (nDocID, 1, "Officers: 1500");
	Doc_PrintLine (nDocID, 1, "Captain: 1000");
	Doc_PrintLine(nDocID,1,"----------------------");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"Personal share: 1860.");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"Merchantman 'Maria'");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"Total booty: 7851 gold.");
	Doc_PrintLine(nDocID,1,"----------------------");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine (nDocID, 1, "Crew: 4400");
	Doc_PrintLine (nDocID, 1, "Officers: 750");
	Doc_PrintLine (nDocID, 1, "Captain: 1000");
	Doc_PrintLine(nDocID,1,"----------------------");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"Personal share: 1701.");
	Doc_Show(nDocID);
	if(Francis_HasProof == FALSE)
	{
		B_Say(self,self,"$ADDON_THISLITTLEBASTARD");
	};
	Francis_HasProof = TRUE;
};


instance ITWR_Addon_GregsLogbuch_Mis(C_Item)
{
	name = "Greg's Diary";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_01.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = UseGregsLogbuch;
};


func void UseGregsLogbuch()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Brown_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Brown_R.tga",0);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLines(nDocID,0,"I've seen more than enough of this beach. Sand everywhere. I can't even sleep right any more because everything itches. It's time that Raven forked over the gold for the prisoners and we put to sea again. I'll have to have a word with the puffed-up jerk.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "How dare that ass? He made his stinking henchmen at the gate send me away. He'll have me to reckon with! I'll turn his bootlicker Bloodwyn into fish food with my own hands.");
	Doc_PrintLines (nDocID, 0, "If he doesn't pay soon, I'll have to get tough.");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_SetFont(nDocID,1,FONT_Book);
	Doc_PrintLines(nDocID,1,"The bandits are getting brazen. They still haven't paid for the last delivery. We just don't have enough information. I have to find out what Raven wants here.");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines (nDocID, 1, "I'll take the majority of the crew to the mainland and secure the ore. Francis will stay behind with a few people and fortify the camp.");
	Doc_PrintLines (nDocID, 1, "So the time doesn't go to waste, I gave Bones the armor. He'll sneak into the bandit camp for me and find out what Raven is planning there.");
	Doc_Show(nDocID);
	Greg_GaveArmorToBones = TRUE;
};


instance ITKE_Addon_Bloodwyn_01(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = "Bloodwyn's key";
	text[0] = "Fits his chest inside the temple.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ITKE_Addon_Heiler(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_05.3ds";
	material = MAT_METAL;
	description = "A stone sentinel's key";
	text[0] = "Fits a chest";
	text[1] = "In a strange old building in the swamp.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItMi_TempelTorKey(C_Item)
{
	name = "Stone tablet of Quarhodron";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 0;
	visual = "ItMi_StonePlate_Read_06.3ds";
	material = MAT_STONE;
	scemeName = "MAP";
	on_state[0] = Use_TempelTorKey;
	description = name;
	text[0] = "The key to the temple of Adanos.";
};


func void Use_TempelTorKey()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"Maya_Stoneplate_03.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"  Jhehedra Akhantar");
	Doc_Show(nDocID);
};


instance ItMi_Addon_Bloodwyn_Kopf(C_Item)
{
	name = "Bloodwyn's Head";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItMi_Head_Bloodwyn_01.3ds";
	material = MAT_LEATHER;
	description = name;
};

instance ItMi_FakeBloodwynHead(C_Item)
{
	name = "Bloodwyn's Head";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	visual = "ItMi_Head_Bloodwyn_01.3ds";
	material = MAT_LEATHER;
	scemeName = "MAPSEALED";
	description = name;
};

instance ItWR_Addon_TreasureMap(C_Item)
{
	name = "Treasure map";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MULTI;
	value = 250;
	visual = "ItWr_Map_AW.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_TreasureMap;
	description = name;
	text[0] = "Some places are marked on the map.";
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_TreasureMap()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWR_Addon_TreasureMap);
	};
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_AddonWorld_Treasures.tga",TRUE);
	Doc_SetLevel(Document,"Addon\AddonWorld.zen");
	Doc_SetLevelCoords(Document,-47783,36300,43949,-32300);
	Doc_Show(Document);
};


instance ItMi_Addon_GregsTreasureBottle_MIS(C_Item)
{
	name = "Bottle";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItMi_Addon_GregsTreasureBottle_MIS.3DS";
	material = MAT_GLAS;
	on_state[0] = Use_GregsBottle;
	scemeName = "MAPSEALED";
	description = name;
	text[0] = "There is a piece of paper in the bottle.";
};


func void Use_GregsBottle()
{
	Snd_Play("RELEASECORK");
	B_PlayerFindItem(ItWR_Addon_TreasureMap,1);
};


instance ItMi_ErolsKelch(C_Item)
{
	name = "Scratched Silver Bowl";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 125;
	visual = "ItMi_ErolsKelch.3DS";
	material = MAT_METAL;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

