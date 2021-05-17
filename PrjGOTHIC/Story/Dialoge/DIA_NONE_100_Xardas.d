
instance DIA_Xardas_FirstEXIT(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 990;
	condition = DIA_Xardas_FirstEXIT_Condition;
	information = DIA_Xardas_FirstEXIT_Info;
	permanent = FALSE;
	description = "I'll be on my way as fast as I can! (END)";
};


func int DIA_Xardas_FirstEXIT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Xardas_TODO) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_FirstEXIT_Info()
{
	AI_Output (other, self, "DIA_Xardas_FirstEXIT_15_00");	//I'll be on my way as fast as I can!
	AI_Output (self, other, "DIA_Xardas_FirstEXIT_14_01");	//Good! And one more thing: don't tell anyone that you have talked to me. Above all, don't tell any magician.
	AI_Output (self, other, "DIA_Xardas_FirstEXIT_14_02");	//Since I have gone into exile, the Circle of Fire has taken me for dead - and that's a good thing, too.
	AI_StopProcessInfos (self);
	B_Kapitelwechsel (1, NEWWORLD_ZEN);
	Npc_ExchangeRoutine (self, "START");
};


instance DIA_Xardas_EXIT(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 999;
	condition = DIA_Xardas_EXIT_Condition;
	information = DIA_Xardas_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Xardas_EXIT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Xardas_FirstEXIT))
	{
		return TRUE;
	};
};

func void DIA_Xardas_EXIT_Info()
{
	if(Npc_HasItems(hero,ItMw_BeliarWeapon_Fake))
	{
		Npc_RemoveInvItem(hero,ItMw_BeliarWeapon_Fake);
	};
	AI_StopProcessInfos(self);
};


var int Addon_zuerst;

func void B_Xardas_SoLittleTime()
{
	AI_Output(self,other,"DIA_Xardas_Hello_14_15");	//(pensively) We do not have much time left.
};

