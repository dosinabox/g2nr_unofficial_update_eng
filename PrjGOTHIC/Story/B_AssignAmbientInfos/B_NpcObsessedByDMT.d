
var int NpcObsessedByDMT;
var int NpcObsessedByDMT_Brutus;
var int NpcObsessedByDMT_Engrom;
var int NpcObsessedByDMT_Vino;
var int NpcObsessedByDMT_Malak;
var int NpcObsessedByDMT_Fernando;
var int NpcObsessedByDMT_Bromor;
var int NpcObsessedByDMT_Sekob;
var int NpcObsessedByDMT_Randolph;

func void B_DMTWurm()
{
	AI_Output (self, other, "DIA_NoName_ObsessedByDMT_19_00");	//We see you, worm. You cannot escape us.
};

func void B_NpcClearObsessionByDMT(var C_Npc medium)
{
	AI_StopProcessInfos(medium);
	if(NpcObsessedByDMT == TRUE)
	{
		AI_EquipBestMeleeWeapon(medium);
		AI_EquipBestRangedWeapon(medium);
		if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Sekob))
		{
			AI_EquipArmor(medium,ITAR_Vlk_H);
		};
		if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Randolph))
		{
			AI_EquipArmor(medium,ITAR_Bau_L);
		};
		if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Vino))
		{
			AI_EquipArmor(medium,ITAR_Bau_L);
		};
		if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Malak))
		{
			AI_EquipArmor(medium,ITAR_Bau_M);
		};
		if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Fernando))
		{
			AI_EquipArmor(medium,ITAR_Governor);
		};
		if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Brutus))
		{
			AI_EquipArmor(medium,ITAR_MIL_L);
		};
		if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Engrom))
		{
			AI_EquipArmor(medium,ITAR_Leather_L);
		};
		if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Bromor))
		{
			AI_EquipArmor(medium,ITAR_Vlk_H);
		};
		NpcObsessedByDMT = FALSE;
		medium.flags = 0;
		Npc_SetTempAttitude(medium,ATT_ANGRY);
		B_Attack(medium,other,AR_NONE,1);
		Wld_StopEffect("DEMENTOR_FX");
		Snd_Play("MFX_FEAR_CAST");
		B_SCIsObsessed(medium);
		if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Malak))
		{
			Npc_SetTarget(BAU_962_Bauer,medium);
			AI_StartState(BAU_962_Bauer,ZS_Flee,0,"");
			Npc_SetTarget(BAU_964_Bauer,medium);
			AI_StartState(BAU_964_Bauer,ZS_Flee,0,"");
			Npc_SetTarget(BAU_965_Bauer,medium);
			AI_StartState(BAU_965_Bauer,ZS_Flee,0,"");
			Npc_SetTarget(BAU_966_Bauer,medium);
			AI_StartState(BAU_966_Bauer,ZS_Flee,0,"");
			Npc_SetTarget(BAU_967_Bauer,medium);
			AI_StartState(BAU_967_Bauer,ZS_Flee,0,"");
			Npc_SetTarget(BAU_968_Bauer,medium);
			AI_StartState(BAU_968_Bauer,ZS_Flee,0,"");
			Npc_SetTarget(BAU_969_Bauer,medium);
			AI_StartState(BAU_969_Bauer,ZS_Flee,0,"");
		};
	};
};

func void B_NpcObsessedByDMT(var C_Npc medium)
{
	if(NpcObsessedByDMT == FALSE)
	{
		Wld_PlayEffect("DEMENTOR_FX",hero,hero,0,0,0,FALSE);
		AI_UnequipWeapons(medium);
		CreateInvItems(medium,ITAR_Dementor,1);
//		AI_UnequipArmor(medium);
		AI_EquipArmor(medium,ITAR_Dementor);
		AI_PlayAni(medium,"T_PRACTICEMAGIC5");
		Wld_PlayEffect("spellFX_Fear",medium,medium,0,0,0,FALSE);
		NpcObsessedByDMT = TRUE;
/*		if(!Npc_HasItems(medium,ITWR_DementorObsessionBook_MIS))
		{
			CreateInvItems(medium,ITWR_DementorObsessionBook_MIS,1);
		}; */
		if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Brutus))
		{
			if(MIS_OCGateOpen == TRUE)
			{
				AI_Output (self, other, "DIA_Brutus_ObsessedByDMT_19_00");	//Opening the gate was a great service for our Master, puny mortal. We shall erect a shrine in his honor on your grave.
			}
			else
			{
				B_DMTWurm();
			};
			NpcObsessedByDMT_Brutus = TRUE;
		}
		else if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Engrom))
		{
			AI_Output (self, other, "DIA_Engrom_ObsessedByDMT_19_00");	//Turn back. Before it is too late for you.
			NpcObsessedByDMT_Engrom = TRUE;
		}
		else if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Vino))
		{
			AI_Output (self, other, "DIA_Vino_ObsessedByDMT_19_00");	//Soon we shall command them all. You and your pathetic magic skills are no danger to us.
			NpcObsessedByDMT_Vino = TRUE;
		}
		else if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Malak))
		{
			AI_Output (self, other, "DIA_Malak_ObsessedByDMT_19_00");	//You will not be able to save this soul, magician. He will never return to his own.
			NpcObsessedByDMT_Malak = TRUE;
		}
		else if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Sekob))
		{
			AI_Output (self, other, "DIA_Sekob_ObsessedByDMT_19_00");	//Give up, magician. You cannot win.
			NpcObsessedByDMT_Sekob = TRUE;
		}
		else if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Randolph))
		{
			AI_Output (self, other, "DIA_Randolph_ObsessedByDMT_19_00");	//Do not concern yourself with the weak. We shall enslave them all.
			NpcObsessedByDMT_Randolph = TRUE;
		}
		else
		{
			B_DMTWurm();
			if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Bromor))
			{
				NpcObsessedByDMT_Bromor = TRUE;
			};
			if(Hlp_GetInstanceID(medium) == Hlp_GetInstanceID(Fernando))
			{
				NpcObsessedByDMT_Fernando = TRUE;
			};
		};
		B_GivePlayerXP(XP_SCFoundObsessedNpc);
	}
	else
	{
		B_NpcClearObsessionByDMT(medium);
	};
};

