
instance DIA_Addon_AlligatorJack_Exit(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 999;
	condition = DIA_Addon_AlligatorJack_Exit_Condition;
	information = DIA_Addon_AlligatorJack_Exit_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_AlligatorJack_Exit_Condition()
{
	return TRUE;
};


var int DIA_Addon_AlligatorJack_Exit_Info_OneTime;

func void DIA_Addon_AlligatorJack_Exit_Info()
{
	if((MIS_KrokoJagd == LOG_SUCCESS) && (DIA_Addon_AlligatorJack_Exit_Info_OneTime == FALSE))
	{
		AI_Output(self,other,"DIA_Addon_AlligatorJack_Exit_12_00");	//If you're looking for me, you'll usually find me near my camp in front of the palisade.
		if(Henry.aivar[AIV_TalkedToPlayer] == FALSE)
		{
			AI_Output (other, self, "DIA_Addon_AlligatorJack_Exit_15_01");	//Palisade?
			AI_Output (self, other, "DIA_Addon_AlligatorJack_Exit_12_02");	//Just continue west from here and you'll see what I mean.
		};
		AI_StopProcessInfos(self);
		Npc_ExchangeRoutine(self,"START");
		self.aivar[AIV_PARTYMEMBER] = FALSE;
		DIA_Addon_AlligatorJack_Exit_Info_OneTime = TRUE;
	};
	AI_StopProcessInfos(self);
};


instance DIA_Addon_AlligatorJack_PICKPOCKET(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 900;
	condition = DIA_Addon_AlligatorJack_PICKPOCKET_Condition;
	information = DIA_Addon_AlligatorJack_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Addon_AlligatorJack_PICKPOCKET_Condition()
{
	return C_Beklauen(100,333);
};

func void DIA_Addon_AlligatorJack_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_AlligatorJack_PICKPOCKET);
	Info_AddChoice(DIA_Addon_AlligatorJack_PICKPOCKET,Dialog_Back,DIA_Addon_AlligatorJack_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_AlligatorJack_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_AlligatorJack_PICKPOCKET_DoIt);
};

func void DIA_Addon_AlligatorJack_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_AlligatorJack_PICKPOCKET);
};

func void DIA_Addon_AlligatorJack_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_AlligatorJack_PICKPOCKET);
};


instance DIA_Addon_AlligatorJack_Hello(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_Hello_Condition;
	information = DIA_Addon_AlligatorJack_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_AlligatorJack_Hello_Condition()
{
	if(GregIsBack == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_Hello_Info()
{
	if(!C_BanditArmorEquipped(other) && (VisibleGuild(other) != GIL_KDW))
	{
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Hello_12_00");	//Who on earth are YOU? You don't look like the others.
	AI_Output (other, self, "DIA_Addon_AlligatorJack_Hello_15_01");	//What others?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Hello_12_02");	//Well, the mages who are hanging around those ruins over there.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Hello_12_03");	//Are you one of that bunch, then?
	};
	AI_Output(self,other,"DIA_Addon_AlligatorJack_Hello_12_04");	//Brave thing to run around here by yourself.
};


instance DIA_Addon_AlligatorJack_WerBistDu(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_WerBistDu_Condition;
	information = DIA_Addon_AlligatorJack_WerBistDu_Info;
	description = "Who are you?";
};


func int DIA_Addon_AlligatorJack_WerBistDu_Condition()
{
	return TRUE;
};

func void DIA_Addon_AlligatorJack_WerBistDu_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_WerBistDu_15_00");	//Who are you?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_WerBistDu_12_01");	//I'm sure you've heard of me before.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_WerBistDu_12_02");	//(proudly) I'm Alligator Jack.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_WerBistDu_12_03");	//Feared all over the country. I'm one of the most dangerous pirates around here.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_WerBistDu_12_04");	//Together with Cap'n Greg I've boarded more merchant vessels than I count.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_WerBistDu_12_05");	//You're looking at a living legend here.
};


instance DIA_Addon_AlligatorJack_Vorschlag(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_Vorschlag_Condition;
	information = DIA_Addon_AlligatorJack_Vorschlag_Info;
	description = "Do you know a fellow named Raven?";
};


func int DIA_Addon_AlligatorJack_Vorschlag_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_WerBistDu) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_Vorschlag_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_Vorschlag_15_00");	//Do you know a fellow named Raven?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Vorschlag_12_01");	//Of course. He's the leader of the bandits to the east.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Vorschlag_12_02");	//What's your business with HIM?
	B_LogEntry (TOPIC_Addon_RavenKDW, "Raven and his bandits are in the eastern part of the valley.");
	Info_ClearChoices (DIA_Addon_AlligatorJack_Vorschlag);
	Info_AddChoice (DIA_Addon_AlligatorJack_Vorschlag, "I want to join him.", DIA_Addon_AlligatorJack_Vorschlag_join);
	Info_AddChoice (DIA_Addon_AlligatorJack_Vorschlag, "I've got to kill him.", DIA_Addon_AlligatorJack_Vorschlag_tot);
};

