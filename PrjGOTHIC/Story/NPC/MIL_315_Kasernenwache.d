
instance MIL_315_Kasernenwache(Npc_Default)
{
	name[0] = NAME_Miliz;
	guild = GIL_MIL;
	id = 315;
	voice = 7;
	flags = 0;
	npcType = NPCTYPE_AMBIENT;
	B_SetAttributesToChapter(self,3);
	fight_tactic = FAI_HUMAN_STRONG;
	EquipItem(self,ItMw_1h_Mil_Sword);
	B_CreateAmbientInv(self);
	B_SetNpcVisual(self,MALE,"Hum_Head_Fighter",Face_N_Tough_Skip,BodyTex_N,ITAR_MIL_L);
	Mdl_SetModelFatness(self,0);
	Mdl_ApplyOverlayMds(self,"Humans_Militia.mds");
	B_GiveNpcTalents(self);
	B_SetFightSkills(self,55);
	daily_routine = Rtn_Start_315;
};


func void Rtn_Start_315()
{
	TA_Smith_Sharp(7,5,20,59,"NW_CITY_KASERN_ARMORY_SHARP");
//	TA_Sit_Campfire(20,59,0,3,"NW_CITY_BARRACK02_SMALLTALK_01");
	TA_Sit_Chair(20,59,0,3,"NW_CITY_KASERN_BARRACK02_03");
	TA_Sleep(0,3,7,5,"NW_CITY_BARRACK01_BED_RUGA");
};

func void Rtn_Hotel_315()
{
	TA_Stand_Guarding(8,0,22,0,"NW_CITY_MERCHANT_SHOP03_FRONT_02");
	TA_Stand_Guarding(22,0,8,0,"NW_CITY_MERCHANT_SHOP03_FRONT_02");
};

