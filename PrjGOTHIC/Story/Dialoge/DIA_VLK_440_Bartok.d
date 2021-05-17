
instance DIA_Bartok_EXIT(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 999;
	condition = DIA_Bartok_EXIT_Condition;
	information = DIA_Bartok_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Bartok_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Bartok_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Bartok_PICKPOCKET(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 900;
	condition = DIA_Bartok_PICKPOCKET_Condition;
	information = DIA_Bartok_PICKPOCKET_Info;
	permanent = TRUE;
	description = "(It would be easy to steal his quiver of arrows)";
};


func int DIA_Bartok_PICKPOCKET_Condition()
{
//	return C_StealItems(30,Hlp_GetInstanceID(ItRw_Arrow),0);
	return C_StealItem(30);
};

func void DIA_Bartok_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Bartok_PICKPOCKET);
	Info_AddChoice(DIA_Bartok_PICKPOCKET,Dialog_Back,DIA_Bartok_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Bartok_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Bartok_PICKPOCKET_DoIt);
};

func void DIA_Bartok_PICKPOCKET_DoIt()
{
//	B_StealItems(30,Hlp_GetInstanceID(ItRw_Arrow),40);
	if(other.attribute[ATR_DEXTERITY] >= 30)
	{
		CreateInvItems(self,ItRw_Arrow,40);
		B_GiveInvItems(self,other,ItRw_Arrow,40);
		self.aivar[AIV_PlayerHasPickedMyPocket] = TRUE;
		B_GiveThiefXP();
		B_LogEntry(Topic_PickPocket,ConcatStrings("Bartok",PRINT_PickPocketSuccess));
	}
	else
	{
		B_ResetThiefLevel();
		B_LogEntry(Topic_PickPocket,ConcatStrings("Bartok",PRINT_PickPocketFailed));
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_Theft,1);
	};
	Info_ClearChoices(DIA_Bartok_PICKPOCKET);
};

func void DIA_Bartok_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Bartok_PICKPOCKET);
};


instance DIA_Bartok_Hallo(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 1;
	condition = DIA_Bartok_Hallo_Condition;
	information = DIA_Bartok_Hallo_Info;
	permanent = FALSE;
	description = "What's up?";
};


func int DIA_Bartok_Hallo_Condition()
{
	return TRUE;
};

func void DIA_Bartok_Hallo_Info()
{
	AI_Output (other, self, "DIA_Bartok_Hello_15_00");	//How's it going?
	AI_Output (self, other, "DIA_Bartok_Hello_04_01");	//You're not from around here, are you? Never mind - neither am I.
	AI_Output (other, self, "DIA_Bartok_Hello_15_02");	//Where did you hang around before?
	AI_Output (self, other, "DIA_Bartok_Hello_04_03");	//In the woods, hunting scavengers and wolves together with some hunters.
	AI_Output (self, other, "DIA_Bartok_Hello_04_04");	//But I gave it up. These are dangerous times. There's a lot of riff-raff running around out there ...
};


instance DIA_Bartok_Jaeger(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 2;
	condition = DIA_Bartok_Jaeger_Condition;
	information = DIA_Bartok_Jaeger_Info;
	permanent = FALSE;
	description = "Where can I find the other hunters?";
};


func int DIA_Bartok_Jaeger_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bartok_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Bartok_Jaeger_Info()
{
	AI_Output (other, self, "DIA_Bartok_Jager_15_00");	//Where can I find the other hunters?
	AI_Output (self, other, "DIA_Bartok_Jager_04_01");	//We had our camp outside, near the tavern, half way to Onar's farm.
	AI_Output (self, other, "DIA_Bartok_Jager_04_02");	//But I don't know whether there's anyone left in the camp now.
	AI_Output (self, other, "DIA_Addon_Bartok_Jager_04_00");	//There used to be two of us here in town, until a few days ago.
	AI_Output (self, other, "DIA_Addon_Bartok_Jager_04_01");	//My friend Trokar is an excellent hunter.
};