func void B_AlligatorJack_Besser()
{
	if(GregIsBack == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_AlligatorJack_Besser_12_00");	//I've got a better idea.
		AI_Output(self,other,"DIA_Addon_AlligatorJack_Besser_12_01");	//Come and join us.
		AI_Output(self,other,"DIA_Addon_AlligatorJack_Besser_12_03");	//Once you've tried our good home-brewed rum, things will look very different.
	};
	AI_Output(self,other,"DIA_Addon_AlligatorJack_Besser_12_02");	//That'll give you time to think about it.
	Info_ClearChoices(DIA_Addon_AlligatorJack_Vorschlag);
};

func void DIA_Addon_AlligatorJack_Vorschlag_tot()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_Vorschlag_tot_15_00");	//I've got to kill him.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Vorschlag_tot_12_01");	//(laughs) What? YOU? How are you going to do THAT?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Vorschlag_tot_12_02");	//Isn't that guy way out of your league?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Vorschlag_tot_12_03");	//You won't even get close to him. The bandits he's surrounded himself with will skin you alive first.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Vorschlag_tot_12_04");	//You won't even get past their first outpost.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Vorschlag_tot_12_05");	//The way you look, those bandits will get itchy fingers when they spot you a mile away.
	B_AlligatorJack_Besser ();
};

func void DIA_Addon_AlligatorJack_Vorschlag_join()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_Vorschlag_join_15_00");	//I want to join him.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Vorschlag_join_12_01");	//(slyly) Is that so?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Vorschlag_join_12_02");	//But you don't look at all like someone who would want to join those crackpots.
	B_AlligatorJack_Besser ();
};


instance DIA_Addon_AlligatorJack_BDTRuestung(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_BDTRuestung_Condition;
	information = DIA_Addon_AlligatorJack_BDTRuestung_Info;
	description = "I need a bandit's armor.";
};


func int DIA_Addon_AlligatorJack_BDTRuestung_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_Vorschlag) && (MIS_Greg_ScoutBandits == FALSE) && !C_SCHasBDTArmor())
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_BDTRuestung_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_BDTRuestung_15_00");	//I need a bandit's armor.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_BDTRuestung_12_01");	//What would you do with THAT?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_BDTRuestung_12_02");	//It'll only get you into trouble if you're seen with it.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_BDTRuestung_12_03");	//Everyone's going to take you for a bandit and will try to kill you.
	Info_ClearChoices (DIA_Addon_AlligatorJack_BDTRuestung);
	Info_AddChoice (DIA_Addon_AlligatorJack_BDTRuestung, "Do you have any idea where I could find armor like that?", DIA_Addon_AlligatorJack_BDTRuestung_wo);
	Info_AddChoice (DIA_Addon_AlligatorJack_BDTRuestung, "Sounds good...", DIA_Addon_AlligatorJack_BDTRuestung_gut);
};

func void DIA_Addon_AlligatorJack_BDTRuestung_gut()
{
	DIA_Common_SoundsGood();
	AI_Output(self,other,"DIA_Addon_AlligatorJack_BDTRuestung_gut_12_01");	//Yes, but only to someone who's suicidal.
};

func void DIA_Addon_AlligatorJack_BDTRuestung_wo()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_BDTRuestung_wo_15_00");	//Do you have any idea where I could find armor like that?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_BDTRuestung_wo_12_01");	//We used to have one in our pirate camp.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_BDTRuestung_wo_12_03");	//But I don't know whether it's still there.
	B_LogEntry (TOPIC_Addon_BDTRuestung, "The pirates are supposed to have a suit of bandit armor. But Alligator Jack couldn't tell me if it exists.");
	Info_ClearChoices (DIA_Addon_AlligatorJack_BDTRuestung);
};


instance DIA_Addon_AlligatorJack_Greg(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_Greg_Condition;
	information = DIA_Addon_AlligatorJack_Greg_Info;
	description = "Your captain's name is Greg?";
};


