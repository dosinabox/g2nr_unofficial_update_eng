
var int Scatty_Start;

instance DIA_Addon_Scatty_EXIT(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 999;
	condition = DIA_Addon_Scatty_EXIT_Condition;
	information = DIA_Addon_Scatty_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Scatty_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Scatty_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
	if(Scatty_Start == FALSE)
	{
		Npc_ExchangeRoutine(self,"START");
		Scatty_Start = TRUE;
	};
};


instance DIA_Addon_Scatty_PICKPOCKET(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 900;
	condition = DIA_Addon_Scatty_PICKPOCKET_Condition;
	information = DIA_Addon_Scatty_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Addon_Scatty_PICKPOCKET_Condition()
{
	return C_Beklauen(60,90);
};

func void DIA_Addon_Scatty_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Scatty_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Scatty_PICKPOCKET,Dialog_Back,DIA_Addon_Scatty_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Scatty_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Scatty_PICKPOCKET_DoIt);
};

func void DIA_Addon_Scatty_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Scatty_PICKPOCKET);
};

func void DIA_Addon_Scatty_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Scatty_PICKPOCKET);
};


instance DIA_Addon_Scatty_Hi(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 2;
	condition = DIA_Addon_Scatty_Hi_Condition;
	information = DIA_Addon_Scatty_Hi_Info;
	permanent = FALSE;
	description = "How's business?";
};


func int DIA_Addon_Scatty_Hi_Condition()
{
	return TRUE;
};

func void DIA_Addon_Scatty_Hi_Info()
{
	AI_Output (other, self, "DIA_Addon_Scatty_Hi_15_00");	//How's business?
	AI_Output (self, other, "DIA_Addon_Scatty_Hi_01_01");	//Since the tomb has been opened, there hasn't been much demand.
	AI_Output (self, other, "DIA_Addon_Scatty_Hi_01_02");	//Raven has no more use for the slaves, that's why they're mining gold now. On Bloodwyn's orders.
	AI_Output (self, other, "DIA_Addon_Scatty_Hi_01_03");	//And the diggers are taking it easy. (mumbles) Diggers who take it easy aren't good for business.
	Log_CreateTopic (Topic_Addon_BDT_Trader, LOG_NOTE);
	B_LogEntry (Topic_Addon_BDT_Trader, "Scatty sells a variety of goods.");
};


instance DIA_Addon_Scatty_last(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 2;
	condition = DIA_Addon_Scatty_last_Condition;
	information = DIA_Addon_Scatty_last_Info;
	permanent = FALSE;
	description = "Bloodwyn? Is he in charge here?";
};


func int DIA_Addon_Scatty_last_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Scatty_Hi) && !Npc_IsDead(Bloodwyn))
	{
		return TRUE;
	};
};

func void DIA_Addon_Scatty_last_Info()
{
	AI_Output (other, self, "DIA_Addon_Scatty_last_15_00");	//Bloodwyn? Is he in charge here?
	AI_Output (self, other, "DIA_Addon_Scatty_last_01_01");	//He oversees the mine. But he's almost never down here. He spends most of his time with Raven in the temple.
	AI_Output (other, self, "DIA_Addon_Scatty_last_15_02");	//What exactly does 'almost never' mean?
	AI_Output (self, other, "DIA_Addon_Scatty_last_01_03");	//The last time I saw him was when he came out of the tomb...
	AI_Output (self, other, "DIA_Addon_Scatty_last_01_04");	//(hastily) ...No, wait! The last time he was here was when he sent the slaves to mine the gold.
	AI_Output (self, other, "DIA_Addon_Scatty_last_01_05");	//Unlike Raven, HE is very interested in gold.
};


instance DIA_Addon_Scatty_Gruft(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 2;
	condition = DIA_Addon_Scatty_Gruft_Condition;
	information = DIA_Addon_Scatty_Gruft_Info;
	permanent = FALSE;
	description = "What sort of tomb?";
};