instance DIA_Addon_Bartok_MissingPeople(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 5;
	condition = DIA_Addon_Bartok_MissingPeople_Condition;
	information = DIA_Addon_Bartok_MissingPeople_Info;
	description = "So where is your friend Trokar now?";
};


func int DIA_Addon_Bartok_MissingPeople_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bartok_Jaeger))
	{
		return TRUE;
	};
};

func void DIA_Addon_Bartok_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Bartok_MissingPeople_15_00");	//So where is your friend Trokar now?
	AI_Output (self, other, "DIA_Addon_Bartok_MissingPeople_04_01");	//Well. It's a curious story.
	AI_Output (self, other, "DIA_Addon_Bartok_MissingPeople_04_02");	//Only a few days ago, we were both standing at the bar in Coragon's tavern, discussing the hunt.
	AI_Output (self, other, "DIA_Addon_Bartok_MissingPeople_04_03");	//Don't ask me what happened next. I had had a few by then.
	AI_Output (self, other, "DIA_Addon_Bartok_MissingPeople_04_04");	//I vaguely remember Trokar saying that he was going out to get a few swampweed reefers. He never came back.
//	MIS_Bartok_MissingTrokar = LOG_Running;
	Info_ClearChoices (DIA_Addon_Bartok_MissingPeople);
	Info_AddChoice (DIA_Addon_Bartok_MissingPeople, "Didn't you go looking for him?", DIA_Addon_Bartok_MissingPeople_such);
	Info_AddChoice (DIA_Addon_Bartok_MissingPeople, "So where can I get some swampweed reefers?", DIA_Addon_Bartok_MissingPeople_wo);
};

func void DIA_Addon_Bartok_MissingPeople_wo()
{
	AI_Output (other, self, "DIA_Addon_Bartok_MissingPeople_wo_15_00");	//Where does one get swampweed reefers?
	AI_Output (self, other, "DIA_Addon_Bartok_MissingPeople_wo_04_01");	//Somewhere down at the harbor, as far as I know.
};

func void DIA_Addon_Bartok_MissingPeople_such()
{
	AI_Output (other, self, "DIA_Addon_Bartok_MissingPeople_such_15_00");	//Didn't you go looking for him?
	AI_Output (self, other, "DIA_Addon_Bartok_MissingPeople_such_04_01");	//No. But I reported it to the militia.
	AI_Output (self, other, "DIA_Addon_Bartok_MissingPeople_such_04_02");	//But they haven't been able to find him yet.
	AI_Output (self, other, "DIA_Addon_Bartok_MissingPeople_such_04_03");	//I hope he didn't get attacked by a wolf, or worse.
	AI_Output (self, other, "DIA_Addon_Bartok_MissingPeople_such_04_04");	//I'm afraid that I'll stumble over his body some day when I'm out hunting.
	AI_Output (self, other, "DIA_Addon_Bartok_MissingPeople_such_04_05");	//I don't think I could bear that.
};


instance DIA_Bartok_Bosper(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 3;
	condition = DIA_Bartok_Bosper_Condition;
	information = DIA_Bartok_Bosper_Info;
	permanent = FALSE;
	description = "Bosper said you used to work for him ...";
};


