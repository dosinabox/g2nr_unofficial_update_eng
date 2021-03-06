
instance DIA_Pal_213_Schiffswache_EXIT(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 999;
	condition = DIA_Pal_213_Schiffswache_EXIT_Condition;
	information = DIA_Pal_213_Schiffswache_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Pal_213_Schiffswache_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Pal_213_Schiffswache_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


const string Pal_213_Checkpoint = "SHIP_DECK_09";

instance DIA_Pal_213_Schiffswache_FirstWarn(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 1;
	condition = DIA_Pal_213_Schiffswache_FirstWarn_Condition;
	information = DIA_Pal_213_Schiffswache_FirstWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Pal_213_Schiffswache_FirstWarn_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (self.aivar[AIV_Guardpassage_Status] == GP_NONE) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_FirstWarn_Info()
{
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_FirstWarn_01_00");	//Wait a moment! Where do you think you're going?
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_FirstWarn_15_01");	//I wanted to ...
	if ((hero.guild == GIL_PAL) || (hero.guild == GIL_KDF))
	{
		AI_Output (self, other, "DIA_Pal_213_Schiffswache_FirstWarn_01_02");	//Sorry. You can't go through here.
	}
	else
	{
		AI_Output (self, other, "DIA_Pal_213_Schiffswache_FirstWarn_01_03");	//There's nothing here to see. Now move along.
	};
	other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP(other,Pal_213_Checkpoint);
	self.aivar[AIV_Guardpassage_Status] = GP_FirstWarnGiven;
};


instance DIA_Pal_213_Schiffswache_SecondWarn(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 2;
	condition = DIA_Pal_213_Schiffswache_SecondWarn_Condition;
	information = DIA_Pal_213_Schiffswache_SecondWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Pal_213_Schiffswache_SecondWarn_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (self.aivar[AIV_Guardpassage_Status] == GP_FirstWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,Pal_213_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_SecondWarn_Info()
{
	if((hero.guild == GIL_PAL) || (hero.guild == GIL_KDF))
	{
		AI_Output (self, other, "DIA_Pal_213_Schiffswache_SecondWarn_01_00");	//Not one step further. No exceptions.
	}
	else
	{
		AI_Output (self, other, "DIA_Pal_213_Schiffswache_SecondWarn_01_01");	//You don't want to FORCE me to hurt you, do you?
	};
	other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP(other,Pal_213_Checkpoint);
	self.aivar[AIV_Guardpassage_Status] = GP_SecondWarnGiven;
	AI_StopProcessInfos(self);
};


instance DIA_Pal_213_Schiffswache_Attack(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 3;
	condition = DIA_Pal_213_Schiffswache_Attack_Condition;
	information = DIA_Pal_213_Schiffswache_Attack_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Pal_213_Schiffswache_Attack_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (self.aivar[AIV_Guardpassage_Status] == GP_SecondWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,Pal_213_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_Attack_Info()
{
	other.aivar[AIV_LastDistToWP] = 0;
	self.aivar[AIV_Guardpassage_Status] = GP_NONE;
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_GuardStopsIntruder,1);
};


instance DIA_Pal_213_Schiffswache_GoOnBoard(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 5;
	condition = DIA_Pal_213_Schiffswache_GoOnBoard_Condition;
	information = DIA_Pal_213_Schiffswache_GoOnBoard_Info;
	permanent = FALSE;
	description = "I want to get aboard the ship.";
};


func int DIA_Pal_213_Schiffswache_GoOnBoard_Condition()
{
	if(MIS_ShipIsFree == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_GoOnBoard_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_GoOnBoard_15_00");	//I want to get aboard the ship.
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_GoOnBoard_01_01");	//No one may enter the ship! I have my orders!
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_GoOnBoard_01_02");	//I shall kill anyone who enters the ship without authorization.
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_GoOnBoard_01_03");	//In the name of Innos, I shall defend the ship with my life.
};


instance DIA_Pal_213_Schiffswache_IAmKDF(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmKDF_Condition;
	information = DIA_Pal_213_Schiffswache_IAmKDF_Info;
	permanent = FALSE;
	description = "You question the wish of a Fire Magician?";
};


func int DIA_Pal_213_Schiffswache_IAmKDF_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_GoOnBoard))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmKDF_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmKDF_15_00");	//You question the wish of a Fire Magician?
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmKDF_01_01");	//(nervous) No, of course not. May Innos forgive me.
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmKDF_01_02");	//(nervous) The Magicians of Fire are the guardians of the wisdom of Innos ...
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmKDF_01_03");	//(nervous) ... whoever doubts them, doubts Innos and forfeits any right to mercy.
};


instance DIA_Pal_213_Schiffswache_IAmKDF2(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmKDF2_Condition;
	information = DIA_Pal_213_Schiffswache_IAmKDF2_Info;
	permanent = FALSE;
	description = "What happens if I go aboard?";
};


func int DIA_Pal_213_Schiffswache_IAmKDF2_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_IAmKDF))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmKDF2_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmKDF2_15_00");	//What happens if I go aboard?
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmKDF2_01_01");	//(nervous) I shall kill... I mean, stop you.
};


