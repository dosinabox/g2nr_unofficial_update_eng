
func void evt_truhe_ow_01_s1()
{
	if(TruheSfx == FALSE)
	{
		Wld_InsertNpc(Gobbo_Black,"FP_ROAM_OW_MOLERAT_03_02");
		Wld_InsertNpc(Gobbo_Black,"FP_ROAM_OW_MOLERAT_03_03");
		Wld_InsertNpc(Gobbo_Black,"FP_ROAM_OW_MOLERAT_03_04");
		Wld_InsertNpc(Gobbo_Black,"FP_ROAM_OW_MOLERAT_03_05");
		Wld_InsertNpc(OrcWarrior_Rest,"SPAWN_OW_MOLERAT_03_04");
		Snd_Play("ORC_ANGRY");
		TruheSfx = TRUE;
	};
};