func int DIA_Bartok_Bosper_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bosper_Bartok) && Npc_KnowsInfo(other,DIA_Bartok_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Bartok_Bosper_Info()
{
	AI_Output (other, self, "DIA_Bartok_Bosper_15_00");	//Bosper said you used to work for him ...
	AI_Output (self, other, "DIA_Bartok_Bosper_04_01");	//Yes, I did. But he was only interested in his blasted hides.
	AI_Output (self, other, "DIA_Bartok_Bosper_04_02");	//I told him how dangerous it's gotten out there. He didn't really listen to me.
	AI_Output (self, other, "DIA_Bartok_Bosper_04_03");	//Well, anyway he paid well - I can't complain about that.
	AI_Output (other, self, "DIA_Bartok_Bosper_15_04");	//Can you tell me anything else about him?
	AI_Output (self, other, "DIA_Bartok_Bosper_04_05");	//(laughs) Bosper had one of his bows stolen recently. In broad daylight.
	AI_Output (self, other, "DIA_Bartok_Bosper_04_06");	//Some guy just waltzed into his store, took a bow, and left.
	AI_Output (self, other, "DIA_Bartok_Bosper_04_07");	//The thieves are getting more and more brazen!
	if (MIS_Bosper_Bogen != LOG_SUCCESS)
	{
		MIS_Bosper_Bogen = LOG_Running;
	};
};


instance DIA_Bartok_WannaLearn(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 4;
	condition = DIA_Bartok_WannaLearn_Condition;
	information = DIA_Bartok_WannaLearn_Info;
	permanent = FALSE;
	description = "Can you teach me something about hunting?";
};


func int DIA_Bartok_WannaLearn_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bartok_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Bartok_WannaLearn_Info()
{
	AI_Output (other, self, "DIA_Bartok_WannaLearn_15_00");	//Can you teach me something about hunting?
	AI_Output (self, other, "DIA_Bartok_WannaLearn_04_01");	//I can teach you how to sneak properly and how to handle a bow.
	if (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE)
	{
		AI_Output (self, other, "DIA_Bartok_WannaLearn_04_02");	//If you want to learn how to skin an animal, go to Bosper. He's the one who taught me.
	};
	Bartok_TeachPlayer = TRUE;
	Log_CreateTopic (TOPIC_CityTeacher, LOG_NOTE);
	B_LogEntry (TOPIC_CityTeacher, "Bartok can teach me archery and how to sneak.");
};


instance DIA_Bartok_TeachSneak(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 4;
	condition = DIA_Bartok_TeachSneak_Condition;
	information = DIA_Bartok_TeachSneak_Info;
	permanent = TRUE;
//	description = B_BuildLearnString("Teach me how to sneak around!",B_GetLearnCostTalent(other,NPC_TALENT_SNEAK,1));
	description = B_BuildLearnString(NAME_Skill_Sneak,B_GetLearnCostTalent(other,NPC_TALENT_SNEAK,1));
};


func int DIA_Bartok_TeachSneak_Condition()
{
	if((Bartok_TeachPlayer == TRUE) && !Npc_GetTalentSkill(other,NPC_TALENT_SNEAK))
	{
		return TRUE;
	};
};

func void DIA_Bartok_TeachSneak_Info()
{
	AI_Output (other, self, "DIA_Bartok_TeachSneak_15_00");	//Teach me how to sneak!
	if (B_TeachThiefTalent (self, other, NPC_TALENT_SNEAK))
	{
		AI_Output (self, other, "DIA_Bartok_TeachSneak_04_01");	//All right - so, first you have to make sure that you shift your weight properly.
		AI_Output (self, other, "DIA_Bartok_TeachSneak_04_02");	//To achieve that, bend your knees and always put your foot down heel first.
		AI_Output (self, other, "DIA_Bartok_TeachSneak_04_03");	//Make sure that you always keep your weight on the foot you're standing on until you've got your other foot securely placed.
		AI_Output (self, other, "DIA_Bartok_TeachSneak_04_04");	//Most creatures you can't sneak up on unless they're sleeping. The beasts just smell you.
		AI_Output (self, other, "DIA_Bartok_TeachSneak_04_05");	//So always pay close attention when you're out there.
	};
};


var int Bartok_MerkeBow;
var int DIA_Bartok_Teacher_permanent;

func void B_BuildLearnDialog_Bartok()
{
	if(VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_Bartok)
	{
		Info_ClearChoices(DIA_Bartok_Teach);
		Info_AddChoice(DIA_Bartok_Teach,Dialog_Back,DIA_Bartok_Teach_Back);
		Info_AddChoice(DIA_Bartok_Teach,B_BuildLearnString(PRINT_LearnBow1,B_GetLearnCostTalent(other,NPC_TALENT_BOW,1)),DIA_Bartok_Teach_BOW_1);
		Info_AddChoice(DIA_Bartok_Teach,B_BuildLearnString(PRINT_LearnBow5,B_GetLearnCostTalent(other,NPC_TALENT_BOW,5)),DIA_Bartok_Teach_BOW_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_BOW) >= TeachLimit_Bow_Bartok)
		{
			DIA_Bartok_Teacher_permanent = TRUE;
		};
		PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_Bow_Bartok)),-1,53,FONT_Screen,2);
		AI_Output(self,other,"DIA_Bartok_TeachBow_BACK_04_00");	//You should now look for someone who knows more about it than I do.
		AI_StopProcessInfos(self);
	};
};