instance DIA_Pal_213_Schiffswache_IAmKDF3(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmKDF3_Condition;
	information = DIA_Pal_213_Schiffswache_IAmKDF3_Info;
	permanent = FALSE;
	description = "You would attack a Fire Magician?";
};


func int DIA_Pal_213_Schiffswache_IAmKDF3_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_IAmKDF2))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmKDF3_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmKDF3_15_00");	//You would attack a Fire Magician?
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmKDF3_01_01");	//(nervous) I would never lay a hand on a magician.
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmKDF3_15_02");	//So what would you do if I went aboard?
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmKDF3_01_03");	//(sheepishly) Nothing, Sir.
};


instance DIA_Pal_213_Schiffswache_IAmKDF4(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmKDF4_Condition;
	information = DIA_Pal_213_Schiffswache_IAmKDF4_Info;
	permanent = FALSE;
	description = "I will go aboard now.";
};


func int DIA_Pal_213_Schiffswache_IAmKDF4_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_IAmKDF3))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmKDF4_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmKDF4_15_00");	//I will go aboard now.
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmKDF4_01_01");	//(nervous) You mustn't do that, Lord Hagen's orders were quite clear.
};


instance DIA_Pal_213_Schiffswache_IAmKDF5(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmKDF5_Condition;
	information = DIA_Pal_213_Schiffswache_IAmKDF5_Info;
	permanent = FALSE;
	description = "Do Lord Hagen's orders include me, too?";
};


func int DIA_Pal_213_Schiffswache_IAmKDF5_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_IAmKDF4))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmKDF5_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmKDF5_15_00");	//Do Lord Hagen's orders include me, too?
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmKDF5_01_01");	//(nervous) I don't know.
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmKDF5_15_02");	//Just think - would Lord Hagen dare to suspect a magician of theft?
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmKDF5_01_03");	//I don't believe that.
};


instance DIA_Pal_213_Schiffswache_IAmKDF6(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmKDF6_Condition;
	information = DIA_Pal_213_Schiffswache_IAmKDF6_Info;
	permanent = FALSE;
	description = "For the last time: Let me board the ship!";
};


func int DIA_Pal_213_Schiffswache_IAmKDF6_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_IAmKDF5))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmKDF6_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmKDF6_15_00");	//For the last time: Let me board the ship!
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmKDF6_01_01");	//(nervous) Understood. You may go on board.
	MIS_ShipIsFree = TRUE;
	B_CheckLog();
	if(Kapitel >= 5)
	{
		B_StartOtherRoutine(Girion,"WaitForShip");
	};
};


instance DIA_Pal_213_Schiffswache_IAmPAL(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmPAL_Condition;
	information = DIA_Pal_213_Schiffswache_IAmPAL_Info;
	permanent = FALSE;
	description = "Do you not trust me, knight?";
};


