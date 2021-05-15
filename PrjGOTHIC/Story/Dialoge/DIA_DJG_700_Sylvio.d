
instance DIA_SylvioDJG_EXIT(C_Info)
{
	npc = DJG_700_Sylvio;
	nr = 999;
	condition = DIA_SylvioDJG_EXIT_Condition;
	information = DIA_SylvioDJG_EXIT_Info;
	important = FALSE;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_SylvioDJG_EXIT_Condition()
{
	return TRUE;
};

func void DIA_SylvioDJG_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_SylvioDJG_HelloAgain(C_Info)
{
	npc = DJG_700_Sylvio;
	condition = DIA_SylvioDJG_HelloAgain_Condition;
	information = DIA_SylvioDJG_HelloAgain_Info;
	important = TRUE;
};


func int DIA_SylvioDJG_HelloAgain_Condition()
{
	if(!Npc_IsDead(IceDragon) && (IceDragon.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_SylvioDJG_HelloAgain_Info()
{
	if(other.guild == GIL_PAL)
	{
		AI_Output(self,other,"DIA_SylvioDJG_HelloAgain_09_03");	//Hey, you, paladin! Go back to your ore mine. There's nothing here.
	}
	else if(other.guild == GIL_KDF)
	{
		AI_Output (self, other, "DIA_SylvioDJG_HelloAgain_09_02");	//Hey, you! Magicians make me nervous! Go somewhere else! There's nothing here.
	}
	else
	{
		AI_Output(self,other,"DIA_SylvioDJG_HelloAgain_09_00");	//Well, I'll be damned. Looking for profit, huh? I knew it! You've got the soul of a mercenary.
		AI_Output(self,other,"DIA_SylvioDJG_HelloAgain_09_01");	//Listen, if you think you can make a pile here, you're thoroughly mistaken. I was here first.
	};
	AI_Output (other, self, "DIA_SylvioDJG_HelloAgain_15_04");	//Understood. Nobody likes to part with his booty.
	AI_Output (self, other, "DIA_SylvioDJG_HelloAgain_09_05");	//You said it. Disappear.
};


instance DIA_Sylvio_VERSAGER(C_Info)
{
	npc = DJG_700_Sylvio;
	nr = 6;
	condition = DIA_Sylvio_VERSAGER_Condition;
	information = DIA_Sylvio_VERSAGER_Info;
	description = "And what if I won't go?";
};


func int DIA_Sylvio_VERSAGER_Condition()
{
	if(Npc_KnowsInfo(other,DIA_SylvioDJG_HelloAgain) && (IceDragon.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Sylvio_VERSAGER_Info()
{
	AI_Output(other,self,"DIA_Sylvio_VERSAGER_15_00");	//And what if I won't go?
	if(SylvioIceGolemsKilledBefore4Chapter == FALSE)
	{
		AI_Output(self,other,"DIA_Sylvio_VERSAGER_09_01");	//Don't play the big man here, squirt, otherwise you'll wind up just like those poor swine lying dead back there in the snow.
	}
	else
	{
		AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_keinInteresse_09_02");	//���, �� ����� �������, ��������� ������� ������. �� ����� ������� ������ �� �����.
		AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_keinInteresse_09_03");	//��� ���������� ������� ������ ������ �� ����� �����.
		AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_09_02");	//���� �� ����� ������, �����, �� ����������?
	};
};


instance DIA_Sylvio_DEINELEUTE(C_Info)
{
	npc = DJG_700_Sylvio;
	nr = 7;
	condition = DIA_Sylvio_DEINELEUTE_Condition;
	information = DIA_Sylvio_DEINELEUTE_Info;
	description = "��� ���� ����?";
};


func int DIA_Sylvio_DEINELEUTE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Sylvio_VERSAGER) && (IceDragon.aivar[AIV_TalkedToPlayer] == FALSE) && (MIS_DJG_Sylvio_KillIceGolem != LOG_SUCCESS) && (SylvioIceGolemsKilledBefore4Chapter == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Sylvio_DEINELEUTE_Info()
{
	AI_Output(other,self,"DIA_Sylvio_DEINELEUTE_15_00");	//��� ���� ����?
	AI_Output(self,other,"DIA_Sylvio_DEINELEUTE_09_01");	//������ ���. �� ����� �� ������� ������. ��� ������ ��� ����� ���� ��� ������.
};


instance DIA_Sylvio_WASISTPASSIERT(C_Info)
{
	npc = DJG_700_Sylvio;
	nr = 8;
	condition = DIA_Sylvio_WASISTPASSIERT_Condition;
	information = DIA_Sylvio_WASISTPASSIERT_Info;
	description = "��� ��������� � ����?";
};


func int DIA_Sylvio_WASISTPASSIERT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Sylvio_VERSAGER) && (IceDragon.aivar[AIV_TalkedToPlayer] == FALSE) && (SylvioIceGolemsKilledBefore4Chapter == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Sylvio_WASISTPASSIERT_Info()
{
	AI_Output(other,self,"DIA_Sylvio_WASISTPASSIERT_15_00");	//��� ��������� � ����?
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_09_01");	//��� �� ������ ������ ���� ���� ������� ��������. �� ��������� ��.
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_09_02");	//���� �� ����� ������, �����, �� ����������?
	Info_AddChoice(DIA_Sylvio_WASISTPASSIERT,"������. ������ �� � ���?",DIA_Sylvio_WASISTPASSIERT_ok);
	Info_AddChoice(DIA_Sylvio_WASISTPASSIERT,"��� ��� ���� �������, ���� � ������ ���?",DIA_Sylvio_WASISTPASSIERT_washastdudavon);
	Info_AddChoice(DIA_Sylvio_WASISTPASSIERT,"��� � �� ��� ������?",DIA_Sylvio_WASISTPASSIERT_warum);
	Info_AddChoice(DIA_Sylvio_WASISTPASSIERT,"������ �� �� ������������ � ���� ���?",DIA_Sylvio_WASISTPASSIERT_selbst);
	Log_CreateTopic(TOPIC_SylvioKillIceGolem,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_SylvioKillIceGolem,LOG_Running);
	B_LogEntry(TOPIC_SylvioKillIceGolem,"������� ��������� ������� ������� � ����� � ����������� ����� ������ ��������.");
	MIS_DJG_Sylvio_KillIceGolem = LOG_Running;
//	IceGolem_Sylvio1.flags = 0;
//	IceGolem_Sylvio2.flags = 0;
};

func void DIA_Sylvio_WASISTPASSIERT_selbst()
{
	AI_Output(other,self,"DIA_Sylvio_WASISTPASSIERT_selbst_15_00");	//������ �� �� ������������ � ���� ���?
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_selbst_09_01");	//�����, �����. �� ���� ������.
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_selbst_09_02");	//��-�����, � ���� ������ �������.
	Info_AddChoice(DIA_Sylvio_WASISTPASSIERT,"� �� ����� � ���� ����.",DIA_Sylvio_WASISTPASSIERT_keinInteresse);
};


var int DJG_Sylvio_PromisedMoney;

func void DIA_Sylvio_WASISTPASSIERT_warum()
{
	AI_Output(other,self,"DIA_Sylvio_WASISTPASSIERT_warum_15_00");	//��� � �� ��� ������?
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_warum_09_01");	//�� ����. ��, ������... 1000 ������� �����. ��� ���� ���?
	DJG_Sylvio_PromisedMoney = TRUE;
};

func void DIA_Sylvio_WASISTPASSIERT_washastdudavon()
{
	AI_Output(other,self,"DIA_Sylvio_WASISTPASSIERT_washastdudavon_15_00");	//��� ��� ���� �������, ���� � ������ ���?
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_washastdudavon_09_01");	//���� ��� ��� �����. ��, ������� �� ���� ������, �����: � ���� ������� � ���� ������� �����.
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_washastdudavon_09_02");	//� ���������, �� ���� ���� ����� ��� ������� �����.
	Info_AddChoice(DIA_Sylvio_WASISTPASSIERT,"��� ���� ������ � ���� ������� ������?",DIA_Sylvio_WASISTPASSIERT_Eisregion);
};

func void DIA_Sylvio_WASISTPASSIERT_keinInteresse()
{
	AI_Output(other,self,"DIA_Sylvio_WASISTPASSIERT_keinInteresse_NEIN_15_00");	//� �� ����� � ���� ����.
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_keinInteresse_NEIN_09_01");	//��-�. ����� �������� ������, ����.
	AI_StopProcessInfos(self);
};

func void DIA_Sylvio_WASISTPASSIERT_Eisregion()
{
	AI_Output(other,self,"DIA_Sylvio_WASISTPASSIERT_keinInteresse_15_00");	//��� ���� ������ � ���� ������� ������?
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_keinInteresse_09_01");	//�� �����-������ ����������� �������� �������, �? ������, � ����� ����.
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_keinInteresse_09_02");	//���, �� ����� �������, ��������� ������� ������. �� ����� ������� ������ �� �����.
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_keinInteresse_09_03");	//��� ���������� ������� ������ ������ �� ����� �����.
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_keinInteresse_09_04");	//��� ����� ���. ��� ���? �� ��� ���?
};

func void DIA_Sylvio_WASISTPASSIERT_ok()
{
	AI_Output(other,self,"DIA_Sylvio_WASISTPASSIERT_ok_15_00");	//������. ������ �� � ���?
	AI_Output(self,other,"DIA_Sylvio_WASISTPASSIERT_ok_09_01");	//����� ����������. � �� ���� ����� �����.
	AI_StopProcessInfos(self);
};


instance DIA_Sylvio_ICEGOLEMSKILLED(C_Info)
{
	npc = DJG_700_Sylvio;
	nr = 9;
	condition = DIA_Sylvio_ICEGOLEMSKILLED_Condition;
	information = DIA_Sylvio_ICEGOLEMSKILLED_Info;
	description = "���� ���� ����! ������� �������� ������ ���.";
};


func int DIA_Sylvio_ICEGOLEMSKILLED_Condition()
{
	if(Npc_IsDead(IceGolem_Sylvio1) && Npc_IsDead(IceGolem_Sylvio2) && (MIS_DJG_Sylvio_KillIceGolem == LOG_Running) && (IceDragon.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Sylvio_ICEGOLEMSKILLED_Info()
{
	AI_Output(other,self,"DIA_Sylvio_ICEGOLEMSKILLED_15_00");	//���� ���� ����! ������� �������� ������ ���.
	AI_Output(self,other,"DIA_Sylvio_ICEGOLEMSKILLED_09_01");	//�������� ������. ���������, ��� ��� � ��� ����.
	if(DJG_Sylvio_PromisedMoney == TRUE)
	{
		AI_Output(other,self,"DIA_Sylvio_ICEGOLEMSKILLED_15_02");	//���������. � ��� ��� ������?
		AI_Output(self,other,"DIA_Sylvio_ICEGOLEMSKILLED_09_03");	//����� ���� �����.
	};
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_Standup(self);
		B_TurnToNpc(self,other);
	};
	AI_StopProcessInfos(self);
	MIS_DJG_Sylvio_KillIceGolem = LOG_SUCCESS;
	B_GivePlayerXP(XP_SylvioDJGIceGolemDead);
	Npc_ExchangeRoutine(self,"IceWait1");
	if(!Npc_IsDead(DJG_Bullco))
	{
		if(C_BodyStateContains(DJG_Bullco,BS_SIT))
		{
			AI_Standup(DJG_Bullco);
		};
		B_StartOtherRoutine(DJG_Bullco,"IceWait1");
	};
};


instance DIA_Sylvio_WASJETZT(C_Info)
{
	npc = DJG_700_Sylvio;
	nr = 10;
	condition = DIA_Sylvio_WASJETZT_Condition;
	information = DIA_Sylvio_WASJETZT_Info;
	description = "��� ���?";
};


func int DIA_Sylvio_WASJETZT_Condition()
{
	if(IceDragon.aivar[AIV_TalkedToPlayer] == FALSE)
	{
		if(MIS_DJG_Sylvio_KillIceGolem == LOG_SUCCESS)
		{
			return TRUE;
		}
		else if((SylvioIceGolemsKilledBefore4Chapter == TRUE) && Npc_KnowsInfo(other,DIA_Sylvio_VERSAGER))
		{
			return TRUE;
		};
	};
};

func void DIA_Sylvio_WASJETZT_Info()
{
	AI_Output(other,self,"DIA_Sylvio_WASJETZT_15_00");	//��� ���?
	AI_Output(self,other,"DIA_Sylvio_WASJETZT_09_01");	//��-�... ��� ���-�� ���������� ��� �� ����� ��������.
	AI_Output(self,other,"DIA_Sylvio_WASJETZT_09_02");	//����� ����� �����, ���� �� ������� ������, � � ����� �� �����.
	Info_AddChoice(DIA_Sylvio_WASJETZT,"������ �������...",DIA_Sylvio_WASJETZT_ok);
	Info_AddChoice(DIA_Sylvio_WASJETZT,"�� �������?",DIA_Sylvio_WASJETZT_trennen);
	Info_AddChoice(DIA_Sylvio_WASJETZT,"� �� ��������� ������ ��� ������� ������ �� ����.",DIA_Sylvio_WASJETZT_nein);
	if(DJG_Sylvio_PromisedMoney == TRUE)
	{
		Info_AddChoice(DIA_Sylvio_WASJETZT,"������� � ���� ������� ���� ������.",DIA_Sylvio_WASJETZT_Geld);
	};
};

func void DIA_Sylvio_WASJETZT_trennen()
{
	AI_Output(other,self,"DIA_Sylvio_WASJETZT_trennen_15_00");	//�� �������?
	AI_Output(self,other,"DIA_Sylvio_WASJETZT_trennen_09_01");	//����, ������ �������. ��� ������.
};

func void DIA_Sylvio_WASJETZT_ok()
{
	DIA_Common_SoundsGood();
	AI_Output(self,other,"DIA_Sylvio_WASJETZT_ok_09_01");	//�����, �������!
	AI_StopProcessInfos(self);
};

func void DIA_Sylvio_WASJETZT_nein()
{
	AI_Output(other,self,"DIA_Sylvio_WASJETZT_nein_15_00");	//� �� ��������� ������ ��� ������� ������ �� ����.
	AI_Output(self,other,"DIA_Sylvio_WASJETZT_nein_09_01");	//����!
	AI_StopProcessInfos(self);
};

func void DIA_Sylvio_WASJETZT_Geld()
{
	AI_Output(other,self,"DIA_Sylvio_WASJETZT_Geld_15_00");	//������� � ���� ������� ���� ������.
	AI_Output(self,other,"DIA_Sylvio_WASJETZT_Geld_09_01");	//����� �� ������� �������, � ���� ����� ������� �����, ��� �� ������� ������.
	Info_AddChoice(DIA_Sylvio_WASJETZT,"� ���� �������� ���� ������ ������.",DIA_Sylvio_WASJETZT_jetztGeld);
};

func void DIA_Sylvio_WASJETZT_jetztGeld()
{
	AI_Output(other,self,"DIA_Sylvio_WASJETZT_jetztGeld_15_00");	//� ���� �������� ���� ������ ������.
	AI_Output(self,other,"DIA_Sylvio_WASJETZT_jetztGeld_09_01");	//���� �� ������� ������� ����, ���� ��� �������� ����������� � �����.
};


instance DIA_Sylvio_KOMMSTDU(C_Info)
{
	npc = DJG_700_Sylvio;
	nr = 11;
	condition = DIA_Sylvio_KOMMSTDU_Condition;
	information = DIA_Sylvio_KOMMSTDU_Info;
	permanent = TRUE;
	description = "� �����, �� ������������� � ������� �����.";
};


func int DIA_Sylvio_KOMMSTDU_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Sylvio_WASJETZT) && (IceDragon.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Sylvio_KOMMSTDU_Info()
{
	AI_Output(other,self,"DIA_Sylvio_KOMMSTDU_15_00");	//� �����, �� ������������� � ������� �����.
	AI_Output(self,other,"DIA_Sylvio_KOMMSTDU_09_01");	//��� ������. � � ����� �����.
	AI_StopProcessInfos(self);
};


instance DIA_Sylvio_DUHIER(C_Info)
{
	npc = DJG_700_Sylvio;
	nr = 11;
	condition = DIA_Sylvio_DUHIER_Condition;
	information = DIA_Sylvio_DUHIER_Info;
	permanent = TRUE;
	description = "��� �� �������� �� ���� ������.";
};


func int DIA_Sylvio_DUHIER_Condition()
{
	if(!Npc_IsDead(IceDragon) && (IceDragon.aivar[AIV_TalkedToPlayer] == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Sylvio_DUHIER_Info()
{
	DIA_Common_INeedYourHelp();
	AI_Output(self,other,"DIA_Sylvio_DUHIER_09_01");	//����. �� � ��� ����������� ������������.
	AI_StopProcessInfos(self);
};


instance DIA_SylvioDJG_WHATNEXT(C_Info)
{
	npc = DJG_700_Sylvio;
	nr = 12;
	condition = DIA_SylvioDJG_WHATNEXT_Condition;
	information = DIA_SylvioDJG_WHATNEXT_Info;
	important = TRUE;
};


func int DIA_SylvioDJG_WHATNEXT_Condition()
{
	if(Npc_IsDead(IceDragon))
	{
		return TRUE;
	};
};

func void DIA_SylvioDJG_WHATNEXT_Info()
{
	AI_Output(self,other,"DIA_SylvioDJG_WHATNEXT_09_00");	//������� ������ �����! � ������ �� ������ ��� ���, ��� � ���� ����!
	AI_Output(other,self,"DIA_SylvioDJG_WHATNEXT_15_01");	//�� �� ���!
	AI_Output(self,other,"DIA_SylvioDJG_WHATNEXT_09_02");	//��� � ������ ��� ����� �� �������� �������� �������.
	AI_Output(self,other,"DIA_SylvioDJG_WHATNEXT_09_03");	//� ���� ��������� ���� � ���� ���� ��������!
	TOPIC_END_SylvioKillIceGolem = TRUE;
	B_GivePlayerXP(XP_AmbientKap4);
	Info_ClearChoices(DIA_SylvioDJG_WHATNEXT);
	Info_AddChoice(DIA_SylvioDJG_WHATNEXT,Dialog_Ende,DIA_SylvioDJG_WHATNEXT_ATTACK);
};

func void DIA_SylvioDJG_WHATNEXT_ATTACK()
{
	AI_StopProcessInfos(self);
	Npc_SetRefuseTalk(self,60);
	Npc_ExchangeRoutine(self,"Start");
	B_StartOtherRoutine(DJG_Bullco,"Start");
	B_LogEntry(TOPIC_Dragonhunter,"��� ������� ������ ������� ��������� ��������� ���� ��� ������ ��� ������� ��������. �� ������� ����������.");
	B_Attack(self,other,AR_KILL,1);
	B_Attack(DJG_Bullco,other,AR_NONE,1);
	if(Biff.aivar[AIV_PARTYMEMBER] == TRUE)
	{
//		B_Attack(Biff,DJG_Sylvio,AR_KILL,1);
		B_Attack(Biff,DJG_Bullco,AR_GuardStopsFight,1);
	};
};


instance DIA_SylvioDJG_BUTNOW(C_Info)
{
	npc = DJG_700_Sylvio;
	nr = 13;
	condition = DIA_SylvioDJG_BUTNOW_Condition;
	information = DIA_SylvioDJG_BUTNOW_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_SylvioDJG_BUTNOW_Condition()
{
	if(Npc_IsDead(IceDragon) && !Npc_RefuseTalk(self) && Npc_KnowsInfo(other,DIA_SylvioDJG_WHATNEXT))
	{
		return TRUE;
	};
};

func void DIA_SylvioDJG_BUTNOW_Info()
{
	AI_Output(self,other,"DIA_SylvioDJG_BUTNOW_09_00");	//������ ����� ��������.
	AI_StopProcessInfos(self);
	Npc_SetRefuseTalk(self,60);
	B_Attack(self,other,AR_KILL,1);
	B_Attack(DJG_Bullco,other,AR_NONE,1);
	if(Biff.aivar[AIV_PARTYMEMBER] == TRUE)
	{
//		B_Attack(Biff,DJG_Sylvio,AR_KILL,1);
		B_Attack(Biff,DJG_Bullco,AR_GuardStopsFight,1);
	};
};


instance DIA_Sylvio_PICKPOCKET(C_Info)
{
	npc = DJG_700_Sylvio;
	nr = 900;
	condition = DIA_Sylvio_PICKPOCKET_Condition;
	information = DIA_Sylvio_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Sylvio_PICKPOCKET_Condition()
{
	return C_Beklauen(78,560);
};

func void DIA_Sylvio_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Sylvio_PICKPOCKET);
	Info_AddChoice(DIA_Sylvio_PICKPOCKET,Dialog_Back,DIA_Sylvio_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Sylvio_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Sylvio_PICKPOCKET_DoIt);
};

func void DIA_Sylvio_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Sylvio_PICKPOCKET);
};

func void DIA_Sylvio_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Sylvio_PICKPOCKET);
};

