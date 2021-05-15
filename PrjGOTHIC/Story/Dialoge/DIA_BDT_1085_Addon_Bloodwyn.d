
instance DIA_Addon_Bloodwyn_EXIT(C_Info)
{
	npc = BDT_1085_Addon_Bloodwyn;
	nr = 999;
	condition = DIA_Addon_Bloodwyn_EXIT_Condition;
	information = DIA_Addon_Bloodwyn_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Bloodwyn_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Bloodwyn_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Bloodwyn_PICKPOCKET(C_Info)
{
	npc = BDT_1085_Addon_Bloodwyn;
	nr = 900;
	condition = DIA_Addon_Bloodwyn_PICKPOCKET_Condition;
	information = DIA_Addon_Bloodwyn_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Addon_Bloodwyn_PICKPOCKET_Condition()
{
	return C_Beklauen(90,250);
};

func void DIA_Addon_Bloodwyn_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Bloodwyn_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Bloodwyn_PICKPOCKET,Dialog_Back,DIA_Addon_Bloodwyn_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Bloodwyn_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Bloodwyn_PICKPOCKET_DoIt);
};

func void DIA_Addon_Bloodwyn_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Bloodwyn_PICKPOCKET);
};

func void DIA_Addon_Bloodwyn_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Bloodwyn_PICKPOCKET);
};


instance DIA_Addon_Bloodwyn_Dead(C_Info)
{
	npc = BDT_1085_Addon_Bloodwyn;
	nr = 2;
	condition = DIA_Addon_Bloodwyn_Dead_Condition;
	information = DIA_Addon_Bloodwyn_Dead_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Bloodwyn_Dead_Condition()
{
	if(Npc_GetDistToWP(self,"BL_RAVEN_09") <= 1000)
	{
		return TRUE;
	};
};

func void DIA_Addon_Bloodwyn_Dead_Info()
{
	AI_Output (self, other, "DIA_Addon_Bloodwyn_Dead_04_00");	//Hey, how did you get in here?
	AI_Output (other, self, "DIA_Addon_Bloodwyn_Dead_15_01");	//Through the entrance.
	AI_Output (self, other, "DIA_Addon_Bloodwyn_Dead_04_02");	//Funny... I HATE jokes.
	EnteredBanditsCamp = TRUE;
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
};

func void Bloodwyn_Choices_1()
{
	Info_ClearChoices (DIA_Addon_Bloodwyn_Wait);
	Info_AddChoice (DIA_Addon_Bloodwyn_Wait, PRINT_ADDON_ENOUGHTALK, DIA_Addon_Bloodwyn_Wait_FIGHT);
	Info_AddChoice (DIA_Addon_Bloodwyn_Wait, "And I thought I did you in.", DIA_Addon_Bloodwyn_Wait_GOOD1);
	Info_AddChoice (DIA_Addon_Bloodwyn_Wait, "Everything comes to an end.", DIA_Addon_Bloodwyn_Wait_BAD1);
};

func void Bloodwyn_Choices_2()
{
	Info_ClearChoices (DIA_Addon_Bloodwyn_Wait);
	Info_AddChoice (DIA_Addon_Bloodwyn_Wait, PRINT_ADDON_ENOUGHTALK, DIA_Addon_Bloodwyn_Wait_FIGHT);
	Info_AddChoice (DIA_Addon_Bloodwyn_Wait, "And who do you think brought down the Barrier?", DIA_Addon_Bloodwyn_Wait_GOOD2);
	Info_AddChoice (DIA_Addon_Bloodwyn_Wait, "You and a lot of other guys, too...", DIA_Addon_Bloodwyn_Wait_BAD2);
};

func void Bloodwyn_Choices_3()
{
	Info_ClearChoices (DIA_Addon_Bloodwyn_Wait);
	Info_AddChoice (DIA_Addon_Bloodwyn_Wait, PRINT_ADDON_ENOUGHTALK, DIA_Addon_Bloodwyn_Wait_FIGHT);
	Info_AddChoice (DIA_Addon_Bloodwyn_Wait, "Obviously he's got no time to be picky...", DIA_Addon_Bloodwyn_Wait_GOOD3);
	Info_AddChoice (DIA_Addon_Bloodwyn_Wait, "Yes, that was his biggest mistake...", DIA_Addon_Bloodwyn_Wait_BAD3);
};


instance DIA_Addon_Bloodwyn_Wait(C_Info)
{
	npc = BDT_1085_Addon_Bloodwyn;
	nr = 2;
	condition = DIA_Addon_Bloodwyn_Wait_Condition;
	information = DIA_Addon_Bloodwyn_Wait_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Bloodwyn_Wait_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Minecrawler_Killed > 9))
	{
		return TRUE;
	};
};

var int Bloodwyn_KnowsSC;

func void DIA_Addon_Bloodwyn_Wait_Info()
{
	AI_Output (self, other, "DIA_Addon_Bloodwyn_Wait_04_00");	//You killed the minecrawlers? Good. I'll take over now. Go on, beat it.
	AI_Output (other, self, "DIA_Addon_Bloodwyn_Wait_15_01");	//Wait a minute.
	AI_Output (self, other, "DIA_Addon_Bloodwyn_Wait_04_02");	//You still aren't gone?
	AI_Output (other, self, "DIA_Addon_Bloodwyn_Wait_15_03");	//We still have to set something straight.
	EnteredBanditsCamp = TRUE;
	Info_ClearChoices(DIA_Addon_Bloodwyn_Wait);
	Info_AddChoice(DIA_Addon_Bloodwyn_Wait,PRINT_ADDON_ENOUGHTALK,DIA_Addon_Bloodwyn_Wait_FIGHT);
	Info_AddChoice(DIA_Addon_Bloodwyn_Wait,"I'm looking for Raven.",DIA_Addon_Bloodwyn_Wait_Raven);
};

