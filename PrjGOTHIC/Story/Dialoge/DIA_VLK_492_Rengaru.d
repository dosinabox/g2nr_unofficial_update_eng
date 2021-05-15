
instance DIA_Rengaru_EXIT(C_Info)
{
	npc = VLK_492_Rengaru;
	nr = 999;
	condition = DIA_Rengaru_EXIT_Condition;
	information = DIA_Rengaru_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Rengaru_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Rengaru_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Rengaru_PICKPOCKET(C_Info)
{
	npc = VLK_492_Rengaru;
	nr = 900;
	condition = DIA_Rengaru_PICKPOCKET_Condition;
	information = DIA_Rengaru_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Rengaru_PICKPOCKET_Condition()
{
	if(Npc_HasItems(self,ItMi_Gold) > 5)
	{
		return C_Beklauen(20,5);
	};
	return FALSE;
};

func void DIA_Rengaru_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Rengaru_PICKPOCKET);
	Info_AddChoice(DIA_Rengaru_PICKPOCKET,Dialog_Back,DIA_Rengaru_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Rengaru_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Rengaru_PICKPOCKET_DoIt);
};

func void DIA_Rengaru_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Rengaru_PICKPOCKET);
};

func void DIA_Rengaru_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Rengaru_PICKPOCKET);
};


instance DIA_Rengaru_Hauab(C_Info)
{
	npc = VLK_492_Rengaru;
	nr = 2;
	condition = DIA_Rengaru_Hauab_Condition;
	information = DIA_Rengaru_Hauab_Info;
	permanent = TRUE;
	description = "What are you doing here?";
};


func int DIA_Rengaru_Hauab_Condition()
{
	if((Jora_Dieb == FALSE) && !Npc_KnowsInfo(other,DIA_Rengaru_GOTYOU))
	{
		return TRUE;
	};
};

func void DIA_Rengaru_Hauab_Info()
{
	DIA_Common_WhatAreYouDoingHere();
	AI_Output(self,other,"DIA_Rengaru_Hauab_07_01");	//I wouldn't know how that is any of your business. Get lost!
	AI_StopProcessInfos(self);
};


instance DIA_Rengaru_HALLODIEB(C_Info)
{
	npc = VLK_492_Rengaru;
	nr = 2;
	condition = DIA_Rengaru_HALLODIEB_Condition;
	information = DIA_Rengaru_HALLODIEB_Info;
	permanent = FALSE;
	description = "Jora says you've got his money ...";
};


