
var int DIEGO_COMING;

func void B_StartNewLife()
{
	if(DIEGO_COMING == 1)
	{
		if(Diego_IsOnBoard == FALSE)
		{
			B_StartOtherRoutine(DiegoNW,"GERBRANDT");
		};
		self.aivar[AIV_CommentedPlayerCrime] = FALSE;
		Npc_ExchangeRoutine(self,"FLEE");
		if(!Npc_IsDead(GerbrandtsFrau))
		{
			GerbrandtsFrau.aivar[AIV_CommentedPlayerCrime] = FALSE;
			B_StartOtherRoutine(GerbrandtsFrau,"NEWLIFE");
		};
		B_StartOtherRoutine(VLK_419_Buerger,"NEWPLACE");
		DIEGO_COMING = 2;
	};
};

instance DIA_Gerbrandt_EXIT(C_Info)
{
	npc = VLK_403_Gerbrandt;
	nr = 999;
	condition = DIA_Gerbrandt_EXIT_Condition;
	information = DIA_Gerbrandt_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Gerbrandt_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Gerbrandt_EXIT_Info()
{
	B_StartNewLife();
	AI_StopProcessInfos(self);
};


instance DIA_Gerbrandt_PICKPOCKET(C_Info)
{
	npc = VLK_403_Gerbrandt;
	nr = 900;
	condition = DIA_Gerbrandt_PICKPOCKET_Condition;
	information = DIA_Gerbrandt_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Gerbrandt_PICKPOCKET_Condition()
{
//	if(C_StealItems(30,Hlp_GetInstanceID(ItSe_GoldPocket100),1) && (DIEGO_COMING != TRUE))
	if(Npc_HasItems(self,ItSe_GoldPocket100) && (DIEGO_COMING == FALSE))
	{
		return C_StealItem(30);
	};
	return FALSE;
};

func void DIA_Gerbrandt_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Gerbrandt_PICKPOCKET);
	Info_AddChoice(DIA_Gerbrandt_PICKPOCKET,Dialog_Back,DIA_Gerbrandt_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Gerbrandt_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Gerbrandt_PICKPOCKET_DoIt);
};

func void DIA_Gerbrandt_PICKPOCKET_DoIt()
{
//	B_StealItems(30,Hlp_GetInstanceID(ItSe_GoldPocket100),1);
	B_StartNewLife();
	B_StealItem(30,Hlp_GetInstanceID(ItSe_GoldPocket100));
	Info_ClearChoices(DIA_Gerbrandt_PICKPOCKET);
};

func void DIA_Gerbrandt_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Gerbrandt_PICKPOCKET);
};


instance DIA_Gerbrandt_PreHello(C_Info)
{
	npc = VLK_403_Gerbrandt;
	nr = 2;
	condition = DIA_Gerbrandt_PreHello_Condition;
	information = DIA_Gerbrandt_PreHello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Gerbrandt_PreHello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (VisibleGuild(hero) != GIL_KDF) && (VisibleGuild(hero) != GIL_PAL) && (VisibleGuild(hero) != GIL_KDW))
	{
		return TRUE;
	};
};

func void DIA_Gerbrandt_PreHello_Info()
{
	AI_Output(self,other,"DIA_Constantino_Hallo_10_00");	//What do you want? There's nothing to be had here for free and I'm not gonna sell you anything either!
};

instance DIA_Gerbrandt_Hello(C_Info)
{
	npc = VLK_403_Gerbrandt;
	nr = 5;
	condition = DIA_Gerbrandt_Hello_Condition;
	information = DIA_Gerbrandt_Hello_Info;
	permanent = FALSE;
	description = "What are you doing here?";
};


