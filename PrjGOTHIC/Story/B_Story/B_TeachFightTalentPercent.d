
/*func int B_TeachFightTalentPercent(var C_Npc slf,var C_Npc oth,var int talent,var int percent,var int teacherMAX)
{
	var string concatText;
	var int kosten;
	var int realHitChance;
	kosten = B_GetLearnCostTalent(oth,talent,1) * percent;
	if((talent != NPC_TALENT_1H) && (talent != NPC_TALENT_2H) && (talent != NPC_TALENT_BOW) && (talent != NPC_TALENT_CROSSBOW))
	{
		Print(PRINT_WrongParameter);
		return FALSE;
	};
	if(talent == NPC_TALENT_1H)
	{
		if(oth.HitChance[NPC_TALENT_1H] >= 100)
		{
			PrintScreen(PRINT_NoLearnOverMAX,-1,-1,FONT_Screen,2);
			B_Say(slf,oth,"$NOLEARNYOUREBETTER");
			return FALSE;
		};
		realHitChance = oth.HitChance[NPC_TALENT_1H];
//		realHitChance = oth.aivar[REAL_TALENT_1H] - Keule1HCurrentPenalty;
	}
	else if(talent == NPC_TALENT_2H)
	{
		if(oth.HitChance[NPC_TALENT_2H] >= 100)
		{
			PrintScreen(PRINT_NoLearnOverMAX,-1,-1,FONT_Screen,2);
			B_Say(slf,oth,"$NOLEARNYOUREBETTER");
			return FALSE;
		};
		realHitChance = oth.HitChance[NPC_TALENT_2H];
//		realHitChance = oth.aivar[REAL_TALENT_2H] - Keule2HCurrentPenalty;
	}
	else if(talent == NPC_TALENT_BOW)
	{
		if(oth.HitChance[NPC_TALENT_BOW] >= 100)
		{
			PrintScreen(PRINT_NoLearnOverMAX,-1,-1,FONT_Screen,2);
			B_Say(slf,oth,"$NOLEARNYOUREBETTER");
			return FALSE;
		};
		realHitChance = oth.HitChance[NPC_TALENT_BOW];
//		realHitChance = oth.aivar[REAL_TALENT_BOW];
	}
	else if(talent == NPC_TALENT_CROSSBOW)
	{
		if(oth.HitChance[NPC_TALENT_CROSSBOW] >= 100)
		{
			PrintScreen(PRINT_NoLearnOverMAX,-1,-1,FONT_Screen,2);
			B_Say(slf,oth,"$NOLEARNYOUREBETTER");
			return FALSE;
		};
		realHitChance = oth.HitChance[NPC_TALENT_CROSSBOW];
//		realHitChance = oth.aivar[REAL_TALENT_CROSSBOW];
	};
	if(realHitChance > teacherMAX)
	{
		concatText = ConcatStrings(PRINT_NoLearnOverPersonalMAX,IntToString(teacherMAX));
		PrintScreen(concatText,-1,-1,FONT_Screen,2);
		B_Say(slf,oth,"$YOULEARNEDSOMETHING");
		return FALSE;
	};
	if(realHitChance == teacherMAX)
	{
		concatText = ConcatStrings(PRINT_NoLearnOverPersonalMAX,IntToString(teacherMAX));
		PrintScreen(concatText,-1,-1,FONT_Screen,2);
		B_Say(slf,oth,"$NOLEARNYOUREBETTER");
		return FALSE;
	};
	if((realHitChance + percent) > teacherMAX)
	{
		concatText = ConcatStrings(PRINT_NoLearnOverPersonalMAX,IntToString(teacherMAX));
		PrintScreen(concatText,-1,-1,FONT_Screen,2);
		B_Say(slf,oth,"$NOLEARNOVERPERSONALMAX");
		return FALSE;
	};
	if(oth.lp < kosten)
	{
		PrintScreen(PRINT_NotEnoughLP,-1,-1,FONT_Screen,2);
		B_Say(slf,oth,"$NOLEARNNOPOINTS");
		return FALSE;
	};
	oth.lp -= kosten;
	if(IgnoreBonuses == TRUE)
	{
		if(talent == NPC_TALENT_1H)
		{
			B_RaiseFightTalent(oth,NPC_TALENT_1H,percent);
			B_RaiseRealFightTalentPercent(oth,NPC_TALENT_1H,percent);
			if(oth.aivar[REAL_TALENT_1H] >= (oth.aivar[REAL_TALENT_2H] + 30))
			{
				B_RaiseFightTalent(oth,NPC_TALENT_2H,percent);
				B_RaiseRealFightTalentPercent(oth,NPC_TALENT_2H,percent);
				PrintScreen(PRINT_Learn1H_and_2H,-1,-1,FONT_Screen,2);
			}
			else
			{
				PrintScreen(PRINT_Learn1H,-1,-1,FONT_Screen,2);
			};
			return TRUE;
		};
		if(talent == NPC_TALENT_2H)
		{
			B_RaiseFightTalent(oth,NPC_TALENT_2H,percent);
			B_RaiseRealFightTalentPercent(oth,NPC_TALENT_2H,percent);
			if(oth.aivar[REAL_TALENT_2H] >= (oth.aivar[REAL_TALENT_1H] + 30))
			{
				B_RaiseFightTalent(oth,NPC_TALENT_1H,percent);
				B_RaiseRealFightTalentPercent(oth,NPC_TALENT_1H,percent);
				PrintScreen(PRINT_Learn2H_and_1H,-1,-1,FONT_Screen,2);
			}
			else
			{
				PrintScreen(PRINT_Learn2H,-1,-1,FONT_Screen,2);
			};
			return TRUE;
		};
		if(talent == NPC_TALENT_BOW)
		{
			B_RaiseFightTalent(oth,NPC_TALENT_BOW,percent);
			B_RaiseRealFightTalentPercent(oth,NPC_TALENT_BOW,percent);
			if(oth.aivar[REAL_TALENT_BOW] >= (oth.aivar[REAL_TALENT_CROSSBOW] + 30))
			{
				B_RaiseFightTalent(oth,NPC_TALENT_CROSSBOW,percent);
				B_RaiseRealFightTalentPercent(oth,NPC_TALENT_CROSSBOW,percent);
				PrintScreen(PRINT_LearnBow_and_Crossbow,-1,-1,FONT_Screen,2);
			}
			else
			{
				PrintScreen(PRINT_LearnBow,-1,-1,FONT_Screen,2);
			};
			return TRUE;
		};
		if(talent == NPC_TALENT_CROSSBOW)
		{
			B_RaiseFightTalent(oth,NPC_TALENT_CROSSBOW,percent);
			B_RaiseRealFightTalentPercent(oth,NPC_TALENT_CROSSBOW,percent);
			if(oth.aivar[REAL_TALENT_CROSSBOW] >= (oth.aivar[REAL_TALENT_BOW] + 30))
			{
				B_RaiseFightTalent(oth,NPC_TALENT_BOW,percent);
				B_RaiseRealFightTalentPercent(oth,NPC_TALENT_BOW,percent);
				PrintScreen(PRINT_LearnCrossbow_and_Bow,-1,-1,FONT_Screen,2);
			}
			else
			{
				PrintScreen(PRINT_LearnCrossbow,-1,-1,FONT_Screen,2);
			};
			return TRUE;
		};
	}
	else
	{
		if(talent == NPC_TALENT_1H)
		{
			B_RaiseFightTalent(oth,NPC_TALENT_1H,percent);
			if(oth.aivar[REAL_TALENT_1H] >= (oth.aivar[REAL_TALENT_2H] + 30))
			{
				B_RaiseFightTalent(oth,NPC_TALENT_2H,percent);
				PrintScreen(PRINT_Learn1H_and_2H,-1,-1,FONT_Screen,2);
			}
			else
			{
				PrintScreen(PRINT_Learn1H,-1,-1,FONT_Screen,2);
			};
			return TRUE;
		};
		if(talent == NPC_TALENT_2H)
		{
			B_RaiseFightTalent(oth,NPC_TALENT_2H,percent);
			if(oth.aivar[REAL_TALENT_2H] >= (oth.aivar[REAL_TALENT_1H] + 30))
			{
				B_RaiseFightTalent(oth,NPC_TALENT_1H,percent);
				PrintScreen(PRINT_Learn2H_and_1H,-1,-1,FONT_Screen,2);
			}
			else
			{
				PrintScreen(PRINT_Learn2H,-1,-1,FONT_Screen,2);
			};
			return TRUE;
		};
		if(talent == NPC_TALENT_BOW)
		{
			B_RaiseFightTalent(oth,NPC_TALENT_BOW,percent);
			if(oth.aivar[REAL_TALENT_BOW] >= (oth.aivar[REAL_TALENT_CROSSBOW] + 30))
			{
				B_RaiseFightTalent(oth,NPC_TALENT_CROSSBOW,percent);
				PrintScreen(PRINT_LearnBow_and_Crossbow,-1,-1,FONT_Screen,2);
			}
			else
			{
				PrintScreen(PRINT_LearnBow,-1,-1,FONT_Screen,2);
			};
			return TRUE;
		};
		if(talent == NPC_TALENT_CROSSBOW)
		{
			B_RaiseFightTalent(oth,NPC_TALENT_CROSSBOW,percent);
			if(oth.aivar[REAL_TALENT_CROSSBOW] >= (oth.aivar[REAL_TALENT_BOW] + 30))
			{
				B_RaiseFightTalent(oth,NPC_TALENT_BOW,percent);
				PrintScreen(PRINT_LearnCrossbow_and_Bow,-1,-1,FONT_Screen,2);
			}
			else
			{
				PrintScreen(PRINT_LearnCrossbow,-1,-1,FONT_Screen,2);
			};
			return TRUE;
		};
	};
	return FALSE;
};*/

