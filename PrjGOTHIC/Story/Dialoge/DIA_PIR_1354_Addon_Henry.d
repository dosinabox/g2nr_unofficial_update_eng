
instance DIA_Addon_Henry_EXIT(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 999;
	condition = DIA_Addon_Henry_EXIT_Condition;
	information = DIA_Addon_Henry_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Henry_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Henry_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

func void B_Henry_Gold(var int gold)
{
	if(gold == 500)
	{
		AI_Output (self, other, "DIA_Addon_Henry_Gold500_04_00");	//500 gold pieces.
	}
	else if(gold == 400)
	{
		AI_Output (self, other, "DIA_Addon_Henry_Gold400_04_00");	//400 gold pieces.
	}
	else if(gold == 300)
	{
		AI_Output (self, other, "DIA_Addon_Henry_Gold300_04_00");	//300 gold pieces.
	}
	else if(gold == 200)
	{
		AI_Output (self, other, "DIA_Addon_Henry_Gold200_04_00");	//200 gold pieces.
	}
	else if(gold == 100)
	{
		AI_Output (self, other, "DIA_Addon_Henry_Gold100_04_00");	//100 gold pieces.
	}
	else
	{
		B_Say_Gold(self,other,gold);
	};
};


instance DIA_Addon_Henry_PICKPOCKET(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 900;
	condition = DIA_Addon_Henry_PICKPOCKET_Condition;
	information = DIA_Addon_Henry_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Addon_Henry_PICKPOCKET_Condition()
{
	return C_Beklauen(40,60);
};

func void DIA_Addon_Henry_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Henry_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Henry_PICKPOCKET,Dialog_Back,DIA_Addon_Henry_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Henry_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Henry_PICKPOCKET_DoIt);
};

func void DIA_Addon_Henry_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Henry_PICKPOCKET);
};

func void DIA_Addon_Henry_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Henry_PICKPOCKET);
};


const string PIR_1354_Checkpoint = "ADW_PIRATECAMP_WAY_02";
var int Henry_FriendOrFoe;

