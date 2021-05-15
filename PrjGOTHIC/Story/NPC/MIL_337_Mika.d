
instance MIL_337_Mika(Npc_Default)
{
	name[0] = "����";
	guild = GIL_MIL;
	id = 337;
	voice = 14;
	flags = 0;
	npcType = npctype_main;
	B_SetAttributesToChapter(self,1);
	fight_tactic = FAI_HUMAN_STRONG;
	EquipItem(self,ItMw_1h_Mil_Sword);
	CreateInvItems(self,ItPo_Health_01,4);
	B_CreateAmbientInv(self);
	B_SetNpcVisual(self,MALE,"Hum_Head_Fatbald",Face_L_ToughBart_Quentin,BodyTex_L,ITAR_MIL_L);
	Mdl_SetModelFatness(self,2);
	Mdl_ApplyOverlayMds(self,"Humans_Militia.mds");
	B_GiveNpcTalents(self);
	B_SetFightSkills(self,30);
	daily_routine = Rtn_Start_337;
};


func void Rtn_Start_337()
{
	TA_Stand_Guarding(8,0,22,0,"NW_CITY_TO_FOREST_01");
//	TA_Stand_Guarding(22,0,8,0,"NW_CITY_TO_FOREST_01");
	TA_Sit_Campfire(22,0,0,10,"NW_CITY_BARRACK02_SMALLTALK_01");
	TA_Sit_Chair(0,10,8,0,"NW_CITY_KASERN_BARRACK02_03");
};

func void Rtn_Akil_337()
{
	TA_Guide_Player(6,0,18,0,"NW_FARM2_PATH_03");
	TA_Guide_Player(18,0,6,0,"NW_FARM2_PATH_03");
};