func int DIA_Addon_AlligatorJack_Greg_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_WerBistDu) && (GregIsBack == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_Greg_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_Greg_15_00");	//Your captain's name is Greg?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Greg_12_01");	//Right. He's the greatest pirate the sea ever spawned.
	if((SC_SawGregInTaverne == TRUE) || (PlayerTalkedToGregNW == TRUE))
	{
		AI_Output (other, self, "DIA_Addon_AlligatorJack_Greg_15_02");	//I think I know your captain. I met him in Khorinis.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Greg_12_03");	//(laughs) Greg? In Khorinis? Nonsense!
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Greg_12_04");	//Greg is out at sea after booty with some of the lads.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Greg_12_05");	//The only thing that could bring Greg to Khorinis would be one of the King's prison galleys.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Greg_12_06");	//He's one of the most wanted men in the land.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Greg_12_07");	//He'd never march into town voluntarily and have the royal guard throw him into prison.
		AI_Output (other, self, "DIA_Addon_AlligatorJack_Greg_15_08");	//If you say so.
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_AlligatorJack_Greg_12_04");	//Greg is out at sea after booty with some of the lads.
	};
};


instance DIA_Addon_AlligatorJack_PIRLager(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_PIRLager_Condition;
	information = DIA_Addon_AlligatorJack_PIRLager_Info;
	description = "Where's your pirate camp?";
};


func int DIA_Addon_AlligatorJack_PIRLager_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_WerBistDu) && (GregIsBack == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_PIRLager_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_PIRLager_15_00");	//Where's your pirate camp?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_PIRLager_12_01");	//See the cave passage over there? Go through it and continue west, and you'll come to our beach sooner or later.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_PIRLager_12_02");	//That's where our log huts are.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_PIRLager_12_03");	//I can take you there if you want, if you do me a favor first.
	AI_Output (other, self, "DIA_Addon_AlligatorJack_PIRLager_15_04");	//What would that be?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_PIRLager_12_05");	//I'll have to get the boys some meat before I can go back to camp.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_PIRLager_12_06");	//You're a strong fellow.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_PIRLager_12_07");	//I could use your help hunting. Interested?
	Log_CreateTopic (TOPIC_Addon_RatHunt, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_RatHunt, LOG_Running);
	B_LogEntry (TOPIC_Addon_RatHunt, "Alligator Jack needs help with hunting.");
};


instance DIA_Addon_AlligatorJack_WasJagen(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_WasJagen_Condition;
	information = DIA_Addon_AlligatorJack_WasJagen_Info;
	description = "What is it you hunt?";
};


func int DIA_Addon_AlligatorJack_WasJagen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_PIRLager))
	{
		return TRUE;
	};
	if((GregIsBack == TRUE) && Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_WerBistDu))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_WasJagen_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_WasJagen_15_00");	//What is it you hunt?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_WasJagen_12_01");	//Only alligators, usually. But they're no good for eating.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_WasJagen_12_02");	//And there aren't any left around here anyway.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_WasJagen_12_03");	//So I take what I can find: swamp rats.
	AI_Output (other, self, "DIA_Addon_AlligatorJack_WasJagen_15_04");	//What?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_WasJagen_12_05");	//Most beasts around here taste like old socks, or they're as tough as alligator meat.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_WasJagen_12_06");	//Those fat swamp rats are the only thing that is remotely edible.
	if(Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_PIRLager))
	{
		B_LogEntry(TOPIC_Addon_RatHunt,"The only thing that is remotely edible in the area is swamp rats.");
	};
};


instance DIA_Addon_AlligatorJack_Pirates(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_Pirates_Condition;
	information = DIA_Addon_AlligatorJack_Pirates_Info;
	permanent = FALSE;
	description = "Tell me more about you pirates.";
};


func int DIA_Addon_AlligatorJack_Pirates_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_PIRLager))
	{
		return TRUE;
	};
	if((GregIsBack == TRUE) && Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_WerBistDu))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_Pirates_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_Pirates_15_00");	//Tell me more about you pirates.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Pirates_12_01");	//We've been living here for years. Back before the war, everyone knew us from here to the mainland.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Pirates_12_02");	//Our flag alone would spread terror among the crews of merchant vessels.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Pirates_12_03");	//But those times are past now. It's been weeks since we've run into a merchant vessel.
	if(GregIsBack == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Pirates_12_04");	//Our Cap'n Greg left to try and catch another.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Pirates_12_05");	//The rest of us are sitting here in camp, twiddling our thumbs until he comes back.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Pirates_12_06");	//I hope he'll bring back lots of booty.
	};
};