instance DIA_Addon_Henry_Hello(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 5;
	condition = DIA_Addon_Henry_Hello_Condition;
	information = DIA_Addon_Henry_Hello_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Henry_Hello_Condition()
{
//	if((Npc_GetDistToWP(other,PIR_1354_Checkpoint) <= 700) && (self.aivar[AIV_PASSGATE] == FALSE))
	if(Npc_GetDistToWP(other,PIR_1354_Checkpoint) <= 700)
	{
		if(self.aivar[AIV_PASSGATE] == FALSE)
		{
			Npc_SetRefuseTalk(self,5);
		};
		return FALSE;
	};
	if((self.aivar[AIV_Guardpassage_Status] == GP_NONE) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && !Npc_RefuseTalk(self))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Hello_Info()
{
	AI_Output(self,other,"DIA_Addon_Henry_Hello_04_00");	//HALT!
	other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP(other,PIR_1354_Checkpoint);
	self.aivar[AIV_Guardpassage_Status] = GP_FirstWarnGiven;
	if(Henry_FriendOrFoe == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Henry_Hello_04_01");	//Friend or foe?
		Info_ClearChoices(DIA_Addon_Henry_Hello);
		Info_AddChoice(DIA_Addon_Henry_Hello,"Foe!",DIA_Addon_Henry_Hello_Feind);
		Info_AddChoice(DIA_Addon_Henry_Hello,"Friend!",DIA_Addon_Henry_Hello_Freund);
		Henry_FriendOrFoe = TRUE;
	};
};


//var int Henry_SC_Frech;

func void DIA_Addon_Henry_Hello_Feind()
{
	AI_Output (other, self, "DIA_Addon_Henry_Hello_Feind_15_00");	//Foe!
	AI_Output (self, other, "DIA_Addon_Henry_Hello_Feind_04_01");	//Asking for a good spanking, you clown?
	AI_Output (self, other, "DIA_Addon_Henry_Hello_Feind_04_02");	//Tell me what you want here, or beat it, and fast.
//	Henry_SC_Frech = TRUE;
	Info_ClearChoices(DIA_Addon_Henry_Hello);
};

func void DIA_Addon_Henry_Hello_Freund()
{
	AI_Output (other, self, "DIA_Addon_Henry_Hello_Freund_15_00");	//Friend!
	AI_Output (self, other, "DIA_Addon_Henry_Hello_Freund_04_01");	//Anyone can say that! I don't know you, what do you want here?
	Info_ClearChoices(DIA_Addon_Henry_Hello);
};


instance DIA_Addon_Henry_SecondWarn(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 2;
	condition = DIA_Addon_Henry_SecondWarn_Condition;
	information = DIA_Addon_Henry_SecondWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Henry_SecondWarn_Condition()
{
	if((self.aivar[AIV_Guardpassage_Status] == GP_FirstWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,PIR_1354_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_SecondWarn_Info()
{
	AI_Output (self, other, "DIA_Addon_Henry_SecondWarn_04_00");	//One more step towards the camp and I'll feed you to the sharks.
	other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP (other, PIR_1354_Checkpoint);
	self.aivar[AIV_Guardpassage_Status] = GP_SecondWarnGiven;
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Henry_Attack(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 3;
	condition = DIA_Addon_Henry_Attack_Condition;
	information = DIA_Addon_Henry_Attack_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Henry_Attack_Condition()
{
	if((self.aivar[AIV_Guardpassage_Status] == GP_SecondWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,PIR_1354_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Attack_Info()
{
	other.aivar[AIV_LastDistToWP] = 0;
	self.aivar[AIV_Guardpassage_Status] = GP_NONE;
	AI_Output (self, other, "DIA_Addon_Henry_Attack_04_00");	//You asked for it...
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_GuardStopsIntruder, 0);
};


var int Henry_Zoll_WhatFor;

instance DIA_Addon_Henry_WantEnter(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 1;
	condition = DIA_Addon_Henry_WantEnter_Condition;
	information = DIA_Addon_Henry_WantEnter_Info;
	permanent = FALSE;
	description = "I want in there.";
};


func int DIA_Addon_Henry_WantEnter_Condition()
{
	if(self.aivar[AIV_PASSGATE] == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_WantEnter_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_WantEnter_15_00");	//I want in there.
	AI_Output (self, other, "DIA_Addon_Henry_WantEnter_04_01");	//Really? That'll cost you, though.
	B_Henry_Gold(500);
	if(Henry_Zoll_WhatFor == FALSE)
	{
		AI_Output (other, self, "DIA_Addon_Henry_WantEnter_15_02");	//Huh? For what?
		AI_Output (self, other, "DIA_Addon_Henry_WantEnter_04_03");	//Don't make such a fuss.
		AI_Output (self, other, "DIA_Addon_Henry_WantEnter_04_04");	//There's PLENTY of stuff here in camp that might interest you...
		Henry_Zoll_WhatFor = TRUE;
	};
	if(C_ExpensiveArmorEquipped(other))
	{
		AI_Output (self, other, "DIA_Addon_Henry_WantEnter_04_07");	//And you look like someone who's got gold on him.
		AI_Output (self, other, "DIA_Addon_Henry_WantEnter_04_08");	//So, a small contribution is not going to kill you.
		if((VisibleGuild(other) != GIL_KDF) && (VisibleGuild(other) != GIL_KDW))
		{
			AI_Output(self,other,"DIA_Addon_Henry_WantEnter_04_09");	//Or did you steal those posh rags of yours?
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Henry_WantEnter_04_10");	//You've got some gold, haven't you?
	};
};

func void B_Henry_NoJoin()
{
	AI_Output (self, other, "DIA_Addon_Henry_Add_04_00");	//If you were planning to sign on with us, lad, you're out of luck.
	AI_Output (self, other, "DIA_Addon_Henry_Add_04_01");	//Only the Captain decides who gets to sign on here, and he took half the crew and went to sea after booty.
	AI_Output (self, other, "DIA_Addon_Henry_Add_04_02");	//But you can stay until he's back.
	AI_Output (self, other, "DIA_Addon_Henry_Add_04_03");	//Provided you don't cause any trouble here!
};


instance DIA_Addon_Henry_Einigen2(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 2;
	condition = DIA_Addon_Henry_Einigen2_Condition;
	information = DIA_Addon_Henry_Einigen2_Info;
	description = "Here's your 500 gold coins.";
};


func int DIA_Addon_Henry_Einigen2_Condition()
{
	if((self.aivar[AIV_PASSGATE] == FALSE) && Npc_KnowsInfo(other,DIA_Addon_Henry_WantEnter) && !Npc_KnowsInfo(other,DIA_Addon_Henry_Einigen) && (Npc_HasItems(other,ItMi_Gold) >= 500))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Einigen2_Info()
{
	AI_Output(other,self,"DIA_Addon_Henry_Einigen2_15_00");	//Here's your 500 gold coins.
	B_GiveInvItems(other,self,ItMi_Gold,500);
	AI_Output(self,other,"DIA_Addon_Henry_Einigen2_04_01");	//All right. Welcome to our camp!
	if(GregIsBack == FALSE)
	{
		B_Henry_NoJoin();
	};
	self.aivar[AIV_PASSGATE] = TRUE;
};


instance DIA_Addon_Henry_Einigen(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 3;
	condition = DIA_Addon_Henry_Einigen_Condition;
	information = DIA_Addon_Henry_Einigen_Info;
	description = "Can't we come to an agreement somehow?";
};


func int DIA_Addon_Henry_Einigen_Condition()
{
	if((self.aivar[AIV_PASSGATE] == FALSE) && Npc_KnowsInfo(other,DIA_Addon_Henry_WantEnter))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Einigen_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_Einigen_15_00");	//Can't we come to an agreement somehow?
	AI_Output (self, other, "DIA_Addon_Henry_Einigen_04_01");	//Well. Give me a good reason, and I might make it cheaper for you.
};


instance DIA_Addon_Henry_MeatForMorgan(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 4;
	condition = DIA_Addon_Henry_MeatForMorgan_Condition;
	information = DIA_Addon_Henry_MeatForMorgan_Info;
	permanent = FALSE;
	description = "I'm supposed to bring Morgan this meat.";
};


func int DIA_Addon_Henry_MeatForMorgan_Condition()
{
	if((self.aivar[AIV_PASSGATE] == FALSE) && Npc_KnowsInfo(other,DIA_Addon_Henry_Einigen) && (MIS_AlligatorJack_BringMeat == LOG_Running) && Npc_HasItems(other,ItFoMuttonRaw))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_MeatForMorgan_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_MeatForMorgan_15_00");	//I'm supposed to bring Morgan this meat.
	AI_Output (self, other, "DIA_Addon_Henry_MeatForMorgan_04_01");	//(curtly) Aha. And who sent you?
	AI_Output (other, self, "DIA_Addon_Henry_MeatForMorgan_15_02");	//Alligator Jack. He says that Morgan is already waiting for it.
	AI_Output (self, other, "DIA_Addon_Henry_MeatForMorgan_04_03");	//I see. Not in the mood himself, is he?
};


instance DIA_Addon_Henry_Malcom(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 5;
	condition = DIA_Addon_Henry_Malcom_Condition;
	information = DIA_Addon_Henry_Malcom_Info;
	description = "Malcom sent me.";
};


func int DIA_Addon_Henry_Malcom_Condition()
{
	if((self.aivar[AIV_PASSGATE] == FALSE) && Npc_KnowsInfo(other,DIA_Addon_Henry_Einigen) && (MalcomBotschaft == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Malcom_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_Malcom_15_00");	//Malcolm sent me. He says the wood may take a while.
	AI_Output (self, other, "DIA_Addon_Henry_Malcom_04_01");	//(griping) Oh great. I might have known. It's taking forever again.
	B_MalcomExident ();
};


instance DIA_Addon_Henry_BaltramPack(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 6;
	condition = DIA_Addon_Henry_BaltramPack_Condition;
	information = DIA_Addon_Henry_BaltramPack_Info;
	description = "I've got a delivery here for Skip. Is he here?";
};


func int DIA_Addon_Henry_BaltramPack_Condition()
{
	if((self.aivar[AIV_PASSGATE] == FALSE) && Npc_KnowsInfo(other,DIA_Addon_Henry_Einigen) && Npc_HasItems(other,ItMi_Packet_Baltram4Skip_Addon))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_BaltramPack_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_BaltramPack_15_00");	//I've got a delivery here for Skip. Is he here?
	AI_Output (self, other, "DIA_Addon_Henry_BaltramPack_04_01");	//Yes. Skip is here. And now?
};


var int Henry_Amount;

instance DIA_Addon_Henry_Tribut(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 7;
	condition = DIA_Addon_Henry_Tribut_Condition;
	information = DIA_Addon_Henry_Tribut_Info;
	permanent = TRUE;
	description = "Let me in.";
};


func int DIA_Addon_Henry_Tribut_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Henry_Einigen) && (self.aivar[AIV_PASSGATE] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Tribut_Info()
{
	Henry_Amount = 500;
	AI_Output (other, self, "DIA_Addon_Henry_Tribut_15_00");	//Let me in.
	AI_Output (self, other, "DIA_Addon_Henry_Tribut_04_01");	//Mmh...
	if (Npc_KnowsInfo (other, DIA_Addon_Henry_Malcom))
	{
		AI_Output(self,other,"DIA_Addon_Henry_Tribut_04_02");	//You brought me a message from our woodcutters.
		Henry_Amount -= 100;
	};
	if(Npc_KnowsInfo(other,DIA_Addon_Henry_MeatForMorgan))
	{
		AI_Output(self,other,"DIA_Addon_Henry_Tribut_04_03");	//You want to play errand boy for Alligator Jack and bring the swamp rat meat to Morgan.
		Henry_Amount -= 100;
	};
	if(Npc_KnowsInfo(other,DIA_Addon_Henry_BaltramPack))
	{
		AI_Output(self,other,"DIA_Addon_Henry_Tribut_04_04");	//You've got a package for Skip.
		Henry_Amount -= 100;
	};
	if(MIS_Henry_FreeBDTTower == LOG_SUCCESS)
	{
		if(Henry_Amount < 500)
		{
			AI_Output (self, other, "DIA_Addon_Henry_Tribut_Add_04_00");	//And, best of all:
		};
		AI_Output (self, other, "DIA_Addon_Henry_Tribut_Add_04_01");	//You got that varmint in the tower off our backs.
		AI_Output (self, other, "DIA_Addon_Henry_Tribut_Add_04_02");	//I never thought you could do it all by yourself.
		Henry_Amount -= 200;
	};
	if(Henry_Amount <= 0)
	{
		AI_Output (self, other, "DIA_Addon_Henry_Tribut_Add_04_03");	//Tell you what. You get in for free.
		self.aivar[AIV_PASSGATE] = TRUE;
		Info_ClearChoices(DIA_Addon_Henry_Tribut);
	}
	else
	{
		B_Henry_Gold (Henry_Amount);
		AI_Output (self, other, "DIA_Addon_Henry_Tribut_04_05");	//... or you just get lost. It's as simple as that.
		Info_ClearChoices (DIA_Addon_Henry_Tribut);
		Info_AddChoice (DIA_Addon_Henry_Tribut, "I think that's too much.", DIA_Addon_Henry_Tribut_nein);
		if (Npc_HasItems (other, ItMi_Gold) >= Henry_Amount)
		{
			Info_AddChoice (DIA_Addon_Henry_Tribut, "Good. Here's your gold.", DIA_Addon_Henry_Tribut_ja);
		};
	};
};

func void DIA_Addon_Henry_Tribut_ja()
{
	AI_Output(other,self,"DIA_Addon_Henry_Tribut_ja_15_00");	//Good. Here's your gold.
	B_GiveInvItems(other,self,ItMi_Gold,Henry_Amount);
	AI_Output(self,other,"DIA_Addon_Henry_Tribut_ja_04_01");	//Thanks. Welcome to our camp.
	if(GregIsBack == FALSE)
	{
		B_Henry_NoJoin();
	};
	Info_ClearChoices(DIA_Addon_Henry_Tribut);
	self.aivar[AIV_PASSGATE] = TRUE;
};

func void DIA_Addon_Henry_Tribut_nein()
{
	AI_Output (other, self, "DIA_Addon_Henry_Tribut_nein_15_00");	//I think that's too much.
	if (Henry_Amount < 500)
	{
		AI_Output (self, other, "DIA_Addon_Henry_Tribut_nein_04_03");	//Come on, I already made it cheaper for you.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Henry_Tribut_nein_04_04");	//Get lost, then.
	};
	Info_ClearChoices(DIA_Addon_Henry_Tribut);
};


instance DIA_Addon_Henry_Palisade(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 11;
	condition = DIA_Addon_Henry_Palisade_Condition;
	information = DIA_Addon_Henry_Palisade_Info;
	permanent = FALSE;
	description = "What are you doing here?";
};


func int DIA_Addon_Henry_Palisade_Condition()
{
	return TRUE;
};

func void DIA_Addon_Henry_Palisade_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_Palisade_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_04_01");	//What does it look like? I must see to it that these miserable wretches get the palisade built in time.
	if(GregIsBack == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Henry_Palisade_04_02");	//If they don't, Cap'n Greg will kick my ass all over the place.
	};
	AI_Output(self,other,"DIA_Addon_Henry_Palisade_04_03");	//Also, I keep strangers from traipsing in here just like that.
};


instance DIA_Addon_Henry_Palisade_WhatFor(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 12;
	condition = DIA_Addon_Henry_Palisade_WhatFor_Condition;
	information = DIA_Addon_Henry_Palisade_WhatFor_Info;
	permanent = FALSE;
	description = "What are you building the palisade for?";
};


func int DIA_Addon_Henry_Palisade_WhatFor_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Henry_Palisade))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Palisade_WhatFor_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_Palisade_WhatFor_15_00");	//What are you building the palisade for?
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_WhatFor_04_10");	//Well, we don't want to make it too easy for the bandits!
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_WhatFor_04_02");	//Those bastards are getting more brazen all the time. They've been sneaking around our camp for days now. Just like sharks after a shipwreck.
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_WhatFor_04_11");	//Some of those good-for-nothings are holing up in the tower a little south of here.
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_WhatFor_04_12");	//But that's only an advance party, I'm sure.
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_WhatFor_04_03");	//If they're really stupid enough to mount an attack, we'll give them a welcome they won't forget.
	Log_CreateTopic (TOPIC_Addon_BanditsTower, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_BanditsTower, LOG_Running);
	B_LogEntry (TOPIC_Addon_BanditsTower, "A few bandits have occupied the tower south of the pirate camp and fortified it.");
};

func void B_Henry_WhereIsTower()
{
	AI_Output (other, self, "DIA_Addon_Francis_BanditsDead_15_08");	//Where exactly is that tower located?
	AI_Output (self, other, "DIA_Addon_Henry_Entercrew_Add_04_07");	//Set off from here and keep to the right.
	AI_Output (self, other, "DIA_Addon_Henry_Entercrew_Add_04_08");	//You'll find the tower on a small cliff there.
};


instance DIA_Addon_Henry_Turmbanditen(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 13;
	condition = DIA_Addon_Henry_Turmbanditen_WhatFor_Condition;
	information = DIA_Addon_Henry_Turmbanditen_WhatFor_Info;
	permanent = TRUE;
	description = "About those bandits in the tower...";
};


func int DIA_Addon_Henry_Turmbanditen_WhatFor_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Henry_Palisade_WhatFor) && (MIS_Henry_FreeBDTTower != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Turmbanditen_WhatFor_Info()
{
	AI_Output(other,self,"DIA_Addon_Henry_Turmbanditen_15_00");	//About those bandits in the tower ...
	if(C_TowerBanditsDead())
	{
		AI_Output (self, other, "DIA_Addon_Henry_Turmbanditen_04_01");	//Yes?
		AI_Output (other, self, "DIA_Addon_Francis_BanditsDead_15_01");	//They're history.
		if (MIS_Henry_FreeBDTTower == LOG_Running)
		{
			AI_Output (self, other, "DIA_Addon_Henry_Turmbanditen_04_02");	//Great! One less problem, then.
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_Henry_Turmbanditen_04_03");	//Did you pull that off all by yourself? Respect!
			AI_Output (self, other, "DIA_Addon_Henry_Turmbanditen_04_04");	//Maybe you'll even be a real pirate some day!
		};
		if(!Npc_IsDead(SawPirate))
		{
			SawPirate.aivar[AIV_PARTYMEMBER] = FALSE;
			Npc_ExchangeRoutine(SawPirate,"START");
		};
		if(!Npc_IsDead(HammerPirate))
		{
			HammerPirate.aivar[AIV_PARTYMEMBER] = FALSE;
			Npc_ExchangeRoutine(HammerPirate,"START");
		};
		MIS_Henry_FreeBDTTower = LOG_SUCCESS;
		B_LogEntry(TOPIC_Addon_BanditsTower,"Бандиты из башни убиты.");
		B_GivePlayerXP(XP_Addon_Henry_FreeBDTTower);
	}
	else if(MIS_Henry_FreeBDTTower == LOG_Running)
	{
		AI_Output (self, other, "DIA_Addon_Henry_Turmbanditen_04_07");	//What else do you want?
		B_Henry_WhereIsTower ();
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Henry_Turmbanditen_04_05");	//If you're planning to take them on ALL BY YOURSELF, forget it!
		AI_Output (self, other, "DIA_Addon_Henry_Turmbanditen_04_06");	//I'll be sending two people from my raiding troop soon. Let them handle the bandits.
	};
	Knows_HenrysEntertrupp = TRUE;
};


instance DIA_Addon_Henry_Palisade_Bandits(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 14;
	condition = DIA_Addon_Henry_Palisade_Bandits_Condition;
	information = DIA_Addon_Henry_Palisade_Bandits_Info;
	permanent = FALSE;
	description = "Why would the bandits attack you?";
};


func int DIA_Addon_Henry_Palisade_Bandits_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Henry_Palisade_WhatFor))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Palisade_Bandits_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_Palisade_Bandits_15_00");	//Why would the bandits attack you?
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Bandits_04_04");	//Because there's WAR between them and us! What did you think?
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Bandits_04_05");	//Everything was peachy at first. We brought them here, they marched right into their swamp and left us alone.
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Bandits_04_06");	//But now, those bastards attack anyone who's not one of them.
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Bandits_04_07");	//Heaven knows what's gotten into them.
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Bandits_04_08");	//I reckon they may be after our boats. There's no other way to get out of here, after all.
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Bandits_04_09");	//You should ask Skip about this. He's been with them - and barely got away with his life.
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Bandits_04_10");	//He's got quite an interesting tale to tell.
	if (self.aivar[AIV_PASSGATE] == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Henry_Palisade_Bandits_04_11");	//(mischievously) Too bad you can't hear it, though. You haven't paid your toll, after all.
		Henry_Zoll_WhatFor = TRUE;
	};
};


var int Henry_EnterCrewMember;

instance DIA_Addon_Henry_Entercrew(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 31;
	condition = DIA_Addon_Henry_Entercrew_Condition;
	information = DIA_Addon_Henry_Entercrew_Info;
	permanent = TRUE;
	description = "I want to join your raiding troop.";
};


func int DIA_Addon_Henry_Entercrew_Condition()
{
	if((Knows_HenrysEntertrupp == TRUE) && (Henry_EnterCrewMember == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Entercrew_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_Entercrew_15_00");	//I want to join your raiding troop.
	if (self.aivar[AIV_PASSGATE] == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Henry_Entercrew_Add_04_00");	//(laughs) You won't get past me that easily, kid!
		AI_Output (self, other, "DIA_Addon_Henry_Entercrew_Add_04_01");	//First let's talk about whether you can get into the CAMP at all!
		Henry_Zoll_WhatFor = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Henry_Entercrew_04_06");	//Well, welcome to my raiding troop, then!
		AI_Output (self, other, "DIA_Addon_Henry_Entercrew_04_07");	//One more fighter to help keep the bandits off our backs.
		if (MIS_Henry_FreeBDTTower == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_Addon_Henry_Entercrew_Add_04_02");	//Hmm, I should have said, get one of the boys and smoke out those bastards in the tower.
			AI_Output (self, other, "DIA_Addon_Henry_Entercrew_Add_04_03");	//But you already did that.
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_Henry_Entercrew_Add_04_05");	//Get rid of those bandits in the tower for us!
			if(Npc_IsDead(SawPirate) && Npc_IsDead(HammerPirate))
			{
				AI_Output(self,other,"DIA_Addon_Henry_Entercrew_Add_04_04");	//ОWell, my men are both dead. So you'll have to go it alone after all.
				B_LogEntry(TOPIC_Addon_BanditsTower,"Henry wants me to drive the bandits out of the tower. He can't give me any support.");
			}
			else
			{
				AI_Output (self, other, "DIA_Addon_Henry_Entercrew_Add_04_06");	//Grab one of the boys and make short shrift of those bandits in the tower.
				Henry_GetPartyMember = TRUE;
				B_LogEntry (TOPIC_Addon_BanditsTower, "Henry wants me to drive the bandits out of the tower. I am to take one of his boys with me.");
			};
			B_Henry_WhereIsTower ();
			AI_Output (other, self, "DIA_Addon_Henry_Entercrew_15_09");	//Aye aye, Sir!
			MIS_Henry_FreeBDTTower = LOG_Running;
		};
		Henry_EnterCrewMember = TRUE;
	};
};


instance DIA_Addon_Henry_Owen(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 32;
	condition = DIA_Addon_Henry_Owen_Condition;
	information = DIA_Addon_Henry_Owen_Info;
	description = "Is there anything else for me to do?";
};


func int DIA_Addon_Henry_Owen_Condition()
{
//	if((MIS_Henry_FreeBDTTower == LOG_SUCCESS) && (Henry_EnterCrewMember == TRUE) && !Npc_IsDead(Malcom))
	if((MIS_Henry_FreeBDTTower == LOG_SUCCESS) && (Henry_EnterCrewMember == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Owen_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_Owen_15_01");	//Is there anything else for me to do?
	AI_Output (self, other, "DIA_Addon_Henry_Owen_04_01");	//We've been waiting for wood for our palisade for days now.
	AI_Output (self, other, "DIA_Addon_Henry_Owen_04_05");	//Malcolm and Owen should have been back some time ago.
	if (!Npc_KnowsInfo (other, DIA_Addon_Henry_Malcom))
	{
		AI_Output (self, other, "DIA_Addon_Henry_Owen_04_06");	//Their woodcutters' camp isn't far from here, by the hollow to the south-east.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Henry_Owen_04_07");	//Malcolm said it would take a WHILE - not half an ETERNITY!
	};
	AI_Output (self, other, "DIA_Addon_Henry_Owen_04_08");	//Tell them we're waiting for that wood!
	AI_Output (self, other, "DIA_Addon_Henry_Owen_04_09");	//No, wait! Tell OWEN. Malcolm is too unreliable.
	B_MalcomExident ();
	MIS_Henry_HolOwen = LOG_Running;
	Log_CreateTopic (TOPIC_Addon_HolOwen, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_HolOwen, LOG_Running);
	B_LogEntry (TOPIC_Addon_HolOwen, "Henry is waiting for the wood for the palisade. I'm supposed to inform Owen. He is together with Malcom by the hollow.");
};

func void B_Addon_Henry_MalcomsDead()
{
	AI_Output (self, other, "DIA_Addon_Henry_Owen2_Add_04_00");	//What about Malcolm?
	AI_Output (other, self, "DIA_Addon_Henry_Owen2_Add_15_01");	//He's dead.
	AI_Output (self, other, "DIA_Addon_Henry_Owen2_Add_04_02");	//Well, looks like he ran out of luck, then.
};


instance DIA_Addon_Henry_Owen2(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 33;
	condition = DIA_Addon_Henry_Owen2_Condition;
	information = DIA_Addon_Henry_Owen2_Info;
	permanent = TRUE;
	description = "About that woodcutter, Owen...";
};


func int DIA_Addon_Henry_Owen2_Condition()
{
	if(MIS_Henry_HolOwen == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Owen2_Info()
{
	AI_Output(other,self,"DIA_Addon_Henry_Owen2_15_00");	//About that woodcutter, Owen...
	if(Npc_IsDead(Owen))
	{
		AI_Output (other, self, "DIA_Addon_Henry_Owen2_15_01");	//He's dead.
		AI_Output (self, other, "DIA_Addon_Henry_Owen2_04_02");	//Damnit! I guess I'll have to send a new man, then.
		if(!Npc_IsDead(Morgan))
		{
			AI_Output(self,other,"DIA_Addon_Henry_Owen2_04_03");	//(grumbling) High time Morgan finally got around to getting rid of those beasts around here.
		};
		B_Addon_Henry_MalcomsDead();
		MIS_Henry_HolOwen = LOG_OBSOLETE;
		B_LogEntry (TOPIC_Addon_HolOwen, "Owen and Malcom are both dead.");
		Log_SetTopicStatus (TOPIC_Addon_HolOwen, LOG_OBSOLETE);
	}
	else if(Owen_ComesToHenry == TRUE)
	{
		AI_Output (other, self, "DIA_Addon_Henry_Owen2_15_03");	//Owen will bring you the wood.
		AI_Output (self, other, "DIA_Addon_Henry_Owen2_04_04");	//Very good. And high time, too.
		B_Addon_Henry_MalcomsDead();
		AI_Output(self,other,"DIA_Addon_Henry_Owen2_04_05");	//Here's your reward.
		B_GiveInvItems(self,other,ItMi_Gold,200);
		if(Npc_KnowsInfo(other,DIA_Addon_Greg_RavenDead))
		{
			B_StartOtherRoutine(Owen,"PostStart");
		}
		else
		{
			B_StartOtherRoutine(Owen,"PreStart");
		};
		MIS_Henry_HolOwen = LOG_SUCCESS;
		B_GivePlayerXP(XP_Addon_Owen_ComesToHenry);
	}
	else
	{
		AI_Output (other, self, "DIA_Addon_Henry_Owen2_15_06");	//Where's his camp again?
		AI_Output (self, other, "DIA_Addon_Henry_Owen2_04_07");	//It's not far from here, to the south-east by the hollow.
	};
};


var int Henry_PERM_Once;

instance DIA_Addon_Henry_Palisade_CanHelp(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 34;
	condition = DIA_Addon_Henry_Palisade_CanHelp_Condition;
	information = DIA_Addon_Henry_Palisade_CanHelp_Info;
	permanent = TRUE;
	description = "Do you need help?";
};


func int DIA_Addon_Henry_Palisade_CanHelp_Condition()
{
	if((MIS_Henry_HolOwen == LOG_SUCCESS) || (MIS_Henry_HolOwen == LOG_OBSOLETE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Palisade_CanHelp_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_Palisade_CanHelp_15_00");	//Do you need help?
	if (Henry_PERM_Once == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Henry_Palisade_CanHelp_04_01");	//Do you know anything about building palisades?
		AI_Output (other, self, "DIA_Addon_Henry_Palisade_CanHelp_15_02");	//No, not really.
		AI_Output (self, other, "DIA_Addon_Henry_Palisade_CanHelp_04_03");	//Then I can't use you here. Go and help out somewhere else.
		Henry_PERM_Once = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Henry_Palisade_CanHelp_04_04");	//Get roaring drunk for all I care, but keep out of the way of my workers.
	};
};


instance DIA_Addon_Henry_WhatTeach(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 21;
	condition = DIA_Addon_Henry_WhatTeach_Condition;
	information = DIA_Addon_Henry_WhatTeach_Info;
	permanent = TRUE;
	description = "Can you teach me how to be a better fighter?";
};


func int DIA_Addon_Henry_WhatTeach_Condition()
{
	if((Knows_HenrysEntertrupp == TRUE) && (Henry_Addon_TeachPlayer == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_WhatTeach_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_WhatTeach_Add_15_00");	//Can you teach me how to be a better fighter?
	if (self.aivar[AIV_PASSGATE] == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Henry_WhatTeach_Add_04_01");	//(laughs) First, pay your toll. After that, I can talk to you about fighting.
		AI_Output (self, other, "DIA_Addon_Henry_WhatTeach_Add_04_02");	//(slyly) It's all included in the price.
		Henry_Zoll_WhatFor = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Henry_WhatTeach_Add_04_03");	//Sure, why not?
		if(!Npc_KnowsInfo(other,DIA_Addon_Bones_Teacher))
		{
			Log_CreateTopic(Topic_Addon_PIR_Teacher,LOG_NOTE);
			B_LogEntry(Topic_Addon_PIR_Teacher,Log_Text_Addon_HenryTeach);
		};
		Henry_Addon_TeachPlayer = TRUE;
	};
};


var int Henry_merke2h;
var int Henry_merkeCbow;
var int Henry_Labercount;
var int Henry_Comment2H;
var int DIA_Henry_Teacher_permanent;
var int DIA_Henry_TeachState_2H;
var int DIA_Henry_TeachState_Crossbow;

func void B_Henry_NoMore_2H()
{
	AI_Output(self,other,"DIA_DIA_Lee_Teach_2H_1_04_00");	//Now you are a real master in two-handed combat.
};

func void B_Henry_NoMoreTeach()
{
	AI_Output(self,other,"DIA_DIA_Lee_Teach_2H_1_04_01");	//You no longer need a teacher.
};

func void B_BuildLearnDialog_Henry()
{
	Info_ClearChoices(DIA_Addon_Henry_Teach);
	Info_AddChoice(DIA_Addon_Henry_Teach,Dialog_Back,DIA_Addon_Henry_Teach_Back);
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Henry)
	{
		Info_AddChoice(DIA_Addon_Henry_Teach,B_BuildLearnString(PRINT_Learn2h1,B_GetLearnCostTalent(other,NPC_TALENT_2H,1)),DIA_Addon_Henry_Teach_2H_1);
		Info_AddChoice(DIA_Addon_Henry_Teach,B_BuildLearnString(PRINT_Learn2h5,B_GetLearnCostTalent(other,NPC_TALENT_2H,5)),DIA_Addon_Henry_Teach_2H_5);
		DIA_Henry_TeachState_2H = 1;
	}
	else
	{
		if((DIA_Henry_TeachState_2H == 1) && (DIA_Henry_TeachState_Crossbow != 2))
		{
			PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_2H_Henry)),-1,53,FONT_Screen,2);
			B_Henry_NoMore_2H();
		};
		DIA_Henry_TeachState_2H = 2;
	};
	if(VisibleTalentValue(NPC_TALENT_CROSSBOW) < TeachLimit_Crossbow_Henry)
	{
		Info_AddChoice(DIA_Addon_Henry_Teach,B_BuildLearnString(PRINT_LearnCrossBow1,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,1)),DIA_Addon_Henry_Teach_CB_1);
		Info_AddChoice(DIA_Addon_Henry_Teach,B_BuildLearnString(PRINT_LearnCrossBow5,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,5)),DIA_Addon_Henry_Teach_CB_5);
		DIA_Henry_TeachState_Crossbow = 1;
	}
	else
	{
		if((DIA_Henry_TeachState_Crossbow == 1) && (DIA_Henry_TeachState_2H != 2))
		{
			PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_Crossbow_Henry)),-1,53,FONT_Screen,2);
			B_Say(self,other,"$NOLEARNYOUREBETTER");
		};
		DIA_Henry_TeachState_Crossbow = 2;
	};
	if((RealTalentValue(NPC_TALENT_2H) >= DIA_Henry_TeachState_2H) && (RealTalentValue(NPC_TALENT_CROSSBOW) >= TeachLimit_Crossbow_Henry))
	{
		DIA_Henry_Teacher_permanent = TRUE;
	};
	if((DIA_Henry_TeachState_2H == 2) && (DIA_Henry_TeachState_Crossbow == 2))
	{
		PrintScreen(PRINT_NoLearnTotalMAXReached,-1,53,FONT_Screen,2);
		B_Henry_NoMoreTeach();
		AI_StopProcessInfos(self);
	};
};

func void B_Henry_Comment2H()
{
	if(Henry_Comment2H == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Henry_CommentFightSkill_04_03");	//Always remember - he who parries lives longer!
		Henry_Comment2H = TRUE;
	};
};

func void B_Henry_CommentFightSkill()
{
	if(Henry_Labercount == 0)
	{
		AI_Output(self,other,"DIA_Addon_Henry_Teach_Back_04_00");	//You're getting really good.
		Henry_Labercount = 1;
	}
	else if(Henry_Labercount == 1)
	{
		AI_Output(self,other,"DIA_Addon_Henry_CommentFightSkill_04_01");	//You're learning fast, maybe you'll be a real pirate some day.
		Henry_Labercount = 2;
	}
	else if(Henry_Labercount == 2)
	{
		AI_Output(self,other,"DIA_Addon_Henry_CommentFightSkill_04_02");	//If you continue like that, you'll soon be able to board a ship all by yourself.
		Henry_Labercount = 0;
	};
};

instance DIA_Addon_Henry_Teach(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 6;
	condition = DIA_Addon_Henry_Teach_Condition;
	information = DIA_Addon_Henry_Teach_Info;
	permanent = TRUE;
	description = "Teach me!";
};


func int DIA_Addon_Henry_Teach_Condition()
{
	if((Henry_Addon_TeachPlayer == TRUE) && (DIA_Henry_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Teach_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_Teach_15_00");	//Teach me!
	Henry_merke2h = other.HitChance[NPC_TALENT_2H];
	Henry_merkeCbow = other.HitChance[NPC_TALENT_CROSSBOW];
	B_BuildLearnDialog_Henry();
};

func void DIA_Addon_Henry_Teach_Back()
{
	if((other.HitChance[NPC_TALENT_2H] > Henry_merke2h) || (other.HitChance[NPC_TALENT_CROSSBOW] > Henry_merkeCbow))
	{
		B_Henry_CommentFightSkill();
	};
	Info_ClearChoices(DIA_Addon_Henry_Teach);
};

func void DIA_Addon_Henry_Teach_CB_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,1,TeachLimit_Crossbow_Henry))
	{
		B_BuildLearnDialog_Henry();
	};
};

func void DIA_Addon_Henry_Teach_CB_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,5,TeachLimit_Crossbow_Henry))
	{
		B_BuildLearnDialog_Henry();
	};
};

func void DIA_Addon_Henry_Teach_2H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,1,TeachLimit_2H_Henry))
	{
		B_Henry_Comment2H();
		B_BuildLearnDialog_Henry();
	};
};

func void DIA_Addon_Henry_Teach_2H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,5,TeachLimit_2H_Henry))
	{
		B_Henry_Comment2H();
		B_BuildLearnDialog_Henry();
	};
};