func int B_TeachFightTalentPercent(var C_Npc slf,var C_Npc oth,var int talent,var int percent,var int teacherMAX)
{
	var string concatText;
	var int cost;
	var int limitReason;
	limitReason = B_GetTeachLimitReason(oth,talent,percent,teacherMax);
	if(limitReason == TLR_AlreadyMax)
	{
		B_PrintPlayerMiddle(oth,PRINT_NoLearnOverMAX);
		B_Say(slf,oth,"$NOLEARNYOUREBETTER");
		return FALSE;
	}
	else if(limitReason == TLR_WillBeOverMax)
	{
		B_PrintPlayerMiddle(oth,PRINT_NoLearnOverMAX);
		B_Say(slf,oth,"$NOLEARNYOUREBETTER");
		return FALSE;
	}
	else if(limitReason == TLR_AlreadySame)
	{
		concatText = ConcatStrings(PRINT_NoLearnOverPersonalMAX,IntToString(teacherMAX));
		B_PrintPlayerMiddle(oth,concatText);
		B_Say(slf,oth,"$NOLEARNYOUREBETTER");
		return FALSE;
	}
	else if(limitReason == TLR_AlreadyBetter)
	{
		concatText = ConcatStrings(PRINT_NoLearnOverPersonalMAX,IntToString(teacherMAX));
		B_PrintPlayerMiddle(oth,concatText);
		B_Say(slf,oth,"$YOULEARNEDSOMETHING");
		return FALSE;
	}
	else if(limitReason == TLR_WillBeBetter)
	{
		concatText = ConcatStrings(PRINT_NoLearnOverPersonalMAX,IntToString(teacherMAX));
		B_PrintPlayerMiddle(oth,concatText);
		B_Say(slf,oth,"$NOLEARNOVERPERSONALMAX");
		return FALSE;
	};
	cost = B_GetTalentTrainCost(oth,talent,percent);
	if(oth.lp < cost)
	{
		B_PrintPlayerMiddle(oth,PRINT_NotEnoughLP);
		B_Say(slf,oth,"$NOLEARNNOPOINTS");
		return FALSE;
	};
	B_ChangeTalent(oth,talent,percent,TS_Training);
	oth.lp -= cost;
	if(SecondaryChange > 0)
	{
		if(talent == NPC_TALENT_1H)
		{
			concatText = PRINT_Learn1H_and_2H;
		}
		else if(talent == NPC_TALENT_2H)
		{
			concatText = PRINT_Learn2H_and_1H;
		}
		else if(talent == NPC_TALENT_BOW)
		{
			concatText = PRINT_LearnBow_and_Crossbow;
		}
		else if(talent == NPC_TALENT_CROSSBOW)
		{
			concatText = PRINT_LearnCrossbow_and_Bow;
		};
	}
	else
	{
		if(talent == NPC_TALENT_1H)
		{
			concatText = PRINT_Learn1H;
		}
		else if(talent == NPC_TALENT_2H)
		{
			concatText = PRINT_Learn2H;
		}
		else if(talent == NPC_TALENT_BOW)
		{
			concatText = PRINT_LearnBow;
		}
		else if(talent == NPC_TALENT_CROSSBOW)
		{
			concatText = PRINT_LearnCrossbow;
		};
	};
	B_PrintPlayerMiddle(oth,concatText);
	return TRUE;
};

