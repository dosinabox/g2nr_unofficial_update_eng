
instance DIA_DiegoNW_EXIT(C_Info)
{
	npc = PC_Thief_NW;
	nr = 999;
	condition = DIA_DiegoNW_EXIT_Condition;
	information = DIA_DiegoNW_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_DiegoNW_EXIT_Condition()
{
	return TRUE;
};

func void DIA_DiegoNW_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_DiegoNW_Perm(C_Info)
{
	npc = PC_Thief_NW;
	nr = 800;
	condition = DIA_DiegoNW_Perm_Condition;
	information = DIA_DiegoNW_Perm_Info;
	permanent = TRUE;
	description = "How's business?";
};


func int DIA_DiegoNW_Perm_Condition()
{
	if((Diego_IsOnBoard == FALSE) && (Kapitel > 3))
	{
		return TRUE;
	};
};

func void DIA_DiegoNW_Perm_Info()
{
	AI_Output (other, self, "DIA_DiegoNW_Perm_15_00");	//How's business?
	AI_Output (self, other, "DIA_DiegoNW_Perm_11_01");	//Lousy. Somebody should have told me that Khorinis has gone to the dogs in the meantime.
	AI_Output (other, self, "DIA_DiegoNW_Perm_15_02");	//No idea. I've only known the city like this.
	AI_Output (self, other, "DIA_DiegoNW_Perm_11_03");	//You should have seen it a few years ago. You would have liked it then.
};


instance DIA_DiegoNW_NeedHelp(C_Info)
{
	npc = PC_Thief_NW;
	nr = 1;
	condition = DIA_DiegoNW_NeedHelp_Condition;
	information = DIA_DiegoNW_NeedHelp_Info;
	important = TRUE;
};


func int DIA_DiegoNW_NeedHelp_Condition()
{
	if(Diego_IsOnBoard == FALSE)
	{
		return TRUE;
	};
};

func void DIA_DiegoNW_NeedHelp_Info()
{
	if(Diego_IsDead == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_DiegoNW_NeedHelp_11_01");	//Hey, you look completely flabbergasted!
		AI_Output (self, other, "DIA_Addon_DiegoNW_NeedHelp_11_02");	//(laughs) You thought I had bought it, didn't you?
		AI_Output (self, other, "DIA_Addon_DiegoNW_NeedHelp_11_03");	//I was unconscious for quite some time. But, as you can see, I'm still alive.
		AI_Output (self, other, "DIA_Addon_DiegoNW_NeedHelp_11_04");	//The most important thing is that we're both here now.
		AI_Output (self, other, "DIA_Addon_DiegoNW_NeedHelp_11_05");	//You've got to help me.
	}
	else
	{
		AI_Output (self, other, "DIA_DiegoNW_NeedHelp_11_00");	//Good thing you're here. You need to help me.
	};
	Info_ClearChoices(DIA_DiegoNW_NeedHelp);
	if(!Npc_KnowsInfo(other,DIA_DiegoOW_Hallo))
	{
		Info_AddChoice(DIA_DiegoNW_NeedHelp,"Who are you?",DIA_DiegoNW_NeedHelp_WhoAreYou);
	};
	Info_AddChoice(DIA_DiegoNW_NeedHelp,"What kind of clothes are these?",DIA_DiegoNW_NeedHelp_Clothes);
	Info_AddChoice(DIA_DiegoNW_NeedHelp,"What are you doing here?",DIA_DiegoNW_NeedHelp_Plan);
};

func void DIA_DiegoNW_NeedHelp_Plan()
{
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Plan_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Plan_11_01");	//I've been observing the guards. They're constantly on their toes.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Plan_11_02");	//I don't think it will be easy for me to get through there.
};

func void DIA_DiegoNW_NeedHelp_WhoAreYou()
{
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_WhoAreYou_15_00");	//Who are you?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_WhoAreYou_11_01");	//I'm sure it's just my clothes. The guards won't let me into town.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_WhoAreYou_11_02");	//That's why I bought these togs from a trader outside of town. Now I hope you'll remember me. I am Diego.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_WhoAreYou_11_03");	//Back in the slammer, I taught you everything you needed to know to survive.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_WhoAreYou_11_04");	//You can't just have forgotten all that.
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_WhoAreYou_15_05");	//Er... what exactly happened back then?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_WhoAreYou_11_06");	//Holy shit, you really don't remember a thing.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_WhoAreYou_11_07");	//Listen I really don't have time to explain everything to you now. Only this much: we used to be damn good friends, and I saved your life more than once.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_WhoAreYou_11_08");	//And now I need your help.
};

