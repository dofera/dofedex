class dofus.utils.nameChecker.CheckResults extends dofus.utils.ApiElement
{
	function CheckResults()
	{
		super();
	}
	function toString(var2)
	{
		var var3 = new String();
		if(this.IS_SUCCESS)
		{
			var3 = "OK!";
		}
		else if(this.api.lang.getText != undefined)
		{
			var var4 = new Array();
			if(this.FAILED_ON_LENGTH_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_3"));
			}
			if(this.FAILED_ON_SPACES_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_11"));
			}
			if(this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_1"));
			}
			if(this.FAILED_ON_DASHES_COUNT_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_2"));
			}
			if(this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_4"));
			}
			if(this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_5"));
			}
			if(this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_6"));
			}
			if(this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_7"));
			}
			if(this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_8"));
			}
			if(this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_9"));
			}
			if(this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_10"));
			}
			if(this.FAILED_ON_VOWELS_COUNT_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_12"));
			}
			if(this.FAILED_ON_CONSONANTS_COUNT_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_13"));
			}
			if(this.FAILED_ON_REPETITION_CHECK)
			{
				var4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_14"));
			}
			var3 = var4.join(var2);
		}
		else
		{
			var var5 = new Array();
			if(this.FAILED_ON_LENGTH_CHECK)
			{
				var5.push("FAILED_ON_LENGTH_CHECK");
			}
			if(this.FAILED_ON_SPACES_CHECK)
			{
				var5.push("FAILED_ON_SPACES_CHECK");
			}
			if(this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
			{
				var5.push("FAILED_ON_DASHES_AT_INDEXES_CHECK");
			}
			if(this.FAILED_ON_DASHES_COUNT_CHECK)
			{
				var5.push("FAILED_ON_DASHES_COUNT_CHECK");
			}
			if(this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
			{
				var5.push("FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK");
			}
			if(this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
			{
				var5.push("FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK");
			}
			if(this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
			{
				var5.push("FAILED_ON_UPPERCASE_AT_THE_END_CHECK");
			}
			if(this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
			{
				var5.push("FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK");
			}
			if(this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
			{
				var5.push("FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK");
			}
			if(this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
			{
				var5.push("FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK");
			}
			if(this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
			{
				var5.push("FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK");
			}
			if(this.FAILED_ON_VOWELS_COUNT_CHECK)
			{
				var5.push("FAILED_ON_VOWELS_COUNT_CHECK");
			}
			if(this.FAILED_ON_CONSONANTS_COUNT_CHECK)
			{
				var5.push("FAILED_ON_CONSONANTS_COUNT_CHECK");
			}
			if(this.FAILED_ON_REPETITION_CHECK)
			{
				var5.push("FAILED_ON_REPETITION_CHECK");
			}
			var3 = var5.join(var2);
		}
		return var3;
	}
	function errorCount()
	{
		var var2 = 0;
		if(this.FAILED_ON_LENGTH_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_SPACES_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_DASHES_COUNT_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_VOWELS_COUNT_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_CONSONANTS_COUNT_CHECK)
		{
			var2 = var2 + 1;
		}
		if(this.FAILED_ON_REPETITION_CHECK)
		{
			var2 = var2 + 1;
		}
		return var2;
	}
}