instance DIA_Addon_AlligatorJack_LetsGoHunting(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_LetsGoHunting_Condition;
	information = DIA_Addon_AlligatorJack_LetsGoHunting_Info;
	permanent = TRUE;
	description = "Let's go hunting.";
};


func int DIA_Addon_AlligatorJack_LetsGoHunting_Condition()
{
	if((MIS_KrokoJagd == FALSE) && Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_WasJagen) && (GregIsBack == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_LetsGoHunting_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_LetsGoHunting_15_00");	//Let's go hunting.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_LetsGoHunting_12_01");	//All right. With two people, that's child's play.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_LetsGoHunting_12_02");	//Are you ready?
	Info_ClearChoices (DIA_Addon_AlligatorJack_LetsGoHunting);
	Info_AddChoice (DIA_Addon_AlligatorJack_LetsGoHunting, "No, not yet.", DIA_Addon_AlligatorJack_LetsGoHunting_No);
	Info_AddChoice (DIA_Addon_AlligatorJack_LetsGoHunting, "Yes.", DIA_Addon_AlligatorJack_LetsGoHunting_Yes);
};


const int AlligatorJack_Inter1 = 1;
const int AlligatorJack_Kessel = 2;
const int AlligatorJack_Inter2 = 3;
const int AlligatorJack_Canyon = 4;

func void DIA_Addon_AlligatorJack_LetsGoHunting_Yes()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_LetsGoHunting_Yes_15_00");	//Yes.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_LetsGoHunting_Yes_12_01");	//Great. Just stay right behind me.
	AI_StopProcessInfos (self);
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	Npc_ExchangeRoutine(self,"HUNT1");
	Wld_InsertNpc(Swamprat,"ADW_PIRATECAMP_WATERHOLE_06");
	Wld_InsertNpc(Swamprat,"ADW_PIRATECAMP_WATERHOLE_07");
	Wld_InsertNpc(Swamprat,"ADW_PIRATECAMP_WATERHOLE_07");
	Wld_InsertNpc(Swamprat,"ADW_CANYON_TELEPORT_PATH_06");
	Wld_InsertNpc(Swamprat,"ADW_CANYON_TELEPORT_PATH_06");
	Wld_InsertNpc(Swamprat,"ADW_CANYON_TELEPORT_PATH_06");
	AlligatorJack_JagdStart = AlligatorJack_Inter1;
	MIS_KrokoJagd = LOG_Running;
};

func void DIA_Addon_AlligatorJack_LetsGoHunting_No()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_LetsGoHunting_No_15_00");	//No, not yet.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_LetsGoHunting_No_12_01");	//Hurry up, then.
	Info_ClearChoices (DIA_Addon_AlligatorJack_LetsGoHunting);
};


instance DIA_Addon_AlligatorJack_AlligatorJackInter1(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_AlligatorJackInter1_Condition;
	information = DIA_Addon_AlligatorJack_AlligatorJackInter1_Info;
	important = TRUE;
};