func void DIA_DiegoNW_NeedHelp_Clothes()
{
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Clothes_15_00");	//What kind of clothes are these?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Clothes_11_01");	//I bought them from a trader outside of town. The guards wouldn't let me in at first.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Clothes_11_02");	//Also, there's no need to let the whole world know where I come from.
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Clothes_15_03");	//You've got a point there.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Clothes_11_04");	//That's the way I see it. But even though I have doffed my Shadow garb, I'm still who I always was.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Clothes_11_05");	//And I have big plans for this city.
	Info_AddChoice(DIA_DiegoNW_NeedHelp,"What plans?",DIA_DiegoNW_NeedHelp_Problem);
};

func void DIA_DiegoNW_NeedHelp_Problem()
{
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_15_00");	//What is this about?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_11_01");	//A lot of things have changed since I left here. I have to get back on my feet somehow.
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_15_02");	//What's the problem?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_11_03");	//I have to get into the upper quarter.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_11_04");	//But I'm not a citizen of the town, and I don't have enough money to bribe the guards. That's where you come in!
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_15_05");	//So you want me to lend you some gold?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_11_06");	//Nonsense. I've got some gold - a whole lot of gold, even! Unfortunately, I don't have it with me.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_11_07");	//You need to go fetch my gold for me.
	Info_AddChoice (DIA_DiegoNW_NeedHelp, "I've got no time for that.", DIA_DiegoNW_NeedHelp_Problem_NoTime);
	Info_AddChoice (DIA_DiegoNW_NeedHelp, "What's in it for me?", DIA_DiegoNW_NeedHelp_Problem_Reward);
	Info_AddChoice (DIA_DiegoNW_NeedHelp, "OK, I'll help you.", DIA_DiegoNW_NeedHelp_Problem_WillHelpYou);
};

func void DIA_DiegoNW_NeedHelp_Problem_NoTime()
{
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_NoTime_15_00");	//I've got no time for that.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_NoTime_11_01");	//Hey, I thought we were buddies! It was me, after all, who saved your butt back when they tossed you into the colony.
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_NoTime_15_02");	//You're exaggerating.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_NoTime_11_03");	//Am I, really? Then think for a minute about what would have happened if I hadn't explained to you back then how to behave.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_NoTime_11_04");	//The ore barons would have had you for breakfast, and you would have died miserably down in the mine.
	MIS_HelpDiegoNW = LOG_FAILED;
	Info_ClearChoices(DIA_DiegoNW_NeedHelp);
};

func void DIA_DiegoNW_NeedHelp_Problem_Reward()
{
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_Reward_15_00");	//What's in it for me?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_Reward_11_01");	//Have I ever asked you what you could give me in return? We are friends, shouldn't that be enough?
};

func void DIA_DiegoNW_NeedHelp_Problem_WillHelpYou()
{
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_15_00");	//OK, I'll help you.
	AI_Output (self, other, "DIA_Addon_DiegoNW_WillHelpYou_11_01");	//Well. Listen. Back when the Barrier was still in place, I hid a small treasure.
	AI_Output (self, other, "DIA_Addon_DiegoNW_WillHelpYou_11_02");	//It's been quite a while. That's why I forgot to take it with me.
	AI_Output (self, other, "DIA_Addon_DiegoNW_WillHelpYou_11_03");	//And I can't leave here at all at the moment.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_11_03");	//To cut a long story short, you must go to the Valley of Mines for me and fetch my gold.
	MIS_HelpDiegoNW = LOG_Running;
	Log_CreateTopic(TOPIC_HelpDiegoNW,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_HelpDiegoNW,LOG_Running);
	B_LogEntry (TOPIC_HelpDiegoNW, "Diego's gold is in the Valley of Mines. He needs it to get to the upper quarter and has sent me to get it.");
	Info_ClearChoices(DIA_DiegoNW_NeedHelp);
	Info_AddChoice(DIA_DiegoNW_NeedHelp,"What are you planning to do with the gold?",DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_YourPlan);
	Info_AddChoice(DIA_DiegoNW_NeedHelp,"Where did you get all that gold?",DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_HowGold);
	Info_AddChoice(DIA_DiegoNW_NeedHelp,"Where's the gold hidden?",DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_WhereGold);
	Info_AddChoice(DIA_DiegoNW_NeedHelp,"Why can't you fetch it yourself?",DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_Why);
};

func void DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_YourPlan()
{
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_YourPlan_15_00");	//What are you planning to do with the gold?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_YourPlan_11_01");	//I still have an account to settle with one of the merchants in the upper quarter. I need to take care of that.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_YourPlan_11_02");	//And then I'll be all set for a new career!
};