instance DIA_Bartok_Teach(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 4;
	condition = DIA_Bartok_Teach_Condition;
	information = DIA_Bartok_Teach_Info;
	permanent = TRUE;
	description = "I want to be able to handle a bow better!";
};


func int DIA_Bartok_Teach_Condition()
{
	if((Bartok_TeachPlayer == TRUE) && (DIA_Bartok_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Bartok_Teach_Info()
{
	AI_Output(other,self,"DIA_Bartok_TeachBow_15_00");	//I want to be able to handle a bow better!
	if(VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_Bartok)
	{
		AI_Output(self,other,"DIA_Bartok_TeachBow_04_01");	//Okay, then let's see if I can teach you anything...
		Bartok_MerkeBow = other.HitChance[NPC_TALENT_BOW];
	};
	B_BuildLearnDialog_Bartok();
};

func void DIA_Bartok_Teach_Back()
{
	if(Bartok_MerkeBow < other.HitChance[NPC_TALENT_BOW])
	{
		AI_Output(self,other,"DIA_Bartok_TeachBow_BACK_04_01");	//All right, your aim has become more accurate already.
	};
	Info_ClearChoices(DIA_Bartok_Teach);
};

func void DIA_Bartok_Teach_BOW_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,1,TeachLimit_Bow_Bartok))
	{
		B_BuildLearnDialog_Bartok();
	};
};

func void DIA_Bartok_Teach_BOW_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,5,TeachLimit_Bow_Bartok))
	{
		B_BuildLearnDialog_Bartok();
	};
};

var int Bartok_Bereit;
var int Bartok_Later;

instance DIA_Bartok_Zusammen(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 5;
	condition = DIA_Bartok_Zusammen_Condition;
	information = DIA_Bartok_Zusammen_Info;
	permanent = TRUE;
	description = "Why don't we go hunting together?";
};


