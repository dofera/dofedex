class dofus.utils.nameChecker.CheckResults extends dofus.utils.ApiElement
{
	function CheckResults()
	{
		super();
	}
	function toString(loc2)
	{
		var loc3 = new String();
		if(this.IS_SUCCESS)
		{
			loc3 = "OK!";
		}
		else if(this.api.lang.getText != undefined)
		{
			var loc4 = new Array();
			if(this.FAILED_ON_LENGTH_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_3"));
			}
			if(this.FAILED_ON_SPACES_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_11"));
			}
			if(this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_1"));
			}
			if(this.FAILED_ON_DASHES_COUNT_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_2"));
			}
			if(this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_4"));
			}
			if(this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_5"));
			}
			if(this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_6"));
			}
			if(this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_7"));
			}
			if(this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_8"));
			}
			if(this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_9"));
			}
			if(this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_10"));
			}
			if(this.FAILED_ON_VOWELS_COUNT_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_12"));
			}
			if(this.FAILED_ON_CONSONANTS_COUNT_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_13"));
			}
			if(this.FAILED_ON_REPETITION_CHECK)
			{
				loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_14"));
			}
			loc3 = loc4.join(loc2);
		}
		else
		{
			var loc5 = new Array();
			if(this.FAILED_ON_LENGTH_CHECK)
			{
				loc5.push("FAILED_ON_LENGTH_CHECK");
			}
			if(this.FAILED_ON_SPACES_CHECK)
			{
				loc5.push("FAILED_ON_SPACES_CHECK");
			}
			if(this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
			{
				loc5.push("FAILED_ON_DASHES_AT_INDEXES_CHECK");
			}
			if(this.FAILED_ON_DASHES_COUNT_CHECK)
			{
				loc5.push("FAILED_ON_DASHES_COUNT_CHECK");
			}
			if(this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
			{
				loc5.push("FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK");
			}
			if(this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
			{
				loc5.push("FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK");
			}
			if(this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
			{
				loc5.push("FAILED_ON_UPPERCASE_AT_THE_END_CHECK");
			}
			if(this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
			{
				loc5.push("FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK");
			}
			if(this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
			{
				loc5.push("FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK");
			}
			if(this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
			{
				loc5.push("FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK");
			}
			if(this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
			{
				loc5.push("FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK");
			}
			if(this.FAILED_ON_VOWELS_COUNT_CHECK)
			{
				loc5.push("FAILED_ON_VOWELS_COUNT_CHECK");
			}
			if(this.FAILED_ON_CONSONANTS_COUNT_CHECK)
			{
				loc5.push("FAILED_ON_CONSONANTS_COUNT_CHECK");
			}
			if(this.FAILED_ON_REPETITION_CHECK)
			{
				loc5.push("FAILED_ON_REPETITION_CHECK");
			}
			loc3 = loc5.join(loc2);
		}
		return loc3;
	}
	function errorCount()
	{
		var loc2 = 0;
		if(this.FAILED_ON_LENGTH_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_SPACES_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_DASHES_COUNT_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_VOWELS_COUNT_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_CONSONANTS_COUNT_CHECK)
		{
			loc2 = loc2 + 1;
		}
		if(this.FAILED_ON_REPETITION_CHECK)
		{
			loc2 = loc2 + 1;
		}
		return loc2;
	}
}
