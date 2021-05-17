
instance DIA_MiltenNW_KAP3_EXIT(C_Info)
{
	npc = PC_Mage_NW;
	nr = 999;
	condition = DIA_MiltenNW_KAP3_EXIT_Condition;
	information = DIA_MiltenNW_KAP3_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_MiltenNW_KAP3_EXIT_Condition()
{
	return TRUE;
};

func void DIA_MiltenNW_KAP3_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_MiltenNW_KAP3_Hello_FirstMeet(C_Info)
{
	npc = PC_Mage_NW;
	nr = 31;
	condition = DIA_MiltenNW_KAP3_Hello_FirstMeet_Condition;
	information = DIA_MiltenNW_KAP3_Hello_FirstMeet_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_MiltenNW_KAP3_Hello_FirstMeet_Condition()
{
	if((Kapitel == 3) && !Npc_KnowsInfo(other,DIA_MiltenOW_Hello))
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_KAP3_Hello_FirstMeet_Info()
{
	AI_Output(self,other,"DIA_MiltenOW_Hello_03_00");	//Look who has returned! Our hero from the barrier!
	if(hero.guild == GIL_PAL)
	{
		AI_Output(self,other,"DIA_MiltenNW_KAP3_Hello_03_00");	//disbelieving) I can hardly believe it. Are you really a paladin now?
		AI_Output(other,self,"DIA_MiltenNW_KAP3_Hello_15_01");	//Obviously.
		AI_Output(self,other,"DIA_MiltenNW_KAP3_Hello_03_02");	//(euphoric) If someone like you is with the paladins, then Beliar's thugs had better watch out.
		AI_Output(self,other,"DIA_MiltenNW_KAP3_Hello_03_03");	//If you did in the Sleeper, that handful of orcs shouldn't be a problem.
	}
	else if(hero.guild == GIL_DJG)
	{
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_10");	//I can see that the rumors are true.
		AI_Output (other, self, "DIA_MiltenNW_KAP3_Hello_15_11");	//What rumors?
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_12");	//That you joined up with those dragon hunters.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_13");	//Well, you never were a man of the church. Nevertheless, you're fighting for our cause, and that's what counts.
		AI_Output (other, self, "DIA_MiltenNW_KAP3_Hello_15_14");	//Is that all?
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_15");	//I'm glad, of course, and the way you look, every orc is bound to be afraid of you.
	}
	else
	{
		AI_Output(self,other,"DIA_MiltenOW_Hello_NO_03_01");	//You've been through a lot, huh?
	};
	Info_ClearChoices(DIA_MiltenNW_KAP3_Hello_FirstMeet);
	if((hero.guild == GIL_PAL) || (hero.guild == GIL_DJG))
	{
		Info_AddChoice(DIA_MiltenNW_KAP3_Hello_FirstMeet,"This is not only about the orcs.",DIA_MiltenNW_KAP3_Hello_FirstMeet_YES);
	}
	else
	{
		Info_AddChoice(DIA_MiltenNW_KAP3_Hello_FirstMeet,"It'll be all right.",DIA_MiltenNW_KAP3_Hello_FirstMeet_YES);
	};
	Info_AddChoice(DIA_MiltenNW_KAP3_Hello_FirstMeet,"Should I know you?",DIA_MiltenNW_KAP3_Hello_FirstMeet_NO);
};


func void DIA_MiltenNW_KAP3_Hello_FirstMeet_YES()
{
	if(hero.guild == GIL_PAL)
	{
		AI_Output(other,self,"DIA_MiltenNW_KAP3_Hello_15_04");	//This is not only about the orcs.
		AI_Output(self,other,"DIA_MiltenNW_KAP3_Hello_03_05");	//I know, but it's still good to have you on our side.
		AI_Output(other,self,"DIA_MiltenNW_KAP3_Hello_15_06");	//Oh well.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_07");	//What are you doing here in the monastery? Let me guess. You want to be instructed in the art of magic.
		AI_Output (other, self, "DIA_MiltenNW_KAP3_Hello_15_08");	//Perhaps.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_09");	//I knew it - best talk to Marduk, he's responsible for you paladins. You'll find him in front of the chapel.
	}
	else if(hero.guild == GIL_DJG)
	{
		AI_Output(other,self,"DIA_MiltenNW_KAP3_Hello_15_04");	//This is not only about the orcs.
		AI_Output(self,other,"DIA_MiltenNW_KAP3_Hello_03_17");	//I know, but nonetheless they're a problem. You are important.
		
	}
	else
	{
		AI_Output(other,self,"DIA_Bengar_PERM_15_00");	//It'll be all right.
		AI_Output(self,other,"DIA_MiltenNW_KAP3_Hello_03_18");	//You defeated the Sleeper. We may all need your help some day.
		AI_Output(other,self,"DIA_MiltenNW_KAP3_Hello_15_19");	//Oh well.
		Knows_Milten = TRUE;
	};
	Info_ClearChoices(DIA_MiltenNW_KAP3_Hello_FirstMeet);
};


func void DIA_MiltenNW_KAP3_Hello_FirstMeet_NO()
{
	//AI_Output(other,self,"DIA_MiltenOW_Hello_NO_15_00");	//Am I supposed to know them?
	AI_Output(other,self,"DIA_Addon_Skip_NW_WerBistDu_keineAhnung_15_00");	//Should I know you?
	AI_Output(self,other,"DIA_MiltenOW_Hello_Forget_03_01");	//You have forgotten a great deal, haven't you? Well, let's leave the past in peace and devote ourselves to the here and now.
	AI_Output(self,other,"DIA_MiltenOW_Hello_Forget_03_02");	//Even if there isn't anything pleasant to report.
	Info_ClearChoices(DIA_MiltenNW_KAP3_Hello_FirstMeet);
};


//////////////////////////////////////////////////////////////////

instance DIA_MiltenNW_KAP3_Hello(C_Info)
{
	npc = PC_Mage_NW;
	nr = 31;
	condition = DIA_MiltenNW_KAP3_Hello_Condition;
	information = DIA_MiltenNW_KAP3_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_MiltenNW_KAP3_Hello_Condition()
{
	if(((hero.guild == GIL_PAL) || (hero.guild == GIL_DJG)) && Npc_KnowsInfo(other,DIA_MiltenOW_Hello))
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_KAP3_Hello_Info()
{
	if(hero.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_00");	//(disbelieving) I can hardly believe it. Are you really a paladin now?
		AI_Output (other, self, "DIA_MiltenNW_KAP3_Hello_15_01");	//Obviously.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_02");	//(euphoric) If someone like you is with the paladins, then Beliar's thugs had better watch out.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_03");	//If you did in the Sleeper, that handful of orcs shouldn't be a problem.
		AI_Output (other, self, "DIA_MiltenNW_KAP3_Hello_15_04");	//This is not only about the orcs.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_05");	//I know, but it's still good to have you on our side.
		AI_Output (other, self, "DIA_MiltenNW_KAP3_Hello_15_06");	//Oh well.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_07");	//What are you doing here in the monastery? Let me guess. You want to be instructed in the art of magic.
		AI_Output (other, self, "DIA_MiltenNW_KAP3_Hello_15_08");	//Perhaps.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_09");	//I knew it - best talk to Marduk, he's responsible for you paladins. You'll find him in front of the chapel.
	};
	if(hero.guild == GIL_DJG)
	{
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_10");	//I can see that the rumors are true.
		AI_Output (other, self, "DIA_MiltenNW_KAP3_Hello_15_11");	//What rumors?
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_12");	//That you joined up with those dragon hunters.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_13");	//Well, you never were a man of the church. Nevertheless, you're fighting for our cause, and that's what counts.
		AI_Output (other, self, "DIA_MiltenNW_KAP3_Hello_15_14");	//Is that all?
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_15");	//I'm glad, of course, and the way you look, every orc is bound to be afraid of you.
		AI_Output (other, self, "DIA_MiltenNW_KAP3_Hello_15_16");	//This is not only about the orcs.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_17");	//I know, but nonetheless they're a problem. You are important.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Hello_03_18");	//You defeated the Sleeper. We may all need your help some day.
		AI_Output (other, self, "DIA_MiltenNW_KAP3_Hello_15_19");	//Oh well.
	};
};


instance DIA_MiltenNW_Monastery(C_Info)
{
	npc = PC_Mage_NW;
	nr = 35;
	condition = DIA_MiltenNW_Monastery_Condition;
	information = DIA_MiltenNW_Monastery_Info;
	permanent = FALSE;
	description = "How did you get to the monastery so fast?";
};


func int DIA_MiltenNW_Monastery_Condition()
{
	if((Kapitel == 3) && Npc_KnowsInfo(other,DIA_MiltenOW_Hello))
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_Monastery_Info()
{
	AI_Output (other, self, "DIA_MiltenNW_Monastery_15_00");	//How did you get to the monastery so fast?
	AI_Output (self, other, "DIA_MiltenNW_Monastery_03_01");	//What kind of a question is that? I crept through the pass and made my way straight to the monastery.
	AI_Output (self, other, "DIA_MiltenNW_Monastery_03_02");	//Admittedly, it was never easy avoiding all the monsters making themselves at home on this side of the valley, but ultimately I encountered fewer problems than I'd expected.
};


instance DIA_MiltenNW_FourFriends(C_Info)
{
	npc = PC_Mage_NW;
	nr = 35;
	condition = DIA_MiltenNW_FourFriends_Condition;
	information = DIA_MiltenNW_FourFriends_Info;
	permanent = FALSE;
	description = "Do you know where the others are?";
};


func int DIA_MiltenNW_FourFriends_Condition()
{
	if((Kapitel == 3) && ((Knows_Milten == TRUE) || (Knows_Diego == TRUE)))
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_FourFriends_Info()
{
	AI_Output(other,self,"DIA_MiltenNW_FourFriends_15_00");	//Do you know where the others are?
	if(!Npc_IsDead(GornNW_vor_DJG))
	{
		AI_Output (self, other, "DIA_MiltenNW_FourFriends_03_01");	//Gorn seems to have coped with his stay in Garond's dungeon very well.
		if (MIS_RescueGorn != LOG_SUCCESS)
		{
			AI_Output(other,self,"DIA_MiltenNW_FourFriends_15_02");	//How did he get out?
			if(Npc_KnowsInfo(other,DIA_DiegoOw_Gorn))
			{
				AI_Output (self, other, "DIA_MiltenNW_FourFriends_03_03");	//I had to lie to Garond, so that he would drop all the charges.
				AI_Output (self, other, "DIA_MiltenNW_FourFriends_03_04");	//But let's keep that between ourselves, understood?
				AI_Output(self,other,"DIA_MiltenNW_FourFriends_03_07");	//Gorn didn't make it.
			}
			else
			{
				AI_Output(self,other,"DIA_MiltenNW_FourFriends_03_10");	//Diego bought it - looks like that Barrier got him after all.
			};
		};
		AI_Output (self, other, "DIA_MiltenNW_FourFriends_03_05");	//In any case, he wanted to go to Lee and see what was happening on the farm.
		AI_Output (self, other, "DIA_MiltenNW_FourFriends_03_06");	//After the grub they serve in the dungeon, he's probably stuffing his face right now and putting the mercenaries' provisions to a real test.
	}
	else
	{
		AI_Output (self, other, "DIA_MiltenNW_FourFriends_03_07");	//Gorn didn't make it.
	};
		AI_Output (self, other, "DIA_MiltenNW_FourFriends_03_08");	//Diego mumbled something about a reckoning. No idea what he meant by that.
		AI_Output (self, other, "DIA_MiltenNW_FourFriends_03_09");	//But I suspect that he's in the city. You know him - always there where there's something to be had.
	if(!Npc_KnowsInfo(other,DIA_MiltenOW_Hello))
	{
		AI_Output(self,other,"DIA_MiltenOW_Hello_Friends_03_02");	//Lester has vanished, though - I have no idea where he's hanging around.
		if(Npc_KnowsInfo(other,DIA_Lester_Hello) || Npc_KnowsInfo(other,DIA_Lester_BACKINTOWN))
		{
			if(Npc_KnowsInfo(other,DIA_Lester_SEND_XARDAS) || Npc_KnowsInfo(other,DIA_Lester_BACKINTOWN))
			{
				AI_Output(other,self,"DIA_MiltenOW_Hello_Friends_15_03");	//I've met Lester - he's with Xardas now.
			}
			else
			{
				AI_Output(other,self,"DIA_MiltenOW_Hello_Friends_15_03_add");	//Я встретил Лестера. Он в порядке.@@@
			};
			AI_Output(self,other,"DIA_MiltenOW_Hello_Friends_03_04");	//One bit of good news, at least.
		}
		else
		{
			AI_Output(other,self,"Extro_Tempel_15_04");	//Where is he?
		};
	};
};


instance DIA_MiltenNW_KAP3_Entry(C_Info)
{
	npc = PC_Mage_NW;
	nr = 32;
	condition = DIA_MiltenNW_KAP3_Entry_Condition;
	information = DIA_MiltenNW_KAP3_Entry_Info;
	permanent = TRUE;
	description = "I need to get into the monastery. It's urgent!";
};


func int DIA_MiltenNW_KAP3_Entry_Condition()
{
	if((Kapitel == 3) && (hero.guild != GIL_KDF) && (MiltenNW_GivesMonasteryKey == FALSE))
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_KAP3_Entry_Info()
{
	AI_Output (other, self, "DIA_MiltenNW_KAP3_Entry_15_00");	//I need to get into the monastery. It's urgent!
	if (hero.guild == GIL_PAL)
	{
		AI_Output(self,other,"DIA_MiltenNW_KAP3_Entry_03_01");	//Yes, sure. Here's the key.
		CreateInvItems(self,ItKe_Innos_MIS,1);
		B_GiveInvItems(self,other,ItKe_Innos_MIS,1);
		if(Npc_HasItems(Gorax,ItKe_Innos_MIS))
		{
			Npc_RemoveInvItem(Gorax,ItKe_Innos_MIS);
		};
		MiltenNW_GivesMonasteryKey = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Entry_03_02");	//I can't let you into the monastery. I'll get in trouble with the High Council.
		AI_Output (self, other, "DIA_MiltenNW_KAP3_Entry_03_03");	//Without the permission of my superiors, I can't let anyone into the monastery.
		Info_ClearChoices(DIA_MiltenNW_KAP3_Entry);
		Info_AddChoice(DIA_MiltenNW_KAP3_Entry,Dialog_Back,DIA_MiltenNW_KAP3_Entry_BACK);
		Info_AddChoice(DIA_MiltenNW_KAP3_Entry,"It's important!",DIA_MiltenNW_KAP3_Entry_Important);
		if(Npc_HasItems(other,ItWr_PermissionToWearInnosEye_MIS))
		{
			Info_AddChoice (DIA_MiltenNW_KAP3_Entry, "I've got a letter from Lord Hagen.", DIA_MiltenNW_KAP3_Entry_Permit);
		};
	};
};

func void DIA_MiltenNW_KAP3_Entry_BACK()
{
	Info_ClearChoices(DIA_MiltenNW_KAP3_Entry);
};

func void DIA_MiltenNW_KAP3_Entry_Important()
{
	AI_Output (other, self, "DIA_MiltenNW_KAP3_Entry_Important_15_00");	//It's important!
	AI_Output (self, other, "DIA_MiltenNW_KAP3_Entry_Important_03_01");	//It won't work. Pyrokar would rip my head off.
	Info_ClearChoices (DIA_MiltenNW_KAP3_Entry);
};

func void DIA_MiltenNW_KAP3_Entry_Permit()
{
	AI_Output (other, self, "DIA_MiltenNW_KAP3_Entry_Permit_15_00");	//I've got a letter from Lord Hagen.
	AI_Output (self, other, "DIA_MiltenNW_KAP3_Entry_Permit_03_01");	//Show me.
	B_GiveInvItems(other,self,ItWr_PermissionToWearInnosEye_MIS,1);
	B_UseFakeScroll();
	AI_Output(self,other,"DIA_MiltenOW_Hello_NO_03_01");	//You've been through a lot, huh?
	B_GiveInvItems(self,other,ItWr_PermissionToWearInnosEye_MIS,1);
	AI_Output(self,other,"DIA_MiltenNW_KAP3_Entry_Permit_03_02");	//(hesitantly) All right. Here's the key to the monastery. Pyrokar is in the church.
	CreateInvItems(self,ItKe_Innos_MIS,1);
	B_GiveInvItems(self,other,ItKe_Innos_MIS,1);
	if(Npc_HasItems(Gorax,ItKe_Innos_MIS))
	{
		Npc_RemoveInvItem(Gorax,ItKe_Innos_MIS);
	};
	MiltenNW_GivesMonasteryKey = TRUE;
	Info_ClearChoices(DIA_MiltenNW_KAP3_Entry);
};


instance DIA_MiltenNW_KAP3_NovizenChase(C_Info)
{
	npc = PC_Mage_NW;
	nr = 31;
	condition = DIA_MiltenNW_KAP3_NovizenChase_Condition;
	information = DIA_MiltenNW_KAP3_NovizenChase_Info;
	permanent = FALSE;
	description = "Do you know where Pedro is?";
};


func int DIA_MiltenNW_KAP3_NovizenChase_Condition()
{
	if((Kapitel == 3) && (MIS_NovizenChase == LOG_Running) && (MIS_SCKnowsInnosEyeIsBroken == FALSE))
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_KAP3_NovizenChase_Info()
{
	AI_Output (other, self, "DIA_MiltenNW_KAP3_NovizenChase_15_00");	//Do you know where Pedro is?
	AI_Output (self, other, "DIA_MiltenNW_KAP3_NovizenChase_03_01");	//Do you think I'd be standing around here if I knew where the renegade was hiding?
	AI_Output (self, other, "DIA_MiltenNW_KAP3_NovizenChase_03_02");	//He must pay for his deeds. I hope we manage to get the Eye back.
	AI_Output (self, other, "DIA_MiltenNW_KAP3_NovizenChase_03_03");	//You have to help us. Find him and bring back the Eye of Innos.
};


instance DIA_MiltenNW_KAP3_Perm(C_Info)
{
	npc = PC_Mage_NW;
	nr = 39;
	condition = DIA_MiltenNW_KAP3_Perm_Condition;
	information = DIA_MiltenNW_KAP3_Perm_Info;
	permanent = FALSE;
	description = "Do you know anything about the hooded figures?";
};


func int DIA_MiltenNW_KAP3_Perm_Condition()
{
	if(Kapitel == 3)
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_KAP3_Perm_Info()
{
	AI_Output (other, self, "DIA_MiltenNW_KAP3_Perm_15_00");	//Do you know anything about the hooded figures?
	AI_Output (self, other, "DIA_MiltenNW_KAP3_Perm_03_01");	//No, but I have a bad feeling about those guys.
	AI_Output (self, other, "DIA_MiltenNW_KAP3_Perm_03_02");	//Be careful if you run into them.
};


instance DIA_MiltenNW_KAP4_PERM(C_Info)
{
	npc = PC_Mage_NW;
	nr = 49;
	condition = DIA_MiltenNW_KAP4_PERM_Condition;
	information = DIA_MiltenNW_KAP4_PERM_Info;
	permanent = TRUE;
	description = "Any news?";
};


func int DIA_MiltenNW_KAP4_PERM_Condition()
{
	if(Kapitel >= 4)
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_KAP4_PERM_Info()
{
	AI_Output(other,self,"DIA_MiltenNW_KAP4_PERM_15_00");	//Any news?
	if(Kapitel == 4)
	{
	AI_Output (self, other, "DIA_MiltenNW_KAP4_PERM_03_01");	//I should be asking you that. We're still very worried here.
	AI_Output (self, other, "DIA_MiltenNW_KAP4_PERM_03_02");	//The High Council is trying to find out the enemy's next move.
	AI_Output (other, self, "DIA_MiltenNW_KAP4_PERM_15_03");	//Anything else?
		if(hero.guild == GIL_PAL)
		{
		AI_Output (self, other, "DIA_MiltenNW_KAP4_PERM_03_04");	//Lately, you hear more about orc attacks, even outside the Valley of Mines.
		AI_Output (self, other, "DIA_MiltenNW_KAP4_PERM_03_05");	//I don't like all this - I don't think we have much time left.
		}
		else if(hero.guild == GIL_DJG)
		{
		AI_Output (self, other, "DIA_MiltenNW_KAP4_PERM_03_06");	//A farmer reported scaly creatures near his farm.
		AI_Output (self, other, "DIA_MiltenNW_KAP4_PERM_03_07");	//I don't know what to make of that, but I think the enemy is planning something.
		}
		else
		{
			AI_Output(self,other,"DIA_MiltenNW_KAP4_PERM_03_08");	//We're getting more and more reports of people possessed. The enemy has become strong, much stronger than I expected.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_MiltenNW_KAP4_PERM_03_09");	//No, the situation is still serious. All we can do now is trust in Innos.
	};
};


instance DIA_MiltenNW_AllDragonsDead(C_Info)
{
	npc = PC_Mage_NW;
	nr = 900;
	condition = DIA_MiltenNW_AllDragonsDead_Condition;
	information = DIA_MiltenNW_AllDragonsDead_Info;
	permanent = FALSE;
	description = "I killed all the dragons.";
};


func int DIA_MiltenNW_AllDragonsDead_Condition()
{
	if(Kapitel == 5)
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_AllDragonsDead_Info()
{
	AI_Output (other, self, "DIA_MiltenNW_AllDragonsDead_15_00");	//I killed all the dragons.
	AI_Output (self, other, "DIA_MiltenNW_AllDragonsDead_03_01");	//Really? So there's more than a glimmer of hope on the horizon. Now all we have to do is to cut off the head of Evil.
	AI_Output (self, other, "DIA_MiltenNW_AllDragonsDead_03_02");	//If you have indeed done that, then we shall win the war.
	AI_Output (other, self, "DIA_MiltenNW_AllDragonsDead_15_03");	//Who, me?
	AI_Output (self, other, "DIA_MiltenNW_AllDragonsDead_03_04");	//You, of course. Who else?
	if (MiltenNW_IsOnBoard == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_MiltenNW_AllDragonsDead_03_05");	//We should set out soon, otherwise it could be too late.
	};
};


instance DIA_MiltenNW_SCWasInLib(C_Info)
{
	npc = PC_Mage_NW;
	nr = 3;
	condition = DIA_MiltenNW_SCWasInLib_Condition;
	information = DIA_MiltenNW_SCWasInLib_Info;
	important = TRUE;
};


func int DIA_MiltenNW_SCWasInLib_Condition()
{
	if(MIS_SCKnowsWayToIrdorath == TRUE)
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_SCWasInLib_Info()
{
	AI_Output (self, other, "DIA_MiltenNW_SCWasInLib_03_00");	//Hey, I heard you spent a long time in the monastery cellars. What did you find out?
};


instance DIA_MiltenNW_KnowWhereEnemy(C_Info)
{
	npc = PC_Mage_NW;
	nr = 55;
	condition = DIA_MiltenNW_KnowWhereEnemy_Condition;
	information = DIA_MiltenNW_KnowWhereEnemy_Info;
	permanent = TRUE;
	description = "I know now where the enemy is hiding.";
};


func int DIA_MiltenNW_KnowWhereEnemy_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && (MiltenNW_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_KnowWhereEnemy_Info()
{
	AI_Output (other, self, "DIA_MiltenNW_KnowWhereEnemy_15_00");	//I know now where the enemy is hiding. It's a small island, not far from here.
	AI_Output (self, other, "DIA_MiltenNW_KnowWhereEnemy_03_01");	//This is our big chance. We have to set out at once and destroy evil forever.
	if(!Npc_IsDead(DiegoNW))
	{
		AI_Output(self,other,"DIA_MiltenNW_KnowWhereEnemy_03_02");	//Have you talked to Diego about it? I think he would want to accompany you.
		if(SCToldDiegoHeKnowWhereEnemy == FALSE)
		{
			B_LogEntry(Topic_Crew,"Diego could be a great help. He's never stayed in one place long.");
			SCToldDiegoHeKnowWhereEnemy = TRUE;
		};
	};
	if(!Npc_IsDead(GornNW_nach_DJG))
	{
		AI_Output(self,other,"DIA_MiltenNW_KnowWhereEnemy_03_03");	//What about Gorn? Talk to him. I heard that he has returned from the Valley of Mines.
		if(SCToldGornHeKnowWhereEnemy == FALSE)
		{
			B_LogEntry(Topic_Crew,"Gorn would certainly be a great help. It can't hurt to have a good fighter at one's side. Maybe he can train me.");
			SCToldGornHeKnowWhereEnemy = TRUE;
		};
	};
	if(!Npc_IsDead(Lester))
	{
		AI_Output(self,other,"DIA_MiltenNW_KnowWhereEnemy_03_04");	//And don't forget Lester. If you don't drag him out of his valley, he'll rot there.
		if(SCToldLesterHeKnowWhereEnemy == FALSE)
		{
			if(Npc_KnowsInfo(other,DIA_Lester_SEND_XARDAS))
			{
				B_LogEntry(Topic_Crew,"Lester may have valuable information. I can find him in Xardas' tower.");
			}
			else
			{
				B_LogEntry(Topic_Crew,"If I don't take Lester along, he'll probably never get out of his valley.");
			};
			SCToldLesterHeKnowWhereEnemy = TRUE;
		};
	};
	AI_Output(self,other,"DIA_MiltenNW_KnowWhereEnemy_03_05");	//I also know my role in all this. I can increase your mana and be helpful in constructing runes once we face the enemy. When do we start?
	if(SCToldMiltenHeKnowWhereEnemy == FALSE)
	{
		B_LogEntry(Topic_Crew,"If Milten comes with me, he can teach me to create runes and increase my mana.");
		SCToldMiltenHeKnowWhereEnemy = TRUE;
	};
	if(Crewmember_Count >= Max_Crew)
	{
		AI_Output (other, self, "DIA_MiltenNW_KnowWhereEnemy_15_06");	//Not so fast, I've already got enough people.
		AI_Output (self, other, "DIA_MiltenNW_KnowWhereEnemy_03_07");	//You know I would go with you. If you change your mind, I'll be here waiting for you.
		AI_Output (self, other, "DIA_MiltenNW_KnowWhereEnemy_03_08");	//Good luck, and may Innos hold his protecting hand over you.
	}
	else
	{
		Info_ClearChoices (DIA_MiltenNW_KnowWhereEnemy);
		Info_AddChoice (DIA_MiltenNW_KnowWhereEnemy, "I cannot use you at the moment.", DIA_MiltenNW_KnowWhereEnemy_No);
		Info_AddChoice (DIA_MiltenNW_KnowWhereEnemy, "Welcome aboard!", DIA_MiltenNW_KnowWhereEnemy_Yes);
	};
};

func void DIA_MiltenNW_KnowWhereEnemy_Yes()
{
	AI_Output (other, self, "DIA_MiltenNW_KnowWhereEnemy_Yes_15_00");	//Welcome aboard!
	AI_Output (other, self, "DIA_MiltenNW_KnowWhereEnemy_Yes_15_01");	//We should meet at the harbor. Wait for me there.
	AI_Output (self, other, "DIA_MiltenNW_KnowWhereEnemy_Yes_03_02");	//Good. I'll be there when you're ready.
	B_JoinShip(self);
};

func void DIA_MiltenNW_KnowWhereEnemy_No()
{
	AI_Output (other, self, "DIA_MiltenNW_KnowWhereEnemy_No_15_00");	//I cannot use you at the moment.
	AI_Output (self, other, "DIA_MiltenNW_KnowWhereEnemy_No_03_01");	//You know that I would have stuck with you to the end. If you change your mind, I'll be here waiting for you.
	MiltenNW_IsOnBoard = LOG_OBSOLETE;
	Info_ClearChoices(DIA_MiltenNW_KnowWhereEnemy);
};


instance DIA_MiltenNW_WhereCaptain(C_Info)
{
	npc = PC_Mage_NW;
	nr = 3;
	condition = DIA_MiltenNW_WhereCaptain_Condition;
	information = DIA_MiltenNW_WhereCaptain_Info;
	description = "Where shall I look for a captain?";
};


func int DIA_MiltenNW_WhereCaptain_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && (SCToldMiltenHeKnowWhereEnemy == TRUE) && (SCGotCaptain == FALSE))
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_WhereCaptain_Info()
{
	AI_Output (other, self, "DIA_MiltenNW_WhereCaptain_15_00");	//Where shall I look for a captain?
	AI_Output (self, other, "DIA_MiltenNW_WhereCaptain_03_01");	//Ask Jorgen. He's a sailor, after all. He should still be in the monastery.
	AI_Output (self, other, "DIA_MiltenNW_WhereCaptain_03_02");	//But if he can't help you, you'll have to look for someone on the farms or in the city who can navigate your ship.
	AI_Output (self, other, "DIA_MiltenNW_WhereCaptain_03_03");	//The best thing to do is talk to Lee or go to the harbor of Khorinis. I can't think of anything better at the moment.
	B_LogEntry(Topic_Captain,"I might be able to take Jorgen on as captain. He should still be in the monastery. Other than that, there must be other candidates on the farms or in the city. Maybe I should talk to Lee or ask around at the harbor.");
};


instance DIA_MiltenNW_LeaveMyShip(C_Info)
{
	npc = PC_Mage_NW;
	nr = 55;
	condition = DIA_MiltenNW_LeaveMyShip_Condition;
	information = DIA_MiltenNW_LeaveMyShip_Info;
	permanent = TRUE;
	description = "I can't take you along after all.";
};


func int DIA_MiltenNW_LeaveMyShip_Condition()
{
	if((MiltenNW_IsOnBoard == LOG_SUCCESS) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_LeaveMyShip_Info()
{
	AI_Output (other, self, "DIA_MiltenNW_LeaveMyShip_15_00");	//I can't take you along after all.
	AI_Output (self, other, "DIA_MiltenNW_LeaveMyShip_03_01");	//You know best who can be of use to you. If you change your mind, I'll wait for you in the monastery.
	MiltenNW_IsOnBoard = LOG_OBSOLETE;
	Crewmember_Count -= 1;
	Npc_ExchangeRoutine(self,"ShipOff");
};


instance DIA_MiltenNW_StillNeedYou(C_Info)
{
	npc = PC_Mage_NW;
	nr = 55;
	condition = DIA_MiltenNW_StillNeedYou_Condition;
	information = DIA_MiltenNW_StillNeedYou_Info;
	permanent = TRUE;
	description = "I need you.";
};


func int DIA_MiltenNW_StillNeedYou_Condition()
{
	if(((MiltenNW_IsOnBoard == LOG_OBSOLETE) || (MiltenNW_IsOnBoard == LOG_FAILED)) && (Crewmember_Count < Max_Crew))
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_StillNeedYou_Info()
{
	DIA_Common_INeedYou();
	AI_Output (self, other, "DIA_MiltenNW_StillNeedYou_03_01");	//Your decision honors me. Let's go, we haven't any time to lose.
	AI_Output (self, other, "DIA_MiltenNW_StillNeedYou_03_02");	//I'll go to the harbor. We'll meet there.
	B_JoinShip(self);
};


instance DIA_MiltenNW_Teach(C_Info)
{
	npc = PC_Mage_NW;
	nr = 90;
	condition = DIA_MiltenNW_Teach_Condition;
	information = DIA_MiltenNW_Teach_Info;
	permanent = TRUE;
	description = "I want to learn some new spells.";
};


func int DIA_MiltenNW_Teach_Condition()
{
	if(other.guild == GIL_KDF)
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_Teach_Info()
{
	AI_Output(other,self,"DIA_MiltenNW_Teach_15_00");	//I want to learn some new spells.
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 0)
	{
		AI_Output(self,other,"DIA_MiltenNW_Teach_03_01");	//You still haven't reached the second Circle of Magic. I can't teach you anything.
	}
	else
	{
		Info_ClearChoices(DIA_MiltenNW_Teach);
		Info_AddChoice(DIA_MiltenNW_Teach,Dialog_Back,DIA_MiltenNW_Teach_BACK);
		if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 1)
		{
			if(PLAYER_TALENT_RUNES[SPL_Light] == FALSE)
			{
				Info_AddChoice(DIA_MiltenNW_Teach,B_BuildLearnString(NAME_SPL_Light,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Light)),DIA_MiltenOW_Teach_Light);
			};
			if(PLAYER_TALENT_RUNES[SPL_LightHeal] == FALSE)
			{
				Info_AddChoice(DIA_MiltenNW_Teach,B_BuildLearnString(NAME_SPL_LightHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_LightHeal)),DIA_MiltenOW_Teach_Heal);
			};
		};
		if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 2)
		{
			if(PLAYER_TALENT_RUNES[SPL_WindFist] == FALSE)
			{
				Info_AddChoice(DIA_MiltenNW_Teach,B_BuildLearnString(NAME_SPL_WINDFIST,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_WindFist)),DIA_MiltenOW_Teach_Windfist);
			};
			if(PLAYER_TALENT_RUNES[SPL_InstantFireball] == FALSE)
			{
				Info_AddChoice(DIA_MiltenNW_Teach,B_BuildLearnString(NAME_SPL_InstantFireball,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_InstantFireball)),DIA_MiltenOW_Teach_Feuerball);
			};
			if(PLAYER_TALENT_RUNES[SPL_Icebolt] == FALSE)
			{
				Info_AddChoice(DIA_MiltenNW_Teach,B_BuildLearnString(NAME_SPL_Icebolt,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Icebolt)),DIA_MiltenOW_Teach_Eispfeil);
			};
		};
	};
};

func void DIA_MiltenNW_Teach_BACK()
{
	Info_ClearChoices(DIA_MiltenNW_Teach);
};

var int Milten_NW_TeachMANA_NoPerm;

func void B_BuildLearnDialog_Milten_NW()
{
	if(other.aivar[REAL_MANA_MAX] >= T_MED)
	{
		AI_Output(self,other,"DIA_MiltenNW_Mana_03_00");	//Your magic power is great. Too great for me to be able to help you increase it.
		Milten_NW_TeachMANA_NoPerm = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_MiltenNW_KAP3_NovizenChase_03_04");	//I'll see what I can do.
		Info_ClearChoices(DIA_MiltenNW_Mana);
		Info_AddChoice(DIA_MiltenNW_Mana,Dialog_Back,DIA_MiltenNW_Mana_BACK);
		Info_AddChoice(DIA_MiltenNW_Mana,B_BuildLearnString(PRINT_LearnMANA1,B_GetLearnCostAttribute(other,ATR_MANA_MAX)),DIA_MiltenNW_Mana_1);
		Info_AddChoice(DIA_MiltenNW_Mana,B_BuildLearnString(PRINT_LearnMANA5,B_GetLearnCostAttribute(other,ATR_MANA_MAX) * 5),DIA_MiltenNW_Mana_5);
	};
};

instance DIA_MiltenNW_Mana(C_Info)
{
	npc = PC_Mage_NW;
	nr = 100;
	condition = DIA_MiltenNW_Mana_Condition;
	information = DIA_MiltenNW_Mana_Info;
	permanent = TRUE;
	description = "I want to increase my magic powers.";
};


func int DIA_MiltenNW_Mana_Condition()
{
	if(((other.guild == GIL_KDF) || ((GuildlessMode == TRUE) && (other.guild == GIL_NOV))) && (Milten_NW_TeachMANA_NoPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_MiltenNW_Mana_Info()
{
	AI_Output(other,self,"DIA_MiltenNW_Mana_15_00");	//I want to increase my magic powers.
	B_BuildLearnDialog_Milten_NW();
};

func void DIA_MiltenNW_Mana_BACK()
{
	Info_ClearChoices(DIA_MiltenNW_Mana);
};

func void DIA_MiltenNW_Mana_1()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,1,T_MED))
	{
		B_BuildLearnDialog_Milten_NW();
	};
};

func void DIA_MiltenNW_Mana_5()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,5,T_MED))
	{
		B_BuildLearnDialog_Milten_NW();
	};
};

instance DIA_Mage_NW_PICKPOCKET(C_Info)
{
	npc = PC_Mage_NW;
	nr = 900;
	condition = DIA_Mage_NW_PICKPOCKET_Condition;
	information = DIA_Mage_NW_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Mage_NW_PICKPOCKET_Condition()
{
	return C_Beklauen(56,75);
};

func void DIA_Mage_NW_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Mage_NW_PICKPOCKET);
	Info_AddChoice(DIA_Mage_NW_PICKPOCKET,Dialog_Back,DIA_Mage_NW_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Mage_NW_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Mage_NW_PICKPOCKET_DoIt);
};

func void DIA_Mage_NW_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Mage_NW_PICKPOCKET);
};

func void DIA_Mage_NW_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Mage_NW_PICKPOCKET);
};

