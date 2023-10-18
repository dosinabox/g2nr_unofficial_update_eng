
instance DIA_Dragon_Ice_Exit(C_Info)
{
	nr = 999;
	condition = DIA_Dragon_Ice_Exit_Condition;
	information = DIA_Dragon_Ice_Exit_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Dragon_Ice_Exit_Condition()
{
	if(DragonTalk_Exit_Free == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Dragon_Ice_Exit_Info()
{
	AI_Output(self,other,"DIA_Dragon_Ice_Exit_20_00");	//The power of the Eye is extinguished, and your time has run out.
	B_EndDragonTalk();
	Wld_InsertNpc(Draconian,"FP_ROAM_OW_ICEREGION_29_02");
	Wld_InsertNpc(Draconian,"FP_ROAM_OW_ICEREGION_30_01");
	Wld_InsertNpc(Draconian,"FP_ROAM_OW_BLOODFLY_05_01");
	Wld_InsertNpc(Draconian,"FP_ROAM_OW_BLOODFLY_05_01");
};


instance DIA_Dragon_Ice_Hello(C_Info)
{
	nr = 1;
	condition = DIA_Dragon_Ice_Hello_Condition;
	information = DIA_Dragon_Ice_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Dragon_Ice_Hello_Condition()
{
	if(Npc_HasItems(other,ItMi_InnosEye_MIS))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Ice_Hello_Info()
{
	AI_Output (self, other, "DIA_Dragon_Ice_Hello_20_00");	//Why do you disturb my rest? Must I bury myself still farther, just so you annoying little mites will finally leave me alone?
	if (MIS_KilledDragons == 0)
	{
		AI_Output(other,self,"DIA_Dragon_Ice_Hello_15_01");	//A talking dragon. Thanks be to the Eye of Innos.
	};
	AI_Output(self,other,"DIA_Dragon_Ice_Hello_20_02");	//You humans are curious creatures. Swept away by the icy winds of death, there will always be at least one who rises from the ashes, thinking he is destined to be a hero.
	AI_Output(self,other,"DIA_Dragon_Ice_Hello_20_03");	//But that will soon be over. I shall personally see to it that none of you will rise again any time soon.
	AI_Output(other,self,"DIA_Dragon_Ice_Hello_15_04");	//Silence. With the power of the sacred Eye which has been bestowed upon me, I order you to answer my questions
	AI_Output(self,other,"DIA_Dragon_Ice_Hello_20_05");	//Ha ha ha. Ask away, then. Your knowledge will not help you.
	if(Npc_IsDead(IceGolem_Sylvio1) && Npc_IsDead(IceGolem_Sylvio2) && !Npc_IsDead(DJG_Sylvio))
	{
		B_StartOtherRoutine(DJG_Sylvio,"IceWait2");
		B_StartOtherRoutine(DJG_Bullco,"IceWait2");
	};
};


instance DIA_Dragon_Ice_WERBISTDU(C_Info)
{
	nr = 5;
	condition = DIA_Dragon_Ice_WERBISTDU_Condition;
	information = DIA_Dragon_Ice_WERBISTDU_Info;
	description = "Who are you?";
};


func int DIA_Dragon_Ice_WERBISTDU_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dragon_Ice_Hello))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Ice_WERBISTDU_Info()
{
	AI_Output (other, self, "DIA_Dragon_Ice_WERBISTDU_15_00");	//Who are you?
	AI_Output (self, other, "DIA_Dragon_Ice_WERBISTDU_20_01");	//I am Finkregh. Lord of ice and snow, Guardian of the Congress and, ultimately, your death.
};


instance DIA_Dragon_Ice_BELIAR(C_Info)
{
	nr = 6;
	condition = DIA_Dragon_Ice_BELIAR_Condition;
	information = DIA_Dragon_Ice_BELIAR_Info;
	description = "Which god do you serve?";
};


func int DIA_Dragon_Ice_BELIAR_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dragon_Ice_Hello))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Ice_BELIAR_Info()
{
	AI_Output (other, self, "DIA_Dragon_Ice_BELIAR_15_00");	//Which god do you serve?
	AI_Output (other, self, "DIA_Dragon_Ice_BELIAR_15_01");	//What accursed god could ever allow despicable creatures such as you to walk this earth?
	AI_Output (self, other, "DIA_Dragon_Ice_BELIAR_20_02");	//Do not trouble yourself trying to understand the meaning of our gathering, little hero.
	AI_Output (self, other, "DIA_Dragon_Ice_BELIAR_20_03");	//Beliar has not only permitted us to be here - he has even commanded it.
	AI_Output (self, other, "DIA_Dragon_Ice_BELIAR_20_04");	//Inspired by his holy words, we shall not rest until his will is made deed.
};

func void B_AssignDragonTalk_Ice(var C_Npc slf)
{
	DIA_Dragon_Ice_Exit.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Ice_Hello.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Ice_WERBISTDU.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Ice_BELIAR.npc = Hlp_GetInstanceID(slf);
	B_AssignDragonTalk_Main(slf);
};

