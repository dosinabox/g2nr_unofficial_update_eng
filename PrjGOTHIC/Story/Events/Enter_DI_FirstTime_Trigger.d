
var int EnterDI_Kapitel6;

func void enter_di_firsttime_trigger()
{
	if(EnterDI_Kapitel6 == FALSE)
	{
		if(hero.attribute[ATR_DEXTERITY] <= (Condition_Weidenbogen - DEX_Elixier))
		{
			Wld_InsertItem(ItPo_Perm_DEX,"FP_ITEM_DI_ENTER_05");
		};
		if(hero.guild == GIL_PAL)
		{
			CreateInvItems(Archol,ItRu_PalDestroyEvil,1);
		};
		Wld_InsertItem(ItMi_Flask,"FP_ITEM_SHIP_12");
		if(!Npc_HasItems(hero,ItMi_InnosEye_MIS))
		{
			if(!Npc_HasItems(hero,ItMi_InnosEye_Discharged_Mis))
			{
				Wld_InsertItem(ItSe_XardasNotfallBeutel_MIS,"FP_ITEM_SHIP_12");
				SC_InnosEyeVergessen_DI = TRUE;
				B_LogEntry(TOPIC_HallenVonIrdorath,"Last night I had a dream. Xardas was talking to me, he asked me to go to the alchemist's bench on the ship to collect something there. This was very strange, but I actually hadn't drunk anything last night.");
			};
			Wld_InsertItem(ItMi_Flask,"FP_ITEM_SHIP_06");
			if(!Npc_HasItems(hero,ItAt_IcedragonHeart) && !Npc_HasItems(hero,ItAt_RockdragonHeart) && !Npc_HasItems(hero,ItAt_FiredragonHeart) && !Npc_HasItems(hero,ItAt_SwampdragonHeart))
			{
				CreateInvItems(AntiPaladin_DI,ItAt_RockdragonHeart,1);
			};
		};
		if(PedroGotLostInnosStatue == TRUE)
		{
			CreateInvItems(AntiPaladin_DI,ItMi_LostInnosStatue_Daron,1);
		};
		Log_CreateTopic(TOPIC_MyCrew,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_MyCrew,LOG_Running);
		if(JorgenIsCaptain == TRUE)
		{
			Log_AddEntry(TOPIC_MyCrew,"Jorgen, my captain, will wait here on the ship until I get back.");
		};
		if(TorlofIsCaptain == TRUE)
		{
			Log_AddEntry(TOPIC_MyCrew,"Torlof, my captain, will remain here on the ship to defend it as long as I am on the island. With him I can improve my dexterity and strength.");
		};
		if(JackIsCaptain == TRUE)
		{
			Log_AddEntry(TOPIC_MyCrew,"Jack, my captain, will wait here on the ship until I get back. He seems a little bit scared. I hope he'll calm down in time. I need him.");
		};
		if(Lee_IsOnBoard == LOG_SUCCESS)
		{
			Log_AddEntry(TOPIC_MyCrew,"Lee will take command of the ship during my absence. With his help I can improve my abilities with one and two-handed-weapons.");
		};
		if(MiltenNW_IsOnBoard == LOG_SUCCESS)
		{
			if(hero.guild == GIL_KDF)
			{
				Log_AddEntry(TOPIC_MyCrew,"With Milten I can increase my mana and learn new magic formulas.");
			}
			else
			{
				Log_AddEntry(TOPIC_MyCrew,"Milten can help increase my mana..");
			};
		};
		if(Lester_IsOnBoard == LOG_SUCCESS)
		{
			Log_AddEntry (TOPIC_MyCrew, "I get the impression Lester's state has gotten even worse on the strange island.");
		};
		if(Mario_IsOnBoard == LOG_SUCCESS)
		{
			Log_AddEntry (TOPIC_MyCrew, "Mario is a little bit strange. He just sat in the stern throughout the crossing and hasn't said a word since.");
		};
		if(Wolf_IsOnBoard == LOG_SUCCESS)
		{
			Log_AddEntry (TOPIC_MyCrew, "Wolf can teach me to shoot the crossbow and bow.");
		};
		if(Vatras_IsOnBoard == LOG_SUCCESS)
		{
			if(hero.guild == GIL_KDF)
			{
				Log_AddEntry(TOPIC_MyCrew,"Vatras has retired into the Magicians' cabin. He can heal me and teach me a lot about brewing potions. He can increase my Magic Circle as well.");
			}
			else
			{
				Log_AddEntry(TOPIC_MyCrew,"Vatras has retired into the Magicians' cabin. He can heal me and teach me a lot about brewing potions");
			};
		};
		if(Bennet_IsOnBoard == LOG_SUCCESS)
		{
			Log_AddEntry (TOPIC_MyCrew, "Bennet will teach me to forge if I want him to.");
		};
		if(Diego_IsOnBoard == LOG_SUCCESS)
		{
			Log_AddEntry (TOPIC_MyCrew, "Diego will help me on if I don't know what to do, and he's got ammunition for me. From him I can learn how to pick locks or to shoot bows or crossbows.");
		};
		if(Gorn_IsOnBoard == LOG_SUCCESS)
		{
			Log_AddEntry(TOPIC_MyCrew,"Gorn has not slept on our trip at all. He will look after the ship. I think it will be in good hands with him. He can also help me improve my abilities with two-handed weapons.");
		};
		if(Lares_IsOnBoard == LOG_SUCCESS)
		{
			Log_AddEntry (TOPIC_MyCrew, "Lares has promised to teach me sneaking and one-handed combat. Apart from that he can improve my dexterity.");
		};
		if(Biff_IsOnBoard == LOG_SUCCESS)
		{
			Log_AddEntry (TOPIC_MyCrew, "Biff is so keen on money that it hurts. It will be hard to control him.");
		};
		if(Angar_IsOnBoard == LOG_SUCCESS)
		{
			Log_AddEntry (TOPIC_MyCrew, "Angar appears very restless. I get the impression that it won't be much longer before he goes to battle on his own.");
		};
		if(Girion_IsOnBoard == LOG_SUCCESS)
		{
			Log_AddEntry (TOPIC_MyCrew, "Girion is holding back a lot. His patience is admirable. And he's a fighting instructor. That might benefit me in the end.");
		};
		IntroduceChapter(KapWechsel_6,KapWechsel_6_Text,"chapter6.tga","chapter_01.wav",6000);
		EnterDI_Kapitel6 = TRUE;
	};
};