func int DIA_Rengaru_HALLODIEB_Condition()
{
	if(Jora_Dieb == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Rengaru_HALLODIEB_Info()
{
	AI_Output (other, self, "DIA_Rengaru_HALLODIEB_15_00");	//Jora says you've got his money...
	AI_Output (self, other, "DIA_Rengaru_HALLODIEB_07_01");	//Damnit! I'm outta here!
	self.aivar[AIV_ToughGuy] = TRUE;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"RunAway");
};


var int RengaruGold;

func void B_Rengaru_NoGoldReason()
{
	if(self.aivar[AIV_PlayerHasPickedMyPocket] == TRUE)
	{
		AI_Output(self,other,"DIA_Rengaru_GOTYOU_YouThief_07_03");	//But why am I telling you that? You've robbed me already!
	}
	else if(self.aivar[AIV_DefeatedByPlayer] == TRUE)
	{
		AI_Output(self,other,"DIA_Rengaru_GOTYOU_Anteil_07_01");	//You already took everything I had after you knocked me to the ground! So let me go!
	};
};

instance DIA_Rengaru_GOTYOU(C_Info)
{
	npc = VLK_492_Rengaru;
	nr = 3;
	condition = DIA_Rengaru_GOTYOU_Condition;
	information = DIA_Rengaru_GOTYOU_Info;
	permanent = FALSE;
	description = "Gotcha!";
};


func int DIA_Rengaru_GOTYOU_Condition()
{
	if(C_RengaruIsReadyToTalk() && Npc_KnowsInfo(other,DIA_Rengaru_HALLODIEB))
	{
		return TRUE;
	};
};

func void DIA_Rengaru_GOTYOU_Info()
{
	AI_Output (other, self, "DIA_Rengaru_GOTYOU_15_00");	//Gotcha!
	AI_Output (self, other, "DIA_Rengaru_GOTYOU_07_01");	//What do you want from me?
	AI_Output (other, self, "DIA_Rengaru_GOTYOU_15_02");	//You stole from Jora in broad daylight, and he even saw you do it.
	AI_Output (other, self, "DIA_Rengaru_GOTYOU_15_03");	//So I've come to tell you that you're a lousy thief, and that...
	B_GivePlayerXP(XP_RengaruGotThief);
	RengaruGold = Npc_HasItems(self,ItMi_Gold);
	Info_ClearChoices(DIA_Rengaru_GOTYOU);
	Info_AddChoice (DIA_Rengaru_GOTYOU, "...I deserve a share of the loot.", DIA_Rengaru_GOTYOU_Anteil);
	Info_AddChoice (DIA_Rengaru_GOTYOU, "...you had better hand over Jora's gold now.", DIA_Rengaru_GOTYOU_YouThief);
	Info_AddChoice (DIA_Rengaru_GOTYOU, "...and now you tell me who you are.", DIA_Rengaru_GOTYOU_WhoAreYou);
};

func void DIA_Rengaru_GOTYOU_YouThief()
{
	AI_Output(other,self,"DIA_Rengaru_GOTYOU_YouThief_15_00");	//...you had better hand over Jora's gold now.
	if(RengaruGold >= 50)
	{
		AI_Output(self,other,"DIA_Rengaru_GOTYOU_YouThief_07_01");	//Here's the dough, man! But now let me go, I'll never do it again.
		B_GiveInvItems(self,other,ItMi_Gold,50);
	}
	else if(RengaruGold > 0)
	{
		AI_Output(self,other,"DIA_Rengaru_GOTYOU_YouThief_07_02");	//I haven't got the gold any more.
		B_Rengaru_NoGoldReason();
	}
	else
	{
		AI_Output(self,other,"DIA_Rengaru_GOTYOU_Anteil_alles_07_03");	//But why am I telling you that? You've robbed me already!
		B_Rengaru_NoGoldReason();
	};
	Info_ClearChoices(DIA_Rengaru_GOTYOU);
};

func void DIA_Rengaru_GOTYOU_Anteil()
{
	AI_Output(other,self,"DIA_Rengaru_GOTYOU_Anteil_15_00");	//...I deserve a share of the loot.
	if(RengaruGold >= 25)
	{
		AI_Output(self,other,"DIA_Rengaru_GOTYOU_Anteil_GehtKlar_07_01");	//Here's your half! And now let me go!
		Info_ClearChoices(DIA_Rengaru_GOTYOU);
		Info_AddChoice(DIA_Rengaru_GOTYOU,"No - you give me everything!",DIA_Rengaru_GOTYOU_Anteil_alles);
		Info_AddChoice(DIA_Rengaru_GOTYOU,"All right, give me half, then.",DIA_Rengaru_GOTYOU_Anteil_GehtKlar);
	}
	else if(RengaruGold > 0)
	{
		AI_Output(self,other,"DIA_Rengaru_GOTYOU_Anteil_alles_07_02");	//So you're plundering me. Well, take the gold, then. And now leave me alone.
		B_GiveInvItems(self,other,ItMi_Gold,RengaruGold);
		Info_ClearChoices(DIA_Rengaru_GOTYOU);
	}
	else
	{
		AI_Output(self,other,"DIA_Rengaru_GOTYOU_Anteil_GehtKlar_07_02");	//I wouldn't mind giving you half of the gold, but I haven't got it any more.
		B_Rengaru_NoGoldReason();
		Info_ClearChoices(DIA_Rengaru_GOTYOU);
	};
};

func void DIA_Rengaru_GOTYOU_Anteil_alles()
{
	AI_Output(other,self,"DIA_Rengaru_GOTYOU_Anteil_alles_15_00");	//No - you give me everything!
	AI_Output(self,other,"DIA_Rengaru_GOTYOU_Anteil_alles_07_02");	//So you're plundering me. Well, take the gold, then. And now leave me alone.
	B_GiveInvItems(self,other,ItMi_Gold,RengaruGold);
	Info_ClearChoices(DIA_Rengaru_GOTYOU);
};

func void DIA_Rengaru_GOTYOU_Anteil_GehtKlar()
{
	AI_Output(other,self,"DIA_Rengaru_GOTYOU_Anteil_GehtKlar_15_00");	//All right, give me half, then.
	AI_Output(self,other,"DIA_Rengaru_GOTYOU_YouThief_07_01");	//Here's the dough, man! But now let me go, I'll never do it again.
	B_GiveInvItems(self,other,ItMi_Gold,25);
	Info_ClearChoices(DIA_Rengaru_GOTYOU);
};

func void DIA_Rengaru_GOTYOU_WhoAreYou()
{
	AI_Output (other, self, "DIA_Rengaru_GOTYOU_WhoAreYou_15_00");	//...and now you tell me who you are.
	AI_Output (self, other, "DIA_Rengaru_GOTYOU_WhoAreYou_07_01");	//I'm nothing but a poor wretch, trying to make ends meet one way or another.
	AI_Output (self, other, "DIA_Rengaru_GOTYOU_WhoAreYou_07_02");	//What else can I do? I can't find a job in town ...
	AI_Output (other, self, "DIA_Rengaru_GOTYOU_WhoAreYou_15_03");	//...all right, I see. Spare me your whining.
};


instance DIA_Rengaru_INKNAST(C_Info)
{
	npc = VLK_492_Rengaru;
	nr = 4;
	condition = DIA_Rengaru_INKNAST_Condition;
	information = DIA_Rengaru_INKNAST_Info;
	permanent = FALSE;
	description = "I should turn you in to the militia.";
};


func int DIA_Rengaru_INKNAST_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rengaru_GOTYOU) && !Npc_KnowsInfo(other,DIA_Rengaru_SPARE))
	{
		return TRUE;
	};
};