func void DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_HowGold()
{
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_HowGold_15_00");	//Where did you get all that gold?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_HowGold_11_01");	//Am I the only one, then, who put some gold aside for himself in the Valley of Mines?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_HowGold_11_02");	//Filching a few nuggets was a piece of cake. Just in case we ever got out of there.
	AI_Output (self, other, "DIA_Addon_DiegoNW_WillHelpYou_HowGold_11_03");	//Everybody was so keen on that ore that no-one even cared for gold at the time ...
};

func void DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_WhereGold()
{
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_WhereGold_15_00");	//Where's the gold hidden?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_WhereGold_11_01");	//Directly at the trading square. Above the abandoned mine. It's in a leather satchel.
	if(Diego_Nostalgie == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_DiegoNW_WillHelpYou_WhereGold_11_01");	//Spare yourself that comment. I know myself that we must have walked right past it.
		AI_Output (self, other, "DIA_Addon_DiegoNW_WillHelpYou_WhereGold_11_02");	//Just bring me the bag.
	}
	else
	{
		AI_Output(self,other,"DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_11_02");	//I was going to go and get it, but unfortunately there is a bunch of orcs hanging out near the stash.
	};
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_WhereGold_11_02");	//But don't forget to check that it's the right one so you don't walk all that way for nothing.
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_WhereGold_15_03");	//How can I recognize it?
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_WhereGold_11_04");	//It's full of gold. A whole lot of gold!
	Info_AddChoice (DIA_DiegoNW_NeedHelp, "I will try to find your gold.", DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_WhereGold_End_TryIt);
	B_LogEntry (TOPIC_HelpDiegoNW, "Diego's gold is somewhere at the old trading square, where goods used to be sent into the colony by cable railway, above the abandoned mine.");
};

func void DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_WhereGold_End_TryIt()
{
	AI_Output (other, self, "DIA_DiegoNW_NeedHelp_Problem_TryIt_15_00");	//I will try to find your gold.
	AI_Output (self, other, "DIA_DiegoNW_NeedHelp_Problem_TryIt_11_01");	//(grins) Just do it. That's enough for me.
	Info_ClearChoices(DIA_DiegoNW_NeedHelp);
};

func void DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_Why()
{
	AI_Output(other,self,"DIA_DiegoNW_HelpYou_15_04");	//Why can't you fetch it yourself?
	AI_Output(self,other,"DIA_DiegoNW_HelpYou_11_05");	//Because some orcs are hanging out near the stash, you're just the right person for this job, believe me.
};


instance DIA_DiegoNW_HelpYou(C_Info)
{
	npc = PC_Thief_NW;
	nr = 30;
	condition = DIA_DiegoNW_HelpYou_Condition;
	information = DIA_DiegoNW_HelpYou_Info;
	permanent = FALSE;
	description = "OK, I'll help you after all.";
};


