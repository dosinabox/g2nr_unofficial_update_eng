
instance DIA_ToughGuy_NEWS(C_Info)
{
	nr = 1;
	condition = DIA_ToughGuy_NEWS_Condition;
	information = DIA_ToughGuy_NEWS_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_ToughGuy_NEWS_Condition()
{
	if(Hlp_GetInstanceID(self) == Hlp_GetInstanceID(BridgeBandit))
	{
		return FALSE;
	}
	else if((Hlp_GetInstanceID(self) == Hlp_GetInstanceID(DJG_Sylvio)) && Npc_KnowsInfo(other,DIA_SylvioDJG_WHATNEXT))
	{
		return FALSE;
	}
	else if((Hlp_GetInstanceID(self) == Hlp_GetInstanceID(DJG_Bullco)) && Npc_IsDead(DJG_Sylvio) && !Npc_KnowsInfo(other,DIA_Bullco_SYLVIODEAD))
	{
		return FALSE;
	}
	else if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_LastFightAgainstPlayer] != FIGHT_NONE) && (self.aivar[AIV_LastFightComment] == FALSE) && (Hlp_GetInstanceID(self) != Hlp_GetInstanceID(Sentenza)))
	{
		return TRUE;
	}
	else if((Hlp_GetInstanceID(self) == Hlp_GetInstanceID(Sentenza)) && Npc_KnowsInfo(other,DIA_Sentenza_Hello) && (self.aivar[AIV_LastFightComment] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_ToughGuy_NEWS_Info()
{
	if(self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST)
	{
		B_Say(self,other,"$TOUGHGUY_ATTACKLOST");
	}
	else if(self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_WON)
	{
		B_Say(self,other,"$TOUGHGUY_ATTACKWON");
	}
	else
	{
		B_Say(self,other,"$TOUGHGUY_PLAYERATTACK");
	};
	self.aivar[AIV_LastFightComment] = TRUE;
	if(Hlp_GetInstanceID(self) == Hlp_GetInstanceID(Skinner))
	{
		AI_Output(self,other,"DIA_Addon_Skinner_ToughguyNews_08_00");	//...�� � �� ���� �������� � �����...
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_NONE,1);
	};
};

func void B_AssignToughGuyNEWS(var C_Npc slf)
{
	DIA_ToughGuy_NEWS.npc = Hlp_GetInstanceID(slf);
};

