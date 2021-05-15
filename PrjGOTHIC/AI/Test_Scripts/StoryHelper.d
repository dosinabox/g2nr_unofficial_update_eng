
/*instance ItPo_Story(C_Item)
{
	name = "�������";
	mainflag = ITEM_KAT_POTIONS;
	flags = ITEM_MULTI;
	visual = "ItPo_Perm_STR.3ds";
	material = MAT_GLAS;
	on_state[0] = UseItPo_Story;
	scemeName = "POTIONFAST";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = name;
	text[0] = "����� Raven Video I";
};


func void UseItPo_Story()
{
	b_ravensescapeintotempelavi();
};*/


instance SH(Npc_Default)
{
	name[0] = "�������� �� ������";
	guild = GIL_NONE;
	id = 9999;
	voice = 15;
	flags = 0;
	npcType = NPCTYPE_FRIEND;
	aivar[AIV_IgnoresArmor] = TRUE;
	B_SetAttributesToChapter(self,1);
	B_GiveNpcTalents(self);
	fight_tactic = FAI_HUMAN_MASTER;
	B_CreateAmbientInv(self);
	B_SetNpcVisual(self,MALE,"Hum_Head_Pony",Face_N_Player,BodyTex_Player_Sequel,NO_ARMOR);
	Mdl_SetModelFatness(self,0);
	Mdl_ApplyOverlayMds(self,"Humans_Relaxed.mds");
	daily_routine = Rtn_Start_9999;
};


func void Rtn_Start_9999()
{
	TA_Stand_ArmsCrossed(8,0,23,0,"XXX");
	TA_Stand_ArmsCrossed(23,0,8,0,"XXX");
};


