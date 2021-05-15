
instance VLK_462_Thorben(Npc_Default)
{
	name[0] = "������";
	guild = GIL_VLK;
	id = 462;
	voice = 6;
	flags = 0;
	npcType = npctype_main;
	aivar[AIV_NPCIsTrader] = TRUE;
	B_SetAttributesToChapter(self,2);
	fight_tactic = FAI_HUMAN_COWARD;
	EquipItem(self,ItMw_1h_Bau_Mace);
//	B_CreateAmbientInv(self);
//	CreateInvItems(self,ItKe_Lockpick,12);
	B_SetNpcVisual(self,MALE,"Hum_Head_Bald",Face_N_Normal04,BodyTex_N,ITAR_Vlk_L);
	Mdl_SetModelFatness(self,1);
	Mdl_ApplyOverlayMds(self,"Humans_Relaxed.mds");
	B_GiveNpcTalents(self);
	B_SetFightSkills(self,30);
	daily_routine = Rtn_Start_462;
};


func void Rtn_Start_462()
{
	TA_Saw(6,0,9,0,"NW_CITY_MAINSTREET_05_B");
	TA_Repair_Hut(9,0,13,0,"NW_CITY_MERCHANT_SHOP01_FRONT_01");
	TA_Smalltalk(13,0,14,2,"NW_CITY_MERCHANT_SHOP01_FRONT_01");
	TA_Repair_Hut(14,2,16,0,"NW_CITY_MERCHANT_SHOP01_FRONT_01");
	TA_Saw(16,0,17,5,"NW_CITY_MAINSTREET_05_B");
	TA_Smalltalk(17,5,18,0,"NW_CITY_MERCHANT_SHOP01_FRONT_01");
	TA_Saw(18,0,19,0,"NW_CITY_MAINSTREET_05_B");
	TA_Repair_Hut(19,0,20,0,"NW_CITY_MERCHANT_SHOP01_FRONT_01");
	TA_Sit_Bench(20,0,0,0,"NW_CITY_MERCHANT_HUT_01_FRONT");
	TA_Sleep(0,0,6,0,"NW_CITY_BED_BOSPER");
};