func void DIA_Rengaru_INKNAST_Info()
{
	AI_Output (other, self, "DIA_Rengaru_INKNAST_15_00");	//I should turn you in to the militia.
	AI_Output (self, other, "DIA_Rengaru_INKNAST_07_01");	//What else do you want? I've got nothing left! Let me go, man!
	Info_AddChoice (DIA_Rengaru_INKNAST, "Why would I want to do that?", DIA_Rengaru_INKNAST_keinKnast);
	Info_AddChoice (DIA_Rengaru_INKNAST, "I'll see to it that you are put behind bars.", DIA_Rengaru_INKNAST_Knast);
	Info_AddChoice (DIA_Rengaru_INKNAST, "Get lost! And don't show your face around here again!", DIA_Rengaru_INKNAST_HauAb);
};

func void DIA_Rengaru_INKNAST_HauAb()
{
	AI_Output (other, self, "DIA_Rengaru_INKNAST_HauAb_15_00");	//Get lost! And don't show your face around here again!
	AI_Output (self, other, "DIA_Rengaru_INKNAST_HauAb_07_01");	//You won't regret this! Thanks, man!
	self.aivar[AIV_ToughGuy] = FALSE;
	Npc_ExchangeRoutine(self,"Start");
	AI_StopProcessInfos(self);
	Diebesgilde_Okay += 1;
};

func void DIA_Rengaru_INKNAST_Knast()
{
	AI_Output (other, self, "DIA_Rengaru_INKNAST_Knast_15_00");	//I'll see to it that you are put behind bars.
	AI_Output (self, other, "DIA_Rengaru_INKNAST_Knast_07_01");	//(tired) I don't want any more trouble. If you think that's what you should do, then be my guest.
	AI_Output (self, other, "DIA_Rengaru_INKNAST_Knast_07_02");	//(warning) Be careful, though - my friends are not going to like what you're pulling here ...
	Rengaru_InKnast = TRUE;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"Hide");
};

