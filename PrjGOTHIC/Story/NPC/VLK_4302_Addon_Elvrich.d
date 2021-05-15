
instance VLK_4302_Addon_Elvrich(Npc_Default)
{
	name[0] = "������";
	guild = GIL_VLK;
	id = 4302;
	voice = 4;
	flags = NPC_FLAG_IMMORTAL;
	npcType = npctype_main;
	aivar[AIV_IgnoresFakeGuild] = TRUE;
	aivar[AIV_IgnoresArmor] = TRUE;
	aivar[AIV_NoFightParker] = TRUE;
	aivar[AIV_ToughGuy] = TRUE;
	B_SetAttributesToChapter(self,2);
	fight_tactic = FAI_HUMAN_COWARD;
//	CreateInvItem(self,ItMw_1h_Vlk_Axe);
	B_CreateAmbientInv(self);
	B_SetNpcVisual(self,MALE,"Hum_Head_Pony",Face_B_Normal01,BodyTex_B,ITAR_Bau_L);
	Mdl_SetModelFatness(self,0);
	Mdl_ApplyOverlayMds(self,"Humans_Relaxed.mds");
	B_GiveNpcTalents(self);
	B_SetFightSkills(self,30);
	daily_routine = Rtn_Start_4302;
};


func void Rtn_Start_4302()
{
	TA_Sit_Campfire(8,0,23,0,"NW_BIGMILL_FARM3_RANGERBANDITS_ELVRICH");
	TA_Sit_Campfire(23,0,8,0,"NW_BIGMILL_FARM3_RANGERBANDITS_ELVRICH");
};

func void Rtn_BackInTheCity_4302()
{
	TA_Repair_Hut(6,0,9,0,"NW_CITY_MERCHANT_SHOP01_FRONT_01");
	TA_Saw(9,0,13,0,"NW_CITY_MAINSTREET_05_B");
	TA_Repair_Hut(13,0,14,2,"NW_CITY_MERCHANT_SHOP01_FRONT_01");
	TA_Saw(14,2,16,0,"NW_CITY_MAINSTREET_05_B");
	TA_Repair_Hut(16,0,19,0,"NW_CITY_MERCHANT_SHOP01_FRONT_01");
	TA_Saw(19,0,20,0,"NW_CITY_MAINSTREET_05_B");
	TA_Repair_Hut(20,0,0,0,"NW_CITY_MERCHANT_SHOP01_FRONT_01");
	TA_Sit_Throne(0,0,6,0,"NW_CITY_CHAIR_BOSPER");
};

