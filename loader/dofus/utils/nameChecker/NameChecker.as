class dofus.utils.nameChecker.NameChecker
{
	static var VOWELS = ["A","E","I","O","U","Y"];
	static var CONSONANTS = ["B","C","D","F","G","H","J","K","L","M","N","P","Q","R","S","T","V","W","X","Z"];
	function NameChecker(§\x1e\x10\x06§)
	{
		this.name = var2;
		this.upperName = var2.toUpperCase();
		this.lowerName = var2.toLowerCase();
	}
	function isValidAgainst(rules)
	{
		if(!this.checkLength(var2.getMinNameLength(),var2.getMaxNameLength()))
		{
			return false;
		}
		if(!var2.getIsAllowingSpaces() && this.checkContainSpaces())
		{
			return false;
		}
		if(!this.checkDashesCount(var2.getNumberOfAllowedDashes()))
		{
			return false;
		}
		var var3 = 0;
		while(var3 < var2.getNoDashesOnTheseIndexes().length)
		{
			if(!this.checkBorderingDashes(var2.getNoDashesOnTheseIndexes()[var3]))
			{
				return false;
			}
			var3 = var3 + 1;
		}
		if(var2.getIfFirstCharMustBeUppercase() && !this.checkUpperCaseOnFirstChar())
		{
			return false;
		}
		if(var2.getIfNoCharAfterTheFirstMustBeUppercase() && !this.checkUpperCaseElsewhere(var2.getCharAllowingUppercase()))
		{
			return false;
		}
		if(var2.getIfCannotEndWithUppercase() && !this.checkLastIsUppercase())
		{
			return false;
		}
		if(!this.checkCannotBeEqualTo(var2.getStrictlyEqualsProhibedWords()))
		{
			return false;
		}
		if(!this.checkCannotContain(var2.getContainingProhibedWords()))
		{
			return false;
		}
		if(!this.checkCannotStartWith(var2.getBeginningProhibedWords()))
		{
			return false;
		}
		if(!this.checkCannotEndWith(var2.getEndingProhibedWords()))
		{
			return false;
		}
		if(!this.checkContainsAtLeastNFromArray(var2.getMinimumVowelsCount(),dofus.utils.nameChecker.NameChecker.VOWELS))
		{
			return false;
		}
		if(!this.checkContainsAtLeastNFromArray(var2.getMinimumConsonantsCount(),dofus.utils.nameChecker.NameChecker.CONSONANTS))
		{
			return false;
		}
		if(!this.checkMaximumRepetitionOfSimultaneousLetters(var2.getMaxRepetitionForOneChar()))
		{
			return false;
		}
		return true;
	}
	function isValidAgainstWithDetails(rules)
	{
		var var3 = new dofus.utils.nameChecker.();
		var3.IS_SUCCESS = true;
		if(!this.checkLength(var2.getMinNameLength(),var2.getMaxNameLength()))
		{
			var3.FAILED_ON_LENGTH_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		if(this.name.length == 0)
		{
			var3.FAILED_ON_LENGTH_CHECK = true;
			var3.IS_SUCCESS = false;
			return var3;
		}
		if(!var2.getIsAllowingSpaces() && this.checkContainSpaces())
		{
			var3.FAILED_ON_SPACES_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		if(!this.checkDashesCount(var2.getNumberOfAllowedDashes()))
		{
			var3.FAILED_ON_DASHES_COUNT_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		var var4 = 0;
		while(var4 < var2.getNoDashesOnTheseIndexes().length)
		{
			if(!this.checkBorderingDashes(var2.getNoDashesOnTheseIndexes()[var4]))
			{
				var3.FAILED_ON_DASHES_AT_INDEXES_CHECK = true;
				var3.IS_SUCCESS = false;
				break;
			}
			var4 = var4 + 1;
		}
		if(var2.getIfFirstCharMustBeUppercase() && !this.checkUpperCaseOnFirstChar())
		{
			var3.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		if(var2.getIfNoCharAfterTheFirstMustBeUppercase() && !this.checkUpperCaseElsewhere(var2.getCharAllowingUppercase()))
		{
			var3.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		if(var2.getIfCannotEndWithUppercase() && !this.checkLastIsUppercase())
		{
			var3.FAILED_ON_UPPERCASE_AT_THE_END_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		if(!this.checkCannotBeEqualTo(var2.getStrictlyEqualsProhibedWords()))
		{
			var3.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		if(!this.checkCannotContain(var2.getContainingProhibedWords()))
		{
			var3.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		if(!this.checkCannotStartWith(var2.getBeginningProhibedWords()))
		{
			var3.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		if(!this.checkCannotEndWith(var2.getEndingProhibedWords()))
		{
			var3.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		if(!this.checkContainsAtLeastNFromArray(var2.getMinimumVowelsCount(),dofus.utils.nameChecker.NameChecker.VOWELS))
		{
			var3.FAILED_ON_VOWELS_COUNT_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		if(!this.checkContainsAtLeastNFromArray(var2.getMinimumConsonantsCount(),dofus.utils.nameChecker.NameChecker.CONSONANTS))
		{
			var3.FAILED_ON_CONSONANTS_COUNT_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		if(!this.checkMaximumRepetitionOfSimultaneousLetters(var2.getMaxRepetitionForOneChar()))
		{
			var3.FAILED_ON_REPETITION_CHECK = true;
			var3.IS_SUCCESS = false;
		}
		return var3;
	}
	function checkLength(§\x02\x1d§, §\x03\r§)
	{
		if(this.name.length < var2 || this.name.length > var3)
		{
			return false;
		}
		return true;
	}
	function checkContainSpaces()
	{
		var var2 = 0;
		while(var2 < this.name.length)
		{
			if(this.name.charAt(var2) == " ")
			{
				return true;
			}
			var2 = var2 + 1;
		}
		return false;
	}
	function checkBorderingDashes(§\x04\x17§)
	{
		if(this.name.charAt(var2) == "-" || this.name.charAt(this.name.length - 1 - var2) == "-")
		{
			return false;
		}
		return true;
	}
	function checkDashesCount(§\x03\x11§)
	{
		var var3 = 0;
		var var4 = 0;
		while(var4 < this.name.length)
		{
			if(this.name.charAt(var4) == "-")
			{
				if((var3 = var3 + 1) > var2)
				{
					return false;
				}
			}
			var4 = var4 + 1;
		}
		return true;
	}
	function checkUpperCaseOnFirstChar()
	{
		if(this.upperName.charAt(0) != this.name.charAt(0))
		{
			return false;
		}
		return true;
	}
	function checkUpperCaseElsewhere(§\x1e\x18§)
	{
		var var3 = 1;
		while(var3 < this.name.length)
		{
			if(this.lowerName.charAt(var3) != this.name.charAt(var3))
			{
				var var4 = false;
				var var5 = 0;
				while(var5 < var2.length)
				{
					if(this.name.charAt(var3 - 1) == var2[var5])
					{
						var4 = true;
					}
					var5 = var5 + 1;
				}
				if(!var4)
				{
					return false;
				}
			}
			var3 = var3 + 1;
		}
		return true;
	}
	function checkLastIsUppercase()
	{
		if(this.lowerName.charAt(this.name.length - 1) != this.name.charAt(this.name.length - 1))
		{
			return false;
		}
		return true;
	}
	function checkCannotBeEqualTo(§\x1d\x19§)
	{
		if(var2 == null)
		{
			return true;
		}
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(this.upperName == var2[var3])
			{
				return false;
			}
			var3 = var3 + 1;
		}
		return true;
	}
	function checkCannotContain(§\x1d\x19§)
	{
		if(var2 == null)
		{
			return true;
		}
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(this.upperName.indexOf(var2[var3]) > -1)
			{
				return false;
			}
			var3 = var3 + 1;
		}
		return true;
	}
	function checkCannotStartWith(§\x1d\x19§)
	{
		if(var2 == null)
		{
			return true;
		}
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(this.upperName.indexOf(var2[var3]) == 0)
			{
				return false;
			}
			var3 = var3 + 1;
		}
		return true;
	}
	function checkCannotEndWith(§\x1d\x19§)
	{
		if(var2 == null)
		{
			return true;
		}
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(this.upperName.indexOf(var2[var3],this.upperName.length - var2[var3].length) == this.upperName.length - var2[var3].length)
			{
				return false;
			}
			var3 = var3 + 1;
		}
		return true;
	}
	function checkContainsAtLeastNFromArray(§\x07\x07§, §\r§)
	{
		var var4 = 0;
		var var5 = 0;
		while(var5 < this.name.length)
		{
			var var6 = 0;
			while(var6 < var3.length)
			{
				if(this.upperName.charAt(var5) == var3[var6])
				{
					if((var4 = var4 + 1) >= var2)
					{
						return true;
					}
				}
				var6 = var6 + 1;
			}
			var5 = var5 + 1;
		}
		return false;
	}
	function checkMaximumRepetitionOfSimultaneousLetters(§\x03\t§)
	{
		var var3 = new String();
		var var4 = 0;
		var var5 = 0;
		while(var5 < this.name.length)
		{
			if(var3 == (var3 = this.name.charAt(var5)))
			{
				if((var4 = var4 + 1) > var2 - 1)
				{
					return false;
				}
			}
			var5 = var5 + 1;
		}
		return true;
	}
}
