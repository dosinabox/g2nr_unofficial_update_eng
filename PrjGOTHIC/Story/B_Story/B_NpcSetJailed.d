
func void B_UnequipWeapons(var C_Npc slf)
{
	var C_Item Weapon;
	if(Npc_HasEquippedMeleeWeapon(slf))
	{
		Weapon = Npc_GetEquippedMeleeWeapon(slf);
		Npc_RemoveInvItem(slf,Hlp_GetInstanceID(Weapon));
//		CreateInvItem(slf,Hlp_GetInstanceID(Weapon));
	};
	if(Npc_HasEquippedRangedWeapon(slf))
	{
		Weapon = Npc_GetEquippedRangedWeapon(slf);
		Npc_RemoveInvItem(slf,Hlp_GetInstanceID(Weapon));
//		CreateInvItem(slf,Hlp_GetInstanceID(Weapon));
	};
};

func void B_NpcSetJailed(var C_Npc slf)
{
	B_UnequipWeapons(slf);
	Npc_RemoveInvItems(slf,ItMi_Joint,Npc_HasItems(slf,ItMi_Joint));
	slf.attribute[ATR_STRENGTH] = Condition_VLKDolch - 1;		//���� �� ����� ������������ ���� ������
	slf.attribute[ATR_DEXTERITY] = Condition_Kurzbogen - 1;		//������� �� ����� ������������ ���� �������� ���
	if((slf.guild == GIL_KDF) || (slf.guild == GIL_KDW) || (slf.guild == GIL_PAL) || (slf.aivar[AIV_MagicUser] == MAGIC_ALWAYS))
	{
		if(Npc_IsDrawingSpell(slf))
		{
			AI_UnreadySpell(slf);
		};
		slf.attribute[ATR_MANA] = Spl_Cost_Scroll - 1;		//��� �� ����� ������������ ���� ������
		slf.attribute[ATR_MANA_MAX] = Spl_Cost_Scroll - 1;
	};
	slf.aivar[AIV_IGNORE_Murder] = TRUE;	//������������� ������������ ������
	slf.aivar[AIV_IGNORE_Theft] = TRUE;
	slf.aivar[AIV_IGNORE_Sheepkiller] = TRUE;
	slf.aivar[AIV_CommentedPlayerCrime] = FALSE;
};

func void B_NpcSetReleased(var C_Npc slf)
{
	if(slf.attribute[ATR_STRENGTH] != slf.aivar[REAL_STRENGTH])
	{
		slf.attribute[ATR_STRENGTH] = slf.aivar[REAL_STRENGTH];		//�������������� ���� � �����
	};
	if(slf.attribute[ATR_DEXTERITY] != slf.aivar[REAL_DEXTERITY])
	{
		slf.attribute[ATR_DEXTERITY] = slf.aivar[REAL_DEXTERITY];	//�������������� �������� � �������
	};
	if(((slf.guild == GIL_KDF) || (slf.guild == GIL_KDW) || (slf.guild == GIL_PAL) || (slf.aivar[AIV_MagicUser] == MAGIC_ALWAYS)) && (slf.attribute[ATR_MANA_MAX] != slf.aivar[REAL_MANA_MAX]))
	{
		slf.attribute[ATR_MANA_MAX] = slf.aivar[REAL_MANA_MAX];		//�������������� ���� � ����
		slf.attribute[ATR_MANA] = slf.attribute[ATR_MANA_MAX];
	};
	slf.aivar[AIV_CommentedPlayerCrime] = FALSE;
	AI_EquipBestMeleeWeapon(slf);
	AI_EquipBestRangedWeapon(slf);
};

