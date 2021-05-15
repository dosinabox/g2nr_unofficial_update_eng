
instance DIA_Dragon_Ice_Exit(C_Info)
{
	nr = 999;
	condition = DIA_Dragon_Ice_Exit_Condition;
	information = DIA_Dragon_Ice_Exit_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Dragon_Ice_Exit_Condition()
{
	if(DragonTalk_Exit_Free == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Dragon_Ice_Exit_Info()
{
	AI_Output(self,other,"DIA_Dragon_Ice_Exit_20_00");	//���� ����� ������, � ���� ����� �����.
	B_EndDragonTalk();
	Wld_InsertNpc(Draconian,"FP_ROAM_OW_ICEREGION_29_02");
	Wld_InsertNpc(Draconian,"FP_ROAM_OW_ICEREGION_30_01");
	Wld_InsertNpc(Draconian,"FP_ROAM_OW_BLOODFLY_05_01");
	Wld_InsertNpc(Draconian,"FP_ROAM_OW_BLOODFLY_05_01");
};


instance DIA_Dragon_Ice_Hello(C_Info)
{
	nr = 1;
	condition = DIA_Dragon_Ice_Hello_Condition;
	information = DIA_Dragon_Ice_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Dragon_Ice_Hello_Condition()
{
	if(Npc_HasItems(other,ItMi_InnosEye_MIS))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Ice_Hello_Info()
{
	AI_Output(self,other,"DIA_Dragon_Ice_Hello_20_00");	//����� �� ���������� ��� ���? ��� ���, ���������� ��� ������, ����� ��, ����������� ����, �������, �������� ���� � �����?
	if(MIS_KilledDragons == 0)
	{
		AI_Output(other,self,"DIA_Dragon_Ice_Hello_15_01");	//��������� ������. ������� ����� ������.
	};
	AI_Output(self,other,"DIA_Dragon_Ice_Hello_20_02");	//��, ����, �������� ��������. ���� ���� ��� ���� ����� ������� ����� ������, ������ �������� ���� �� ����, ��� ���������� �� �����, �����, ��� ��� ������� ������������� ����� ������.
	AI_Output(self,other,"DIA_Dragon_Ice_Hello_20_03");	//�� ������ ��� ����� �������. � ����� ����������, ����� ����� �� ��� ������ �� ��������.
	AI_Output(other,self,"DIA_Dragon_Ice_Hello_15_04");	//�������! ����� ���������� �����, ��� �������� ��� �����, � ���������� ���� �������� �� ��� �������.
	AI_Output(self,other,"DIA_Dragon_Ice_Hello_20_05");	//��-��! ����� ���������. �� ���� ������ �� ������� ����.
	if(Npc_IsDead(IceGolem_Sylvio1) && Npc_IsDead(IceGolem_Sylvio2) && !Npc_IsDead(DJG_Sylvio))
	{
		B_StartOtherRoutine(DJG_Sylvio,"IceWait2");
		if(!Npc_IsDead(DJG_Bullco))
		{
			B_StartOtherRoutine(DJG_Bullco,"IceWait2");
		};
	};
};


instance DIA_Dragon_Ice_WERBISTDU(C_Info)
{
	nr = 5;
	condition = DIA_Dragon_Ice_WERBISTDU_Condition;
	information = DIA_Dragon_Ice_WERBISTDU_Info;
	description = "��� ��?";
};


func int DIA_Dragon_Ice_WERBISTDU_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dragon_Ice_Hello))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Ice_WERBISTDU_Info()
{
	AI_Output(other,self,"DIA_Dragon_Ice_WERBISTDU_15_00");	//��� ��?
	AI_Output(self,other,"DIA_Dragon_Ice_WERBISTDU_20_01");	//� �������. ���������� ���� � �����, ����� ��������� � ���� ���������� ������.
};


instance DIA_Dragon_Ice_BELIAR(C_Info)
{
	nr = 6;
	condition = DIA_Dragon_Ice_BELIAR_Condition;
	information = DIA_Dragon_Ice_BELIAR_Info;
	description = "������ ���� �� �������?";
};


func int DIA_Dragon_Ice_BELIAR_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dragon_Ice_Hello))
	{
		return TRUE;
	};
};

func void DIA_Dragon_Ice_BELIAR_Info()
{
	AI_Output(other,self,"DIA_Dragon_Ice_BELIAR_15_00");	//������ ���� �� �������?
	AI_Output(other,self,"DIA_Dragon_Ice_BELIAR_15_01");	//����� ��������� ��� ��� ��������� ����� ���������� ���������, ��� ��, ������ �� ���� �����?
	AI_Output(self,other,"DIA_Dragon_Ice_BELIAR_20_02");	//�� ������� ������ ����� ������ ��������� �����, ������ �����.
	AI_Output(self,other,"DIA_Dragon_Ice_BELIAR_20_03");	//������ �� ������ �������� ��� ��������� ����� - �� �������� ���.
	AI_Output(self,other,"DIA_Dragon_Ice_BELIAR_20_04");	//�������������� ��� ������� �������, �� �� ����� ������, ���� ��� ���� �� ���������� � �����.
};

func void B_AssignDragonTalk_Ice(var C_Npc slf)
{
	DIA_Dragon_Ice_Exit.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Ice_Hello.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Ice_WERBISTDU.npc = Hlp_GetInstanceID(slf);
	DIA_Dragon_Ice_BELIAR.npc = Hlp_GetInstanceID(slf);
	B_AssignDragonTalk_Main(slf);
};