func int DIA_DiegoNW_HelpYou_Condition()
{
	if((Diego_IsOnBoard == FALSE) && (MIS_HelpDiegoNW == LOG_FAILED) && (Diego_IsOnBoard != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_DiegoNW_HelpYou_Info()
{
	AI_Output (other, self, "DIA_DiegoNW_HelpYou_15_00");	//OK, I'll help you after all.
	AI_Output (self, other, "DIA_DiegoNW_HelpYou_11_01");	//I knew it.
	AI_Output (other, self, "DIA_DiegoNW_HelpYou_15_02");	//OK, let's get straight down to business.
	AI_Output (self, other, "DIA_DiegoNW_HelpYou_11_03");	//All right. I have hidden a treasure in the Valley of Mines, and you are to go and get it for me.
	AI_Output (self, other, "DIA_DiegoNW_HelpYou_11_06");	//I'll stay here in the meantime and prepare everything.
	DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_WhereGold();
	DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_Why();
	DIA_DiegoNW_NeedHelp_Problem_WillHelpYou_WhereGold_End_TryIt();
	MIS_HelpDiegoNW = LOG_Running;
	Log_CreateTopic(TOPIC_HelpDiegoNW,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_HelpDiegoNW,LOG_Running);
	B_LogEntry(TOPIC_HelpDiegoNW,"Diego's gold is in the Valley of Mines. He needs it to get to the upper quarter and has sent me to get it.");
};


func void B_DiegoNW_DiegosRevenge()
{
	if(!Npc_IsDead(Gerbrandt))
	{
		AI_Output(self,other,"DIA_DiegoNW_HaveYourGold_11_05");	//Very good. Gerbrandt had better watch out now.
	}
	else
	{
		B_Say(self,other,"$ABS_GOOD");
	};
	MIS_HelpDiegoNW = LOG_SUCCESS;
	B_GivePlayerXP(XP_HelpDiegoNW);
};

instance DIA_DiegoNW_HaveYourGold(C_Info)
{
	npc = PC_Thief_NW;
	nr = 31;
	condition = DIA_DiegoNW_HaveYourGold_Condition;
	information = DIA_DiegoNW_HaveYourGold_Info;
	permanent = TRUE;
	description = "I found your gold!";
};


func int DIA_DiegoNW_HaveYourGold_Condition()
{
	if(((OpenedDiegosBag == TRUE) || Npc_HasItems(other,ItSe_DiegosTreasure_Mis)) && (MIS_HelpDiegoNW == LOG_Running) && (Diego_IsOnBoard != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_DiegoNW_HaveYourGold_Info()
{
	AI_Output (other, self, "DIA_DiegoNW_HaveYourGold_15_00");	//I found your gold!
	AI_Output (self, other, "DIA_DiegoNW_HaveYourGold_11_01");	//Great. Show me.
	if(Npc_HasItems(other,ItSe_DiegosTreasure_Mis))
	{
		B_GiveInvItems(other,self,ItSe_DiegosTreasure_Mis,1);
		B_DiegoNW_DiegosRevenge();
	}
	else if(Npc_HasItems(other,ItMi_Gold) < DiegosTreasure)
	{
		AI_Output (self, other, "DIA_DiegoNW_HaveYourGold_11_02");	//But that's not all of it! Don't you trust me? I need the entire sum.
		AI_Output (self, other, "DIA_DiegoNW_HaveYourGold_11_03");	//If my plan works out, there will be enough left over for you.
		AI_Output (self, other, "DIA_DiegoNW_HaveYourGold_11_04");	//So make sure that I get the whole amount. It's important!
	}
	else
	{
		B_GiveInvItems(other,self,ItMi_Gold,DiegosTreasure);
		B_DiegoNW_DiegosRevenge();
	};
	if(!Npc_IsDead(Gerbrandt) && (MIS_HelpDiegoNW == LOG_SUCCESS))
	{
		AI_Output (self, other, "DIA_DiegoNW_HaveYourGold_11_06");	//Listen, I still need to take care of the guards.
		AI_Output (self, other, "DIA_DiegoNW_HaveYourGold_11_07");	//I want you to take this letter to Gerbrandt. He is one of the fat merchants in the upper quarter.
		AI_Output (self, other, "DIA_DiegoNW_HaveYourGold_11_08");	//Give him my regards. I'll meet you in front of Gerbrandt's house, then.
		CreateInvItems (self, ItWr_DiegosLetter_MIS, 1);
		B_GiveInvItems (self, other, ItWr_DiegosLetter_MIS, 1);
		B_StartOtherRoutine (Gerbrandt, "WaitForDiego");
		MIS_DiegosResidence = LOG_Running;
		Log_CreateTopic(TOPIC_DiegosResidence,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_DiegosResidence,LOG_Running);
		B_LogEntry(TOPIC_DiegosResidence,"Diego gave me a letter for the merchant Gerbrandt.");
		AI_StopProcessInfos(self);
	};
};


instance DIA_DiegoNW_DeliveredLetter(C_Info)
{
	npc = PC_Thief_NW;
	nr = 30;
	condition = DIA_DiegoNW_DeliveredLetter_Condition;
	information = DIA_DiegoNW_DeliveredLetter_Info;
	permanent = FALSE;
	description = "I delivered the letter.";
};


func int DIA_DiegoNW_DeliveredLetter_Condition()
{
	if((Diego_IsOnBoard == FALSE) && (MIS_DiegosResidence == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_DiegoNW_DeliveredLetter_Info()
{
	AI_Output (other, self, "DIA_DiegoNW_DeliveredLetter_15_00");	//I delivered the letter.
	AI_Output (self, other, "DIA_DiegoNW_DeliveredLetter_11_01");	//Very good. How did Gerbrandt take it?
	AI_Output (other, self, "DIA_DiegoNW_DeliveredLetter_15_02");	//He was rather shocked and made himself scarce right away.
	AI_Output (self, other, "DIA_DiegoNW_DeliveredLetter_11_03");	//(satisfied) I should think so.
	AI_Output (self, other, "DIA_DiegoNW_DeliveredLetter_11_04");	//I'm afraid that, first of all, I need to attend to furnishing my new house. If I remember correctly, Gerbrandt's taste is horrible.
	B_GivePlayerXP(XP_DiegoHasANewHome);
	Wld_AssignRoomToGuild("reich01",GIL_PUBLIC);
	B_StartOtherRoutine(Gerbrandt,"NEWLIFE");
	Info_ClearChoices(DIA_DiegoNW_DeliveredLetter);
	Info_AddChoice(DIA_DiegoNW_DeliveredLetter,Dialog_Back,DIA_DiegoNW_DeliveredLetter_YourTrick_BACK);
	Info_AddChoice(DIA_DiegoNW_DeliveredLetter,"What about my share?",DIA_DiegoNW_DeliveredLetter_YourTrick_REWARD);
	Info_AddChoice(DIA_DiegoNW_DeliveredLetter,"What about Gerbrandt",DIA_DiegoNW_DeliveredLetter_Gerbrandt);
	Info_AddChoice(DIA_DiegoNW_DeliveredLetter,"So how did you pull this off?",DIA_DiegoNW_DeliveredLetter_YourTrick);
	Info_AddChoice(DIA_DiegoNW_DeliveredLetter,"The house is yours, then?",DIA_DiegoNW_DeliveredLetter_YourHouse);
};

func void DIA_DiegoNW_DeliveredLetter_Gerbrandt()
{
	AI_Output (other, self, "DIA_DiegoNW_TalkedToJudge_Gerbrandt_15_00");	//What about Gerbrandt?
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_Gerbrandt_11_01");	//He has enjoyed the good life for far too long.
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_Gerbrandt_11_02");	//He was living here, in the lap of luxury, while I was forcing down meatbug stew.
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_Gerbrandt_11_03");	//I have no idea where he went from here, but he'll never get a foothold in Khorinis again - I'll see to that.
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_Gerbrandt_11_04");	//If you're looking for him, you should try the harbor district.
};

func void DIA_DiegoNW_DeliveredLetter_YourHouse()
{
	AI_Output (other, self, "DIA_DiegoNW_TalkedToJudge_YourHouse_15_00");	//The house is yours, then?
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_YourHouse_11_01");	//Yes, from cellar to attic, with all the furnishings.
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_YourHouse_11_02");	//Having spent several years in less-than-befitting quarters, I'm looking forward to sleeping in a soft four-poster bed.
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_YourHouse_11_03");	//And then, for breakfast, I'll have a fine wine and some excellent ham.
	AI_Output (other, self, "DIA_DiegoNW_TalkedToJudge_YourHouse_15_04");	//You don't miss any chances, do you?
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_YourHouse_11_05");	//You betcha.
};

func void DIA_DiegoNW_DeliveredLetter_YourTrick()
{
	AI_Output (other, self, "DIA_DiegoNW_TalkedToJudge_YourTrick_15_00");	//So how did you pull this off?
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_YourTrick_11_01");	//Did you think that Gerbrandt came by his fortune through honest business?
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_YourTrick_11_02");	//Of course he never got his fingers dirty when it came to really shady deals. He had a helper for that.
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_YourTrick_11_03");	//Of course, I caught on to a lot back then. Gerbrandt finally got rid of me. He was probably afraid that I knew too much.
	AI_Output (other, self, "DIA_DiegoNW_TalkedToJudge_YourTrick_15_04");	//You never told me about that.
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_YourTrick_11_05");	//You never asked me.
};

func void DIA_DiegoNW_DeliveredLetter_YourTrick_REWARD()
{
	AI_Output (other, self, "DIA_DiegoNW_TalkedToJudge_YourTrick_REWARD_15_00");	//What about my share?
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_YourTrick_REWARD_11_01");	//Looks like you haven't forgotten everything I've taught you after all.
	AI_Output (self, other, "DIA_DiegoNW_TalkedToJudge_YourTrick_REWARD_11_02");	//But you're right, I couldn't have done it without you. Here's your share.
	CreateInvItems (self, ItMi_Gold, 500);
	B_GiveInvItems (self, other, ItMi_Gold, 500);
};

func void DIA_DiegoNW_DeliveredLetter_YourTrick_BACK()
{
	Info_ClearChoices(DIA_DiegoNW_DeliveredLetter);
};


var int Diego_Teach;

instance DIA_DiegoNW_CanYouTeach(C_Info)
{
	npc = PC_Thief_NW;
	nr = 888;
	condition = DIA_DiegoNW_CanYouTeach_Condition;
	information = DIA_DiegoNW_CanYouTeach_Info;
	permanent = TRUE;
	description = "Can you teach me something?";
};


func int DIA_DiegoNW_CanYouTeach_Condition()
{
//	if((Diego_IsOnBoard == FALSE) && (Diego_Teach == FALSE))
	if(Diego_Teach == FALSE)
	{
		return TRUE;
	};
};

func void DIA_DiegoNW_CanYouTeach_Info()
{
	AI_Output (other, self, "DIA_DiegoNW_CanYouTeach_15_00");	//Can you teach me something?
	if (Npc_KnowsInfo (other, DIA_DiegoNW_DeliveredLetter))
	{
		AI_Output(self,other,"DIA_DiegoNW_CanYouTeach_11_01");	//Yeah, sure. Just let me know when you're ready.
		if(DiegoOW_Teach == FALSE)
		{
			Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
			B_LogEntry(TOPIC_CityTeacher,"Diego can increase my strength and dexterity?");
		};
		Diego_Teach = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_DiegoOW_Teach_11_01");	//There is no time for that. I really have more important things to do.
		AI_Output(self,other,"DIA_DiegoNW_CanYouTeach_11_02");	//I have to attend to my business first.
	};
};


var int DiegoNW_Merke_DEX;
var int DiegoNW_Merke_STR;

func void B_BuildLearnDialog_Diego_NW()
{
	Info_ClearChoices(DIA_DiegoNW_Teach);
	Info_AddChoice(DIA_DiegoNW_Teach,Dialog_Back,DIA_DiegoNW_Teach_BACK);
	Info_AddChoice(DIA_DiegoNW_Teach,B_BuildLearnString(PRINT_LearnDEX1,B_GetLearnCostAttribute(other,ATR_DEXTERITY)),DIA_DiegoNW_TeachDEX_1);
	Info_AddChoice(DIA_DiegoNW_Teach,B_BuildLearnString(PRINT_LearnDEX5,B_GetLearnCostAttribute(other,ATR_DEXTERITY) * 5),DIA_DiegoNW_TeachDEX_5);
	Info_AddChoice(DIA_DiegoNW_Teach,B_BuildLearnString(PRINT_LearnSTR1,B_GetLearnCostAttribute(other,ATR_STRENGTH)),DIA_DiegoNW_TeachSTR_1);
	Info_AddChoice(DIA_DiegoNW_Teach,B_BuildLearnString(PRINT_LearnSTR5,B_GetLearnCostAttribute(other,ATR_STRENGTH) * 5),DIA_DiegoNW_TeachSTR_5);
};

instance DIA_DiegoNW_Teach(C_Info)
{
	npc = PC_Thief_NW;
	nr = 888;
	condition = DIA_DiegoNW_Teach_Condition;
	information = DIA_DiegoNW_Teach_Info;
	permanent = TRUE;
	description = "Teach me something.";
};


func int DIA_DiegoNW_Teach_Condition()
{
	if(Diego_Teach == TRUE)
	{
		return TRUE;
	};
};

func void DIA_DiegoNW_Teach_Info()
{
	AI_Output(other,self,"DIA_DiegoNW_Teach_15_00");	//Teach me.
	AI_Output(self,other,"DIA_Addon_DiegoOw_Teach_11_01");	//I can teach you to become more dexterous.
	DiegoNW_Merke_DEX = other.aivar[REAL_DEXTERITY];
	DiegoNW_Merke_STR = other.aivar[REAL_STRENGTH];
	B_BuildLearnDialog_Diego_NW();
};

func void DIA_DiegoNW_Teach_BACK()
{
	if(DiegoNW_Merke_DEX < other.aivar[REAL_DEXTERITY])
	{
		AI_Output (self, other, "DIA_DiegoNW_Teach_BACK_11_00");	//You've become more dexterous already. Keep it up!
	};
	if(DiegoNW_Merke_STR < other.aivar[REAL_STRENGTH])
	{
		AI_Output(self,other,"DIA_Addon_DiegoOw_Teach_11_03");	//(appraisingly) Good. Your strength has increased.
	};
	Info_ClearChoices(DIA_DiegoNW_Teach);
};

func void DIA_DiegoNW_TeachDEX_1()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,1,T_MAX))
	{
		B_BuildLearnDialog_Diego_NW();
	};
};

func void DIA_DiegoNW_TeachDEX_5()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,5,T_MAX))
	{
		B_BuildLearnDialog_Diego_NW();
	};
};

func void DIA_DiegoNW_TeachSTR_1()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,1,T_MED))
	{
		B_BuildLearnDialog_Diego_NW();
	};
};

