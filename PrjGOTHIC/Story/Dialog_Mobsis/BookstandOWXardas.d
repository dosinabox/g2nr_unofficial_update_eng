
func void Use_BookstandOWXardas1_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Wood_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Wood_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"����� ������������");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"������������ ������ ���������� ������ �������� ��, ��� ���� ��� ����� ��������� � �����, ������������ �� ����� ����� �������, ���������� ����������� ������ ������. ������� ����� ���� ������������ ���������. ������� ����������� ��� ����� ������������ ���.");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_Show(nDocID);
	};
};

func void Use_BookstandOWXardas2_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Wood_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Wood_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"��������� ����");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"��� �� ����� �� ������� �����. �� �������� ������������ ������ �� ������������ ����, � ������ � ������������ ������� �������, ������� ����������� ������ ��������. ����� ��� ��������� ���� ������, ������������ ��� ��������� ��� ������� �������� �������������, �� ����� ����� � ������ ���, ��������� ������� ��������.");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"��� ����� ���������� ����� ������� ������� � ������������, � ���� ������, ������ ����� ������, �� ������ ���������� ���.");
		Doc_Show(nDocID);
	};
};

