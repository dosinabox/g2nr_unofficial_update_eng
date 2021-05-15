
instance DIA_Haupttorwache_EXIT(C_Info)
{
	npc = VLK_4143_HaupttorWache;
	nr = 999;
	condition = DIA_Haupttorwache_EXIT_Condition;
	information = DIA_Haupttorwache_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Haupttorwache_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Haupttorwache_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Haupttorwache_AUFGABE(C_Info)
{
	npc = VLK_4143_HaupttorWache;
	nr = 4;
	condition = DIA_Haupttorwache_AUFGABE_Condition;
	information = DIA_Haupttorwache_AUFGABE_Info;
	permanent = TRUE;
	description = "What's your job?";
};


func int DIA_Haupttorwache_AUFGABE_Condition()
{
	return TRUE;
};

func void DIA_Haupttorwache_AUFGABE_Info()
{
	AI_Output (other, self, "DIA_Haupttorwache_AUFGABE_15_00");	//What's your task?
	AI_Output (self, other, "DIA_Haupttorwache_AUFGABE_13_01");	//My assignment is simple. I'm supposed to make sure that the orcs stay away more than 30 feet from the gate.
	AI_Output (self, other, "DIA_Haupttorwache_AUFGABE_13_02");	//If they try to break through the portcullis, I sound the alarm. That's all.
};


instance DIA_Haupttorwache_TOROEFFNEN(C_Info)
{
	npc = VLK_4143_HaupttorWache;
	nr = 5;
	condition = DIA_Haupttorwache_TOROEFFNEN_Condition;
	information = DIA_Haupttorwache_TOROEFFNEN_Info;
	permanent = TRUE;
	description = "What would one have to do to open the main gate?";
};


func int DIA_Haupttorwache_TOROEFFNEN_Condition()
{
	if(Kapitel >= 5)
	{
		return TRUE;
	};
};

func void DIA_Haupttorwache_TOROEFFNEN_Info()
{
	AI_Output (other, self, "DIA_Haupttorwache_TOROEFFNEN_15_00");	//What would one have to do to open the main gate?
	AI_Output (self, other, "DIA_Haupttorwache_TOROEFFNEN_13_01");	//For heaven's sake. Why would you want to know that?
	self.flags = 0;
	Info_ClearChoices (DIA_Haupttorwache_TOROEFFNEN);
	Info_AddChoice (DIA_Haupttorwache_TOROEFFNEN, "I'm worried about the safety of the castle.", DIA_Haupttorwache_TOROEFFNEN_sicherheit);
	Info_AddChoice (DIA_Haupttorwache_TOROEFFNEN, "Never mind. Just asking.", DIA_Haupttorwache_TOROEFFNEN_frage);
};

func void DIA_Haupttorwache_TOROEFFNEN_sicherheit()
{
	AI_Output (other, self, "DIA_Haupttorwache_TOROEFFNEN_sicherheit_15_00");	//I'm worried about the safety of the castle.
	AI_Output (self, other, "DIA_Haupttorwache_TOROEFFNEN_sicherheit_13_01");	//So am I, all the time, believe me.
	AI_Output (self, other, "DIA_Haupttorwache_TOROEFFNEN_sicherheit_13_02");	//And since I am such a faithful guardian, Garond has finally entrusted the key to the gate room to me.
	AI_Output (self, other, "DIA_Haupttorwache_TOROEFFNEN_sicherheit_13_03");	//(proudly) That's a great responsibility. I shall guard it well. I had to swear that to Garond.
	AI_Output (self, other, "DIA_Haupttorwache_TOROEFFNEN_sicherheit_13_04");	//Yes. Just imagine someone coming and simply pulling the lever to open the gate, and that rusty, old steel grating getting jammed.
	AI_Output (self, other, "DIA_Haupttorwache_TOROEFFNEN_sicherheit_13_05");	//Nobody could close the gate then. I mustn't think about what would happen next. It's a good thing no one knows that I have the key.
	AI_StopProcessInfos (self);
};

func void DIA_Haupttorwache_TOROEFFNEN_frage()
{
	AI_Output (other, self, "DIA_Haupttorwache_TOROEFFNEN_frage_15_00");	//Never mind. Just asking.
	AI_Output (self, other, "DIA_Haupttorwache_TOROEFFNEN_frage_13_01");	//Don't invite trouble by talking like that. Times are hard enough as it is. Now go. I'm busy.
	AI_StopProcessInfos (self);
};


instance DIA_Haupttorwache_PICKPOCKET(C_Info)
{
	npc = VLK_4143_HaupttorWache;
	nr = 900;
	condition = DIA_Haupttorwache_PICKPOCKET_Condition;
	information = DIA_Haupttorwache_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20_Key;
};


func int DIA_Haupttorwache_PICKPOCKET_Condition()
{
//	if(C_StealItems(20,Hlp_GetInstanceID(ItKe_OC_MainGate_MIS),1) && Npc_KnowsInfo(other,DIA_Torlof_BEMYCAPTAIN))
	if(Npc_HasItems(self,ItKe_OC_MainGate_MIS) && Npc_KnowsInfo(other,DIA_Torlof_BEMYCAPTAIN))
	{
		return C_StealItem(20);
	};
	return FALSE;
};

func void DIA_Haupttorwache_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Haupttorwache_PICKPOCKET);
	Info_AddChoice(DIA_Haupttorwache_PICKPOCKET,Dialog_Back,DIA_Haupttorwache_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Haupttorwache_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Haupttorwache_PICKPOCKET_DoIt);
};

func void DIA_Haupttorwache_PICKPOCKET_DoIt()
{
//	B_StealItems(20,Hlp_GetInstanceID(ItKe_OC_MainGate_MIS),1);
	B_StealItem(20,Hlp_GetInstanceID(ItKe_OC_MainGate_MIS));
	Info_ClearChoices(DIA_Haupttorwache_PICKPOCKET);
};

func void DIA_Haupttorwache_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Haupttorwache_PICKPOCKET);
};