instance DIA_Xardas_Hello(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 1;
	condition = DIA_Xardas_Hello_Condition;
	information = DIA_Xardas_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Xardas_Hello_Condition()
{
	return TRUE;
};

func void DIA_Xardas_Hello_Info()
{
	AI_Output (self, other, "DIA_Addon_Xardas_Hello_14_00");	//There you are again! (smiling) I never thought the two of us would meet again.
	AI_Output (other, self, "DIA_Addon_Xardas_Hello_15_01");	//I feel like I spent three weeks lying under a load of rocks.
	AI_Output (self, other, "DIA_Addon_Xardas_Hello_14_02");	//Well, so you did. Only the magic within your armor kept you alive.
	AI_Output (self, other, "DIA_Addon_Xardas_Hello_14_03");	//I had feared I might not be able to rescue you from the debris of the temple.
	AI_Output (self, other, "DIA_Addon_Xardas_Hello_14_04");	//But enough of that. You're here now.
	AI_Output (self, other, "DIA_Addon_Xardas_Hello_14_05");	//There's a NEW threat that we have to deal with.
	Info_ClearChoices (DIA_Xardas_Hello);
	Info_AddChoice (DIA_Xardas_Hello, "We've got plenty of time now. The Sleeper has been vanquished.", DIA_Addon_Xardas_Hello_Dragons);
	Info_AddChoice (DIA_Xardas_Hello, "What NEW threat are you talking about?", DIA_Addon_Xardas_Hello_Man);
};

func void DIA_Addon_Xardas_Hello_Man()
{
	PlayVideo("Intro_ADDON.BIK");
	AI_Output(self,other,"DIA_Addon_AddonIntro_14_01");	//(scornfully) Humans are weak.
	AI_Output(other,self,"DIA_Addon_AddonIntro_15_00");	//(astonished) ... humans?
	AI_Output(self,other,"DIA_Addon_AddonIntro_14_02");	//(scornfully) They succumb all too easily to the temptations of evil.
	AI_Output(self,other,"DIA_Addon_AddonIntro_14_03");	//And so, they get involved with powers they do not understand, and certainly cannot control.
	AI_Output(self,other,"DIA_Addon_AddonIntro_14_04");	//Those who are steadfast in their faith have already begun the battle against the enemy.
	AI_Output(self,other,"DIA_Addon_Xardas_AddonIntro_Add_14_10");	//You must become their ally! That's the only way to stop Beliar.
	Addon_zuerst = TRUE;
};

func void DIA_Addon_Xardas_Hello_Dragons()
{
	AI_Output(other,self,"DIA_Xardas_Hello_15_03");	//t least we have enough time now. I did it. The Sleeper...
	AI_Output(self,other,"DIA_Xardas_Hello_14_04");	//...has been banned. You vanquished him, so much is true - but it is not within our power to stop the war that ensues now.
	AI_Output(other,self,"DIA_Xardas_Hello_15_05");	//You're talking about the orcs?
	AI_Output(self,other,"DIA_Xardas_Hello_14_06");	//I'm talking about much more terrible creatures?
	AI_Output(self,other,"DIA_Xardas_Hello_14_07");	//With his final, furious scream, the Sleeper has set into movement the armies of darkness.
	AI_Output(self,other,"DIA_Xardas_Hello_14_08");	//It was an order to all evil creatures. A word of power that they were all bound to obey.
	AI_Output (self, other, "DIA_Xardas_Hello_14_09");	//His last order was: COME! And they came. All of them. Even the dragons.
	AI_Output (other, self, "DIA_Xardas_Hello_15_10");	//(amazed) ... Dragons!
	AI_Output (self, other, "DIA_Xardas_Hello_14_11");	//They are creatures of ancient power. I can sense their presence - even here.
	AI_Output (self, other, "DIA_Xardas_Hello_14_12");	//And they have gathered an entire army of lowly servant creatures around them.
	AI_Output (other, self, "DIA_Xardas_Hello_15_13");	//Where's this army now?
	AI_Output (self, other, "DIA_Xardas_Hello_14_14");	//The army's camp is not far from here, in the Valley of Mines near Khorinis, and they are getting ready to attack.
	if(Addon_zuerst == TRUE)
	{
		B_Xardas_SoLittleTime();
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Xardas_Hello_Dragons_14_06");	//But that's not all. There is yet ANOTHER threat of which I have learned only recently.
		Info_ClearChoices (DIA_Xardas_Hello);
		Info_AddChoice (DIA_Xardas_Hello, "What OTHER threat are you talking about?", DIA_Addon_Xardas_Hello_Man);
	};
};


instance DIA_Xardas_AWAY(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 2;
	condition = DIA_Xardas_AWAY_Condition;
	information = DIA_Xardas_AWAY_Info;
	permanent = FALSE;
	description = "Well then let's hurry to get out of here!";
};


func int DIA_Xardas_AWAY_Condition()
{
	if(!Npc_KnowsInfo(other,DIA_Xardas_TODO) && !Npc_KnowsInfo(other,DIA_Xardas_FirstEXIT) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_AWAY_Info()
{
	AI_Output (other, self, "DIA_Xardas_AWAY_15_00");	//Then let's hurry to get out of here!
	AI_Output (self, other, "DIA_Xardas_AWAY_14_01");	//If we flee now, then it's only to face the dragons later.
	AI_Output (self, other, "DIA_Xardas_AWAY_14_02");	//With the help of the soldiers and the magicians who live around here, we can stop them before their army is completely formed.
	AI_Output (self, other, "DIA_Xardas_AWAY_14_03");	//We're not going to get a better chance.
};


instance DIA_Xardas_TODO(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 1;
	condition = DIA_Xardas_TODO_Condition;
	information = DIA_Xardas_TODO_Info;
	permanent = FALSE;
	description = "What can we do now?";
};


func int DIA_Xardas_TODO_Condition()
{
	if(Kapitel < 3)
	{
		return TRUE;
	};
};

func void DIA_Xardas_TODO_Info()
{
	AI_Output (other, self, "DIA_Xardas_TODO_15_00");	//What can we do?
	AI_Output (self, other, "DIA_Xardas_TODO_14_01");	//This time we cannot handle it by ourselves. Only the power of Innos can help us against those dragons.
	AI_Output (self, other, "DIA_Xardas_TODO_14_02");	//A group of paladins is stationed in the city of Khorinis, not far from here.
	AI_Output (self, other, "DIA_Xardas_TODO_14_03");	//They possess a powerful artifact which could help us defeat the dragons.
	AI_Output (self, other, "DIA_Xardas_TODO_14_04");	//They call it the 'Eye of Innos'. You need to get hold of this artifact.
	AI_Output (self, other, "DIA_Xardas_TODO_14_05");	//Tell the paladins about the threat. You MUST convince their leader to support us!
	AI_Output (self, other, "DIA_Addon_Xardas_Add_14_07");	//And once you have talked to him, you need to find the artifact of Beliar.
	AI_Output (self, other, "DIA_Addon_Xardas_Add_14_08");	//It is the counterpiece to the Eye of Innos. It must not fall into the hands of Evil.
	Log_CreateTopic (TOPIC_INNOSEYE, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_INNOSEYE, LOG_Running);
	B_LogEntry (TOPIC_INNOSEYE, "There's a group of paladins camping out in the city of Khorinis. They have a powerful artifact with them: The Eye of Innos. Its power should help us fend off the dragon threat. I'm going to have to persuade the paladins to rally to our cause.");
};


instance DIA_Addon_Xardas_StonePlate(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 5;
	condition = DIA_Addon_Xardas_StonePlate_Condition;
	information = DIA_Addon_Xardas_StonePlate_Info;
	description = "Can you tell me anything about this stone tablet?";
};


func int DIA_Addon_Xardas_StonePlate_Condition()
{
	if(Npc_HasItems(other,ItWr_StonePlateCommon_Addon))
	{
		return TRUE;
	};
};

func void DIA_Addon_Xardas_StonePlate_Info()
{
	AI_Output (other, self, "DIA_Addon_Xardas_StonePlate_15_00");	//Can you tell me anything about this stone tablet?
	AI_Output (self, other, "DIA_Addon_Xardas_StonePlate_14_03");	//First I suspected it might be a magical artifact, but I finally concluded that it is not of any great significance.
	AI_Output (self, other, "DIA_Addon_Xardas_StonePlate_14_04");	//I have not been able to decode the meaning of this tablet entirely, but it seems to concern the history of a very old culture.
	AI_Output (self, other, "DIA_Addon_Xardas_StonePlate_14_05");	//If you want the tablet, it's yours, I have no use for it.
	B_GivePlayerXP (XP_Ambient);
};


instance DIA_Addon_Xardas_Portal(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 1;
	condition = DIA_Addon_Xardas_Portal_Condition;
	information = DIA_Addon_Xardas_Portal_Info;
	description = "The Water Mages have discovered a portal to an unknown part of the island ...";
};


func int DIA_Addon_Xardas_Portal_Condition()
{
	if((SC_KnowsPortal == TRUE) && !C_ScHasBeliarsWeapon() && !C_SCHasBeliarsRune() && (Saturas_KlaueInsMeer == FALSE) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Xardas_Portal_Info()
{
	AI_Output (other, self, "DIA_Addon_Xardas_AddonSuccess_15_00");	//The Water Mages have discovered a portal to an unknown part of the island ...
	AI_Output (self, other, "DIA_Addon_Xardas_AddonSuccess_14_01");	//Interesting ...
	AI_Output (self, other, "DIA_Addon_Xardas_AddonSuccess_14_02");	//As soon as you find out something that is REALLY helpful, be sure to let me know!
	AI_Output (self, other, "DIA_Addon_Xardas_AddonSuccess_14_03");	//The artifact of Beliar could be hidden somewhere there. Find it!
};


instance DIA_Addon_Xardas_PortalAgain(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 1;
	condition = DIA_Addon_Xardas_PortalAgain_Condition;
	information = DIA_Addon_Xardas_PortalAgain_Info;
	permanent = TRUE;
	description = "About that unknown part of the island ...";
};


func int DIA_Addon_Xardas_PortalAgain_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Xardas_Portal) && !C_ScHasBeliarsWeapon() && !C_SCHasBeliarsRune() && (Saturas_KlaueInsMeer == FALSE) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Xardas_PortalAgain_Info()
{
	AI_Output (other, self, "DIA_Addon_Xardas_AddonSuccess_15_17");	//About that unknown part of the island ...
	AI_Output (self, other, "DIA_Addon_Xardas_AddonSuccess_14_18");	//Don't bother me with details. Come back if you really find anything useful.
};


func void B_Xardas_ClawIsLost()
{
	if(XardasKnowsAboutDestroyedClaw == TRUE)
	{
		AI_Output(self,other,"DIA_Addon_Xardas_AddonSuccess_14_13");	//(ranting) Are you out of your mind? Do you have any idea what you gave away there?
	};
		AI_Output (self, other, "DIA_Addon_Xardas_AddonSuccess_14_14");	//This weapon could have been of great service to us!
		AI_Output (other, self, "DIA_Addon_Xardas_AddonSuccess_15_15");	//I think it was for the better this way.
		AI_Output (self, other, "DIA_Addon_Xardas_AddonSuccess_14_16");	//(sighs) The ways of the Gods are unfathomable...
};

func void B_Xardas_ClawReaction()
{
	AI_Output (self, other, "DIA_Addon_Xardas_AddonSuccess_14_01");	//Interesting...
	AI_Output (self, other, "DIA_Addon_Xardas_AddonSuccess_14_02");	//As soon as you find out something that is REALLY helpful, be sure to let me know!
	B_GivePlayerXP(XP_Ambient * 3);
};

instance DIA_Addon_Xardas_AddonSuccess(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 1;
	condition = DIA_Addon_Xardas_AddonSuccess_Condition;
	information = DIA_Addon_Xardas_AddonSuccess_Info;
	description = "I've explored the unknown part of the island ...";
};


func int DIA_Addon_Xardas_AddonSuccess_Condition()
{
	if(RavenIsDead == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Xardas_AddonSuccess_Info()
{
	AI_Output (other, self, "DIA_Addon_Xardas_AddonSuccess_15_03");	//I've explored the unknown part of the island ...
	AI_Output (self, other, "DIA_Addon_Xardas_AddonSuccess_14_04");	//And, what did you find?
	AI_Output (other, self, "DIA_Addon_Xardas_AddonSuccess_15_05");	//It was all about a mighty artifact. The Claw of Beliar.
	AI_Output (self, other, "DIA_Addon_Xardas_AddonSuccess_14_06");	//The Claw of Beliar?! Where is it now? Do you have it on you?
	if (C_ScHasBeliarsWeapon ())
	{
		AI_Output(other,self,"DIA_Addon_Xardas_AddonSuccess_15_07");	//Yes, here it is.
		CreateInvItem(other,ItMw_BeliarWeapon_Fake);
		AI_UseItem(other,ItMw_BeliarWeapon_Fake);
		AI_Wait(other,0.5);
		AI_WaitTillEnd(self,other);
		B_Xardas_ClawReaction();
		AI_Output(self,other,"DIA_Addon_Xardas_AddonSuccess_14_10");	//Take good care of yourself! And, above all: don't lose it!
	}
	else if(C_SCHasBeliarsRune())
	{
		AI_Output(other,self,"DIA_Hyglas_GOTRUNE_15_00");	//I've created the rune.
		B_Xardas_ClawReaction();
	}
	else
	{
		AI_Output(other,self,"DIA_Addon_Xardas_AddonSuccess_15_11");	//I don't have it any more...
		if(Saturas_KlaueInsMeer == TRUE)
		{
			AI_Output(other,self,"DIA_Addon_Xardas_AddonSuccess_15_12");	//I gave it to the Water Mages so they could dump it in the sea...
			XardasKnowsAboutDestroyedClaw = TRUE;
		};
		B_Xardas_ClawIsLost();
	};
};


instance DIA_Xardas_WhereIsClaw(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 77;
	condition = DIA_Xardas_WhereIsClaw_Condition;
	information = DIA_Xardas_WhereIsClaw_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Xardas_WhereIsClaw_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Xardas_AddonSuccess) && (XardasKnowsAboutDestroyedClaw == FALSE) && (Saturas_KlaueInsMeer == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Xardas_WhereIsClaw_Info()
{
	AI_Output(self,other,"DIA_Addon_Xardas_AddonSuccess_14_06");	//The Claw of Beliar?! Where is it now? Do you have it on you?
	AI_Output(other,self,"DIA_Addon_Xardas_AddonSuccess_15_12");	//I gave it to the Water Mages so they could dump it in the sea...
	XardasKnowsAboutDestroyedClaw = TRUE;
	B_Xardas_ClawIsLost();
};


instance DIA_Xardas_WEAPON(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 5;
	condition = DIA_Xardas_WEAPON_Condition;
	information = DIA_Xardas_WEAPON_Info;
	permanent = FALSE;
	description = "I need weapons.";
};


func int DIA_Xardas_WEAPON_Condition()
{
	if(!Npc_KnowsInfo(other,DIA_Xardas_TODO) && !Npc_KnowsInfo(other,DIA_Xardas_FirstEXIT) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_WEAPON_Info()
{
	AI_Output (other, self, "DIA_Xardas_WEAPON_15_00");	//I need weapons.
	AI_Output (self, other, "DIA_Xardas_WEAPON_14_01");	//I can only give you whatever little I have here.
	AI_Output (self, other, "DIA_Xardas_WEAPON_14_02");	//Look around in my tower. Anything that looks useful to you, you can have.
};


instance DIA_Xardas_ARTEFAKT(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 2;
	condition = DIA_Xardas_ARTEFAKT_Condition;
	information = DIA_Xardas_ARTEFAKT_Info;
	permanent = FALSE;
	description = "What exactly is the 'Eye of Innos'?";
};


func int DIA_Xardas_ARTEFAKT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Xardas_TODO) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_ARTEFAKT_Info()
{
	AI_Output (other, self, "DIA_Xardas_ARTEFAKT_15_00");	//What exactly is the 'Eye of Innos'?
	AI_Output (self, other, "DIA_Xardas_ARTEFAKT_14_01");	//It is an amulet. Legend has it that Innos himself has poured part of his power into this amulet.
	AI_Output (self, other, "DIA_Xardas_ARTEFAKT_14_02");	//It will restore some of your lost strength and help us to defeat the dragons.
	AI_Output (self, other, "DIA_Xardas_ARTEFAKT_14_03");	//It also has some other hidden powers. I shall tell you more about that once the amulet is yours.
};


instance DIA_Xardas_PALADIN(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 3;
	condition = DIA_Xardas_PALADIN_Condition;
	information = DIA_Xardas_PALADIN_Info;
	permanent = FALSE;
	description = "Why would the paladins give me the Eye of Innos?";
};


func int DIA_Xardas_PALADIN_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Xardas_TODO) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_PALADIN_Info()
{
	AI_Output (other, self, "DIA_Xardas_PALADIN_15_00");	//Why would the paladins give me the Eye of Innos?
	AI_Output (self, other, "DIA_Xardas_PALADIN_14_01");	//Because you are the one who is destined to wear it.
	AI_Output (other, self, "DIA_Xardas_PALADIN_15_02");	//How can you claim to know that?
	AI_Output (self, other, "DIA_Xardas_PALADIN_14_03");	//There is a number of reasons, the most important being: you have defeated the Sleeper. If you weren't a favorite of the gods, you'd be dead by now.
	AI_Output (other, self, "DIA_Xardas_PALADIN_15_04");	//Let's assume you are right, and I'm destined to bear the Eye of Innos. How would the paladins know that is true?
	AI_Output (self, other, "DIA_Xardas_PALADIN_14_05");	//The Eye itself chooses the one who may wear it. Once you get hold of it and put it on, the paladins cannot doubt your words any longer.
};


instance DIA_Xardas_Khorinis(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 4;
	condition = DIA_Xardas_Khorinis_Condition;
	information = DIA_Xardas_Khorinis_Info;
	permanent = FALSE;
	description = "How can I get to the city?";
};


func int DIA_Xardas_Khorinis_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Xardas_TODO) && (PlayerEnteredCity == FALSE) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_Khorinis_Info()
{
	AI_Output (other, self, "DIA_Xardas_Khorinis_15_00");	//How can I get to the city?
	AI_Output (self, other, "DIA_Xardas_Khorinis_14_01");	//Just follow the path from here through the mountains. The city is large. You cannot miss it.
	AI_Output (self, other, "DIA_Xardas_Khorinis_14_02");	//But watch out! The path to town is not without dangers. And you aren't nearly as strong as you once were.
};


instance DIA_Xardas_WhereEx(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 6;
	condition = DIA_Xardas_WhereEx_Condition;
	information = DIA_Xardas_WhereEx_Info;
	permanent = FALSE;
	description = "Where exactly are we?";
};


func int DIA_Xardas_WhereEx_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Xardas_FirstEXIT) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_WhereEx_Info()
{
	AI_Output (other, self, "DIA_Xardas_Add_15_00");	//Where exactly are we here?
	AI_Output (self, other, "DIA_Xardas_Add_14_01");	//As I already said, near the city of Khorinis.
	AI_Output (self, other, "DIA_Xardas_Add_14_02");	//I have rebuilt my tower here.
	AI_Output (other, self, "DIA_Xardas_Add_15_03");	//But it's only been a few days since we last saw each other in the Valley of Mines...
	AI_Output (self, other, "DIA_Xardas_Add_14_04");	//The servants which I summoned to build my tower have done a thorough job ...
	AI_Output (other, self, "DIA_Xardas_Add_15_05");	//You can say that again.
};


instance DIA_Xardas_EQUIPMENT(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 7;
	condition = DIA_Xardas_EQUIPMENT_Condition;
	information = DIA_Xardas_EQUIPMENT_Info;
	permanent = FALSE;
	description = "Where can I find better equipment?";
};


func int DIA_Xardas_EQUIPMENT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Xardas_WEAPON) && Npc_KnowsInfo(other,DIA_Xardas_FirstEXIT) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_EQUIPMENT_Info()
{
	AI_Output (other, self, "DIA_Xardas_EQUIPMENT_15_00");	//Where can I find better equipment?
	AI_Output (self, other, "DIA_Xardas_EQUIPMENT_14_01");	//The closest place where you can get better weapons and armor is the city of Khorinis.
	AI_Output (self, other, "DIA_Xardas_EQUIPMENT_14_02");	//But down in the valley you can find some healing herbs that will help you if you get injured in a fight.
	AI_Output (self, other, "DIA_Xardas_EQUIPMENT_14_03");	//See the lake right in front of my tower. A secret passage leads to the valley from there.
};


instance DIA_Xardas_ABOUTLESTER(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 5;
	condition = DIA_Xardas_ABOUTLESTER_Condition;
	information = DIA_Xardas_ABOUTLESTER_Info;
	permanent = FALSE;
	description = "Have you talked to Lester yet?";
};


func int DIA_Xardas_ABOUTLESTER_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lester_SEND_XARDAS) && (Npc_GetDistToWP(Lester,"NW_XARDAS_TOWER_IN1_31") <= 500) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_ABOUTLESTER_Info()
{
	AI_Output (other, self, "DIA_Xardas_ABOUTLESTER_15_00");	//Have you talked to Lester yet?
	AI_Output (self, other, "DIA_Xardas_ABOUTLESTER_14_01");	//Yes, I have peppered him with questions. He was able to tell me a lot, but he is completely exhausted.
	AI_Output (self, other, "DIA_Xardas_ABOUTLESTER_14_02");	//It's almost a miracle that he survived this escape at all. I have sent him to bed for now.
	AI_Output (other, self, "DIA_Xardas_ABOUTLESTER_15_03");	//What did he tell you?
	AI_Output (self, other, "DIA_Xardas_ABOUTLESTER_14_04");	//Nothing good, I'm afraid. He has seen not only a dragon, but also men in black hooded cloaks.
	if(Kapitel < 3)
	{
	AI_Output (other, self, "DIA_Xardas_ABOUTLESTER_15_05");	//And?
	AI_Output (self, other, "DIA_Xardas_ABOUTLESTER_14_06");	//If those men exist, then their presence will pose a possible threat.
	AI_Output (self, other, "DIA_Xardas_ABOUTLESTER_14_07");	//And I don't like that. Here, take my ring. It will protect you against magic.
		B_GiveInvItems(self,other,ItRi_Prot_Mage_03,1);
	};
	B_GivePlayerXP(XP_AmbientKap2);
};


instance DIA_Xardas_FirstPal(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 10;
	condition = DIA_Xardas_FirstPal_Condition;
	information = DIA_Xardas_FirstPal_Info;
//	permanent = FALSE;
	permanent = TRUE;
	description = "I've been to town ...";
};


func int DIA_Xardas_FirstPal_Condition()
{
	if((PlayerEnteredCity == TRUE) && (Kapitel < 3) && (XardasKnowsAboutProof == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Xardas_FirstPal_Info()
{
	AI_Output(other,self,"DIA_Xardas_FirstPal_15_00");	//I've been to town...
	AI_Output(self,other,"DIA_Xardas_FirstPal_14_01");	//And? Were you able to talk to the leader of the paladins?
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
	{
		AI_Output(other,self,"DIA_Xardas_FirstPal_15_02");	//They won't let me see him...
		AI_Output(self,other,"DIA_Xardas_FirstPal_14_03");	//Nonsense! There must be a way for you to see him.
		if(other.guild == GIL_NONE)
		{
			AI_Output(self,other,"DIA_Xardas_FirstPal_14_04");	//If all else fails, enter the monastery and become a magician.
			AI_Output(self,other,"DIA_Xardas_FirstPal_14_05");	//That might be considered morally questionable, but it would get you what you need.
		};
		AI_Output(self,other,"DIA_Xardas_FirstPal_14_06");	//If you were a magician, he would certainly have to see you.
	}
	else if(LordHagen.aivar[AIV_TalkedToPlayer] == TRUE)
	{
		DIA_Common_Yes();
		if(Kapitel == 2)
		{
			AI_Output(other,self,"DIA_Addon_Vatras_NowRanger_15_03");	//But he sent me to the Valley of Mines so I could get him proof for my words!
			AI_Output(self,other,"DIA_Xardas_DMTSINDDA_Beweis_14_01");	//What proof is that?
			AI_Output(other,self,"DIA_Marcos_Hagen_15_00");	//I need to bring Lord Hagen proof that the dragons exist.
			AI_Output(self,other,"DIA_Xardas_Weiter_14_01");	//We shall proceed as planned. There is no other way.
			XardasKnowsAboutProof = TRUE;
		}
		else
		{
			AI_Output(self,other,"DIA_Xardas_RITUALREQUEST_14_01");	//That's good. What did he say?
			DIA_Common_NothingImportantYet();
			B_Xardas_SoLittleTime();
		};
	}
	else
	{
		DIA_Common_NoNotYet();
		B_Xardas_SoLittleTime();
	};
	if((LesterMovedToXardas == FALSE) && Npc_KnowsInfo(other,DIA_Lester_SEND_XARDAS))
	{
		B_StartOtherRoutine(Lester,"XARDAS");
		LesterMovedToXardas = TRUE;
	};
};


instance DIA_Xardas_Weiter(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 99;
	condition = DIA_Xardas_Weiter_Condition;
	information = DIA_Xardas_Weiter_Info;
	permanent = TRUE;
	description = "So what shall we do next?";
};


func int DIA_Xardas_Weiter_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Xardas_FirstEXIT) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_Weiter_Info()
{
	AI_Output(other,self,"DIA_Xardas_Weiter_15_00");	//So what shall we do next?
	if(XardasKnowsAboutProof == FALSE)
	{
		AI_Output(self,other,"DIA_Xardas_Weiter_14_01");	//We shall proceed as planned. There is no other way.
	};
	AI_Output(self,other,"DIA_Xardas_Weiter_14_02");	//You go get yourself the Eye of Innos, and I shall keep looking for answers.
};


instance DIA_Xardas_KdfSecret(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 9;
	condition = DIA_Xardas_KdfSecret_Condition;
	information = DIA_Xardas_KdfSecret_Info;
	permanent = FALSE;
	description = "Why is the Circle of Fire not supposed to know about you?";
};


func int DIA_Xardas_KdfSecret_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Xardas_FirstEXIT) && !Npc_KnowsInfo(other,DIA_Pyrokar_SPOKETOVATRAS))
	{
		return TRUE;
	};
};

func void DIA_Xardas_KdfSecret_Info()
{
	AI_Output (other, self, "DIA_Xardas_KdfSecret_15_00");	//Why is the Circle of Fire not supposed to know about you?
	AI_Output (self, other, "DIA_Xardas_KdfSecret_14_01");	//I used to be a high member of the Circle. Even then I suspected that demon magic might be the key to the magic barrier.
	AI_Output (self, other, "DIA_Xardas_KdfSecret_14_02");	//But I could never have convinced the other members of the Circle to follow this path.
	AI_Output (self, other, "DIA_Xardas_KdfSecret_14_03");	//So I left the Circle in order to study the Black Arts.
	AI_Output (self, other, "DIA_Xardas_KdfSecret_14_04");	//That is a crime for which the Fire Magicians, (snidely) the 'Ordained of Innos', the ever 'Good' and 'Virtuous' will accept no excuse.
	AI_Output (self, other, "DIA_Xardas_KdfSecret_14_05");	//They are certain that I am still alive, but they have no idea where to find me - and that's a good thing, too.
};


instance DIA_Xardas_HelloKap3(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 1;
	condition = DIA_Xardas_HelloKap3_Condition;
	information = DIA_Xardas_HelloKap3_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Xardas_HelloKap3_Condition()
{
	if(Kapitel == 3)
	{
		return TRUE;
	};
};

func void DIA_Xardas_HelloKap3_Info()
{
	AI_Output(self,other,"DIA_Xardas_Hello_14_00");	//Finally! I've been trying to bring you here for days.
};


instance DIA_Xardas_BACKFROMOW(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 31;
	condition = DIA_Xardas_BACKFROMOW_Condition;
	information = DIA_Xardas_BACKFROMOW_Info;
	description = "I'm back from the Valley of Mines.";
};


func int DIA_Xardas_BACKFROMOW_Condition()
{
	if(Kapitel == 3)
	{
		return TRUE;
	};
};

func void DIA_Xardas_BACKFROMOW_Info()
{
	AI_Output (other, self, "DIA_Xardas_BACKFROMOW_15_00");	//I'm back from the Valley of Mines.
	AI_Output (self, other, "DIA_Xardas_BACKFROMOW_14_01");	//High time, too. What did you see?
	AI_Output (other, self, "DIA_Xardas_BACKFROMOW_15_02");	//You were right. The land has been overrun by an entire army of the enemy.
	AI_Output (other, self, "DIA_Xardas_BACKFROMOW_15_03");	//Orcs are besieging the castle, and dragons have laid whole areas to waste.
	AI_Output (other, self, "DIA_Xardas_BACKFROMOW_15_04");	//It won't be long before they attack Khorinis, if I'm not mistaken.
	B_GivePlayerXP(XP_AmbientKap3);
};


instance DIA_Xardas_DMTSINDDA(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 32;
	condition = DIA_Xardas_DMTSINDDA_Condition;
	information = DIA_Xardas_DMTSINDDA_Info;
	description = "What the hell has happened here in the meantime?";
};


func int DIA_Xardas_DMTSINDDA_Condition()
{
	if((Kapitel == 3) && Npc_KnowsInfo(other,DIA_Xardas_BACKFROMOW))
	{
		return TRUE;
	};
};

func void DIA_Xardas_DMTSINDDA_Info()
{
	AI_Output(other,self,"DIA_Xardas_DMTSINDDA_15_01");	//What the hell has happened here in the meantime?
	if(Npc_KnowsInfo(other,DIA_Lester_BACKINTOWN))
	{
		AI_Output(other,self,"DIA_Xardas_DMTSINDDA_15_00");	//Lester said you wanted to see me at once.
	};
	AI_Output(self,other,"DIA_Xardas_DMTSINDDA_14_02");	//The enemy has learned who you really are and that you are planning to get hold of the Eye of Innos.
	AI_Output(self,other,"DIA_Xardas_DMTSINDDA_14_03");	//He has recognized the threat. It has forced him to leave his cover and openly attack.
	AI_Output(self,other,"DIA_Xardas_DMTSINDDA_14_04");	//The game of hide-and-seek is over. Yesterday nobody knew what the enemy's attack would look like. Now it has become only too obvious.
	B_LogEntry(TOPIC_INNOSEYE,"The enemy's found it I'm looking for the Eye of Innos. It's time I found it, before it's too late.");
	Info_ClearChoices(DIA_Xardas_DMTSINDDA);
	if(Npc_KnowsInfo(other,DIA_Lester_SEND_XARDAS) && !Npc_KnowsInfo(other,DIA_Xardas_ABOUTLESTER))
	{
		Info_AddChoice(DIA_Xardas_DMTSINDDA,"I've finally got the proof for Lord Hagen.",DIA_Xardas_ABOUTLESTER_Info);
	};
	Info_AddChoice(DIA_Xardas_DMTSINDDA,"I was attacked by magicians in black robes.",DIA_Xardas_DMTSINDDA_DMT);
	Info_AddChoice(DIA_Xardas_DMTSINDDA,"I've finally got the proof for Lord Hagen.",DIA_Xardas_DMTSINDDA_Beweis);
};

func void DIA_Xardas_DMTSINDDA_DMT()
{
	AI_Output (other, self, "DIA_Xardas_DMTSINDDA_DMT_15_00");	//I was attacked by magicians in black robes.
	AI_Output (self, other, "DIA_Xardas_DMTSINDDA_DMT_14_01");	//The enemy has many faces. The Seekers are one of them. They're really the ones who prepare the ground for the enemy.
	AI_Output (self, other, "DIA_Xardas_DMTSINDDA_DMT_14_02");	//They have taken up their positions in strategic places and are now only waiting for an opportunity to spring the trap.
	AI_Output (self, other, "DIA_Xardas_DMTSINDDA_DMT_14_03");	//Stay out of their way. They are very powerful magical beings, and they shall try to deter you at any cost.
	if (hero.guild == GIL_KDF)
	{
		Log_CreateTopic (TOPIC_DEMENTOREN, LOG_MISSION);
		Log_SetTopicStatus (TOPIC_DEMENTOREN, LOG_Running);
		B_LogEntry (TOPIC_DEMENTOREN, "Xardas knew the black robed men. It seems the Seekers are the ones who really pull the strings in the enemy ranks, and they're very dangerous.");
	};
};

func void DIA_Xardas_DMTSINDDA_Beweis()
{
	AI_Output(other,self,"DIA_Xardas_DMTSINDDA_Beweis_15_00");	//I've finally got the proof that Lord Hagen demanded of me.
	if(XardasKnowsAboutProof == FALSE)
	{
		AI_Output(self,other,"DIA_Xardas_DMTSINDDA_Beweis_14_01");	//What proof is that?
	};
	AI_Output (other, self, "DIA_Xardas_DMTSINDDA_Beweis_15_02");	//I received a letter from Garond, the commander of the paladins in the Valley of Mines. In it, he asks for reinforcements.
	AI_Output (self, other, "DIA_Xardas_DMTSINDDA_Beweis_14_03");	//That should be enough to convince that militant warhorse. Well done.
	Info_AddChoice (DIA_Xardas_DMTSINDDA, "What will be the next step now?", DIA_Xardas_DMTSINDDA_DMT_WhatToDo);
	XardasKnowsAboutProof = TRUE;
	B_GivePlayerXP(XP_AmbientKap3);
};

func void DIA_Xardas_DMTSINDDA_DMT_WhatToDo()
{
	AI_Output (other, self, "DIA_Xardas_DMTSINDDA_DMT_WhatToDo_15_00");	//What will be the next step now?
	AI_Output (self, other, "DIA_Xardas_DMTSINDDA_DMT_WhatToDo_14_01");	//Go and bring Lord Hagen the letter from Garond so that he may grant you access to the Eye of Innos.
	AI_Output (self, other, "DIA_Xardas_DMTSINDDA_DMT_WhatToDo_14_02");	//Then go to the monastery and talk to Pyrokar. He must give you the Eye.
	AI_Output (self, other, "DIA_Xardas_DMTSINDDA_DMT_WhatToDo_14_03");	//Nothing is more important than getting this artifact away to safety.
	AI_Output (self, other, "DIA_Xardas_DMTSINDDA_DMT_WhatToDo_14_04");	//Go now before it is too late. The enemy will also try to lay his hands on it.
	B_LogEntry (TOPIC_INNOSEYE, "The Eye is the the monastery of the Fire Magicians. Hopefully, Lord Hagen will grant me access to it when I give him Lord Garond's message. The head Fire Magician Pyrokar won't let me near the amulet without Hagen's approval.");
};


instance DIA_Xardas_INNOSEYEBROKEN(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 33;
	condition = DIA_Xardas_INNOSEYEBROKEN_Condition;
	information = DIA_Xardas_INNOSEYEBROKEN_Info;
	description = "The Eye of Innos has been destroyed.";
};


func int DIA_Xardas_INNOSEYEBROKEN_Condition()
{
	if((Kapitel == 3) && Npc_KnowsInfo(other,DIA_Xardas_DMTSINDDA) && (Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) || (MIS_SCKnowsInnosEyeIsBroken == TRUE)))
	{
		return TRUE;
	};
};

func void DIA_Xardas_INNOSEYEBROKEN_Info()
{
	AI_Output (other, self, "DIA_Xardas_INNOSEYEBROKEN_15_00");	//The Eye of Innos has been destroyed.
	AI_Output (self, other, "DIA_Xardas_INNOSEYEBROKEN_14_01");	//What are you saying? Destroyed!
	AI_Output (other, self, "DIA_Xardas_INNOSEYEBROKEN_15_02");	//I found it up in the northern forests - unfortunately, I've only been able to salvage its fragments.
	AI_Output (self, other, "DIA_Xardas_INNOSEYEBROKEN_14_03");	//That was our only chance to stand up to those dragons, and it's gone. We have failed.
	MIS_SCKnowsInnosEyeIsBroken = TRUE;
	B_GivePlayerXP(XP_AmbientKap3);
	Info_ClearChoices(DIA_Xardas_INNOSEYEBROKEN);
	Info_AddChoice(DIA_Xardas_INNOSEYEBROKEN,"What now?",DIA_Xardas_INNOSEYEBROKEN_wasnun);
};

func void DIA_Xardas_INNOSEYEBROKEN_wasnun()
{
	AI_Output (other, self, "DIA_Xardas_INNOSEYEBROKEN_wasnun_15_00");	//What now?
	AI_Output (self, other, "DIA_Xardas_INNOSEYEBROKEN_wasnun_14_01");	//This is a painful blow. We have to reorient ourselves. I shall retreat and ponder the matter.
	AI_Output (self, other, "DIA_Xardas_INNOSEYEBROKEN_wasnun_14_02");	//In the meantime, you should go to town and talk to Vatras the Water Mage. I could imagine that maybe he knows what is to be done.
	B_LogEntry (TOPIC_INNOSEYE, "Xardas wasn't exactly pleased over the destruction of the Eye of Innos. The Water Mage Vatras in the city of Khorinis seems to be our only hope now.");
	MIS_Xardas_GoToVatrasInnoseye = LOG_Running;
};


func void B_XardasGivesProofForPyrokar()
{
	AI_Output (other, self, "DIA_Xardas_PYROWILLNICHT_15_00");	//Pyrokar refuses to show up for the ritual.
	AI_Output (other, self, "DIA_Xardas_PYROWILLNICHT_15_01");	//First, he wants proof that he can trust you.
	AI_Output (self, other, "DIA_Xardas_PYROWILLNICHT_14_02");	//Ah really. Pyrokar. How interesting.
	AI_Output (self, other, "DIA_Xardas_PYROWILLNICHT_14_03");	//That old geezer is getting to be a nuisance. But I think I've got something for you that will be useful.
	AI_Output (self, other, "DIA_Xardas_PYROWILLNICHT_14_04");	//Back when I left the Order of the Fire Magicians, I took a few things with me from the monastery.
	AI_Output (self, other, "DIA_Xardas_PYROWILLNICHT_14_05");	//Now that I've built my tower so close to town, I have to be prepared. Someone could come here and look for them at anytime.
	AI_Output (self, other, "DIA_Xardas_PYROWILLNICHT_14_06");	//I didn't want a troop of paladins or Fire Magicians to turn my tower upside down at some point, and find all those things.
	AI_Output (self, other, "DIA_Xardas_PYROWILLNICHT_14_07");	//So I hid them in safe places where the magicians would certainly never look for them.
	AI_Output (other, self, "DIA_Xardas_PYROWILLNICHT_15_08");	//And where?
	AI_Output (self, other, "DIA_Xardas_PYROWILLNICHT_14_09");	//Some of them lie locked in a chest on Sekob's farm.
	Wld_AssignRoomToGuild("grpbauer01",GIL_NONE);
	Sekob_RoomFree = TRUE;
	AI_Output (other, self, "DIA_Xardas_PYROWILLNICHT_15_10");	//You trust that Sekob?
	AI_Output (self, other, "DIA_Xardas_PYROWILLNICHT_14_11");	//No. But he can be bought and asks no awkward questions. Also, the chest is locked. Here's the key.
	CreateInvItems(self,ItKe_CHEST_SEKOB_XARDASBOOK_MIS,1);
	B_GiveInvItems(self,other,ItKe_CHEST_SEKOB_XARDASBOOK_MIS,1);
	AI_Output (self, other, "DIA_Xardas_PYROWILLNICHT_14_12");	//There's a very old book among those things. When Pyrokar sees that book, he'll know it came from me.
	AI_Output (self, other, "DIA_Xardas_PYROWILLNICHT_14_13");	//It is of no further use to me. So I guess it can at least fulfill this purpose.
	B_LogEntry (TOPIC_INNOSEYE, "Xardas gave me a key to a chest on Sekob's farm. I'm to take the book that's inside it to Pyrokar.");
};

func void B_XardasGoesToRitual()
{
	if(Pyrokar_DeniesInnosEyeRitual == TRUE)
	{
		B_XardasGivesProofForPyrokar();
	};
	AI_StopProcessInfos(self);
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_UseMob(self,"THRONE",-1);
	};
	B_LogEntry(TOPIC_INNOSEYE,"Xardas has agreed to appear for the ritual at the Circle of the Sun.");
	Npc_ExchangeRoutine(self,"RitualInnosEyeRepair");
	Xardas_GoesToRitualInnosEye = TRUE;
};

instance DIA_Xardas_RITUALREQUEST(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 34;
	condition = DIA_Xardas_RITUALREQUEST_Condition;
	information = DIA_Xardas_RITUALREQUEST_Info;
	description = "Vatras sent me to you.";
};


func int DIA_Xardas_RITUALREQUEST_Condition()
{
	if((MIS_RitualInnosEyeRepair == LOG_Running) && Npc_KnowsInfo(other,DIA_Xardas_INNOSEYEBROKEN) && (Kapitel == 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_RITUALREQUEST_Info()
{
	AI_Output (other, self, "DIA_Xardas_RITUALREQUEST_15_00");	//Vatras sent me to you.
	AI_Output (self, other, "DIA_Xardas_RITUALREQUEST_14_01");	//That's good. What did he say?
	AI_Output (other, self, "DIA_Xardas_RITUALREQUEST_15_02");	//He said something about a reversal ritual at the Circle of the Sun.
	AI_Output (self, other, "DIA_Xardas_RITUALREQUEST_14_03");	//(laughs) That old devil. I think I know what he's up to. You have come to summon me to him.
	AI_Output (other, self, "DIA_Xardas_RITUALREQUEST_15_04");	//Looks like it. When will you set out?
	if((hero.guild == GIL_KDF) || (hero.guild == GIL_DJG) || (hero.guild == GIL_PAL) || (GuildlessMode == TRUE))
	{
		AI_Output(self,other,"DIA_Xardas_RITUALREQUEST_14_05");	//I must not keep Vatras waiting. I shall be on my way immediately. You must fulfill your tasks and then join me again.
		B_GivePlayerXP(XP_AmbientKap3 * 2);
		B_XardasGoesToRitual();
	}
	else
	{
		AI_Output(self,other,"DIA_Xardas_RITUALREQUEST_14_06");	//I shall only assist with the ritual when I can be sure that you are ready to face the dragons.
		B_LogEntry(TOPIC_INNOSEYE,"Xardas thinks I'm not ready to face the dragons yet.");
		B_GivePlayerXP(XP_AmbientKap3);
	};
};


instance DIA_Xardas_WARUMNICHTJETZT(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 34;
	condition = DIA_Xardas_WARUMNICHTJETZT_Condition;
	information = DIA_Xardas_WARUMNICHTJETZT_Info;
	description = "Why don't you go see Vatras RIGHT AWAY?";
};


func int DIA_Xardas_WARUMNICHTJETZT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Xardas_RITUALREQUEST) && (Xardas_GoesToRitualInnosEye == FALSE) && ((hero.guild == GIL_MIL) || (hero.guild == GIL_SLD)))
	{
		return TRUE;
	};
};

func void DIA_Xardas_WARUMNICHTJETZT_Info()
{
	AI_Output (other, self, "DIA_Xardas_WARUMNICHTJETZT_15_00");	//Why don't you go see Vatras RIGHT AWAY?
	AI_Output (other, self, "DIA_Xardas_WARUMNICHTJETZT_15_01");	//Sometimes I just don't understand you.
	AI_Output (self, other, "DIA_Xardas_WARUMNICHTJETZT_14_02");	//(irritated) Do not talk to me in that tone. If it weren't for ME, your wretched body would still be rotting in that temple.
	AI_Output(other,self,"Extro_Tempel_15_01");	//(astonished) Xardas! What...
	Info_AddChoice(DIA_Xardas_WARUMNICHTJETZT,"Never mind. Just tell me what I need to do.",DIA_Xardas_WARUMNICHTJETZT_wastun);
	Info_AddChoice(DIA_Xardas_WARUMNICHTJETZT,"Then, at least, explain to me why you hesitate.",DIA_Xardas_WARUMNICHTJETZT_grund);
};

func void DIA_Xardas_WARUMNICHTJETZT_grund()
{
	AI_Output (other, self, "DIA_Xardas_WARUMNICHTJETZT_grund_15_00");	//Then, at least, explain to me why you hesitate.
	AI_Output (self, other, "DIA_Xardas_WARUMNICHTJETZT_grund_14_01");	//Ever since I abandoned the Fire Magicians, I have stayed well away from them.
	AI_Output (self, other, "DIA_Xardas_WARUMNICHTJETZT_grund_14_02");	//And I do not intend to change that, unless I do not have a choice.
	AI_Output (self, other, "DIA_Xardas_WARUMNICHTJETZT_grund_14_03");	//But before I expose myself to the magicians' reproachful glances, I first want to be sure that you stand even the slightest chance against the dragons.
	AI_Output (self, other, "DIA_Xardas_WARUMNICHTJETZT_grund_14_04");	//You will not get far, however, with that shabby equipment of yours. Come back, but only when you are strong enough.
	AI_StopProcessInfos (self);
};

func void DIA_Xardas_WARUMNICHTJETZT_wastun()
{
	AI_Output (other, self, "DIA_Xardas_WARUMNICHTJETZT_wastun_15_00");	//Never mind. Just tell me what I need to do.
	AI_Output (self, other, "DIA_Xardas_WARUMNICHTJETZT_wastun_14_01");	//You are still too weak to fight the dragons. With this equipment, you stand no chance whatsoever.
	AI_Output (self, other, "DIA_Xardas_WARUMNICHTJETZT_wastun_14_02");	//Do not come back until you are better prepared. Then I will go and join Vatras.
	AI_StopProcessInfos (self);
};


instance DIA_Xardas_BEREIT(C_Info)
{
	npc = NONE_100_Xardas;
	condition = DIA_Xardas_BEREIT_Condition;
	information = DIA_Xardas_BEREIT_Info;
	description = "I'm ready to fight the dragons.";
};


func int DIA_Xardas_BEREIT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Xardas_RITUALREQUEST) && (Xardas_GoesToRitualInnosEye == FALSE) && ((hero.guild == GIL_DJG) || (hero.guild == GIL_PAL)))
	{
		return TRUE;
	};
};

