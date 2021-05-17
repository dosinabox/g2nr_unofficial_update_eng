
instance VLK_417_Constantino(Npc_Default)
{
	name[0] = "Constantino";
	guild = GIL_VLK;
	id = 417;
	voice = 10;
	flags = 0;
	npcType = npctype_main;
	aivar[AIV_NPCIsTrader] = TRUE;
	B_SetAttributesToChapter(self,4);
	self.attribute[ATR_DEXTERITY] = 1;
	fight_tactic = FAI_HUMAN_COWARD;
	EquipItem(self,ItMw_1h_Bau_Axe);
	B_SetNpcVisual(self,MALE,"Hum_Head_Psionic",Face_N_OldBald_Jeremiah,BodyTex_N,ITAR_Smith);
	Mdl_SetModelFatness(self,0);
	Mdl_ApplyOverlayMds(self,"Humans_Tired.mds");
	B_GiveNpcTalents(self);
	B_SetFightSkills(self,35);
	daily_routine = Rtn_Start_417;
};


func void Rtn_Start_417()
{
	TA_Potion_Alchemy(10,0,22,0,"NW_CITY_ALCHEMY_VELAX");
	TA_Sleep(22,0,8,0,"NW_CITY_BED_VELAX");
	TA_Read_Bookstand(8,0,10,0,"NW_CITY_BOOK_VELAX");
};

