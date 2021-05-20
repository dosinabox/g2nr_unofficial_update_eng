
instance MENU_LEAVE_GAME(C_MENU_DEF)
{
	backpic = MENU_BACK_PIC;
	items[0] = "MENUITEM_LEAVE_GAME_HEADLINE";
	items[1] = "MENUITEM_LEAVE_GAME_YES";
	items[2] = "MENUITEM_LEAVE_GAME_NO";
	defaultoutgame = 2;
	defaultingame = 2;
	flags = flags | MENU_SHOW_INFO;
};

instance MENUITEM_LEAVE_GAME_HEADLINE(C_MENU_ITEM_DEF)
{
	text[0] = "Do you really want to Quit?";
	type = MENU_ITEM_TEXT;
	posx = 0;
	posy = 3000;
	dimx = MENU_MAIN_DX;
	dimy = MENU_MAIN_DY;
	flags = IT_CHROMAKEYED | IT_TRANSPARENT | IT_MOVEABLE | IT_TXT_CENTER;
};

instance MENUITEM_LEAVE_GAME_YES(C_MENU_ITEM_DEF)
{
	backpic = MENU_ITEM_BACK_PIC;
	text[0] = "Yes.";
	text[1] = "Yes, I'll be back!";
	posx = 0;
	posy = 4000;
	dimx = MENU_MAIN_DX;
	dimy = MENU_MAIN_DY;
	onselaction[0] = SEL_ACTION_CLOSE;
	onselaction_s[0] = "LEAVE_GAME";
	flags = IT_CHROMAKEYED | IT_TRANSPARENT | IT_MOVEABLE | IT_SELECTABLE | IT_TXT_CENTER;
};

instance MENUITEM_LEAVE_GAME_NO(C_MENU_ITEM_DEF)
{
	backpic = MENU_ITEM_BACK_PIC;
	text[0] = "No.";
	text[1] = "No, I want to resume playing.";
	posx = 0;
	posy = 4600;
	dimx = MENU_MAIN_DX;
	dimy = MENU_MAIN_DY;
	flags = IT_CHROMAKEYED | IT_TRANSPARENT | IT_MOVEABLE | IT_SELECTABLE | IT_TXT_CENTER;
};

