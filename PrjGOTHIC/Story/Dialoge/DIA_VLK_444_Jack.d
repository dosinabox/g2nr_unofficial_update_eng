
instance DIA_Jack_EXIT(C_Info)
{
	npc = VLK_444_Jack;
	nr = 999;
	condition = DIA_Jack_EXIT_Condition;
	information = DIA_Jack_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Jack_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Jack_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Jack_PICKPOCKET(C_Info)
{
	npc = VLK_444_Jack;
	nr = 900;
	condition = DIA_Jack_PICKPOCKET_Condition;
	information = DIA_Jack_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Jack_PICKPOCKET_Condition()
{
	return C_Beklauen(50,100);
};

func void DIA_Jack_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Jack_PICKPOCKET);
	Info_AddChoice(DIA_Jack_PICKPOCKET,Dialog_Back,DIA_Jack_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Jack_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Jack_PICKPOCKET_DoIt);
};

func void DIA_Jack_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Jack_PICKPOCKET);
};

func void DIA_Jack_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Jack_PICKPOCKET);
};


instance DIA_Jack_GREET(C_Info)
{
	npc = VLK_444_Jack;
	nr = 4;
	condition = DIA_Jack_GREET_Condition;
	information = DIA_Jack_GREET_Info;
	important = TRUE;
};


func int DIA_Jack_GREET_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Jack_GREET_Info()
{
	AI_Output (self, other, "DIA_Jack_GREET_14_00");	//Ahoy, you landlubber, looks like you're stranded here.
	AI_Output (self, other, "DIA_Jack_GREET_14_01");	//You look a bit pale around the gills.
	AI_Output (self, other, "DIA_Jack_GREET_14_02");	//Never mind, my lad. All you need is a good stiff sea breeze.
};


instance DIA_Jack_Job(C_Info)
{
	npc = VLK_444_Jack;
	nr = 5;
	condition = DIA_Jack_Job_Condition;
	information = DIA_Jack_Job_Info;
	description = "What are you doing here?";
};


func int DIA_Jack_Job_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Jack_GREET))
	{
		return TRUE;
	};
};

func void DIA_Jack_Job_Info()
{
	AI_Output (other, self, "DIA_Jack_Job_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Jack_Job_14_01");	//Back when I was a young man, I went to sea and rode through many a big storm.
	AI_Output (self, other, "DIA_Jack_Job_14_02");	//Many years ago, I settled here and took care of the Khorinis lighthouse for a long time.
	AI_Output (self, other, "DIA_Jack_Job_14_03");	//No big deal. Not at all. But that old tower came closest to what I would call a home.
	AI_Output (self, other, "DIA_Jack_Job_14_04");	//I haven't been up there in ages.
	AI_Output (other, self, "DIA_Jack_Job_15_05");	//Why not?
	AI_Output (self, other, "DIA_Jack_Job_14_06");	//Ever since those scallywags took over my lighthouse, I haven't dared get closer to it than twenty feet. Really bad rabble, that.
	AI_Output (self, other, "DIA_Jack_Job_14_07");	//They're criminals from the Valley of Mines, you know.
	AI_Output (self, other, "DIA_Jack_Job_14_08");	//There was this big bang on the other side of the mountains, and then they swarmed all over the land like flies. Now they're hiding out everywhere - even in my lighthouse.
	AI_Output (self, other, "DIA_Jack_Job_14_09");	//I think they're on the lookout for a ship they can raid.
	AI_Output (self, other, "DIA_Jack_Job_14_10");	//Ha! Let them. Then at least they'd be out of my tower.
	Log_CreateTopic (TOPIC_KillLighthouseBandits, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_KillLighthouseBandits, LOG_Running);
	B_LogEntry (TOPIC_KillLighthouseBandits, "The old seadog Jack can't get back in his lighthouse while the bandits are settled in there.");
	MIS_Jack_KillLighthouseBandits = LOG_Running;
};


instance DIA_Jack_City(C_Info)
{
	npc = VLK_444_Jack;
	nr = 6;
	condition = DIA_Jack_City_Condition;
	information = DIA_Jack_City_Info;
	description = "Do you come to town often?";
};


func int DIA_Jack_City_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Jack_Job))
	{
		return TRUE;
	};
};