func void DIA_DiegoNW_TeachSTR_5()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,5,T_MED))
	{
		B_BuildLearnDialog_Diego_NW();
	};
};


instance DIA_DiegoNW_KnowWhereEnemy(C_Info)
{
	npc = PC_Thief_NW;
	nr = 55;
	condition = DIA_DiegoNW_KnowWhereEnemy_Condition;
	information = DIA_DiegoNW_KnowWhereEnemy_Info;
	permanent = TRUE;
	description = "I'm going to leave Khorinis.";
};


func int DIA_DiegoNW_KnowWhereEnemy_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && (Diego_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_DiegoNW_KnowWhereEnemy_Info()
{
	AI_Output (other, self, "DIA_DiegoNW_KnowWhereEnemy_15_00");	//I'm going to leave Khorinis.
	AI_Output (self, other, "DIA_DiegoNW_KnowWhereEnemy_11_01");	//A wise decision. I wish I could come with you. This town has changed too fast - the times where you could get rich fast are over.
	AI_Output (self, other, "DIA_DiegoNW_KnowWhereEnemy_11_02");	//I could instruct you in archery, lock picking, and dexterity.
	AI_Output (self, other, "DIA_DiegoNW_KnowWhereEnemy_11_03");	//Also, I'm sure you can use a decent thief.
	if(SCToldDiegoHeKnowWhereEnemy == FALSE)
	{
		B_LogEntry(Topic_Crew,"Of course, Diego wants to come along. The way he sees it, the sooner he leaves Khorinis, the better. He could show me how to become more dexterous, and train me to be a good archer. He can also teach me how to pick locks.");
		SCToldDiegoHeKnowWhereEnemy = TRUE;
	};
	if(Crewmember_Count >= Max_Crew)
	{
		AI_Output (other, self, "DIA_DiegoNW_KnowWhereEnemy_15_04");	//I'll think about it. At the moment, my crew is already complete.
		AI_Output (self, other, "DIA_DiegoNW_KnowWhereEnemy_11_05");	//Take your time. I'm not going anywhere.
	}
	else
	{
		Info_ClearChoices (DIA_DiegoNW_KnowWhereEnemy);
		Info_AddChoice (DIA_DiegoNW_KnowWhereEnemy, "Maybe I'll let you know when the time comes.", DIA_DiegoNW_KnowWhereEnemy_No);
		Info_AddChoice (DIA_DiegoNW_KnowWhereEnemy, "Won't you come along?", DIA_DiegoNW_KnowWhereEnemy_Yes);
	};
};

func void DIA_DiegoNW_KnowWhereEnemy_Yes()
{
	AI_Output (other, self, "DIA_DiegoNW_KnowWhereEnemy_Yes_15_00");	//Why don't you come with me? We'll meet at the harbor.
	AI_Output (self, other, "DIA_DiegoNW_KnowWhereEnemy_Yes_11_01");	//Mmh. You're right, Khorinis is a dump. I'm coming with you.
	if(Hlp_StrCmp(Npc_GetNearestWP(self),"NW_CITY_UPTOWN_PATH_23") && !ArmorEquipped(self,ITAR_Diego))
	{
		AI_Output(self,other,"DIA_DiegoNW_KnowWhereEnemy_Yes_11_02");	//Wait, I'll be ready in a second.
		AI_SetWalkMode(self,NPC_RUN);
		AI_GotoWP(self,"NW_CITY_UPTOWN_HUT_01_01");
		if(!Npc_HasItems(self,ITAR_Diego))
		{
			CreateInvItems(self,ITAR_Diego,1);
		};
		AI_EquipArmor(self,ITAR_Diego);
		AI_Wait(self,1);
		AI_GotoWP(self,"NW_CITY_UPTOWN_PATH_23");
	};
	AI_Output(self,other,"DIA_DiegoNW_KnowWhereEnemy_Yes_11_03");	//Well, I'm ready. I'll see you at the ship.
	B_JoinShip(self);
};

func void DIA_DiegoNW_KnowWhereEnemy_No()
{
	AI_Output (other, self, "DIA_DiegoNW_KnowWhereEnemy_No_15_00");	//Maybe I'll let you know when the time has come.
	AI_Output (self, other, "DIA_DiegoNW_KnowWhereEnemy_No_11_01");	//You do that. And maybe I'll even go with you. Who knows?
	Diego_IsOnBoard = LOG_OBSOLETE;
	Info_ClearChoices(DIA_DiegoNW_KnowWhereEnemy);
};


instance DIA_DiegoNW_LeaveMyShip(C_Info)
{
	npc = PC_Thief_NW;
	nr = 55;
	condition = DIA_DiegoNW_LeaveMyShip_Condition;
	information = DIA_DiegoNW_LeaveMyShip_Info;
	permanent = TRUE;
	description = "You take care of the city.";
};


func int DIA_DiegoNW_LeaveMyShip_Condition()
{
	if((Diego_IsOnBoard == LOG_SUCCESS) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_DiegoNW_LeaveMyShip_Info()
{
	AI_Output (other, self, "DIA_DiegoNW_LeaveMyShip_15_00");	//You take care of the city.
	AI_Output (self, other, "DIA_DiegoNW_LeaveMyShip_11_01");	//Really? You don't need me any more? Oh well. Don't forget to drop by when you're back in town.
	AI_Output (other, self, "DIA_DiegoNW_LeaveMyShip_15_02");	//You think we'll meet again?
	AI_Output (self, other, "DIA_DiegoNW_LeaveMyShip_11_03");	//I shall never forget the look on your face when you lay on the ground after Bullit knocked you down and we met for the first time.
	AI_Output (self, other, "DIA_DiegoNW_LeaveMyShip_11_04");	//They can't get the better of someone like you. We SHALL meet again. Take care.
	if(!Npc_HasItems(self,ITAR_Vlk_H))
	{
		CreateInvItems(self,ITAR_Vlk_H,1);
	};
	if(!ArmorEquipped(self,ITAR_Vlk_H))
	{
		AI_EquipArmor(self,ITAR_Vlk_H);
	};
	Diego_IsOnBoard = LOG_OBSOLETE;
	Crewmember_Count -= 1;
	if(MIS_DiegosResidence == LOG_SUCCESS)
	{
		Npc_ExchangeRoutine(self,"GERBRANDT");
	}
	else
	{
		Npc_ExchangeRoutine(self,"START");
	};
};


instance DIA_DiegoNW_StillNeedYou(C_Info)
{
	npc = PC_Thief_NW;
	nr = 55;
	condition = DIA_DiegoNW_StillNeedYou_Condition;
	information = DIA_DiegoNW_StillNeedYou_Info;
	permanent = TRUE;
	description = "Come back. I want you to accompany me.";
};


func int DIA_DiegoNW_StillNeedYou_Condition()
{
	if(((Diego_IsOnBoard == LOG_OBSOLETE) || (Diego_IsOnBoard == LOG_FAILED)) && (Crewmember_Count < Max_Crew))
	{
		if(Diego_WasOnBoard == TRUE)
		{
			DIA_DiegoNW_StillNeedYou.description = "Come back. I want you to accompany me.";
		}
		else
		{
			DIA_DiegoNW_StillNeedYou.description = "I could use your help.";
		};
		return TRUE;
	};
};

func void DIA_DiegoNW_StillNeedYou_Info()
{
	if(Diego_WasOnBoard == TRUE)
	{
		AI_Output(other,self,"DIA_DiegoNW_StillNeedYou_15_00");	//Come back. I want you to accompany me.
		AI_Output(self,other,"DIA_DiegoNW_StillNeedYou_11_01");	//What has become of your determination, my friend? Sure I'll go with you - just make up your mind.
	}
	else
	{
		DIA_Common_INeedYourHelp();
	};
	if(Hlp_StrCmp(Npc_GetNearestWP(self),"NW_CITY_UPTOWN_PATH_23") && !ArmorEquipped(self,ITAR_Diego))
	{
		AI_Output(self,other,"DIA_DiegoNW_StillNeedYou_11_02");	//Wait, I'll be ready in a second.
		AI_SetWalkMode(self,NPC_RUN);
		AI_GotoWP(self,"NW_CITY_UPTOWN_HUT_01_01");
		if(!Npc_HasItems(self,ITAR_Diego))
		{
			CreateInvItems(self,ITAR_Diego,1);
		};
		AI_EquipArmor(self,ITAR_Diego);
		AI_Wait(self,1);
		AI_GotoWP(self,"NW_CITY_UPTOWN_PATH_23");
	};
	AI_Output(self,other,"DIA_DiegoNW_StillNeedYou_11_03");	//All right, we can go.
	B_JoinShip(self);
};


instance DIA_Thief_NW_PICKPOCKET(C_Info)
{
	npc = PC_Thief_NW;
	nr = 900;
	condition = DIA_Thief_NW_PICKPOCKET_Condition;
	information = DIA_Thief_NW_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_120;
};


func int DIA_Thief_NW_PICKPOCKET_Condition()
{
	return C_Beklauen(120,600);
};

func void DIA_Thief_NW_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Thief_NW_PICKPOCKET);
	Info_AddChoice(DIA_Thief_NW_PICKPOCKET,Dialog_Back,DIA_Thief_NW_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Thief_NW_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Thief_NW_PICKPOCKET_DoIt);
};

func void DIA_Thief_NW_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Thief_NW_PICKPOCKET);
};

func void DIA_Thief_NW_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Thief_NW_PICKPOCKET);
};