func int DIA_Addon_AlligatorJack_AlligatorJackInter1_Condition()
{
	if((AlligatorJack_JagdStart == AlligatorJack_Inter1) && (Npc_GetDistToWP(self,"ADW_PIRATECAMP_WAY_16") <= 500))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_AlligatorJackInter1_Info()
{
	AI_Output (self, other, "DIA_Addon_AlligatorJack_AlligatorJackInter1_12_00");	//The hollow.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_AlligatorJackInter1_12_01");	//There should be some of those beasts around here.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_AlligatorJackInter1_12_02");	//Follow me.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "HUNT2");
	AlligatorJack_JagdStart = AlligatorJack_Kessel;
};


instance DIA_Addon_AlligatorJack_TheHunt(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_TheHunt_Condition;
	information = DIA_Addon_AlligatorJack_TheHunt_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_AlligatorJack_TheHunt_Condition()
{
	if((AlligatorJack_JagdStart == AlligatorJack_Kessel) && (Npc_GetDistToWP(self,"ADW_PIRATECAMP_WATERHOLE_07") <= 500) && (GregIsBack == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_TheHunt_Info()
{
	AI_Output (self, other, "DIA_Addon_AlligatorJack_TheHunt_12_00");	//I was afraid of that.
	AI_Output (other, self, "DIA_Addon_AlligatorJack_TheHunt_15_01");	//What?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_TheHunt_12_02");	//This handful of beasts here is only about half of what I need.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_TheHunt_12_03");	//Now we'll have to enter the canyon.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_TheHunt_12_04");	//Watch out, it's very dangerous deeper down in the canyon.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_TheHunt_12_05");	//If you hold your life dear, stay very close to me.
	Wld_InsertNpc (Waran, "ADW_ENTRANCE_2_VALLEY_10");
	Wld_InsertNpc (Waran, "ADW_ENTRANCE_2_VALLEY_10");
	Info_ClearChoices (DIA_Addon_AlligatorJack_TheHunt);
	Info_AddChoice (DIA_Addon_AlligatorJack_TheHunt, "What IS there in the canyon?", DIA_Addon_AlligatorJack_TheHunt_Enough);
	Info_AddChoice (DIA_Addon_AlligatorJack_TheHunt, "Fine, let's go.", DIA_Addon_AlligatorJack_TheHunt_Running);
};

func void DIA_Addon_AlligatorJack_TheHunt_Enough()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_TheHunt_Enough_15_00");	//What IS there in the canyon?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_TheHunt_Enough_12_01");	//We avoid that area if it's at all possible.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_TheHunt_Enough_12_02");	//That's where you find razors. Tough beasts, those. Stay away from them if you want to live another day.
};

func void DIA_Addon_AlligatorJack_TheHunt_Running()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_TheHunt_Running_15_00");	//Fine, let's go.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_TheHunt_Running_12_01");	//All right.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "HUNT3");
	AlligatorJack_JagdStart = AlligatorJack_Inter2;
};


instance DIA_Addon_AlligatorJack_AlligatorJackInter2(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_AlligatorJackInter2_Condition;
	information = DIA_Addon_AlligatorJack_AlligatorJackInter2_Info;
	important = TRUE;
};


func int DIA_Addon_AlligatorJack_AlligatorJackInter2_Condition()
{
	if((AlligatorJack_JagdStart == AlligatorJack_Inter2) && (Npc_GetDistToWP(self,"ADW_PIRATECAMP_WAY_16") <= 500) && (GregIsBack == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_AlligatorJackInter2_Info()
{
	AI_Output (self, other, "DIA_Addon_AlligatorJack_AlligatorJackInter2_12_00");	//Come on.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "HUNT4");
	AlligatorJack_JagdStart = AlligatorJack_Canyon;
};


instance DIA_Addon_AlligatorJack_HuntEnd(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_HuntEnd_Condition;
	information = DIA_Addon_AlligatorJack_HuntEnd_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_AlligatorJack_HuntEnd_Condition()
{
	if((AlligatorJack_JagdStart == AlligatorJack_Canyon) && (Npc_GetDistToWP(self,"ADW_CANYON_TELEPORT_PATH_06") <= 500) && (GregIsBack == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_HuntEnd_Info()
{
	if(AlligatorJack_KrokosKilled == 0)
	{
		AI_Output (self, other, "DIA_Addon_AlligatorJack_HuntEnd_12_00");	//Say, can you tell me what I took you along for?
		AI_Output (self, other, "DIA_Addon_AlligatorJack_HuntEnd_12_01");	//You didn't kill a single swamp rat.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_HuntEnd_12_02");	//Oh well. Maybe you can be useful some other way.
	}
	else if(AlligatorJack_KrokosKilled == 1)
	{
		AI_Output (self, other, "DIA_Addon_AlligatorJack_HuntEnd_12_03");	//Well done, we can use someone like you.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_HuntEnd_12_04");	//You brought down one of those beasts on your first hunt. Not bad.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_AlligatorJack_HuntEnd_12_05");	//You're a talented hunter.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_HuntEnd_12_06");	//My goodness! If you continue like that, I'll be able to stay in camp next time.
	};
	AI_Output(self,other,"DIA_Addon_AlligatorJack_PassHenry_12_07");	//Here, take this swamp rat meat to lazy old Morgan.
	AI_WaitTillEnd(other,self);
	B_GiveInvItems(self,other,ItFoMuttonRaw,10);
	AI_Output (self, other, "DIA_Addon_AlligatorJack_PassHenry_12_08");	//You'll find him in our camp.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_PassHenry_12_09");	//He's probably lounging on the beach somewhere. He'll be waiting for this.
	if(Henry.aivar[AIV_PASSGATE] == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_AlligatorJack_PassHenry_12_10");	//Henry usually guards the entrance to the camp and keeps a lookout for bandits.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_PassHenry_12_11");	//If he refuses to let you in, just tell him that I sent you.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_PassHenry_12_12");	//Maybe that'll make him a bit more sociable.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_PassHenry_12_13");	//Henry is a little too eager and a bit bossy, too.
	};
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	MIS_AlligatorJack_BringMeat = LOG_Running;
	Log_CreateTopic(TOPIC_Addon_BringMeat,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_BringMeat,LOG_Running);
	B_LogEntry(TOPIC_Addon_BringMeat,"Alligator Jack gave me 10 pieces of meat. I'm supposed to take them to Morgan.");
	Log_AddEntry(TOPIC_Addon_RatHunt,"The hunt was successful. We caught several swamp rats.");
	MIS_KrokoJagd = LOG_SUCCESS;
	B_GivePlayerXP(XP_Addon_KrokoJagd);
};


instance DIA_Addon_AlligatorJack_Angus(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_Angus_Condition;
	information = DIA_Addon_AlligatorJack_Angus_Info;
	permanent = FALSE;
	description = "Do you know Angus and his friend Hank?";
};


func int DIA_Addon_AlligatorJack_Angus_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Bill_AngusnHank))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_Angus_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_Angus_15_00");	//Do you know Angus and his friend Hank?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Angus_12_03");	//I haven't seen them in a while.
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Angus_12_04");	//And I wouldn't mind if the pair of them never came back.
	AI_Output (other, self, "DIA_Addon_AlligatorJack_Angus_15_05");	//Why?
	AI_Output (self, other, "DIA_Addon_AlligatorJack_Angus_12_06");	//Oh, those bums always hung around the lake, scaring off the game.
};


instance DIA_Addon_AlligatorJack_Lake(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_Lake_Condition;
	information = DIA_Addon_AlligatorJack_Lake_Info;
	permanent = FALSE;
	description = "WHAT lake would that be?";
};


func int DIA_Addon_AlligatorJack_Lake_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_Angus) && (MIS_Addon_Morgan_SeekTraitor != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_Lake_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_Lake_15_00");	//WHAT lake would that be?
	if (MIS_KrokoJagd == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Lake_12_01");	//Remember our hunt?
		AI_Output (other, self, "DIA_Addon_AlligatorJack_Lake_15_02");	//Yep.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Lake_12_03");	//The lake in the hollow. That's where I usually saw them.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Lake_12_04");	//The lake in the big hollow.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Lake_12_05");	//Just walk east from our camp. You can't miss the hollow.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Lake_12_06");	//There's lots of little waterfalls there.
		AI_Output (self, other, "DIA_Addon_AlligatorJack_Lake_12_07");	//But watch out - if there's nothing but dry sand underfoot, you've missed a turn and entered the canyon.
	};
	B_LogEntry (TOPIC_Addon_SkipsGrog, "The cave should be in the hollow east of the camp, right by the lake.");
};


func void B_AlliJack_AlliKlar()
{
	AI_Output(self,other,"DIA_Addon_AlligatorJack_Anheuern_12_01");	//All right then.
};

func void B_AlligatorJack_CanLearn()
{
	AI_Output(self,other,"DIA_Addon_AlligatorJack_CanLearn_12_02");	//I'll teach you if you like.
	Log_CreateTopic(Topic_Addon_PIR_Teacher,LOG_NOTE);
	B_LogEntry(Topic_Addon_PIR_Teacher,"Alligator Jack can show me how to skin animals or how to remove their teeth. Besides that he can teach me archery.");
	AlligatorJack_Addon_TeachPlayer = TRUE;
};

func void DIA_Addon_AlligatorJack_CanLearn_Pay()
{
	DIA_Common_TakeIt();
	B_GiveInvItems(other,self,ItMi_Gold,200);
	B_AlliJack_AlliKlar();
	B_AlligatorJack_CanLearn();
	Info_ClearChoices(DIA_Addon_AlligatorJack_CanLearn);
};

func void DIA_Addon_AlligatorJack_CanLearn_NoPay()
{
	DIA_Common_IWillThinkAboutIt();
	Info_ClearChoices(DIA_Addon_AlligatorJack_CanLearn);
};

var int DIA_AlligatorJack_Teacher_permanent;

instance DIA_Addon_AlligatorJack_CanLearn(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_CanLearn_Condition;
	information = DIA_Addon_AlligatorJack_CanLearn_Info;
	permanent = TRUE;
	description = "Can you teach me something?";
};


func int DIA_Addon_AlligatorJack_CanLearn_Condition()
{
	if((AlligatorJack_Addon_TeachPlayer == FALSE) && Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_WasJagen))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_CanLearn_Info()
{
	AI_Output(other,self,"DIA_Addon_AlligatorJack_CanLearn_15_00");	//Can you teach me something?
	if((VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_AlligatorJack) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ReptileSkin] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] == FALSE))
	{
		AI_Output(self,other,"DIA_Addon_AlligatorJack_CanLearn_12_01");	//Sure, I'm a good hunter and I can show you how to skin animals and pull their teeth.
		if((GregIsBack == TRUE) && (MIS_KrokoJagd == FALSE))
		{
			B_Say_Gold(self,other,200);
			Info_ClearChoices(DIA_Addon_AlligatorJack_CanLearn);
			Info_AddChoice(DIA_Addon_AlligatorJack_CanLearn,"I'll think about it.",DIA_Addon_AlligatorJack_CanLearn_NoPay);
			if(Npc_HasItems(other,ItMi_Gold) >= 200)
			{
				Info_AddChoice(DIA_Addon_AlligatorJack_CanLearn,"Here's your gold.",DIA_Addon_AlligatorJack_CanLearn_Pay);
			};
		}
		else if(MIS_KrokoJagd > LOG_Running)
		{
			B_AlligatorJack_CanLearn();
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_AlligatorJack_CanLearn_12_03");	//But first show me that you're ready for the hunt.
			AI_Output (self, other, "DIA_Addon_AlligatorJack_CanLearn_12_04");	//Once we've been out hunting together, I might do it.
		};
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_BOW) >= TeachLimit_Bow_AlligatorJack)
		{
			AlligatorJack_Addon_TeachPlayer = TRUE;
			DIA_AlligatorJack_Teacher_permanent = TRUE;
		};
		B_Say(self,other,"$NOLEARNYOUREBETTER");
	};
};


