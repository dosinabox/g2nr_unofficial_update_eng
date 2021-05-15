
instance STRF_1126_Addon_Telbor_NW(Npc_Default)
{
	name[0] = "������";
	guild = GIL_OUT;
	id = 1126;
	voice = 12;
	flags = 0;
	npcType = npctype_main;
	aivar[AIV_IgnoresArmor] = TRUE;
	B_SetAttributesToChapter(self,2);
	fight_tactic = FAI_HUMAN_COWARD;
	EquipItem(self,ItMw_1h_Bau_Axe);
	B_CreateAmbientInv(self);
	B_SetNpcVisual(self,MALE,"Hum_Head_Fatbald",Face_B_Normal01,BodyTex_B,ITAR_Bau_L);
	Mdl_SetModelFatness(self,2);
	Mdl_ApplyOverlayMds(self,"Humans_Tired.mds");
	B_GiveNpcTalents(self);
	B_SetFightSkills(self,30);
	daily_routine = Rtn_Start_1126;
};


func void Rtn_Start_1126()
{
	TA_Rake_FP(5,0,21,0,"NW_FARM2_FIELD_TELBOR");
	TA_Stand_Drinking(21,0,5,0,"NW_FARM2_OUT_10");
};