instance DIA_Addon_Henry_Palisade_Train(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 11;
	condition = DIA_Addon_Henry_Palisade_Train_Condition;
	information = DIA_Addon_Henry_Palisade_Train_Info;
	permanent = FALSE;
	description = "Greg's your boss?";
};


func int DIA_Addon_Henry_Palisade_Train_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Henry_Palisade))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_Palisade_Train_Info()
{
	AI_Output (other, self, "DIA_Addon_Henry_Palisade_Train_15_00");	//Greg's your boss?
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Train_04_01");	//He sure is. And it's CAPTAIN Greg to you. Have I made myself clear?
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Train_04_02");	//He's a great man. If you meet him, be careful not to get on the wrong side of him. You won't live long enough to regret it.
	if((SC_SawGregInTaverne == TRUE) || (PlayerTalkedToGregNW == TRUE) || (Greg.aivar[AIV_TalkedToPlayer] == TRUE))
	{
		AI_Output (other, self, "DIA_Addon_Henry_Palisade_Train_15_03");	//I've already met him.
		AI_Output (self, other, "DIA_Addon_Henry_Palisade_Train_04_04");	//Even better. So you know what I'm talking about.
	};
	if(GregIsBack == FALSE)
	{
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Train_04_05");	//He's not in camp right now, though.
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Train_04_06");	//Francis is in command for now.
	AI_Output (self, other, "DIA_Addon_Henry_Palisade_Train_04_07");	//He sits in front of Greg's hut all day and goggles at us working.
	};
};


instance DIA_Addon_Henry_YourOwnTrupp(C_Info)
{
	npc = PIR_1354_Addon_Henry;
	nr = 1;
	condition = DIA_Addon_Henry_YourOwnTrupp_Condition;
	information = DIA_Addon_Henry_YourOwnTrupp_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Henry_YourOwnTrupp_Condition()
{
	if((MIS_Addon_Greg_ClearCanyon == LOG_Running) && ((AlligatorJack.aivar[AIV_PARTYMEMBER] == TRUE) || (Brandon.aivar[AIV_PARTYMEMBER] == TRUE) || (Matt.aivar[AIV_PARTYMEMBER] == TRUE) || (Skip.aivar[AIV_PARTYMEMBER] == TRUE) || (BenchPirate.aivar[AIV_PARTYMEMBER] == TRUE) || (RoastPirate.aivar[AIV_PARTYMEMBER] == TRUE)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Henry_YourOwnTrupp_Info()
{
	AI_Output (self, other, "DIA_Addon_Henry_Add_04_04");	//The Captain gave you your own raiding troop, did he?
	AI_Output (self, other, "DIA_Addon_Henry_Add_04_05");	//Then see to it that your boys get plenty to do!
	AI_StopProcessInfos (self);
};