func void B_BuildLearnDialog_AlligatorJack()
{
	Info_ClearChoices(DIA_Addon_AlligatorJack_Teach);
	Info_AddChoice(DIA_Addon_AlligatorJack_Teach,Dialog_Back,DIA_Addon_AlligatorJack_Teach_Back);
	if(VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_AlligatorJack)
	{
		Info_AddChoice(DIA_Addon_AlligatorJack_Teach,B_BuildLearnString(PRINT_LearnBow1,B_GetLearnCostTalent(other,NPC_TALENT_BOW,1)),DIA_Addon_AlligatorJack_Teach_Bow_1);
		Info_AddChoice(DIA_Addon_AlligatorJack_Teach,B_BuildLearnString(PRINT_LearnBow5,B_GetLearnCostTalent(other,NPC_TALENT_BOW,5)),DIA_Addon_AlligatorJack_Teach_Bow_5);
	};
	if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ReptileSkin] == FALSE)
	{
		Info_AddChoice(DIA_Addon_AlligatorJack_Teach,B_BuildLearnString(NAME_TROPHY_ReptileSkin,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALFUR,TROPHY_ReptileSkin)),DIA_Addon_AlligatorJack_Teach_FUR);
	};
	if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] == FALSE)
	{
		Info_AddChoice(DIA_Addon_AlligatorJack_Teach,B_BuildLearnString(NAME_TROPHY_Teeth,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Teeth)),DIA_Addon_AlligatorJack_Teach_Teeth);
	};
	if((VisibleTalentValue(NPC_TALENT_BOW) >= TeachLimit_Bow_AlligatorJack) && (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ReptileSkin] == TRUE) && (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] == TRUE))
	{
		if(RealTalentValue(NPC_TALENT_BOW) >= TeachLimit_Bow_AlligatorJack)
		{
			DIA_AlligatorJack_Teacher_permanent = TRUE;
		};
		PrintScreen(PRINT_NoLearnTotalMAXReached,-1,53,FONT_Screen,2);
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		AI_StopProcessInfos(self);
	};
};


