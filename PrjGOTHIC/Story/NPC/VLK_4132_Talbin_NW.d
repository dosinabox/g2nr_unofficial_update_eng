
instance VLK_4132_Talbin_NW(Npc_Default)
{
	name[0] = "Talbin";
	guild = GIL_OUT;
	id = 4132;
	voice = 7;
	flags = 0;
	npcType = NPCTYPE_FRIEND;
	B_SetAttributesToChapter(self,3);
	fight_tactic = FAI_HUMAN_STRONG;
	EquipItem(self,ItMw_1h_Sld_Sword);
	EquipItem(self,ItRw_Sld_Bow);
	B_CreateAmbientInv(self);
	B_SetNpcVisual(self,MALE,"Hum_Head_FatBald",Face_N_Bullit,BodyTex_N,ITAR_Leather_L);
	Mdl_SetModelFatness(self,0);
	Mdl_ApplyOverlayMds(self,"Humans_Relaxed.mds");
	B_GiveNpcTalents(self);
	B_SetFightSkills(self,30);
	daily_routine = Rtn_PreStart_4132;
};


func void Rtn_PreStart_4132()
{
	/*TA_Stand_Eating(8,0,23,0,"LEVELCHANGE");
	TA_Stand_Drinking(23,0,8,0,"LEVELCHANGE");*/
	TA_Follow_Player(8,0,23,0,"NW_PASS_SECRET_17");
	TA_Follow_Player(23,0,8,0,"NW_PASS_SECRET_17");
};

func void Rtn_Farm_4132()
{
	TA_Sit_Bench(8,0,21,0,"NW_FARM2_OUT_06");
	TA_Stand_Eating(21,0,8,0,"NW_FARM2_OUT_07");
};