func void DIA_Rengaru_INKNAST_keinKnast()
{
	AI_Output (other, self, "DIA_Rengaru_INKNAST_keinKnast_15_00");	//Why would I want to do that?
	AI_Output (self, other, "DIA_Rengaru_INKNAST_keinKnast_07_01");	//In the city, it's always good to know the right people - and to stay on their good side.
	AI_Output (self, other, "DIA_Rengaru_INKNAST_keinKnast_07_02");	//I could put in a good word for you. I can't and won't say more. The rest is up to you.
};


instance DIA_Rengaru_SPARE(C_Info)
{
	npc = VLK_492_Rengaru;
	nr = 5;
	condition = DIA_Rengaru_SPARE_Condition;
	information = DIA_Rengaru_SPARE_Info;
	permanent = FALSE;
	description = "Get lost! And don't show your face around here again!";
};


func int DIA_Rengaru_SPARE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rengaru_GOTYOU) && !Npc_KnowsInfo(other,DIA_Rengaru_INKNAST))
	{
		return TRUE;
	};
};

func void DIA_Rengaru_SPARE_Info()
{
	AI_Output(other,self,"DIA_Rengaru_INKNAST_HauAb_15_00");	//Get lost! And don't show your face around here again!
	AI_Output(self,other,"DIA_Rengaru_INKNAST_HauAb_07_01");	//You won't regret this! Thanks, man!
	self.aivar[AIV_ToughGuy] = FALSE;
	Npc_ExchangeRoutine(self,"Start");
	AI_StopProcessInfos(self);
	Diebesgilde_Okay += 1;
};


instance DIA_Rengaru_LastInfoKap1(C_Info)
{
	npc = VLK_492_Rengaru;
	nr = 6;
	condition = DIA_Rengaru_LastInfoKap1_Condition;
	information = DIA_Rengaru_LastInfoKap1_Info;
	permanent = TRUE;
	description = "So? Doing all right?";
};


func int DIA_Rengaru_LastInfoKap1_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rengaru_INKNAST) || Npc_KnowsInfo(other,DIA_Rengaru_SPARE))
	{
		return TRUE;
	};
};

func void DIA_Rengaru_LastInfoKap1_Info()
{
	AI_Output (other, self, "DIA_Rengaru_LastInfoKap1_15_00");	//So? Doing all right?
	if (Rengaru_InKnast == TRUE)
	{
		AI_Output (self, other, "DIA_Rengaru_LastInfoKap1_07_01");	//Go ahead, mock me. Eventually, you'll get what's due to you, I swear!
	}
	else
	{
		AI_Output (self, other, "DIA_Rengaru_LastInfoKap1_07_02");	//What else do you want? I didn't steal anything else, honest, man!
	};
};


instance DIA_Rengaru_Zeichen(C_Info)
{
	npc = VLK_492_Rengaru;
	nr = 800;
	condition = DIA_Rengaru_Zeichen_Condition;
	information = DIA_Rengaru_Zeichen_Info;
	permanent = FALSE;
	description = DIALOG_SecretSign;
};


func int DIA_Rengaru_Zeichen_Condition()
{
	if((Knows_SecretSign == TRUE) && (Rengaru_InKnast == FALSE) && Npc_KnowsInfo(other,DIA_Rengaru_GOTYOU))
	{
		return TRUE;
	};
};

func void DIA_Rengaru_Zeichen_Info()
{
	AI_PlayAni (other, "T_YES");
	AI_Output (self, other, "DIA_Rengaru_Zeichen_07_00");	//Hey, you're one of us.
	AI_Output (self, other, "DIA_Rengaru_Zeichen_07_01");	//Let me tell you something. If you intend to empty some pockets in town, be especially careful with the merchants!
	AI_Output (self, other, "DIA_Rengaru_Zeichen_07_02");	//They are pretty sharp at watching their stuff. But I can give you a tip.
	AI_Output (self, other, "DIA_Rengaru_Zeichen_07_03");	//Try to grab the desired object with one hand, and wave about with the other. That distracts them.
	B_RaiseAttribute (other, ATR_DEXTERITY, 1);
	Snd_Play ("LEVELUP");
};

