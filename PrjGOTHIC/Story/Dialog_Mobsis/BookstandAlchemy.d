
var int ALchemy_1_permanent;
var int ALchemy_2_permanent;
var int ALchemy_3_permanent;

func void Use_BookstandALCHEMY1_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"����� ���������� ����");
		Doc_PrintLine(nDocID,0,"� �����������");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,NAME_Mana_Essenz);
		Doc_PrintLine(nDocID,0,"2 �������� �������");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,NAME_Mana_Extrakt);
		Doc_PrintLine(nDocID,0,"2 �������� �����");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,NAME_Mana_Elixier);
		Doc_PrintLine(nDocID,0,"2 �������� �����");
		Doc_PrintLine(nDocID,0,"");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"��� ������ �� ������������ ����� ���������� ��������.");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"����� ������� ����� �������� ����� ��� �����, ����������� ���������� ����, ��������� ������ ���������� � ��������:");
		Doc_PrintLine(nDocID,1,"������� �����");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"����� ������� �����, ����������� ������������ ����������� �� ���� ��� ���, ���������� ������������ ��������:");
		Doc_PrintLines(nDocID,1,"������� ������");
		Doc_Show(nDocID);
		if(ALchemy_1_permanent == FALSE)
		{
			B_GivePlayerXP(XP_Bookstand);
			ALchemy_1_permanent = TRUE;
		};
	};
};

func void Use_BookstandALCHEMY2_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"�������� �����");
		Doc_PrintLine(nDocID,0,"� �����������");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,NAME_HP_Essenz);
		Doc_PrintLine(nDocID,0,"2 �������� �����");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,NAME_HP_Extrakt);
		Doc_PrintLine(nDocID,0,"2 �������� ��������");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,NAME_HP_Elixier);
		Doc_PrintLine(nDocID,0,"2 �������� �����");
		Doc_PrintLine(nDocID,0,"");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"��� ������ �� ������������ ����� ���������� ��������.");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"����� ������� ����� �������� ����� ��� �����, ����������� ���������� ����, ��������� ������ ���������� � ��������:");
		Doc_PrintLine(nDocID,1,"������� �����");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"����� ������� �����, ����������� ������������ ����������� �� ���� ��� ���, ���������� ������������ ��������:");
		Doc_PrintLines(nDocID,1,"������� ������");
		Doc_Show(nDocID);
		if(ALchemy_2_permanent == FALSE)
		{
			B_GivePlayerXP(XP_Bookstand);
			ALchemy_2_permanent = TRUE;
		};
	};
};

func void Use_BookstandALCHEMY3_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"����� ������������� �������� � �����������");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,NAME_DEX_Elixier);
		Doc_PrintLine(nDocID,0,"1 ���������� �����");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,NAME_STR_Elixier);
		Doc_PrintLine(nDocID,0,"1 �������� ������");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,NAME_HPMax_Elixier);
		Doc_PrintLine(nDocID,0,"1 �������� ������");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,NAME_ManaMax_Elixier);
		Doc_PrintLine(nDocID,0,"1 �������� ������");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"���������� ���� �������� - ������ ������������ ���������. ��� ��� ������� �������� ������.");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,NAME_Speed_Elixier);
		Doc_PrintLines(nDocID,1,"1 �������-����� - ��� ����� ����� ��������� �� ������� ������, � ������� �����.");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"������ ��� ����� ����������� �����, �������� ������, ��� ��� ���� �� ����� ������� ������.");
		Doc_Show(nDocID);
		if(ALchemy_3_permanent == FALSE)
		{
			B_GivePlayerXP(XP_Bookstand);
			ALchemy_3_permanent = TRUE;
		};
	};
};