instance DIA_Addon_AlligatorJack_Teach(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 5;
	condition = DIA_Addon_AlligatorJack_Teach_Condition;
	information = DIA_Addon_AlligatorJack_Teach_Info;
	permanent = TRUE;
	description = "Teach me!";
};


func int DIA_Addon_AlligatorJack_Teach_Condition()
{
	if((AlligatorJack_Addon_TeachPlayer == TRUE) && (DIA_AlligatorJack_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_Teach_Info()
{
	AI_Output(other,self,"DIA_Addon_AlligatorJack_Teach_15_00");	//Teach me!
	if((VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_AlligatorJack) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ReptileSkin] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] == FALSE))
	{
		AI_Output(self,other,"DIA_Addon_AlligatorJack_Teach_12_01");	//What is it you want to learn?
	};
	B_BuildLearnDialog_AlligatorJack();
};

func void DIA_Addon_AlligatorJack_Teach_Back()
{
	Info_ClearChoices(DIA_Addon_AlligatorJack_Teach);
};

func void DIA_Addon_AlligatorJack_Teach_Bow_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,1,TeachLimit_Bow_AlligatorJack))
	{
		B_BuildLearnDialog_AlligatorJack();
	};
};

func void DIA_Addon_AlligatorJack_Teach_Bow_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,5,TeachLimit_Bow_AlligatorJack))
	{
		B_BuildLearnDialog_AlligatorJack();
	};
};

