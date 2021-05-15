
var int rakeplace[50];
const int RAKE_BUDDEL_DIST_MIN = 200;

const string RAKEPLACE_WP_01 = "NW_BIGFARM_LAKE_CAVE_07";
const string RAKEPLACE_WP_02 = "NW_LAKE_GREG_TREASURE_01";
const string RAKEPLACE_WP_03 = "NW_FARM3_GREGTREASURE_01";
const string RAKEPLACE_WP_04 = "NW_FARM3_MOUNTAINLAKE_MONSTER_01";
const string RAKEPLACE_WP_05 = "NW_BIGMILL_FARM3_01";
const string RAKEPLACE_WP_12 = "ADW_ENTRANCE_RAKEPLACE_01";
const string RAKEPLACE_WP_13 = "ADW_ENTRANCE_RAKEPLACE_02";
const string RAKEPLACE_WP_14 = "ADW_ENTRANCE_RAKEPLACE_03";
const string RAKEPLACE_WP_15 = "ADW_ENTRANCE_RAKEPLACE_04";
const string RAKEPLACE_WP_16 = "ADW_VALLEY_GREGTREASURE_01";
const string RAKEPLACE_WP_17 = "ADW_VALLEY_RAKEPLACE_01";
const string RAKEPLACE_WP_18 = "ADW_VALLEY_RAKEPLACE_02";
const string RAKEPLACE_WP_19 = "ADW_VALLEY_RAKEPLACE_03";
const string RAKEPLACE_WP_20 = "ADW_BANDITSCAMP_RAKEPLACE_01";
const string RAKEPLACE_WP_21 = "ADW_BANDITSCAMP_RAKEPLACE_02";
const string RAKEPLACE_WP_22 = "ADW_BANDITSCAMP_RAKEPLACE_03";
const string RAKEPLACE_WP_23 = "ADW_BANDITSCAMP_RAKEPLACE_04";
const string RAKEPLACE_WP_24 = "ADW_CANYON_MINE1_11";
const string RAKEPLACE_WP_25 = "ADW_CANYON_RAKEPLACE_01";
const string RAKEPLACE_WP_26 = "ADW_CANYON_RAKEPLACE_02";
const string RAKEPLACE_WP_27 = "ADW_CANYON_RAKEPLACE_03";
const string RAKEPLACE_WP_28 = "ADW_CANYON_RAKEPLACE_04";
const string RAKEPLACE_WP_29 = "ADW_CANYON_RAKEPLACE_05";
const string RAKEPLACE_WP_30 = "ADW_PIRATECAMP_GREGTREASURE_KOMPASS";

func void RakeTreasureSuccess(var C_Item itm)
{
	Wld_PlayEffect("spellFX_ItemAusbuddeln",itm,itm,0,0,0,FALSE);
	B_Say_Overlay(self,self,"$FOUNDTREASURE");
	B_GivePlayerXP(XP_Ambient);
};

func void B_SCUsesRake(var C_Npc slf)
{
};