func void DIA_Jack_City_Info()
{
	AI_Output (other, self, "DIA_Jack_City_15_00");	//Do you come to town often?
	AI_Output (self, other, "DIA_Jack_City_14_01");	//I always say, a town is only as good as its harbor.
	AI_Output (self, other, "DIA_Jack_City_14_02");	//A harbor is a gate to the world. That's where everyone meets, and where everything starts.
	AI_Output (self, other, "DIA_Jack_City_14_03");	//Once the harbor goes to the dogs, the rest of the city will follow soon.
};


instance DIA_Jack_Harbor(C_Info)
{
	npc = VLK_444_Jack;
	nr = 70;
	condition = DIA_Jack_Harbor_Condition;
	information = DIA_Jack_Harbor_Info;
	permanent = TRUE;
	description = "Tell me about the harbor.";
};


func int DIA_Jack_Harbor_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Jack_City) && (Npc_GetDistToWP(self,"LIGHTHOUSE") >= 3000) && (JackIsCaptain == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jack_Harbor_Info()
{
	AI_Output (other, self, "DIA_Jack_Harbor_15_00");	//Tell me about the harbor.
	AI_Output (self, other, "DIA_Jack_Harbor_14_01");	//The harbor of Khorinis isn't what it used to be.
	AI_Output (self, other, "DIA_Jack_Harbor_14_02");	//There's nothing but riffraff hanging about, the ship's don't come in any more, and trade is dead. This harbor's about to go under.
	Info_ClearChoices (DIA_Jack_Harbor);
	Info_AddChoice (DIA_Jack_Harbor, Dialog_Back, DIA_Jack_Harbor_Back);
	Info_AddChoice (DIA_Jack_Harbor, "Why are the ships no longer coming?", DIA_Jack_Harbor_Ships);
	Info_AddChoice (DIA_Jack_Harbor, "What do you mean by riffraff?", DIA_Jack_Harbor_Rogue);
	Info_AddChoice (DIA_Jack_Harbor, "So why don't you leave?", DIA_Jack_Harbor_Leave);
};

func void DIA_Jack_Harbor_Back()
{
	Info_ClearChoices(DIA_Jack_Harbor);
};

func void DIA_Jack_Harbor_Ships()
{
	AI_Output (other, self, "DIA_Jack_Harbor_Ships_15_00");	//Why are the ships no longer coming?
	AI_Output (self, other, "DIA_Jack_Harbor_Ships_14_01");	//They all say that, once the war is over, everything will be like it used to. That's a load of bilge water.
	AI_Output (self, other, "DIA_Jack_Harbor_Ships_14_02");	//I tell you, a sailor can see when a town's going downhill.
	AI_Output (self, other, "DIA_Jack_Harbor_Ships_14_03");	//A sailor feels that in his blood. And I tell you, forget about this harbor, its heyday's over.
};

func void DIA_Jack_Harbor_Rogue()
{
	AI_Output (other, self, "DIA_Jack_Harbor_Rogue_15_00");	//What do you mean by riffraff?
	AI_Output (self, other, "DIA_Jack_Harbor_Rogue_14_01");	//Look at them, the lazy rabble. Most of them don't even know what work is. All they do is drink all day and spend their last pay at the brothel.
	AI_Output (self, other, "DIA_Jack_Harbor_Rogue_14_02");	//I tell you, stay away from them.
};

func void DIA_Jack_Harbor_Leave()
{
	AI_Output (other, self, "DIA_Jack_Harbor_Leave_15_00");	//So why don't you leave?
	AI_Output (self, other, "DIA_Jack_Harbor_Leave_14_01");	//Nobody would take an old sea dog like me on his ship these days.
	AI_Output (self, other, "DIA_Jack_Harbor_Leave_14_02");	//Most people think that Old Jack's got the gout in his rotten old bones.
	AI_Output (other, self, "DIA_Jack_Harbor_Leave_15_03");	//And? Are they right?
	AI_Output (self, other, "DIA_Jack_Harbor_Leave_14_04");	//Balderdash. Once I've got those planks below my feet again, I'll feel like a young whippersnapper.
};


instance DIA_Jack_BANDITENWEG(C_Info)
{
	npc = VLK_444_Jack;
	nr = 7;
	condition = DIA_Jack_BANDITENWEG_Condition;
	information = DIA_Jack_BANDITENWEG_Info;
	description = "The bandits that were occupying your lighthouse are gone.";
};


func int DIA_Jack_BANDITENWEG_Condition()
{
	if(Npc_IsDead(LeuchtturmBandit_1021) && Npc_IsDead(LeuchtturmBandit_1022) && Npc_IsDead(LeuchtturmBandit_1023) && (MIS_Jack_KillLighthouseBandits == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Jack_BANDITENWEG_Info()
{
	AI_Output (other, self, "DIA_Jack_BANDITENWEG_15_00");	//The bandits that were occupying your lighthouse are gone.
	AI_Output (self, other, "DIA_Jack_BANDITENWEG_14_01");	//Is that really true? Finally I can get back to my work.
	AI_Output (self, other, "DIA_Jack_BANDITENWEG_14_02");	//Come with me to the lighthouse. You get an incredible view of the sea up there.
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_Standup(self);
		B_TurnToNpc(self,other);
	};
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"Lighthouse");
	MIS_Jack_KillLighthouseBandits = LOG_SUCCESS;
	B_GivePlayerXP(XP_KillLighthouseBandits);
};


instance DIA_Jack_LIGHTHOUSEFREE(C_Info)
{
	npc = VLK_444_Jack;
	nr = 8;
	condition = DIA_Jack_LIGHTHOUSEFREE_Condition;
	information = DIA_Jack_LIGHTHOUSEFREE_Info;
	permanent = TRUE;
	description = "Nice lighthouse you've got here.";
};


func int DIA_Jack_LIGHTHOUSEFREE_Condition()
{
	if((MIS_Jack_KillLighthouseBandits == LOG_SUCCESS) && (Npc_GetDistToWP(self,"LIGHTHOUSE") < 3000))
	{
		return TRUE;
	};
};

func void DIA_Jack_LIGHTHOUSEFREE_Info()
{
	AI_Output (other, self, "DIA_Jack_LIGHTHOUSEFREE_15_00");	//Nice lighthouse you've got here.
	AI_Output (self, other, "DIA_Jack_LIGHTHOUSEFREE_14_01");	//Thank you. Just walk on all the way upstairs and take in the beautiful view, my lad. Make yourself at home.
};


instance DIA_Jack_BEMYCAPTAIN(C_Info)
{
	npc = VLK_444_Jack;
	nr = 51;
	condition = DIA_Jack_BEMYCAPTAIN_Condition;
	information = DIA_Jack_BEMYCAPTAIN_Info;
	permanent = TRUE;
	description = "Wouldn't you like to go back to sea?";
};


func int DIA_Jack_BEMYCAPTAIN_Condition()
{
	if((Kapitel == 5) && (MIS_SCKnowsWayToIrdorath == TRUE) && (MIS_Jack_KillLighthouseBandits == LOG_SUCCESS) && (MIS_Jack_NewLighthouseOfficer == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jack_BEMYCAPTAIN_Info()
{
	AI_Output(other,self,"DIA_Jack_BEMYCAPTAIN_15_00");	//Wouldn't you like going back to sea?
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN_14_01");	//I'd give my right arm if only they'd hire me on a big schooner just one more time.
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN_14_02");	//But for an old sea dog like me, that's not so easy, my lad. Anyway, who would take care of the lighthouse then?
	Info_ClearChoices(DIA_Jack_BEMYCAPTAIN);
	Info_AddChoice(DIA_Jack_BEMYCAPTAIN,"Never mind. It was just an idea.",DIA_Jack_BEMYCAPTAIN_no);
	Info_AddChoice(DIA_Jack_BEMYCAPTAIN,"I need your experience as a sailor.",DIA_Jack_BEMYCAPTAIN_seaman);
};

func void DIA_Jack_BEMYCAPTAIN_seaman()
{
	AI_Output (other, self, "DIA_Jack_BEMYCAPTAIN_seaman_15_00");	//I need your experience as a sailor.
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN_seaman_14_01");	//Shiver me timbers. What are you planning to do, matey? You're not fixing to board the King's war galley, are you?
	AI_Output (other, self, "DIA_Jack_BEMYCAPTAIN_seaman_15_02");	//Who knows?
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN_seaman_14_03");	//(laughs) That would be something. Oh well. But I can't give up my lighthouse just like that. Mmh. What shall we do about that?
	B_LogEntry(Topic_Captain,"Jack, the old sailor from the harbor, would make a good captain. But first I'd have to find someone to guard his lighthouse.");
	Info_ClearChoices(DIA_Jack_BEMYCAPTAIN);
	Info_AddChoice(DIA_Jack_BEMYCAPTAIN,"Never mind. It was just an idea.",DIA_Jack_BEMYCAPTAIN_no);
	Info_AddChoice(DIA_Jack_BEMYCAPTAIN,"What if I brought you someone...?",DIA_Jack_BEMYCAPTAIN_seaman_NewOfficer);
};

func void DIA_Jack_BEMYCAPTAIN_seaman_NewOfficer()
{
	AI_Output (other, self, "DIA_Jack_BEMYCAPTAIN_seaman_NewOfficer_15_00");	//What if I brought you someone to take care of your lighthouse in the meantime?
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN_seaman_NewOfficer_14_01");	//Not a bad idea, matey. And I know just the person.
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN_seaman_NewOfficer_14_02");	//Harad the blacksmith has an apprentice called Brian. I've talked to him many times before.
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN_seaman_NewOfficer_14_03");	//I'd like to entrust my lighthouse to him. I think he'd be just the person for that.
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN_seaman_NewOfficer_14_04");	//Go talk to him. Maybe we're lucky and the lad will help us out.
	Info_ClearChoices(DIA_Jack_BEMYCAPTAIN);
	MIS_Jack_NewLighthouseOfficer = LOG_Running;
};

func void DIA_Jack_BEMYCAPTAIN_no()
{
	AI_Output(other,self,"DIA_Jack_BEMYCAPTAIN_no_15_00");	//Never mind. It was just an idea.
	Info_ClearChoices(DIA_Jack_BEMYCAPTAIN);
};


instance DIA_Jack_BEMYCAPTAIN2(C_Info)
{
	npc = VLK_444_Jack;
	nr = 52;
	condition = DIA_Jack_BEMYCAPTAIN2_Condition;
	information = DIA_Jack_BEMYCAPTAIN2_Info;
	description = "Brian will take care of your lighthouse from now on.";
};


func int DIA_Jack_BEMYCAPTAIN2_Condition()
{
	if(MIS_Jack_NewLighthouseOfficer == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Jack_BEMYCAPTAIN2_Info()
{
	AI_Output(other,self,"DIA_Jack_BEMYCAPTAIN2_15_02");	//Brian will take care of your lighthouse from now on.
	AI_Output(self,other,"DIA_Jack_BEMYCAPTAIN2_14_03");	//I had hoped you would say that.
	B_GivePlayerXP(XP_Jack_NewLighthouseOfficer);
	if(SCGotCaptain == FALSE)
	{
		AI_Output(self,other,"DIA_Jack_BEMYCAPTAIN2_14_04");	//Do you still need me?
	}
	else
	{
		AI_Output(self,other,"DIA_Jack_BEMYCAPTAIN2_14_05");	//Let's see whether the boy is any good.
		AI_StopProcessInfos(self);
	};
};


instance DIA_Jack_BrianIsDead(C_Info)
{
	npc = VLK_444_Jack;
	nr = 52;
	condition = DIA_Jack_BrianIsDead_Condition;
	information = DIA_Jack_BrianIsDead_Info;
	description = "Brian is dead.";
};


func int DIA_Jack_BrianIsDead_Condition()
{
	if((MIS_Jack_NewLighthouseOfficer == LOG_Running) && Npc_IsDead(Brian))
	{
		return TRUE;
	};
};

func void DIA_Jack_BrianIsDead_Info()
{
	AI_Output(other,self,"DIA_Jack_BEMYCAPTAIN2_15_00");	//Brian is dead.
	AI_Output(self,other,"DIA_Jack_BEMYCAPTAIN2_14_01");	//Oh. These are terrible times. And such a nice fellow he was.
	MIS_Jack_NewLighthouseOfficer = LOG_OBSOLETE;
};


instance DIA_Jack_BEMYCAPTAIN3(C_Info)
{
	npc = VLK_444_Jack;
	nr = 53;
	condition = DIA_Jack_BEMYCAPTAIN3_Condition;
	information = DIA_Jack_BEMYCAPTAIN3_Info;
	description = "Be my captain.";
};


func int DIA_Jack_BEMYCAPTAIN3_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Jack_BEMYCAPTAIN2) && (SCGotCaptain == FALSE) && (MIS_Jack_NewLighthouseOfficer == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Jack_BEMYCAPTAIN3_Info()
{
	AI_Output (other, self, "DIA_Jack_BEMYCAPTAIN3_15_00");	//Be my captain.
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN3_14_01");	//I've sailed the seven seas, my lad, but never before have I been captain of a ship.
	AI_Output (other, self, "DIA_Jack_BEMYCAPTAIN3_15_02");	//I know nothing about navigation. You're going to have to do that.
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN3_14_03");	//I shall give it my best.
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN3_14_04");	//So, show me your ship and your crew. Do you know, then, where you're headed? I mean, d'you have a nautical chart?
	AI_Output (other, self, "DIA_Jack_BEMYCAPTAIN3_15_05");	//Wait for me at the harbor. Don't worry about the rest.
	AI_Output (self, other, "DIA_Jack_BEMYCAPTAIN3_14_06");	//If you say so.
	if(self.attribute[ATR_HITPOINTS] == 1)
	{
		self.attribute[ATR_HITPOINTS] += 1;
	};
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_Standup(self);
		B_TurnToNpc(self,other);
	};
	AI_StopProcessInfos(self);
	SCGotCaptain = TRUE;
	JackIsCaptain = TRUE;
	self.flags = NPC_FLAG_IMMORTAL;
	Npc_ExchangeRoutine(self,"WaitForShipCaptain");
	B_GivePlayerXP(XP_Captain_Success);
};


instance DIA_Jack_LOSFAHREN(C_Info)
{
	npc = VLK_444_Jack;
	nr = 59;
	condition = DIA_Jack_LOSFAHREN_Condition;
	information = DIA_Jack_LOSFAHREN_Info;
	permanent = TRUE;
	description = "Right, old man. Let us set sail.";
};


func int DIA_Jack_LOSFAHREN_Condition()
{
	if((JackIsCaptain == TRUE) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jack_LOSFAHREN_Info()
{
	AI_Output(other,self,"DIA_Jack_LOSFAHREN_15_00");	//Right, old man. Let us set sail.
	if(B_CaptainConditions(self))
	{
		AI_Output (self, other, "DIA_Jack_LOSFAHREN_14_01");	//Everything's ship-shape. Show me your nautical chart then.
		B_GiveInvItems(other,self,ItWr_Seamap_Irdorath,1);
		AI_Output (self, other, "DIA_Jack_LOSFAHREN_14_02");	//Some trip this is turning out to be. I hope we'll get there in one piece.
		AI_Output (self, other, "DIA_Jack_LOSFAHREN_14_03");	//D'you really have everything you need? We're not going to sail back just because you're still missing something.
		AI_Output (self, other, "DIA_Jack_LOSFAHREN_14_04");	//If you're sure that you've got everything, go to the captain's quarters and hit the sack. You're going to need it.
		if(C_BodyStateContains(self,BS_SIT))
		{
			AI_Standup(self);
			B_TurnToNpc(self,other);
		};
		AI_StopProcessInfos(self);
		B_CaptainCallsAllOnBoard(self);
	}
	else
	{
		if(Npc_GetDistToWP(self,"NW_WAITFOR_SHIP_CAPTAIN") > 3000)
		{
		AI_Output (self, other, "DIA_Jack_LOSFAHREN_14_05");	//Easy does it, my lad. I haven't even seen the tub yet. It doesn't work this way.
		};
		AI_Output (self, other, "DIA_Jack_LOSFAHREN_14_06");	//First, you need a complete crew with at least 5 men, free access to the ship, and a nautical chart. Otherwise, forget it.
		AI_StopProcessInfos(self);
	};
};


instance DIA_Jack_PERM5_NOTCAPTAIN(C_Info)
{
	npc = VLK_444_Jack;
	nr = 59;
	condition = DIA_Jack_PERM5_NOTCAPTAIN_Condition;
	information = DIA_Jack_PERM5_NOTCAPTAIN_Info;
	permanent = TRUE;
	description = "So what happens next?";
};


func int DIA_Jack_PERM5_NOTCAPTAIN_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Jack_BEMYCAPTAIN2) && (SCGotCaptain == TRUE) && (JackIsCaptain == FALSE)) || (MIS_Jack_NewLighthouseOfficer == LOG_OBSOLETE))
	{
		return TRUE;
	};
};

func void DIA_Jack_PERM5_NOTCAPTAIN_Info()
{
	AI_Output (other, self, "DIA_Jack_PERM5_NOTCAPTAIN_15_00");	//So what happens next?
	AI_Output (self, other, "DIA_Jack_PERM5_NOTCAPTAIN_14_01");	//I've thought matters over. I'm going to stay here and guard my lighthouse after all.
	AI_StopProcessInfos(self);
};