func void DIA_Xardas_BEREIT_Info()
{
	AI_Output (other, self, "DIA_Xardas_BEREIT_15_00");	//I'm ready to fight the dragons.
	AI_Output (self, other, "DIA_Xardas_BEREIT_14_01");	//We must not lose any more time, then. I shall be on my way to the Circle of the Sun immediately. Fulfill your tasks. I shall meet you there.
	B_GivePlayerXP(XP_AmbientKap3);
	B_XardasGoesToRitual();
};


instance DIA_Xardas_BINGESPANNT(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 35;
	condition = DIA_Xardas_BINGESPANNT_Condition;
	information = DIA_Xardas_BINGESPANNT_Info;
	permanent = TRUE;
	description = "Is the reversal ritual going to work?";
};


func int DIA_Xardas_BINGESPANNT_Condition()
{
	if((MIS_RitualInnosEyeRepair == LOG_Running) && (Kapitel == 3) && (Xardas_GoesToRitualInnosEye == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Xardas_BINGESPANNT_Info()
{
	AI_Output (other, self, "DIA_Xardas_BINGESPANNT_15_00");	//Is the reversal ritual going to work?
	AI_Output (self, other, "DIA_Xardas_BINGESPANNT_14_01");	//I cannot be sure. That depends on what exactly Vatras is going to do.
};


instance DIA_Xardas_PYROWILLNICHT(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 37;
	condition = DIA_Xardas_PYROWILLNICHT_Condition;
	information = DIA_Xardas_PYROWILLNICHT_Info;
	description = "Pyrokar refuses to show up for the ritual.";
};


func int DIA_Xardas_PYROWILLNICHT_Condition()
{
	if((Pyrokar_DeniesInnosEyeRitual == TRUE) && Npc_KnowsInfo(other,DIA_Xardas_RITUALREQUEST) && (Kapitel == 3) && (Sekob_RoomFree == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Xardas_PYROWILLNICHT_Info()
{
	B_XardasGivesProofForPyrokar();
};


instance DIA_Xardas_RitualInnosEyeRepairImportant(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 36;
	condition = DIA_Xardas_RitualInnosEyeRepairImportant_Condition;
	information = DIA_Xardas_RitualInnosEyeRepairImportant_Info;
	important = TRUE;
};


func int DIA_Xardas_RitualInnosEyeRepairImportant_Condition()
{
	if((MIS_RitualInnosEyeRepair == LOG_SUCCESS) && (Kapitel == 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_RitualInnosEyeRepairImportant_Info()
{
	AI_Output (self, other, "DIA_Xardas_Add_14_06");	//Now that the Eye of Innos is healed, you must face the dragons!
	AI_Output (self, other, "DIA_Xardas_Add_14_07");	//They all serve Beliar, the god of darkness.
	AI_Output (self, other, "DIA_Xardas_Add_14_08");	//But there must be an earthly power that controls them. That much has become clear to me.
	AI_Output (self, other, "DIA_Xardas_Add_14_09");	//Find out what the source of their power is.
	AI_Output (self, other, "DIA_Xardas_Add_14_10");	//As soon as you have found that out, come back to me!
	Info_ClearChoices (DIA_Xardas_RitualInnosEyeRepairImportant);
	Info_AddChoice (DIA_Xardas_RitualInnosEyeRepairImportant, Dialog_Ende, DIA_Xardas_RitualInnosEyeRepairImportant_weiter);
};

func void DIA_Xardas_RitualInnosEyeRepairImportant_weiter()
{
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"Start");
	B_StartOtherRoutine(Vatras,"Start");
};


instance DIA_Xardas_WASNUN(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 36;
	condition = DIA_Xardas_WASNUN_Condition;
	information = DIA_Xardas_WASNUN_Info;
	permanent = TRUE;
	description = "The Eye of Innos is healed. So what next?";
};


func int DIA_Xardas_WASNUN_Condition()
{
	if((MIS_RitualInnosEyeRepair == LOG_SUCCESS) && (Kapitel == 3))
	{
		return TRUE;
	};
};

func void DIA_Xardas_WASNUN_Info()
{
	AI_Output (other, self, "DIA_Xardas_WASNUN_15_00");	//The Eye of Innos is healed. So what next?
	AI_Output (self, other, "DIA_Xardas_WASNUN_14_01");	//Do not forget to wear it when you finally face the dragons.
	if (MIS_ReadyforChapter4 == TRUE)
	{
		AI_Output (self, other, "DIA_Xardas_WASNUN_14_02");	//Do not lose any time. Now go to the Valley of Mines and kill those dragons.
	}
	else
	{
		AI_Output (self, other, "DIA_Xardas_WASNUN_14_03");	//Go to Pyrokar and have him explain to you how to use the Eye.
	};
};


instance DIA_Xardas_PERM4(C_Info)
{
	npc = NONE_100_Xardas;
	nr = 40;
	condition = DIA_Xardas_PERM4_Condition;
	information = DIA_Xardas_PERM4_Info;
	permanent = TRUE;
	description = "What's new?";
};


func int DIA_Xardas_PERM4_Condition()
{
	if((Kapitel == 3) && Npc_KnowsInfo(other,DIA_Xardas_DMTSINDDA))
	{
		return TRUE;
	};
	if(Kapitel == 4)
	{
		return TRUE;
	};
};

func void DIA_Xardas_PERM4_Info()
{
	AI_Output(other,self,"DIA_Xardas_PERM4_15_00");	//What's new?
	if(Kapitel == 3)
	{
		if(MIS_Ulthar_HeileSchreine_PAL == LOG_Running)
		{
			AI_Output(self,other,"DIA_Addon_Xardas_AddonIntro_Add_14_06");	//Beliar's henchmen are desecrating the oldest shrines of the gods.
			AI_Output(self,other,"DIA_Addon_Xardas_AddonIntro_Add_14_03");	//And just that has happened.
		}
		else
		{
			AI_Output(self,other,"OUTRO_Xardas_14_10");	//Not even the gods know what fate has in store for us...
		};
	}
	else if(Kapitel == 4)
	{
		AI_Output(self,other,"DIA_Xardas_PERM4_14_01");	//The Seekers have not left yet. They will not rest before they have hunted you down.
		AI_Output(self,other,"DIA_Xardas_PERM4_14_02");	//Kill the dragons in the Valley of Mines and find out who's behind those attacks. Otherwise, their strength will only grow more.
	};
};