func void DIA_Addon_Bloodwyn_Wait_Raven()
{
	AI_Output (other, self, "DIA_Addon_Bloodwyn_Wait_Raven_15_00");	//I'm looking for Raven.
	AI_Output (self, other, "DIA_Addon_Bloodwyn_Wait_Raven_04_01");	//Yeah - and what makes you think that Raven wants to talk to YOU of all... wait, are YOU... Is it YOU?
	AI_Output (self, other, "DIA_Addon_Bloodwyn_Wait_Raven_04_02");	//You're the guy we've been looking for the whole time. What are YOU doing here? You should be long dead!
	AI_Output (other, self, "DIA_Addon_Bloodwyn_Wait_Raven_15_03");	//People are always telling me that.
	AI_Output (self, other, "DIA_Addon_Bloodwyn_Wait_Raven_04_04");	//Those morons all failed - but you won't get past me. This time I'll finish you!
	AI_Output (other, self, "DIA_Addon_Bloodwyn_Wait_Raven_15_05");	//Like I already said - it's Raven I'm looking for - you aren't important to me.
	AI_Output (self, other, "DIA_Addon_Bloodwyn_Wait_Raven_04_06");	//I'll kill you - I've survived every battle so far!
	Bloodwyn_KnowsSC = TRUE;
	Bloodwyn_Choices_1();
};

func void DIA_Addon_Bloodwyn_Wait_FIGHT()
{
	AI_Output(other,self,"DIA_Addon_Bloodwyn_Wait_Raven_FIGHT_15_00");	//Enough talk. Let's fight.
	if(Bloodwyn_KnowsSC == TRUE)
	{
		AI_Output(self,other,"DIA_Addon_Bloodwyn_Wait_Raven_FIGHT_04_01");	//(triumphant) It's too late for you anyway! Raven is opening the temple right now! Hahahaha - Die, bastard!
	}
	else
	{
		B_Say(self,other,"$KILLENEMY");
	};
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
};

func void Bloodwyn_Lach()
{
	AI_Output (self, other, "DIA_Addon_Bloodwyn_Lach_04_00");	//HAHAHA - I'll defeat you all the same!
};

func void Bloodwyn_Wut()
{
	AI_Output(self,other,"DIA_Addon_Bloodwyn_Wut_04_00");	//AARGH! You miserable dog!
	self.attribute[ATR_STRENGTH] -= 5;
	self.attribute[ATR_HITPOINTS] -= 25;
	self.attribute[ATR_HITPOINTS_MAX] -= 25;
};

func void Bloodwyn_Next_1()
{
	AI_Output (self, other, "DIA_Addon_Bloodwyn_SayChoice_2_04_00");	//And I survived the explosion of the Barrier without a scratch!
};

func void Bloodwyn_Next_2()
{
	AI_Output (self, other, "DIA_Addon_Bloodwyn_SayChoice_3_04_00");	//You can't defeat me, I'm Raven's best friend! His right hand!
};

func void DIA_Addon_Bloodwyn_Wait_GOOD1()
{
	AI_Output (other, self, "DIA_Addon_Bloodwyn_Wait_Raven_GOOD1_15_00");	//And I thought I did you in.
	Bloodwyn_Wut ();
	Bloodwyn_Next_1 ();
	Bloodwyn_Choices_2 ();
};

func void DIA_Addon_Bloodwyn_Wait_BAD1()
{
	AI_Output (other, self, "DIA_Addon_Bloodwyn_Wait_Raven_BAD1_15_00");	//Everything comes to an end.
	Bloodwyn_Lach ();
	Bloodwyn_Next_1 ();
	Bloodwyn_Choices_2 ();
};

func void DIA_Addon_Bloodwyn_Wait_GOOD2()
{
	AI_Output (other, self, "DIA_Addon_Bloodwyn_Wait_Raven_GOOD2_15_00");	//And who do you think brought down the Barrier?
	Bloodwyn_Wut ();
	Bloodwyn_Next_2 ();
	Bloodwyn_Choices_3 ();
};

func void DIA_Addon_Bloodwyn_Wait_BAD2()
{
	AI_Output (other, self, "DIA_Addon_Bloodwyn_Wait_Raven_BAD2_15_00");	//You and a lot of other guys, too...
	Bloodwyn_Lach ();
	Bloodwyn_Next_2 ();
	Bloodwyn_Choices_3 ();
};

func void DIA_Addon_Bloodwyn_Wait_GOOD3()
{
	AI_Output (other, self, "DIA_Addon_Bloodwyn_Wait_Raven_GOOD3_15_00");	//Obviously he's got no time to be picky...
	Bloodwyn_Wut ();
	Info_ClearChoices (DIA_Addon_Bloodwyn_Wait);
	Info_AddChoice (DIA_Addon_Bloodwyn_Wait, PRINT_ADDON_ENOUGHTALK, DIA_Addon_Bloodwyn_Wait_FIGHT);
};

func void DIA_Addon_Bloodwyn_Wait_BAD3()
{
	AI_Output(other,self,"DIA_Addon_Bloodwyn_Wait_Raven_BAD3_15_00");	//Yes, that was his biggest mistake...
//	Bloodwyn_Wut();
	Bloodwyn_Lach();
	Info_ClearChoices(DIA_Addon_Bloodwyn_Wait);
	Info_AddChoice(DIA_Addon_Bloodwyn_Wait,PRINT_ADDON_ENOUGHTALK,DIA_Addon_Bloodwyn_Wait_FIGHT);
};