func int DIA_Gerbrandt_Hello_Condition()
{
	if(DIEGO_COMING == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Gerbrandt_Hello_Info()
{
	AI_Output(other,self,"DIA_Gerbrandt_Hello_15_00");	//What are you doing here?
	if((VisibleGuild(hero) != GIL_KDF) && (VisibleGuild(hero) != GIL_PAL) && (VisibleGuild(hero) != GIL_KDW))
	{
	AI_Output (self, other, "DIA_Gerbrandt_Hello_10_01");	//Who are you, then? Looks like you're new and have no idea what goes on around here.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_10_02");	//They call me Gerbrandt. To you, that's: Mr. Gerbrandt, sir. Got it?
		Info_ClearChoices(DIA_Gerbrandt_Hello);
	Info_AddChoice (DIA_Gerbrandt_Hello, "I got it, Gerbrandt.", DIA_Gerbrandt_Hello_No);
	Info_AddChoice (DIA_Gerbrandt_Hello, "I get the point, Mr. Gerbrandt, sir.", DIA_Gerbrandt_Hello_Yes);
	}
	else
	{
		AI_Output(self,other,"DIA_Gerbrandt_Hello_No_10_02");	//I call the shots here. Whoever causes trouble has to answer to me and had better skip town in a hurry, because once I'm done with him, he'll wish he'd never laid eyes on me.
	};
};

func void DIA_Gerbrandt_Hello_No()
{
	AI_Output (other, self, "DIA_Gerbrandt_Hello_No_15_00");	//I got it, Gerbrandt.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_No_10_01");	//Careful with that big mouth of yours. You had better show me a little more respect, or you're headed for all kinds of trouble here.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_No_10_02");	//I call the shots here. Whoever causes trouble has to answer to me and had better skip town in a hurry, because once I'm done with him, he'll wish he'd never laid eyes on me.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_No_10_03");	//Most people around the harbor work for me. If you're ever looking for work, you had better see to it that my memories of you are pleasant ones.
	Info_ClearChoices (DIA_Gerbrandt_Hello);
};

func void DIA_Gerbrandt_Hello_Yes()
{
	AI_Output (other, self, "DIA_Gerbrandt_Hello_Yes_15_00");	//I get the point, Mr. Gerbrandt, sir.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_Yes_10_01");	//At least it didn't take you long to grasp how the wind blows around here.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_Yes_10_02");	//As soon as business starts picking up again, I can surely find a use for a strapping lad like you.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_Yes_10_03");	//You would make an excellent depot master.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_Yes_10_04");	//Can you read?
	Info_ClearChoices (DIA_Gerbrandt_Hello);
	Info_AddChoice (DIA_Gerbrandt_Hello, "No.", DIA_Gerbrandt_Hello_Yes_No);
	Info_AddChoice (DIA_Gerbrandt_Hello, "I don't want a job.", DIA_Gerbrandt_Hello_NoJob);
	Info_AddChoice (DIA_Gerbrandt_Hello, "Of course.", DIA_Gerbrandt_Hello_Yes_Yes);
};

func void DIA_Gerbrandt_Hello_Yes_No()
{
	AI_Output (other, self, "DIA_Gerbrandt_Hello_Yes_No_15_00");	//No.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_Yes_No_10_01");	//Never mind, at least you'll be able to lug a few sacks about.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_Yes_No_10_02");	//If I am satisfied with you, I might even offer you a permanent position. There is enough to do around here.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_Yes_No_10_03");	//Well, then, I'll expect you when the first ships come back here to dock.
	Info_ClearChoices (DIA_Gerbrandt_Hello);
};

func void DIA_Gerbrandt_Hello_NoJob()
{
	AI_Output (other, self, "DIA_Gerbrandt_Hello_NoJob_15_00");	//I don't want a job.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_NoJob_10_01");	//You think you're awfully clever. Watch it, no one can get a job here as long as I don't approve.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_NoJob_10_02");	//So if you keep giving me the lip like that, you can find yourself a bug-infested straw tick to sleep on, because that will be all you can afford.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_NoJob_10_03");	//The time will come when you'll beg me to give you a job.
	Info_ClearChoices (DIA_Gerbrandt_Hello);
};

func void DIA_Gerbrandt_Hello_Yes_Yes()
{
	AI_Output (other, self, "DIA_Gerbrandt_Hello_Yes_Yes_15_00");	//Of course.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_Yes_Yes_10_01");	//Fine, fine. Trained staff is hard to come by.
	AI_Output (self, other, "DIA_Gerbrandt_Hello_Yes_Yes_10_02");	//How about your references?
	AI_Output (other, self, "DIA_Gerbrandt_Hello_Yes_Yes_15_03");	//References?
	AI_Output (self, other, "DIA_Gerbrandt_Hello_Yes_Yes_10_04");	//All right, I shall remember your face. Once trade picks up again, come and see me. I just might have a job for you then.
	Info_ClearChoices (DIA_Gerbrandt_Hello);
};

func void B_Gerbrandt_PissOff()
{
	AI_Output (self, other, "B_Gerbrandt_PissOff_10_00");	//What is that about - are you trying to mock me?
	AI_Output (self, other, "B_Gerbrandt_PissOff_10_01");	//You and your buddy Diego have wreaked enough havoc already.
	AI_Output (self, other, "B_Gerbrandt_PissOff_10_02");	//Leave me alone!
	B_StartNewLife();
	AI_StopProcessInfos(self);
};


instance DIA_Gerbrandt_Perm(C_Info)
{
	npc = VLK_403_Gerbrandt;
	nr = 800;
	condition = DIA_Gerbrandt_Perm_Condition;
	information = DIA_Gerbrandt_Perm_Info;
	permanent = TRUE;
	description = "Any news?";
};


func int DIA_Gerbrandt_Perm_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gerbrandt_Hello) || (DIEGO_COMING == 2))
	{
		return TRUE;
	};
};

