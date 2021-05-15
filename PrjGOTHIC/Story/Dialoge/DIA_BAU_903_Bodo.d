
instance DIA_Bodo_EXIT(C_Info)
{
	npc = BAU_903_Bodo;
	nr = 999;
	condition = DIA_Bodo_EXIT_Condition;
	information = DIA_Bodo_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Bodo_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Bodo_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Bodo_Hallo(C_Info)
{
	npc = BAU_903_Bodo;
	nr = 1;
	condition = DIA_Bodo_Hallo_Condition;
	information = DIA_Bodo_Hallo_Info;
	permanent = TRUE;
	description = "How's it going?";
};


func int DIA_Bodo_Hallo_Condition()
{
	return TRUE;
};

func void DIA_Bodo_Hallo_Info()
{
	AI_Output (other, self, "DIA_Bodo_Hallo_15_00");	//How's it going?
	if (other.guild == GIL_NONE)
	{
		AI_Output (self, other, "DIA_Bodo_Hallo_12_01");	//The militia has bullied us long enough. Now that the mercenaries are on our side, they won't dare to just show up here any more.
		AI_Output (self, other, "DIA_Bodo_Hallo_12_02");	//The King may think he can get away with anything. But we're not going to take it any more.
	};
	if((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Bodo_Hallo_12_03");	//Good. If you see a few militiamen, pound them one for me too, will you?
	};
	if((other.guild == GIL_NOV) || (other.guild == GIL_KDF))
	{
		AI_Output (self, other, "DIA_Bodo_Hallo_12_04");	//Good. Innos be with you.
	};
	if((other.guild == GIL_MIL) || (other.guild == GIL_PAL))
	{
		AI_Output (self, other, "DIA_Bodo_Hallo_12_05");	//The King's troops aren't exactly welcome on the farm.
		AI_Output (self, other, "DIA_Bodo_Hallo_12_06");	//A lot of people here may talk to you anyway, but you certainly won't make yourself popular.
	};
};


instance DIA_Bodo_Bauernaufstand(C_Info)
{
	npc = BAU_903_Bodo;
	nr = 2;
	condition = DIA_Bodo_Bauernaufstand_Condition;
	information = DIA_Bodo_Bauernaufstand_Info;
	permanent = FALSE;
	description = "In town, they're talking about a peasants' revolt!";
};


func int DIA_Bodo_Bauernaufstand_Condition()
{
	return TRUE;
};

func void DIA_Bodo_Bauernaufstand_Info()
{
	AI_Output (other, self, "DIA_Bodo_Bauernaufstand_15_00");	//In town, they're talking about a peasants' revolt!
	AI_Output (self, other, "DIA_Bodo_Bauernaufstand_12_01");	//Nonsense. We aren't doing anything except defending what we've worked hard for.
	AI_Output (self, other, "DIA_Bodo_Bauernaufstand_12_02");	//It's certainly true that the war is being fought on the backs of the peasants. But Onar is no longer prepared to just stand by and watch while the king bleeds us dry.
};


instance DIA_Bodo_Bett(C_Info)
{
	npc = BAU_903_Bodo;
	nr = 3;
	condition = DIA_Bodo_Bett_Condition;
	information = DIA_Bodo_Bett_Info;
	permanent = FALSE;
	description = "Can I rest somewhere around here?";
};


func int DIA_Bodo_Bett_Condition()
{
	return TRUE;
};

func void DIA_Bodo_Bett_Info()
{
	AI_Output (other, self, "DIA_Bodo_Bett_15_00");	//Can I rest somewhere around here?
	AI_Output (self, other, "DIA_Bodo_Bett_12_01");	//If you're looking for a place to sleep, go to the barn. But don't lie down in a mercenary's bed by mistake.
	if((other.guild != GIL_SLD) && (other.guild != GIL_DJG))
	{
		AI_Output(self,other,"DIA_Bodo_Bett_12_02");	//Onar makes sure that they leave us farmers alone, but with strangers who don't belong on the farm, the mercenaries can do whatever they like.
	};
};


instance DIA_Bodo_Cipher(C_Info)
{
	npc = BAU_903_Bodo;
	nr = 4;
	condition = DIA_Bodo_Cipher_Condition;
	information = DIA_Bodo_Cipher_Info;
	permanent = FALSE;
	description = "Cipher told me somebody stole a package of swampweed from him ...";
};


func int DIA_Bodo_Cipher_Condition()
{
	if(MIS_Cipher_Paket == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Bodo_Cipher_Info()
{
	AI_Output (other, self, "DIA_Bodo_Cipher_15_00");	//Cipher told me somebody stole a package of swampweed from him ...
	AI_Output (self, other, "DIA_Bodo_Cipher_12_01");	//And?
	AI_Output (other, self, "DIA_Bodo_Cipher_15_02");	//He thinks you're the one who took it.
	AI_Output (self, other, "DIA_Bodo_Cipher_12_03");	//Oh, THAT's why the guy is always gawping at me so stupidly.
	AI_Output (self, other, "DIA_Bodo_Cipher_12_04");	//I've been extra friendly to him lately, because he seems to have hit a rough spot.
	AI_Output (self, other, "DIA_Bodo_Cipher_12_05");	//But there was nothing I could do. I'd look at him friendly like and he'd stare at me like he wanted to kill me.
};


instance DIA_Bodo_WeedOrElse(C_Info)
{
	npc = BAU_903_Bodo;
	nr = 5;
	condition = DIA_Bodo_WeedOrElse_Condition;
	information = DIA_Bodo_WeedOrElse_Info;
	permanent = FALSE;
	description = "Give me that weed, or else!";
};


func int DIA_Bodo_WeedOrElse_Condition()
{
	if((MIS_Cipher_Paket == LOG_Running) && (Dar_Dieb == FALSE) && Npc_KnowsInfo(other,DIA_Bodo_Cipher))
	{
		return TRUE;
	};
};

func void DIA_Bodo_WeedOrElse_Info()
{
	AI_Output (other, self, "DIA_Bodo_WeedOrElse_15_00");	//Give me that weed, or else!
	AI_Output (self, other, "DIA_Bodo_WeedOrElse_12_01");	//Listen, all I've got is this one reefer of weed. Take it and leave me alone.
	B_GiveInvItems(self,other,ItMi_Joint,1);
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV) || (other.guild == GIL_MIL))
	{
		AI_Output (self, other, "DIA_Bodo_WeedOrElse_12_02");	//You know that Onar's mercenaries look out for us, right?
		AI_Output (self, other, "DIA_Bodo_WeedOrElse_12_03");	//So don't do anything stupid!
	};
};


instance DIA_Bodo_WeedPERM(C_Info)
{
	npc = BAU_903_Bodo;
	nr = 6;
	condition = DIA_Bodo_WeedPERM_Condition;
	information = DIA_Bodo_WeedPERM_Info;
	permanent = TRUE;
	description = "I don't believe a word you're saying. Give me the swampweed!";
};


func int DIA_Bodo_WeedPERM_Condition()
{
	if((MIS_Cipher_Paket == LOG_Running) && (Dar_Dieb == FALSE) && Npc_KnowsInfo(other,DIA_Bodo_WeedOrElse))
	{
		return TRUE;
	};
};

func void DIA_Bodo_WeedPERM_Info()
{
	AI_Output (other, self, "DIA_Bodo_WeedPERM_15_00");	//I don't believe a word you're saying. Give me the swampweed!
	AI_Output (self, other, "DIA_Bodo_WeedPERM_12_01");	//I don't have it. Honest.
};


instance DIA_Bodo_PICKPOCKET(C_Info)
{
	npc = BAU_903_Bodo;
	nr = 900;
	condition = DIA_Bodo_PICKPOCKET_Condition;
	information = DIA_Bodo_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Bodo_PICKPOCKET_Condition()
{
	return C_Beklauen(30,60);
};

func void DIA_Bodo_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Bodo_PICKPOCKET);
	Info_AddChoice(DIA_Bodo_PICKPOCKET,Dialog_Back,DIA_Bodo_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Bodo_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Bodo_PICKPOCKET_DoIt);
};

func void DIA_Bodo_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Bodo_PICKPOCKET);
};

func void DIA_Bodo_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Bodo_PICKPOCKET);
};