func int DIA_Bartok_Zusammen_Condition()
{
	if((Bartok_Bereit == FALSE) && Npc_KnowsInfo(other,DIA_Bartok_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Bartok_Zusammen_Info()
{
	AI_Output(other,self,"DIA_Bartok_Zusammen_15_00");	//Why don't we go hunting together?
	if(Bartok_Later == FALSE)
	{
		AI_Output (self, other, "DIA_Bartok_Zusammen_04_01");	//Hmm. With two it isn't so dangerous, that's true...
		AI_Output (self, other, "DIA_Bartok_Zusammen_04_02");	//Do you know anything about hunting, then?
		AI_Output (self, other, "DIA_Bartok_Zusammen_04_03");	//I mean, do you know how to skin an animal?
	};
	if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == TRUE)
	{
		if(Bartok_Later == TRUE)
		{
			AI_Output (self, other, "DIA_Bartok_HuntNOW_04_01");	//Do you have 50 gold pieces?
		}
		else
		{
			AI_Output (other, self, "DIA_Bartok_Zusammen_15_04");	//Yes.
			AI_Output (self, other, "DIA_Bartok_Zusammen_04_05");	//All right, but I want to see 50 gold pieces. For that you can keep the skins and sell them to Bosper.
			AI_Output (self, other, "DIA_Bartok_Zusammen_04_06");	//That's a fair deal, isn't it?
		};
		Info_ClearChoices (DIA_Bartok_Zusammen);
		Info_AddChoice (DIA_Bartok_Zusammen, "Later ...", DIA_Bartok_Zusammen_Later);
		Info_AddChoice (DIA_Bartok_Zusammen, "Here you are ...", DIA_Bartok_Zusammen_Pay);
	}
	else
	{
		AI_Output (other, self, "DIA_Bartok_Zusammen_15_07");	//No.
		AI_Output (self, other, "DIA_Bartok_Zusammen_04_08");	//Then it wouldn't be worth it.
		AI_Output (self, other, "DIA_Bartok_Zusammen_04_09");	//Come back when you've learned something.
	};
};

func void DIA_Bartok_Zusammen_Later()
{
	AI_Output (other, self, "DIA_Bartok_HuntNOW_Later_15_00");	//Later ...
	Bartok_Later = TRUE;
	Info_ClearChoices(DIA_Bartok_Zusammen);
};

func void DIA_Bartok_Zusammen_Pay()
{
	Info_ClearChoices(DIA_Bartok_Zusammen);
	AI_Output(other,self,"DIA_Bartok_HuntNOW_GO_15_00");	//Here they are...
	if(B_GiveInvItems(other,self,ItMi_Gold,50))
	{
		Bartok_Bereit = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Bartok_HuntNOW_GO_04_03");	//Where, then? You don't have the gold.
	};
};


var int Bartok_Los;

instance DIA_Bartok_HuntNOW(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 5;
	condition = DIA_Bartok_HuntNOW_Condition;
	information = DIA_Bartok_HuntNOW_Info;
	permanent = FALSE;
	description = "Let's go hunting!";
};


func int DIA_Bartok_HuntNOW_Condition()
{
	if(Bartok_Bereit == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Bartok_HuntNOW_Info()
{
	AI_Output (other, self, "DIA_Bartok_HuntNOW_15_00");	//Let's go hunting!
	AI_Output (self, other, "DIA_Bartok_HuntNOW_GO_04_01");	//All right, follow me. Outside the south gate is a wood where we should find more than enough critters.
	AI_Output (self, other, "DIA_Bartok_HuntNOW_GO_04_02");	//(to himself) Probably more than we'd like...
	CreateInvItem(self,ITAR_Leather_L);
	CreateInvItem(self,ItRw_Bow_M_03);
	if(!Npc_HasItems(self,ItRw_Arrow) < 30)
	{
		CreateInvItems(self,ItRw_Arrow,40);
	};
	AI_EquipArmor(self,ITAR_Leather_L);
	AI_EquipBestRangedWeapon(self);
	Bartok_Los = TRUE;
	AI_StopProcessInfos(self);
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	Npc_ExchangeRoutine(self,"GUIDEMITTE");
	Wld_InsertNpc(Wolf,"NW_FARM1_CITYWALL_FOREST_02");
	Wld_InsertNpc(Wolf,"NW_FARM1_CITYWALL_FOREST_02");
	Wld_InsertNpc(Wolf,"NW_FARM1_CITYWALL_FOREST_02");
};


var int Bartok_OrkStillThere;

instance DIA_Bartok_ImWald(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 1;
	condition = DIA_Bartok_ImWald_Condition;
	information = DIA_Bartok_ImWald_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Bartok_ImWald_Condition()
{
	if((Bartok_Los == TRUE) && (Npc_GetDistToWP(self,"NW_FARM1_CITYWALL_FOREST_03") < 500))
	{
		return TRUE;
	};
};

func void DIA_Bartok_ImWald_Info()
{
	AI_Output (self, other, "DIA_Bartok_ImWald_04_00");	//So, what do you think, should we go farther into the woods or not?
	Info_ClearChoices (DIA_Bartok_ImWald);
	Info_AddChoice (DIA_Bartok_ImWald, "Let's go back!", DIA_Bartok_ImWald_NachHause);
	Info_AddChoice (DIA_Bartok_ImWald, "Let's go on.", DIA_Bartok_ImWald_Weiter);
};

var int Bartok_Ende;

func void B_Bartok_BackInCity()
{
	Bartok_Ende = TRUE;
	self.attribute[ATR_HITPOINTS] = self.attribute[ATR_HITPOINTS_MAX];
	AI_EquipArmor(self,ITAR_Vlk_L);
	AI_UnequipWeapons(self);
	AI_EquipBestMeleeWeapon(self);
	Npc_RemoveInvItem(self,ItRw_Bow_M_03);
	AI_StopProcessInfos(self);
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"START");
};

func void DIA_Bartok_ImWald_NachHause()
{
	AI_Output(other,self,"DIA_Bartok_ImWald_NachHause_15_00");	//Let's go back!
	AI_Output(self,other,"DIA_Bartok_ImWald_NachHause_04_01");	//That's what I'd prefer. We'd probably wind up running straight into the arms of an orc.
	Knows_Ork = TRUE;
	B_Bartok_BackInCity();
};

func void DIA_Bartok_ImWald_Weiter()
{
	AI_Output (other, self, "DIA_Bartok_ImWald_Weiter_15_00");	//Let's go on.
	AI_Output (self, other, "DIA_Bartok_ImWald_Weiter_04_01");	//All right. (to self) Let's hope this works out...
	if(!Npc_IsDead(CityOrc))
	{
		Bartok_OrkStillThere = TRUE;
	};
	Info_ClearChoices(DIA_Bartok_ImWald);
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"GUIDEENDE");
};


instance DIA_Bartok_Angekommen(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 1;
	condition = DIA_Bartok_Angekommen_Condition;
	information = DIA_Bartok_Angekommen_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Bartok_Angekommen_Condition()
{
	if((Bartok_Los == TRUE) && (Npc_GetDistToWP(self,"NW_FARM1_CITYWALL_FOREST_07") < 500))
	{
		return TRUE;
	};
};

func void DIA_Bartok_Angekommen_Info()
{
	AI_Output (self, other, "DIA_Bartok_Angekommen_04_00");	//That's it! I think I'm going back to the city.
	AI_Output (self, other, "DIA_Bartok_Angekommen_04_01");	//It's just too dangerous out here for me - even with two of us.
	if (Bartok_OrkStillThere == TRUE)
	{
		B_Bartok_ShitAnOrc();
		Bartok_OrkGesagt = TRUE;
		Knows_Ork = TRUE;
	};
	AI_Output (self, other, "DIA_Bartok_Angekommen_04_03");	//So, see you!
	AI_Output (self, other, "DIA_Bartok_Angekommen_04_04");	//You can sell the skins to Bosper.
	B_GivePlayerXP(XP_Bartok_Deal);
	B_Bartok_BackInCity();
};


instance DIA_Bartok_PERM(C_Info)
{
	npc = VLK_440_Bartok;
	nr = 1;
	condition = DIA_Bartok_PERM_Condition;
	information = DIA_Bartok_PERM_Info;
	permanent = TRUE;
	description = "Everything all right?";
};


func int DIA_Bartok_PERM_Condition()
{
	if(Bartok_Los == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Bartok_PERM_Info()
{
	AI_Output (other, self, "DIA_Bartok_PERM_15_00");	//Okay?
	if (Bartok_Ende == TRUE)
	{
		AI_Output (self, other, "DIA_Bartok_PERM_04_01");	//Yes. But I'm not going out of the city any more - at least not any time soon.
		if (Bartok_OrkGesagt == TRUE)
		{
			AI_Output (self, other, "DIA_Bartok_PERM_04_02");	//My knees are still shaking from the scare that orc gave us.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Bartok_PERM_04_03");	//Sure. Let's bring down a few beasts!
	};
};

