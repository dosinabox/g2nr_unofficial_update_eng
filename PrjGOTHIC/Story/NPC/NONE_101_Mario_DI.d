
instance NONE_101_Mario_DI(Npc_Default)
{
	name[0] = "�����";
	guild = GIL_NONE;
	id = 1010;
	voice = 7;
	flags = 0;
	npcType = npctype_main;
	aivar[AIV_ToughGuy] = TRUE;
	aivar[AIV_ToughGuyNewsOverride] = TRUE;
	aivar[AIV_EnemyOverride] = TRUE;
	aivar[AIV_MagicUser] = MAGIC_NEVER;
	B_SetAttributesToChapter(self,6);
	fight_tactic = FAI_HUMAN_MASTER;
	EquipItem(self,ItMw_Sturmbringer);
	B_CreateAmbientInv(self);
	B_SetNpcVisual(self,MALE,"Hum_Head_FatBald",Face_B_Normal_Kirgo,BodyTex_B,ITAR_MIL_M);
	Mdl_SetModelFatness(self,1.2);
	Mdl_ApplyOverlayMds(self,"Humans_MILITIA.mds");
	B_GiveNpcTalents(self);
	B_SetFightSkills(self,95);
	daily_routine = Rtn_Start_1010;
};


func void Rtn_Start_1010()
{
	TA_Sit_Bench(8,0,23,0,"SHIP_DECK_25");
	TA_Practice_Sword(23,0,8,0,"SHIP_DECK_24");
};

func void Rtn_OrkSturmDI_1010()
{
	TA_Stand_ArmsCrossed(8,0,23,0,"DI_MARIO_AMBUSH");
	TA_Stand_ArmsCrossed(23,0,8,0,"DI_MARIO_AMBUSH");
};

