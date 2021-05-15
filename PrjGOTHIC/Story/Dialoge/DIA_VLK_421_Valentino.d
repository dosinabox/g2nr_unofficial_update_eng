
instance DIA_Valentino_EXIT(C_Info)
{
	npc = VLK_421_Valentino;
	nr = 999;
	condition = DIA_Valentino_EXIT_Condition;
	information = DIA_Valentino_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Valentino_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Valentino_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Valentino_HALLO(C_Info)
{
	npc = VLK_421_Valentino;
	nr = 1;
	condition = DIA_Valentino_HALLO_Condition;
	information = DIA_Valentino_HALLO_Info;
	permanent = FALSE;
	description = "Well, what have we here?";
};


func int DIA_Valentino_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Valentino_HALLO_Info()
{
	AI_Output (other, self, "DIA_Valentino_HALLO_15_00");	//Well, what have we here?
	if ((hero.guild == GIL_KDF) || (hero.guild == GIL_PAL))
	{
		AI_Output (self, other, "DIA_Valentino_HALLO_03_01");	//My name is Valentino. I'm trying not to profane this day given to me by Innos with work.
		AI_Output (other, self, "DIA_Valentino_HALLO_15_02");	//Mind your words.
		AI_Output (self, other, "DIA_Valentino_HALLO_03_03");	//Oh, pardon me, I meant no offense to our Lord. Please forgive me, sir.
	}
	else
	{
		AI_Output (self, other, "DIA_Valentino_HALLO_03_04");	//Have you no manners? That's disgusting!
		AI_Output (self, other, "DIA_Valentino_HALLO_03_05");	//Always this filthy rabble. Haven't you a job where you ought to be?
		AI_Output (self, other, "DIA_Valentino_HALLO_03_06");	//But I suppose no one would miss a down-at-the-heels fellow like you, hey?
		AI_Output (self, other, "DIA_Valentino_HALLO_03_07");	//Well, if you had as much gold as I do, you wouldn't have to work either. But you'll never be that rich.
		AI_Output (other, self, "DIA_Valentino_HALLO_15_08");	//I see I'm going to have lots of fun with you.
	};
};


instance DIA_Valentino_WhoAgain(C_Info)
{
	npc = VLK_421_Valentino;
	nr = 2;
	condition = DIA_Valentino_WhoAgain_Condition;
	information = DIA_Valentino_WhoAgain_Info;
	permanent = FALSE;
	description = "I asked you who you are!";
};


func int DIA_Valentino_WhoAgain_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Valentino_HALLO) && (other.guild != GIL_KDF) && (other.guild != GIL_PAL))
	{
		return TRUE;
	};
};

func void DIA_Valentino_WhoAgain_Info()
{
	AI_Output (other, self, "DIA_Valentino_Add_15_01");	//I asked you who you are!
	AI_Output (self, other, "DIA_Valentino_HALLO_wasmachstdu_03_01");	//I am Valentino the handsome. Bon vivant and ladies' man.
	AI_Output (self, other, "DIA_Valentino_HALLO_wasmachstdu_03_02");	//Poor in cares, rich in wisdom and gold, and the women throw themselves at me.
	AI_Output (self, other, "DIA_Valentino_HALLO_wasmachstdu_03_03");	//If you have problems, keep them. I don't need them.
};


instance DIA_Valentino_Manieren(C_Info)
{
	npc = VLK_421_Valentino;
	nr = 3;
	condition = DIA_Valentino_Manieren_Condition;
	information = DIA_Valentino_Manieren_Info;
	permanent = FALSE;
	description = "Looks like I'm going to have to teach you some manners!";
};


func int DIA_Valentino_Manieren_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Valentino_HALLO) && (other.guild != GIL_PAL) && (other.guild != GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Valentino_Manieren_Info()
{
	AI_Output (other, self, "DIA_Valentino_Add_15_02");	//Looks like I'm going to have to teach you some manners!
	AI_Output (self, other, "DIA_Valentino_HALLO_klappe_03_01");	//Doesn't matter to me! Thrash me all you want. When I get up tomorrow, I'll be fine again.
	AI_Output (self, other, "DIA_Valentino_HALLO_klappe_03_02");	//But you'll have to run around with that mug of yours for life.
};


var int Valentino_Lo_Perm;
var int Valentino_Hi_Perm;

instance DIA_Valentino_WASNUETZLICHES(C_Info)
{
	npc = VLK_421_Valentino;
	nr = 4;
	condition = DIA_Valentino_WASNUETZLICHES_Condition;
	information = DIA_Valentino_WASNUETZLICHES_Info;
	permanent = TRUE;
	description = "Do you have anything else to tell me?";
};


func int DIA_Valentino_WASNUETZLICHES_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Valentino_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Valentino_WASNUETZLICHES_Info()
{
	AI_Output (other, self, "DIA_Valentino_Add_15_03");	//(calmly) Do you have anything else to tell me?
	if (self.aivar[AIV_DefeatedByPlayer] == TRUE)
	{
		B_Say(self,other,"$NOTNOW");
	}
	else if((Valentino_Lo_Perm == FALSE) && (other.guild != GIL_PAL) && (other.guild != GIL_KDF))
	{
		AI_Output (self, other, "DIA_Valentino_WASNUETZLICHES_03_01");	//Make yourself popular, never promise anything to anyone, take what you can, and watch out that you don't get into a quarrel with the militia.
		AI_Output (self, other, "DIA_Valentino_WASNUETZLICHES_03_02");	//Or with jealous husbands, of course - they're the worst, let me tell you.
		Valentino_Lo_Perm = TRUE;
	}
	else if((Valentino_Hi_Perm == FALSE) && ((other.guild == GIL_PAL) || (other.guild == GIL_KDF)))
	{
		AI_Output (self, other, "DIA_Valentino_WASNUETZLICHES_03_03");	//For a man in your position, anything is possible. You simply have to recognize when it's time to act.
		AI_Output (self, other, "DIA_Valentino_WASNUETZLICHES_03_04");	//So don't waste any time, and act.
		Valentino_Hi_Perm = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Valentino_WASNUETZLICHES_03_05");	//I've told you everything you need to know - the rest is up to you.
	};
};


instance DIA_Valentino_PICKPOCKET(C_Info)
{
	npc = VLK_421_Valentino;
	nr = 900;
	condition = DIA_Valentino_PICKPOCKET_Condition;
	information = DIA_Valentino_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40_Key;
};


func int DIA_Valentino_PICKPOCKET_Condition()
{
//	return C_StealItems(30,Hlp_GetInstanceID(ItKe_Valentino),1);
	if(Npc_HasItems(self,ItKe_Valentino))
	{
		return C_StealItem(30);
	};
	return FALSE;
};

func void DIA_Valentino_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Valentino_PICKPOCKET);
	Info_AddChoice(DIA_Valentino_PICKPOCKET,Dialog_Back,DIA_Valentino_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Valentino_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Valentino_PICKPOCKET_DoIt);
};

func void DIA_Valentino_PICKPOCKET_DoIt()
{
//	B_StealItems(30,Hlp_GetInstanceID(ItKe_Valentino),1);
	B_StealItem(30,Hlp_GetInstanceID(ItKe_Valentino));
	Info_ClearChoices(DIA_Valentino_PICKPOCKET);
};

func void DIA_Valentino_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Valentino_PICKPOCKET);
};