func void DIA_Addon_AlligatorJack_Teach_FUR()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_ReptileSkin))
	{
		AI_Output(self,other,"DIA_Addon_AlligatorJack_Teach_Fur_12_00");	//Always make the cut at the belly, or the quality will suffer.
		B_BuildLearnDialog_AlligatorJack();
	};
};

func void DIA_Addon_AlligatorJack_Teach_Teeth()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Teeth))
	{
		B_BuildLearnDialog_AlligatorJack();
	};
};

instance DIA_Addon_AlligatorJack_Anheuern(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 11;
	condition = DIA_Addon_AlligatorJack_Anheuern_Condition;
	information = DIA_Addon_AlligatorJack_Anheuern_Info;
	permanent = FALSE;
	description = "Let's go hunting.";
};


func int DIA_Addon_AlligatorJack_Anheuern_Condition()
{
	if(MIS_Addon_Greg_ClearCanyon == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_Anheuern_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_Anheuern_15_00");	//Let's go hunting.
	B_AlliJack_AlliKlar ();
	AI_StopProcessInfos (self);
	B_Addon_PiratesFollowAgain ();
	Npc_ExchangeRoutine (self, "FOLLOW");
	self.aivar[AIV_PARTYMEMBER] = TRUE;
};


instance DIA_Addon_AlligatorJack_ComeOn(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 12;
	condition = DIA_Addon_AlligatorJack_ComeOn_Condition;
	information = DIA_Addon_AlligatorJack_ComeOn_Info;
	permanent = TRUE;
	description = "Come along.";
};


func int DIA_Addon_AlligatorJack_ComeOn_Condition()
{
	if((self.aivar[AIV_PARTYMEMBER] == FALSE) && (MIS_Addon_Greg_ClearCanyon == LOG_Running) && Npc_KnowsInfo(other,DIA_Addon_AlligatorJack_Anheuern))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_ComeOn_Info()
{
	AI_Output(other,self,"DIA_Addon_AlligatorJack_KommMit_15_00");	//Come along.
	if(C_GregsPiratesTooFar())
	{
		B_Say(self,other,"$NOTNOW");
		AI_StopProcessInfos(self);
	}
	else
	{
		B_AlliJack_AlliKlar();
		AI_StopProcessInfos(self);
		Npc_ExchangeRoutine(self,"FOLLOW");
		self.aivar[AIV_PARTYMEMBER] = TRUE;
	};
};


instance DIA_Addon_AlligatorJack_GoHome(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 13;
	condition = DIA_Addon_AlligatorJack_GoHome_Condition;
	information = DIA_Addon_AlligatorJack_GoHome_Info;
	permanent = TRUE;
	description = "I no longer need you.";
};


func int DIA_Addon_AlligatorJack_GoHome_Condition()
{
	if((self.aivar[AIV_PARTYMEMBER] == TRUE) && (MIS_Addon_Greg_ClearCanyon == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_GoHome_Info()
{
	AI_Output (other, self, "DIA_Addon_AlligatorJack_DontNeedYou_15_00");	//I no longer need you.
	B_AlliJack_AlliKlar ();
	AI_StopProcessInfos (self);
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"START");
};


instance DIA_Addon_AlligatorJack_TooFar(C_Info)
{
	npc = PIR_1352_Addon_AlligatorJack;
	nr = 14;
	condition = DIA_Addon_AlligatorJack_TooFar_Condition;
	information = DIA_Addon_AlligatorJack_TooFar_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_AlligatorJack_TooFar_Condition()
{
	if((self.aivar[AIV_PARTYMEMBER] == TRUE) && C_GregsPiratesTooFar() && (MIS_Addon_Greg_ClearCanyon == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_AlligatorJack_TooFar_Info()
{
	B_Say(self,other,"$RUNAWAY");
	B_Addon_PiratesGoHome();
	AI_StopProcessInfos(self);
};