func void DIA_Gerbrandt_Perm_Info()
{
	AI_Output(other,self,"DIA_Gerbrandt_Perm_15_00");	//Anything new?
	if(MIS_DiegosResidence != LOG_SUCCESS)
	{
		if(VisibleGuild(other) == GIL_PAL)
		{
			AI_Output(self,other,"DIA_Gerbrandt_Perm_10_03");	//I cannot complain, honorable Sir.
		}
		else if((VisibleGuild(other) == GIL_KDF) || (VisibleGuild(other) == GIL_KDW))
		{
			AI_Output(self,other,"DIA_Gerbrandt_Perm_10_06");	//That's nobody's business but mine. I'm busy!
		}
		else if((VisibleGuild(other) == GIL_SLD) || (VisibleGuild(other) == GIL_DJG))
		{
			AI_Output(self,other,"DIA_Gerbrandt_Perm_10_04");	//I have seen the likes of you - you simply don't know your place.
			AI_Output(self,other,"DIA_Gerbrandt_Perm_10_05");	//I shall have a talk with the governor concerning appropriate safety measures for the upper end of town.
		}
		else
		{
			AI_Output (self, other, "DIA_Gerbrandt_Perm_10_01");	//People like you have no business up here. This is where the respectable society resides, and not tramps or crooks.
			AI_Output (self, other, "DIA_Gerbrandt_Perm_10_02");	//If you should ever succeed in becoming wealthy and respectable, you might find yourself more welcome here.
		};
	}
	else
	{
		B_Gerbrandt_PissOff();
	};
};


instance DIA_Gerbrandt_GreetingsFromDiego(C_Info)
{
	npc = VLK_403_Gerbrandt;
	nr = 10;
	condition = DIA_Gerbrandt_GreetingsFromDiego_Condition;
	information = DIA_Gerbrandt_GreetingsFromDiego_Info;
	permanent = FALSE;
	description = "Diego says hello.";
};


func int DIA_Gerbrandt_GreetingsFromDiego_Condition()
{
	if((MIS_DiegosResidence == LOG_Running) && Npc_HasItems(other,ItWr_DiegosLetter_MIS))
	{
		return TRUE;
	};
};

func void DIA_Gerbrandt_GreetingsFromDiego_Info()
{
	AI_Output (other, self, "DIA_Gerbrandt_GreetingsFromDiego_15_00");	//Diego says hello.
	AI_Output (self, other, "DIA_Gerbrandt_GreetingsFromDiego_10_01");	//(scared) What? Who? What Diego?
	AI_Output (other, self, "DIA_Gerbrandt_GreetingsFromDiego_15_02");	//And he wants me to give you this letter.
	B_GiveInvItems (other, self, ItWr_DiegosLetter_MIS, 1);
	B_UseFakeScroll ();
	AI_Output (self, other, "DIA_Gerbrandt_GreetingsFromDiego_10_03");	//(agitated) That can't be. No. I'm a goner!
	AI_Output (self, other, "DIA_Gerbrandt_GreetingsFromDiego_10_04");	//(fearfully) Is he in town, then?
	AI_Output (other, self, "DIA_Gerbrandt_GreetingsFromDiego_15_05");	//Who?
	AI_Output (self, other, "DIA_Gerbrandt_GreetingsFromDiego_10_06");	//Diego, of course!
	AI_Output (other, self, "DIA_Gerbrandt_GreetingsFromDiego_15_07");	//Yes, I am going to meet him here shortly.
	AI_Output (self, other, "DIA_Gerbrandt_GreetingsFromDiego_10_08");	//(desperately, to himself) This is the end, then. All is lost.
	AI_Output (self, other, "DIA_Gerbrandt_GreetingsFromDiego_10_09");	//I've got no time, I need to get out of here. Quick. If he finds me here, I'm done for.
	MIS_DiegosResidence = LOG_SUCCESS;
	B_GivePlayerXP(XP_DiegosResidence);
	DIEGO_COMING = 1;
};

