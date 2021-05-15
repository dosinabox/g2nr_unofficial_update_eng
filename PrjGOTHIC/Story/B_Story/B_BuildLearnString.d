
func string B_BuildLearnString(var string text,var int kosten)
{
	var string concatText;
	concatText = ConcatStrings(text,PRINT_Kosten);
	concatText = ConcatStrings(concatText,IntToString(kosten));
	if(kosten == 1)
	{
		concatText = ConcatStrings(concatText,PRINT_1LP);
	}
	else if((kosten > 1) && (kosten < 5))
	{
		concatText = ConcatStrings(concatText,PRINT_2LP);
	}
	else
	{
		concatText = ConcatStrings(concatText,PRINT_LP);
	};
	return concatText;
};

func string B_BuildPriceString(var string text,var int price)
{
	var string concatText;
	concatText = ConcatStrings(text," (");
	concatText = ConcatStrings(concatText,IntToString(price));
	concatText = ConcatStrings(concatText,PRINT_Gold);
	concatText = ConcatStrings(concatText,")");
	return concatText;
};