func int DIA_Addon_Scatty_Gruft_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Scatty_Hi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Scatty_Gruft_Info()
{
	AI_Output (other, self, "DIA_Addon_Scatty_Gruft_15_00");	//What sort of tomb?
	AI_Output (self, other, "DIA_Addon_Scatty_Gruft_01_01");	//A cursed unlucky tomb! The guardians of the tomb have killed many men!
	AI_Output (other, self, "DIA_Addon_Scatty_Gruft_15_02");	//Guardians? Are you talking about creatures of stone? Rather flat, with a round head?
	AI_Output (self, other, "DIA_Addon_Scatty_Gruft_01_03");	//That's exactly what I mean! They came out of the depths of the stone by the dozen.
	AI_Output (self, other, "DIA_Addon_Scatty_Gruft_01_04");	//I knew from the beginning that it wasn't good to dig out the tomb.
	AI_Output (self, other, "DIA_Addon_Scatty_Gruft_01_05");	//But Raven was possessed with the idea of digging there. And once the tomb was finally uncovered, he marched in there with his guards.
};


instance DIA_Addon_Scatty_GruftAgain(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 2;
	condition = DIA_Addon_Scatty_GruftAgain_Condition;
	information = DIA_Addon_Scatty_GruftAgain_Info;
	permanent = FALSE;
	description = "What did Raven want in the tomb?";
};


func int DIA_Addon_Scatty_GruftAgain_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Scatty_Gruft))
	{
		return TRUE;
	};
};

func void DIA_Addon_Scatty_GruftAgain_Info()
{
	AI_Output (other, self, "DIA_Addon_Scatty_GruftAgain_15_00");	//What did Raven want in the tomb?
	AI_Output (self, other, "DIA_Addon_Scatty_GruftAgain_01_01");	//(stops short) Hm... you're pretty curious. You remind me of a fellow I once knew.
	AI_Output (self, other, "DIA_Addon_Scatty_GruftAgain_01_02");	//He was just as curious. And eventually it was his undoing.
	AI_Output (other, self, "DIA_Addon_Scatty_GruftAgain_15_03");	//Get to the point. What happened in the tomb?
	AI_Output (self, other, "DIA_Addon_Scatty_GruftAgain_01_04");	//Well... Ehm... my throat is really dry...
	AI_Output (other, self, "DIA_Addon_Scatty_GruftAgain_15_05");	//Hey, Scatty, NOT NOW. This is important, so what did Raven do there?
	AI_Output (self, other, "DIA_Addon_Scatty_GruftAgain_01_06");	//All right. (takes a deep breath) He... he called... summoned something. He kept calling out words in a foreign language.
	AI_Output (self, other, "DIA_Addon_Scatty_GruftAgain_01_07");	//Bright light poured out of the tomb and then I heard a scream that cut right through me - a demonic scream.
	AI_Output (other, self, "DIA_Addon_Scatty_GruftAgain_15_08");	//And then?
	AI_Output (self, other, "DIA_Addon_Scatty_GruftAgain_01_09");	//That's all I know. At that moment Bloodwyn came out of the tomb and said I should beat it. And that's what I did.
	AI_Output (self, other, "DIA_Addon_Scatty_GruftAgain_01_10");	//It also didn't take long before Raven and his boys disappeared back into the temple. Since then Raven hasn't been seen.
};


instance DIA_Addon_Scatty_Trinken(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 99;
	condition = DIA_Addon_Scatty_Trinken_Condition;
	information = DIA_Addon_Scatty_Trinken_Info;
	permanent = FALSE;
	description = "Would you like a drink?";
};


func int DIA_Addon_Scatty_Trinken_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Scatty_GruftAgain))
	{
		return TRUE;
	};
};

func void DIA_Addon_Scatty_Trinken_Info()
{
	AI_Output(other,self,"DIA_Addon_Scatty_Trinken_15_00");	//Would you like a drink?
	AI_Output(self,other,"DIA_Addon_Scatty_Trinken_01_01");	//A beer would really hit the spot. There's hardly any beer here in camp.
	if(!Npc_IsDead(Lucia))
	{
		AI_Output(self,other,"DIA_Addon_Scatty_Trinken_01_02");	//But maybe Lucia still has a bottle...
		if(!Npc_KnowsInfo(other,DIA_Addon_Lucia_was))
		{
			Log_CreateTopic(Topic_Addon_BDT_Trader,LOG_NOTE);
			B_LogEntry(Topic_Addon_BDT_Trader,"Lucia can sell me some drinks.");
		};
	};
};


instance DIA_Addon_Scatty_Bier(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 99;
	condition = DIA_Addon_Scatty_Bier_Condition;
	information = DIA_Addon_Scatty_Bier_Info;
	permanent = FALSE;
	description = "To your health. (give beer)";
};


func int DIA_Addon_Scatty_Bier_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Scatty_Trinken) && Npc_HasItems(other,ItFo_Beer))
	{
		return TRUE;
	};
};