instance StoryHelper_Exit(C_Info)
{
	npc = sh;
	nr = 999;
	condition = StoryHelper_Exit_Condition;
	information = StoryHelper_Exit_Info;
	important = FALSE;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int StoryHelper_Exit_Condition()
{
	return TRUE;
};

func void StoryHelper_Exit_Info()
{
	AI_StopProcessInfos(self);
};
	
instance StoryHelper_PatchSettings(C_Info)
{
	npc = sh;
//	npc = NONE_100_Xardas;
	nr = 995;
	condition = StoryHelper_PatchSettings_Condition;
	information = StoryHelper_PatchSettings_Info;
	important = FALSE;
	permanent = TRUE;
	description = "(��������� �������������� ����������)";
};


func int StoryHelper_PatchSettings_Condition()
{
	return TRUE;
};

func void StoryHelper_PatchSettings_Info()
{
	b_build_settings_diag();
};


instance StoryHelper_INFO1(C_Info)
{
	npc = sh;
	condition = StoryHelper_INFO1_Condition;
	information = StoryHelper_INFO1_Info;
	important = FALSE;
	permanent = TRUE;
	description = KapWechsel_1;
};


func int StoryHelper_INFO1_Condition()
{
	return TRUE;
};

func void StoryHelper_INFO1_Info()
{
	Info_ClearChoices(StoryHelper_INFO1);
	Info_AddChoice(StoryHelper_INFO1,Dialog_Back,StoryHelper_BACK1);
	Info_AddChoice(StoryHelper_INFO1,KapAnfang,StoryHelper_KAPITEL1ANFANG);
	Info_AddChoice(StoryHelper_INFO1,"����� ����� � ������ ������� � ��������� (������ � ������)",StoryHelper_SATURAS);
	Info_AddChoice(StoryHelper_INFO1,"����� ��� � ����������",StoryHelper_Cavalorn);
};

func void StoryHelper_SATURAS()
{
	MIS_Addon_Lares_Ornament2Saturas = LOG_Running;
	CreateInvItems(other,ItMi_Ornament_Addon,1);
	SC_KnowsRanger = TRUE;
	B_Kapitelwechsel(1,NEWWORLD_ZEN);
	AI_StopProcessInfos(self);
};

func void StoryHelper_Cavalorn()
{
	B_Kapitelwechsel(1,NEWWORLD_ZEN);
	//�������� ������ ��� �������
	MIS_Addon_Cavalorn_Letter2Vatras = LOG_SUCCESS;
	//������ ��������, ����������� ������ ��������
	MIS_Vatras_FindTheBanditTrader = LOG_SUCCESS;
	//��� �� ��������� ����?
	MIS_Addon_Vatras_WhereAreMissingPeople = LOG_SUCCESS;
	//������ ����� :)
	CreateInvItems(hero,ItRi_Ranger_Addon,1);
	//����� �������� �����
	MIS_Addon_Nefarius_BringMissingOrnaments = LOG_RUNNING;
	//...� �������� ���������� � ���� �� ���
	B_StartotherRoutine(Cavalorn,"OrnamentSteinring");
	//����� ������� ����� ������
	CreateInvItems(hero,ItWr_Map_NewWorld_Ornaments_Addon,1);
	AI_StopProcessInfos(self);
};

func void StoryHelper_BACK1()
{
	Info_ClearChoices(StoryHelper_INFO1);
};

func void StoryHelper_KAPITEL1ANFANG()
{
	B_Kapitelwechsel(1,NEWWORLD_ZEN);
	AI_StopProcessInfos(self);
};


instance StoryHelper_INFO2(C_Info)
{
	npc = sh;
	condition = StoryHelper_INFO2_Condition;
	information = StoryHelper_INFO2_Info;
	important = FALSE;
	permanent = TRUE;
	description = KapWechsel_2;
};


func int StoryHelper_INFO2_Condition()
{
	return TRUE;
};

func void StoryHelper_INFO2_Info()
{
	Info_ClearChoices(StoryHelper_INFO2);
	Info_AddChoice(StoryHelper_INFO2,Dialog_Back,StoryHelper_BACK2);
	Info_AddChoice(StoryHelper_INFO2,KapAnfang,StoryHelper_KAPITEL2ANFANG);
};

func void StoryHelper_BACK2()
{
	Info_ClearChoices(StoryHelper_INFO2);
};

func void StoryHelper_KAPITEL2ANFANG()
{
	Torwache_305.aivar[AIV_PASSGATE] = TRUE;
	Mil_305_schonmalreingelassen = TRUE;
	B_StartOtherRoutine(Lothar,"START");
	CreateInvItems(hero,ItKe_Pass_MIS,1);
	MIS_OLDWORLD = LOG_Running;
	B_Kapitelwechsel(2,NEWWORLD_ZEN);
	Info_ClearChoices(StoryHelper_INFO2);
	AI_StopProcessInfos(self);
};


instance StoryHelper_INFO3(C_Info)
{
	npc = sh;
	condition = StoryHelper_INFO3_Condition;
	information = StoryHelper_INFO3_Info;
	important = FALSE;
	permanent = TRUE;
	description = KapWechsel_3;
};


func int StoryHelper_INFO3_Condition()
{
	return TRUE;
};

func void StoryHelper_INFO3_Info()
{
	Info_ClearChoices(StoryHelper_INFO3);
	Info_AddChoice(StoryHelper_INFO3,Dialog_Back,StoryHelper_BACK3);
	Info_AddChoice(StoryHelper_INFO3,KapAnfang,StoryHelper_KAPITEL3ANFANG);
};

func void StoryHelper_BACK3()
{
	Info_ClearChoices(StoryHelper_INFO3);
};

func void StoryHelper_KAPITEL3ANFANG()
{
	MIS_OLDWORLD = LOG_Running;
	CreateInvItems(hero,ItWr_PaladinLetter_MIS,1);
	KnowsPaladins_Ore = TRUE;
	MIS_ScoutMine = LOG_SUCCESS;
	MIS_ReadyForChapter3 = TRUE;
	B_NPC_IsAliveCheck(OLDWORLD_ZEN);
	B_Kapitelwechsel(3,NEWWORLD_ZEN);
	Info_ClearChoices(StoryHelper_INFO3);
	AI_StopProcessInfos(self);
};


instance StoryHelper_INFO4(C_Info)
{
	npc = sh;
	condition = StoryHelper_INFO4_Condition;
	information = StoryHelper_INFO4_Info;
	important = FALSE;
	permanent = TRUE;
	description = KapWechsel_4;
};


func int StoryHelper_INFO4_Condition()
{
	return TRUE;
};

func void StoryHelper_INFO4_Info()
{
	Info_ClearChoices(StoryHelper_INFO4);
	Info_AddChoice(StoryHelper_INFO4,Dialog_Back,StoryHelper_BACK4);
	Info_AddChoice(StoryHelper_INFO4,KapAnfang,StoryHelper_KAPITEL4ANFANG);
};

func void StoryHelper_BACK4()
{
	Info_ClearChoices(StoryHelper_INFO4);
};

func void StoryHelper_KAPITEL4ANFANG()
{
	MIS_OLDWORLD = LOG_Running;
	CreateInvItems(hero,ItWr_PaladinLetter_MIS,1);
	KnowsPaladins_Ore = TRUE;
	MIS_ScoutMine = LOG_SUCCESS;
	MIS_ReadyForChapter3 = TRUE;
	B_NPC_IsAliveCheck(OLDWORLD_ZEN);
	B_Kapitelwechsel(3,NEWWORLD_ZEN);
	PLAYER_TALENT_ALCHEMY[CHARGE_Innoseye] = TRUE;
	PrintScreen(PRINT_LearnAlchemyInnosEye,-1,-1,FONT_Screen,2);
	CreateInvItems(hero,ItMi_InnosEye_MIS,1);
	MIS_ReadyforChapter4 = TRUE;
	B_NPC_IsAliveCheck(NEWWORLD_ZEN);
	B_Kapitelwechsel(4,NEWWORLD_ZEN);
	Info_ClearChoices(StoryHelper_INFO4);
	AI_StopProcessInfos(self);
};


instance StoryHelper_INFO5(C_Info)
{
	npc = sh;
	condition = StoryHelper_INFO5_Condition;
	information = StoryHelper_INFO5_Info;
	important = FALSE;
	permanent = TRUE;
	description = KapWechsel_5;
};


func int StoryHelper_INFO5_Condition()
{
	return TRUE;
};

func void StoryHelper_INFO5_Info()
{
	Info_ClearChoices(StoryHelper_INFO5);
	Info_AddChoice(StoryHelper_INFO5,Dialog_Back,StoryHelper_BACK5);
	Info_AddChoice(StoryHelper_INFO5,KapAnfang,StoryHelper_KAPITEL5ANFANG);
};

func void StoryHelper_BACK5()
{
	Info_ClearChoices(StoryHelper_INFO5);
};

func void StoryHelper_KAPITEL5ANFANG()
{
	MIS_OLDWORLD = LOG_Running;
	CreateInvItems(hero,ItWr_PaladinLetter_MIS,1);
	KnowsPaladins_Ore = TRUE;
	MIS_ScoutMine = LOG_SUCCESS;
	MIS_ReadyForChapter3 = TRUE;
	B_NPC_IsAliveCheck(OLDWORLD_ZEN);
	B_Kapitelwechsel(3,NEWWORLD_ZEN);
	PLAYER_TALENT_ALCHEMY[CHARGE_Innoseye] = TRUE;
	PrintScreen(PRINT_LearnAlchemyInnosEye,-1,-1,FONT_Screen,2);
	CreateInvItems(hero,ItMi_InnosEye_MIS,1);
	MIS_ReadyforChapter4 = TRUE;
	B_NPC_IsAliveCheck(NEWWORLD_ZEN);
	B_Kapitelwechsel(4,NEWWORLD_ZEN);
	CreateInvItems(hero,ItAt_IcedragonHeart,1);
	MIS_AllDragonsDead = TRUE;
	B_Kapitelwechsel(5,NEWWORLD_ZEN);
	Info_ClearChoices(StoryHelper_INFO5);
	AI_StopProcessInfos(self);
};


instance StoryHelper_INFO6(C_Info)
{
	npc = sh;
	condition = StoryHelper_INFO6_Condition;
	information = StoryHelper_INFO6_Info;
	important = FALSE;
	permanent = TRUE;
	description = KapWechsel_6;
};


func int StoryHelper_INFO6_Condition()
{
	return TRUE;
};

func void StoryHelper_INFO6_Info()
{
	Info_ClearChoices(StoryHelper_INFO6);
	Info_AddChoice(StoryHelper_INFO6,Dialog_Back,StoryHelper_BACK6);
	Info_AddChoice(StoryHelper_INFO6,KapAnfang,StoryHelper_KAPITEL6ANFANG);
};

func void StoryHelper_BACK6()
{
	Info_ClearChoices(StoryHelper_INFO6);
};

func void StoryHelper_KAPITEL6ANFANG()
{
	B_Kapitelwechsel(6,NEWWORLD_ZEN);
	Info_ClearChoices(StoryHelper_INFO6);
	AI_StopProcessInfos(self);
};

