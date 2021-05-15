
instance DIA_Dragon_Swamp_Exit(C_Info)
{
	nr = 999;
	condition = DIA_Dragon_Swamp_Exit_Condition;
	information = DIA_Dragon_Swamp_Exit_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Dragon_Swamp_Exit_Condition()
{
	if(DragonTalk_Exit_Free == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Dragon_Swamp_Exit_Info()
{
	AI_Output(self,other,"DIA_Dragon_Swamp_Exit_20_00");	//���� ����� �������. ���� ����� ���������� �����, �������.
	B_EndDragonTalk();
	if(DJG_SwampParty_GoGoGo == TRUE)
	{
		if((DJG_SwampParty == TRUE) && !Npc_IsDead(DJG_Cipher))
		{
			B_StartOtherRoutine(DJG_Rod,"SwampDragon");
		};
		B_StartOtherRoutine(DJG_Cipher,"SwampDragon");
	};
};


instance DIA_Dragon_Swamp_Hello(C_Info)
{
	nr = 5;
	condition = DIA_Dragon_Swamp_Hello_Condition;
	information = DIA_Dragon_Swamp_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Dragon_Swamp_Hello_Condition()
{
	if(Npc_HasItems(other,ItMi_InnosEye_MIS))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Swamp_Hello_Info()
{
	AI_Output(self,other,"DIA_Dragon_Swamp_Hello_20_00");	//���� ����, ���� �� �������� ��� ���� ��� ������!
	if(MIS_KilledDragons == 0)
	{
		AI_Output(other,self,"DIA_Dragon_Swamp_Hello_15_01");	//��. ���� ������, ������, ��������.
	};
	AI_Output(self,other,"DIA_Dragon_Swamp_Hello_20_02");	//������ �� ��� ��������� ����. � ���� �� ����.
	AI_Output(other,self,"DIA_Dragon_Swamp_Hello_15_03");	//������ �������. ���� ������� ����� �� ������ ����, ������� ���������� ������.
	AI_Output(other,self,"DIA_Dragon_Swamp_Hello_15_04");	//����� ��� ��, ��� � ���� �����, ��� � ������ ���� � ����� �� �����.
	AI_Output(self,other,"DIA_Dragon_Swamp_Hello_20_05");	//��-��! �� ������ �������� ���, ������ �����? ������ ���� �� ���� �������, ������ ��� �� ��������� ���� �� ������ ������ ����� ������.
	AI_Output(other,self,"DIA_Dragon_Swamp_Hello_15_06");	//� ��������� ������, � �� ���� ��� ����. � ���� ��� ������. �� ������ ����������� ���� ����, ��� �� ������ ���������.
	AI_Output(self,other,"DIA_Dragon_Swamp_Hello_20_07");	//(�����) ��-�. ������, ��� ���� ����� �� ����.
};


instance DIA_Dragon_Swamp_WERBISTDU(C_Info)
{
	nr = 6;
	condition = DIA_Dragon_Swamp_WERBISTDU_Condition;
	information = DIA_Dragon_Swamp_WERBISTDU_Info;
	description = "��� ��?";
};


func int DIA_Dragon_Swamp_WERBISTDU_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dragon_Swamp_Hello))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Swamp_WERBISTDU_Info()
{
	AI_Output(other,self,"DIA_Dragon_Swamp_WERBISTDU_15_00");	//��� ��?
	AI_Output(self,other,"DIA_Dragon_Swamp_WERBISTDU_20_01");	//���� ����� ���������. � ����� ����� ���� ��������� ������� ������� ��� ������, �� �������� �� ������.
};


instance DIA_Dragon_Swamp_WOSINDDIEANDEREN(C_Info)
{
	nr = 7;
	condition = DIA_Dragon_Swamp_WOSINDDIEANDEREN_Condition;
	information = DIA_Dragon_Swamp_WOSINDDIEANDEREN_Info;
	description = "��� ��� ����� ��������� �� ���, ������������� ��������?";
};


func int DIA_Dragon_Swamp_WOSINDDIEANDEREN_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dragon_Swamp_Hello))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Swamp_WOSINDDIEANDEREN_Info()
{
	AI_Output(other,self,"DIA_Dragon_Swamp_WOSINDDIEANDEREN_15_00");	//��� ��� ����� ��������� �� ���, ������������� ��������?
	AI_Output(self,other,"DIA_Dragon_Swamp_WOSINDDIEANDEREN_20_01");	//������, �� ������� ������� ���, ������������ ����������� ����� ����.
	AI_Output(self,other,"DIA_Dragon_Swamp_WOSINDDIEANDEREN_20_02");	//������ �� ��� �������� �� ���� ����� ����.
	AI_Output(self,other,"DIA_Dragon_Swamp_WOSINDDIEANDEREN_20_03");	//��� ������ � �� ������� ���������.
};

func void B_AssignDragonTalk_Swamp(var C_Npc slf)
{
	DIA_Dragon_Swamp_Exit.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Swamp_Hello.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Swamp_WERBISTDU.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Swamp_WOSINDDIEANDEREN.npc = Hlp_GetInstanceID(slf);
	B_AssignDragonTalk_Main(slf);
};