func int DIA_Pal_213_Schiffswache_IAmPAL_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_PAL) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_GoOnBoard))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmPAL_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmPAL_15_00");	//Do you not trust me, knight?
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmPAL_01_01");	//No, I just follow my orders.
};


instance DIA_Pal_213_Schiffswache_IAmPAL2(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmPAL2_Condition;
	information = DIA_Pal_213_Schiffswache_IAmPAL2_Info;
	permanent = FALSE;
	description = "Then you shall know which of us has the higher rank.";
};


func int DIA_Pal_213_Schiffswache_IAmPAL2_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_PAL) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_IAmPAL))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmPAL2_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmPAL2_15_00");	//Then you should know which of us has the higher rank.
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmPAL2_01_01");	//Yes, Sir!
};


instance DIA_Pal_213_Schiffswache_IAmPAL3(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmPAL3_Condition;
	information = DIA_Pal_213_Schiffswache_IAmPAL3_Info;
	permanent = FALSE;
	description = "I hereby command you to grant me access to this ship.";
};


func int DIA_Pal_213_Schiffswache_IAmPAL3_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_PAL) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_IAmPAL2))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmPAL3_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmPAL3_15_00");	//I hereby command you to grant me access to the ship.
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmPAL3_01_01");	//Understood, Sir, access will be granted.
	MIS_ShipIsFree = TRUE;
	B_CheckLog();
	if(Kapitel >= 5)
	{
		B_StartOtherRoutine(Girion,"WaitForShip");
	};
};


instance DIA_Pal_213_Schiffswache_IAmDJG(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmDJG_Condition;
	information = DIA_Pal_213_Schiffswache_IAmDJG_Info;
	permanent = FALSE;
	description = "Is there nothing to be done about that?";
};


func int DIA_Pal_213_Schiffswache_IAmDJG_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_DJG) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_GoOnBoard))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmDJG_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmDJG_15_00");	//Is there nothing to be done about that?
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmDJG_01_01");	//I don't think I understand.
};


instance DIA_Pal_213_Schiffswache_IAmDJG2(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmDJG2_Condition;
	information = DIA_Pal_213_Schiffswache_IAmDJG2_Info;
	permanent = FALSE;
	description = "I could give you money.";
};


func int DIA_Pal_213_Schiffswache_IAmDJG2_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_DJG) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_IAmDJG))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmDJG2_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmDJG2_15_00");	//I could give you money. For looking the other way.
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmDJG2_01_01");	//I cannot be bribed, and if you don't disappear right now, I will take that as an insult.
};


instance DIA_Pal_213_Schiffswache_IAmDJG3(C_Info)
{
	npc = PAL_213_Schiffswache;
	nr = 6;
	condition = DIA_Pal_213_Schiffswache_IAmDJG3_Condition;
	information = DIA_Pal_213_Schiffswache_IAmDJG3_Info;
	permanent = FALSE;
	description = "I have a written authorization.";
};


func int DIA_Pal_213_Schiffswache_IAmDJG3_Condition()
{
	if((MIS_ShipIsFree == FALSE) && (hero.guild == GIL_DJG) && Npc_KnowsInfo(other,DIA_Pal_213_Schiffswache_IAmDJG) && (Npc_HasItems(other,ITWr_ForgedShipLetter_MIS) >= 1))
	{
		return TRUE;
	};
};

func void DIA_Pal_213_Schiffswache_IAmDJG3_Info()
{
	AI_Output (other, self, "DIA_Pal_213_Schiffswache_IAmDJG3_15_00");	//I have a written authorization. I am permitted to board the ship.
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmDJG3_01_01");	//Let me see.
	B_GiveInvItems (other, self, ITWr_ForgedShipLetter_MIS, 1);
	B_UseFakeScroll ();
	AI_Output (self, other, "DIA_Pal_213_Schiffswache_IAmDJG3_01_02");	//All right, you may pass.
	MIS_ShipIsFree = TRUE;
	B_CheckLog();
	if(Kapitel >= 5)
	{
		B_StartOtherRoutine(Girion,"WaitForShip");
	};
};

