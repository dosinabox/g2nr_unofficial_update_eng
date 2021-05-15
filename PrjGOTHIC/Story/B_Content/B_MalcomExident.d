
func void B_MalcomExident()
{
	if(Malcom_Accident == FALSE)
	{
		if(!Npc_IsDead(Malcom))
		{
			B_StartOtherRoutine(Malcom,"Start");
			AI_Teleport(Malcom,"ADW_PIRATECAMP_SECRETCAVE_02");
			CreateInvItem(Malcom,ItMi_OldCoin);
			Npc_ChangeAttribute(Malcom,ATR_HITPOINTS,-Malcom.attribute[ATR_HITPOINTS_MAX]);
			Wld_InsertNpc(Lurker_SecretCave1,"ADW_PIRATECAMP_SECRETCAVE_01");
			Wld_InsertNpc(Lurker_SecretCave2,"ADW_PIRATECAMP_SECRETCAVE_01");
			if(!Npc_IsDead(Owen))
			{
				B_StartOtherRoutine(Owen,"Start");
			};
			Malcom_Accident_Deadly = TRUE;
		};
		Malcom_Accident = TRUE;
	};
};

