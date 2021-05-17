
var int B_RAVENSESCAPEINTOTEMPELAVI_OneTime;

func void b_ravensescapeintotempelavi()
{
	if(B_RAVENSESCAPEINTOTEMPELAVI_OneTime == FALSE)
	{
		PlayVideoEx("PORTAL_RAVEN.BIK",TRUE,FALSE);
		EnteredBanditsCamp = TRUE;
		RavenIsInTempel = TRUE;
		Log_CreateTopic(TOPIC_Addon_RavenKDW,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_RavenKDW,LOG_Running);
		B_LogEntry(TOPIC_Addon_RavenKDW,"I entered Raven's rooms, only to see him disappear behind a large door. I could not follow him. I assume that the door must lead to the temple of Adanos. I need to report this to Saturas.");
		B_RAVENSESCAPEINTOTEMPELAVI_OneTime = TRUE;
	};
};

