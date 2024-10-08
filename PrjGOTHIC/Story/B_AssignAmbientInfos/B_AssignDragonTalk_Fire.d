
instance DIA_Dragon_Fire_Exit(C_Info)
{
	nr = 999;
	condition = DIA_Dragon_Fire_Exit_Condition;
	information = DIA_Dragon_Fire_Exit_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Dragon_Fire_Exit_Condition()
{
	if(DragonTalk_Exit_Free == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Dragon_Fire_Exit_Info()
{
	AI_Output(self,other,"DIA_Dragon_Fire_Exit_20_00");	//The Eye has lost its power, and you will not survive the next day.
	B_EndDragonTalk();
};


instance DIA_Dragon_Fire_Hello(C_Info)
{
	nr = 1;
	condition = DIA_Dragon_Fire_Hello_Condition;
	information = DIA_Dragon_Fire_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Dragon_Fire_Hello_Condition()
{
	if(Npc_HasItems(other,ItMi_InnosEye_MIS))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Fire_Hello_Info()
{
	AI_Output(self,other,"DIA_Dragon_Fire_Hello_20_00");	//I simply cannot believe that there truly are still people who will forfeit their lives merely to see a dragon in the flesh.
	if(MIS_KilledDragons == 0)
	{
		AI_Output (other, self, "DIA_Dragon_Fire_Hello_15_01");	//You're quite articulate for such a bulky monster.
	};
	AI_Output(other,self,"DIA_Dragon_Fire_Hello_15_02");	//I haven't just come to see you. I rather had something more radical in mind, I'm afraid.
	AI_Output(self,other,"DIA_Dragon_Fire_Hello_20_03");	//You do not mean to say that you wish to challenge me?
	AI_Output(self,other,"DIA_Dragon_Fire_Hello_20_04");	//Ha ha ha. I shall break your scrawny neck.
	AI_Output(other,self,"DIA_Dragon_Fire_Hello_15_05");	//Not so fast, my friend. I carry the Eye of Innos with me. You cannot resist my will. Answer my questions, or the agony will be unbearable for you.
	AI_Output(self,other,"DIA_Dragon_Fire_Hello_20_06");	//(bellows) Arrh. Then pose your ridiculous questions while you still can. Your power will not last long.
};


instance DIA_Dragon_Fire_WerBistDu(C_Info)
{
	nr = 5;
	condition = DIA_Dragon_Fire_WerBistDu_Condition;
	information = DIA_Dragon_Fire_WerBistDu_Info;
	description = "Who are you?";
};


func int DIA_Dragon_Fire_WerBistDu_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dragon_Fire_Hello))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Fire_WerBistDu_Info()
{
	AI_Output(other,self,"DIA_Dragon_Fire_WerBistDu_15_00");	//Who are you?
	AI_Output(self,other,"DIA_Dragon_Fire_WerBistDu_20_01");	//My name is Feomathar, and that is all that you will learn about me.
	AI_Output(self,other,"DIA_Dragon_Fire_WerBistDu_20_02");	//Once I can escape the spell of the Eye, you will go up in flames.
};


instance DIA_Dragon_Fire_HORT(C_Info)
{
	nr = 5;
	condition = DIA_Dragon_Fire_HORT_Condition;
	information = DIA_Dragon_Fire_HORT_Info;
	description = "So where's your hoard?";
};


func int DIA_Dragon_Fire_HORT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dragon_Fire_Hello))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Fire_HORT_Info()
{
	AI_Output(other,self,"DIA_Dragon_Fire_HORT_15_00");	//Every dragon has a hoard where he stores his collected treasures. So where's your hoard?
	AI_Output(self,other,"DIA_Dragon_Fire_HORT_20_01");	//In a place that will be inaccessible to you, once I am finally free of the chains of the Eye.
	AI_Output(self,other,"DIA_Dragon_Fire_HORT_20_02");	//I keep my treasure high up on the hot cliffs, which should be all but impossible to reach for a wingless human such as you.
};

func void B_AssignDragonTalk_Fire(var C_Npc slf)
{
	DIA_Dragon_Fire_Exit.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Fire_Hello.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Fire_WerBistDu.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Fire_HORT.npc = Hlp_GetInstanceID(slf);
	B_AssignDragonTalk_Main(slf);
};

