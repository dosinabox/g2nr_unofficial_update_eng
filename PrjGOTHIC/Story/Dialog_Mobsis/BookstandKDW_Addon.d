
func void Use_Runemaking_KDW_CIRC1_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Blue_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Blue_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"����� ����");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"���� ���� � ����������� ��� �� ��������.");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"�����:");
		Doc_PrintLine(nDocID,0,"- ������ �������� ����");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"������� �����:");
		Doc_PrintLine(nDocID,0,"- ������� �����");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"������:");
		Doc_PrintLine(nDocID,0,"- ���������");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"����:");
		Doc_PrintLine(nDocID,0,"- ������� �����");
		Doc_PrintLine(nDocID,0,"- ������ �������� ����");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"����� ����:");
		Doc_PrintLine(nDocID,0,"- ���������");
		Doc_PrintLine(nDocID,0,"- ������ ��������");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes2);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,PRINT_BookstandRunes3);
		Doc_Show(nDocID);
		SC_KnowsBlankRuneForFirebolt = TRUE;
	};
};

func void Use_Runemaking_KDW_CIRC2_S1()
{
	Use_Runemaking_KDW_CIRC1_S1();
};

func void Use_Runemaking_KDW_CIRC3_S1()
{
	Use_Runemaking_KDW_CIRC1_S1();
};

func void Use_Runemaking_KDW_CIRC4_S1()
{
	Use_Runemaking_KDW_CIRC1_S1();
};

func void Use_Runemaking_KDW_CIRC5_S1()
{
	Use_Runemaking_KDW_CIRC1_S1();
};

func void Use_Runemaking_KDW_CIRC6_S1()
{
	Use_Runemaking_KDW_CIRC1_S1();
};

