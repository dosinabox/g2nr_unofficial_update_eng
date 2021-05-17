
var int EVT_ARCHOLDEAD_FUNC_OneTime;

func void evt_archoldead_func()
{
	if(Npc_IsDead(Archol))
	{
		if(!Npc_IsDead(Skeleton_Archol1))
		{
			Skeleton_Archol1.aivar[AIV_EnemyOverride] = FALSE;
		};
		if(!Npc_IsDead(Skeleton_Archol2))
		{
			Skeleton_Archol2.aivar[AIV_EnemyOverride] = FALSE;
		};
		if(!Npc_IsDead(Skeleton_Archol3))
		{
			Skeleton_Archol3.aivar[AIV_EnemyOverride] = FALSE;
		};
		if(!Npc_IsDead(Skeleton_Archol4))
		{
			Skeleton_Archol4.aivar[AIV_EnemyOverride] = FALSE;
		};
		if(!Npc_IsDead(Skeleton_Archol5))
		{
			Skeleton_Archol5.aivar[AIV_EnemyOverride] = FALSE;
		};
		if(!Npc_IsDead(Skeleton_Archol6))
		{
			Skeleton_Archol6.aivar[AIV_EnemyOverride] = FALSE;
		};
	};
	if(EVT_ARCHOLDEAD_FUNC_OneTime == FALSE)
	{
		B_LogEntry (TOPIC_HallenVonIrdorath, "I've found something like a temple here. It is inhabited by a lot of undead beings. This all reminds me a lot of the damned orc temple of the Sleeper. This time I will not fail. Not this time!");
		EVT_ARCHOLDEAD_FUNC_OneTime = TRUE;
	};
};