func void DIA_Addon_Scatty_Bier_Info()
{
	AI_Output(other,self,"DIA_Addon_Scatty_Bier_15_00");	//There you go.
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(other,self,ItFo_Beer,1);
	AI_UseItem(self,ItFo_Beer);
	AI_Output(self,other,"DIA_Addon_Scatty_Bier_01_01");	//Oh, that tastes good. Thanks man. You're my hero.
	B_GivePlayerXP(XP_Ambient * 5);
};


instance DIA_Addon_Scatty_Gold(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 800;
	condition = DIA_Addon_Scatty_Gold_Condition;
	information = DIA_Addon_Scatty_Gold_Info;
	permanent = FALSE;
	description = DIALOG_ADDON_GOLD_DESCRIPTION;
};


func int DIA_Addon_Scatty_Gold_Condition()
{
	return TRUE;
};

func void DIA_Addon_Scatty_Gold_Info()
{
	B_Say (other, self, "$ADDON_GOLD_DESCRIPTION");
	AI_Output (self, other, "DIA_Addon_Scatty_Gold_01_00");	//Take a pickaxe in your hand and whack at a lump of gold - anyone can do that.
	AI_Output (self, other, "DIA_Addon_Scatty_Gold_01_01");	//But many nuggets will shatter that way. That's why only people who understand mining should do it.
	AI_Output (self, other, "DIA_Addon_Scatty_Gold_01_02");	//I can tell you more once you have some more experience.
	B_Upgrade_Hero_HackChance (5);
};


var int Scatty_teach_noPerm;

instance DIA_Addon_Scatty_teach(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 800;
	condition = DIA_Addon_Scatty_teach_Condition;
	information = DIA_Addon_Scatty_teach_Info;
	permanent = TRUE;
//	description = "Расскажи мне еще что-нибудь о том, как копать золото. (1 LP/10 процентов)";
	description = "(learn to dig gold: + 10, 1 LP)";
};


func int DIA_Addon_Scatty_teach_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Scatty_Gold) && (Scatty_teach_noPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Scatty_teach_Info()
{
	AI_Output(other,self,"DIA_Addon_Scatty_teach_15_00");	//Tell me more about gold mining.
	if(Hero_HackChance < 100)
	{
		if(other.lp >= 1)
		{
				AI_Output (self, other, "DIA_Addon_Scatty_teach_01_01");	//Above all, you should know that gold isn't ore. It's soft as butter. If you strike too hard, everything will shatter.
				AI_Output (self, other, "DIA_Addon_Scatty_teach_01_02");	//Every digger has his own tricks for knocking some decent nuggets out of the rock.
				AI_Output (self, other, "DIA_Addon_Scatty_teach_01_03");	//Ultimately, these tricks are what make the difference between a digger and a good digger.
				AI_Output (self, other, "DIA_Addon_Scatty_teach_01_04");	//Besides that, practice makes perfect. Only when you've been digging for a while will you get better.
			other.lp -= 1;
			B_Upgrade_Hero_HackChance(10);
		}
		else
		{
			B_Say(self,other,"$NOLEARNNOPOINTS");
		};
	}
	else
	{
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		Scatty_teach_noPerm = TRUE;
	};
};


instance DIA_Addon_Scatty_tot(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 2;
	condition = DIA_Addon_Scatty_tot_Condition;
	information = DIA_Addon_Scatty_tot_Info;
	permanent = FALSE;
	description = "Bloodwyn is dead.";
};


func int DIA_Addon_Scatty_tot_Condition()
{
	if(Npc_IsDead(Bloodwyn))
	{
		return TRUE;
	};
};

func void DIA_Addon_Scatty_tot_Info()
{
	AI_Output (other, self, "DIA_Addon_Scatty_tot_15_00");	//Bloodwyn is dead.
	AI_Output (self, other, "DIA_Addon_Scatty_tot_01_01");	//Hm, there aren't many people I'd wish that on - but Bloodwyn is better off dead.
};


instance DIA_Addon_Scatty_trade(C_Info)
{
	npc = BDT_1086_Addon_Scatty;
	nr = 99;
	condition = DIA_Addon_Scatty_trade_Condition;
	information = DIA_Addon_Scatty_trade_Info;
	permanent = TRUE;
	trade = TRUE;
	description = DIALOG_TRADE_v1;
};


func int DIA_Addon_Scatty_trade_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Scatty_Hi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Scatty_trade_Info()
{
	B_Say(other,self,"$TRADE_1");
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};