func void B_SCGetTreasure_S1()
{
	if(Npc_IsPlayer(self))
	{
		if((Npc_GetDistToWP(self,RAKEPLACE_WP_01) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[1] == FALSE))
		{
			Wld_InsertItem(ItSe_GoldPocket25,RAKEPLACE_WP_01);
			RakeTreasureSuccess(ItSe_GoldPocket25);
			if(!ArmorEquipped(Greg_NW,ITAR_PIR_H_Addon))
			{
				AI_EquipArmor(Greg_NW,ITAR_PIR_H_Addon);
			};
			RAKEPLACE[1] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_02) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[2] == FALSE))
		{
			Wld_InsertItem(ItSe_GoldPocket100,RAKEPLACE_WP_02);
			RakeTreasureSuccess(ItSe_GoldPocket100);
			RAKEPLACE[2] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_03) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[3] == FALSE))
		{
			Wld_InsertItem(ItMi_GoldChalice,RAKEPLACE_WP_03);
			RakeTreasureSuccess(ItMi_GoldChalice);
			RAKEPLACE[3] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_04) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[4] == FALSE))
		{
			Wld_InsertItem(ItMi_GregsSilverPlate,RAKEPLACE_WP_04);
			RakeTreasureSuccess(ItMi_GregsSilverPlate);
			RAKEPLACE[4] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_05) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[5] == FALSE))
		{
			Wld_InsertItem(ItAm_Addon_Greg,RAKEPLACE_WP_05);
			RakeTreasureSuccess(ItAm_Addon_Greg);
			RAKEPLACE[5] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_12) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[12] == FALSE))
		{
			Wld_InsertItem(ItWr_StonePlateCommon_Addon,RAKEPLACE_WP_12);
			Wld_InsertItem(ItMi_SilverChalice,RAKEPLACE_WP_12);
			RakeTreasureSuccess(ItMi_SilverChalice);
			RAKEPLACE[12] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_13) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[13] == FALSE))
		{
			Wld_InsertItem(ItWr_DexStonePlate1_Addon,RAKEPLACE_WP_13);
			Wld_InsertItem(ItMi_GoldCup,RAKEPLACE_WP_13);
			RakeTreasureSuccess(ItMi_GoldCup);
			RAKEPLACE[13] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_14) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[14] == FALSE))
		{
			Wld_InsertItem(ItPo_Perm_Health,RAKEPLACE_WP_14);
			Wld_InsertItem(ItSe_GoldPocket100,RAKEPLACE_WP_14);
			RakeTreasureSuccess(ItSe_GoldPocket100);
			RAKEPLACE[14] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_15) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[15] == FALSE))
		{
			Wld_InsertItem(ItMi_SilverRing,RAKEPLACE_WP_15);
			Wld_InsertItem(ItMw_Schwert4,RAKEPLACE_WP_15);
			RakeTreasureSuccess(ItMw_Schwert4);
			RAKEPLACE[15] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_16) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[16] == FALSE))
		{
			Wld_InsertItem(ItSe_GoldPocket100,RAKEPLACE_WP_16);
			Wld_InsertItem(ItPo_Health_02,RAKEPLACE_WP_16);
			Wld_InsertItem(ItPo_Mana_03,RAKEPLACE_WP_16);
			RakeTreasureSuccess(ItPo_Mana_03);
			RAKEPLACE[16] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_17) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[17] == FALSE))
		{
			Wld_InsertItem(ItPo_Mana_Addon_04,RAKEPLACE_WP_17);
			Wld_InsertItem(ItPo_Speed,RAKEPLACE_WP_17);
			Wld_InsertItem(ItPo_Mana_02,RAKEPLACE_WP_17);
			RakeTreasureSuccess(ItPo_Mana_02);
			RAKEPLACE[17] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_18) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[18] == FALSE))
		{
			Wld_InsertItem(ItPo_Health_Addon_04,RAKEPLACE_WP_18);
			Wld_InsertItem(ItWr_StonePlateCommon_Addon,RAKEPLACE_WP_18);
			Wld_InsertItem(ItSe_LockpickFisch,RAKEPLACE_WP_18);
			RakeTreasureSuccess(ItSe_LockpickFisch);
			RAKEPLACE[18] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_19) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[19] == FALSE))
		{
			Wld_InsertItem(ItSc_Firerain,RAKEPLACE_WP_19);
			Wld_InsertItem(ItWr_StonePlateCommon_Addon,RAKEPLACE_WP_19);
			Wld_InsertItem(ItSe_GoldPocket50,RAKEPLACE_WP_19);
			RakeTreasureSuccess(ItSe_GoldPocket50);
			RAKEPLACE[19] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_20) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[20] == FALSE))
		{
			Wld_InsertItem(ItMi_Honigtabak,RAKEPLACE_WP_20);
			Wld_InsertItem(ItWr_StonePlateCommon_Addon,RAKEPLACE_WP_20);
			Wld_InsertItem(ItAm_Addon_MANA,RAKEPLACE_WP_20);
			RakeTreasureSuccess(ItAm_Addon_MANA);
			RAKEPLACE[20] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_21) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[21] == FALSE))
		{
			Wld_InsertItem(ItSc_SumGobSkel,RAKEPLACE_WP_21);
			Wld_InsertItem(ItPo_Mana_03,RAKEPLACE_WP_21);
			RakeTreasureSuccess(ItPo_Mana_03);
			RAKEPLACE[21] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_22) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[22] == FALSE))
		{
			Wld_InsertItem(ItSc_TrfShadowbeast,RAKEPLACE_WP_22);
			Wld_InsertItem(ItSc_LightHeal,RAKEPLACE_WP_22);
			RakeTreasureSuccess(ItSc_LightHeal);
			RAKEPLACE[22] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_23) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[23] == FALSE))
		{
			Wld_InsertItem(ItWr_StonePlateCommon_Addon,RAKEPLACE_WP_23);
			Wld_InsertItem(ItRi_HP_01,RAKEPLACE_WP_23);
			RakeTreasureSuccess(ItRi_HP_01);
			RAKEPLACE[23] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_24) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[24] == FALSE))
		{
			Wld_InsertItem(ItSE_Addon_FrancisChest,RAKEPLACE_WP_24);
			RakeTreasureSuccess(ItSE_Addon_FrancisChest);
			RAKEPLACE[24] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_25) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[25] == FALSE))
		{
			Wld_InsertItem(ItMi_RuneBlank,RAKEPLACE_WP_25);
			Wld_InsertItem(ItSe_GoldPocket25,RAKEPLACE_WP_25);
			RakeTreasureSuccess(ItSe_GoldPocket25);
			RAKEPLACE[25] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_26) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[26] == FALSE))
		{
			Wld_InsertItem(ItMi_Nugget,RAKEPLACE_WP_26);
			Wld_InsertItem(ItSc_LightningFlash,RAKEPLACE_WP_26);
			Wld_InsertItem(ItSc_ChargeFireBall,RAKEPLACE_WP_26);
			RakeTreasureSuccess(ItSc_ChargeFireBall);
			RAKEPLACE[26] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_27) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[27] == FALSE))
		{
			Wld_InsertItem(ItSe_GoldPocket25,RAKEPLACE_WP_27);
			Wld_InsertItem(ItWr_ManaStonePlate1_Addon,RAKEPLACE_WP_27);
			Wld_InsertItem(ItMi_Pitch,RAKEPLACE_WP_27);
			RakeTreasureSuccess(ItMi_Pitch);
			RAKEPLACE[27] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_28) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[28] == FALSE))
		{
			Wld_InsertItem(ItMi_SilverRing,RAKEPLACE_WP_28);
			Wld_InsertItem(ItMi_Sulfur,RAKEPLACE_WP_28);
			Wld_InsertItem(ItWr_TwoHStonePlate1_Addon,RAKEPLACE_WP_28);
			RakeTreasureSuccess(ItWr_TwoHStonePlate1_Addon);
			RAKEPLACE[28] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_29) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[29] == FALSE))
		{
			Wld_InsertItem(ItMi_GoldRing,RAKEPLACE_WP_29);
			Wld_InsertItem(ItAt_DragonBlood,RAKEPLACE_WP_29);
			RakeTreasureSuccess(ItAt_DragonBlood);
			RAKEPLACE[29] = TRUE;
		}
		else if((Npc_GetDistToWP(self,RAKEPLACE_WP_30) < RAKE_BUDDEL_DIST_MIN) && (RAKEPLACE[30] == FALSE))
		{
			Wld_InsertItem(ItMI_Addon_Kompass_Mis,RAKEPLACE_WP_30);
			RakeTreasureSuccess(ItMI_Addon_Kompass_Mis);
			RAKEPLACE[30] = TRUE;
		}
		else
		{
			player_plunder_is_empty();
		};
	};
};

