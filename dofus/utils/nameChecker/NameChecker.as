class dofus.utils.nameChecker.NameChecker
{
	static var VOWELS = ["A","E","I","O","U","Y"];
	static var CONSONANTS = ["B","C","D","F","G","H","J","K","L","M","N","P","Q","R","S","T","V","W","X","Z"];
	function NameChecker(loc3)
	{
		this.name = loc2;
		this.upperName = loc2.toUpperCase();
		this.lowerName = loc2.toLowerCase();
	}
	function isValidAgainst(rules)
	{
		if(!this.checkLength(loc2.getMinNameLength(),loc2.getMaxNameLength()))
		{
			return false;
		}
		if(!loc2.getIsAllowingSpaces() && this.checkContainSpaces())
		{
			return false;
		}
		if(!this.checkDashesCount(loc2.getNumberOfAllowedDashes()))
		{
			return false;
		}
		var loc3 = 0;
		while(loc3 < loc2.getNoDashesOnTheseIndexes().length)
		{
			if(!this.checkBorderingDashes(loc2.getNoDashesOnTheseIndexes()[loc3]))
			{
				return false;
			}
			loc3 = loc3 + 1;
		}
		if(loc2.getIfFirstCharMustBeUppercase() && !this.checkUpperCaseOnFirstChar())
		{
			return false;
		}
		if(loc2.getIfNoCharAfterTheFirstMustBeUppercase() && !this.checkUpperCaseElsewhere(loc2.getCharAllowingUppercase()))
		{
			return false;
		}
		if(loc2.getIfCannotEndWithUppercase() && !this.checkLastIsUppercase())
		{
			return false;
		}
		if(!this.checkCannotBeEqualTo(loc2.getStrictlyEqualsProhibedWords()))
		{
			return false;
		}
		if(!this.checkCannotContain(loc2.getContainingProhibedWords()))
		{
			return false;
		}
		if(!this.checkCannotStartWith(loc2.getBeginningProhibedWords()))
		{
			return false;
		}
		if(!this.checkCannotEndWith(loc2.getEndingProhibedWords()))
		{
			return false;
		}
		if(!this.checkContainsAtLeastNFromArray(loc2.getMinimumVowelsCount(),dofus.utils.nameChecker.NameChecker.VOWELS))
		{
			return false;
		}
		if(!this.checkContainsAtLeastNFromArray(loc2.getMinimumConsonantsCount(),dofus.utils.nameChecker.NameChecker.CONSONANTS))
		{
			return false;
		}
		if(!this.checkMaximumRepetitionOfSimultaneousLetters(loc2.getMaxRepetitionForOneChar()))
		{
			return false;
		}
		return true;
	}
	function isValidAgainstWithDetails(rules)
	{
		var loc3 = new dofus.utils.nameChecker.();
		loc3.IS_SUCCESS = true;
		if(!this.checkLength(loc2.getMinNameLength(),loc2.getMaxNameLength()))
		{
			loc3.FAILED_ON_LENGTH_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		if(this.name.length == 0)
		{
			loc3.FAILED_ON_LENGTH_CHECK = true;
			loc3.IS_SUCCESS = false;
			return loc3;
		}
		if(!loc2.getIsAllowingSpaces() && this.checkContainSpaces())
		{
			loc3.FAILED_ON_SPACES_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		if(!this.checkDashesCount(loc2.getNumberOfAllowedDashes()))
		{
			loc3.FAILED_ON_DASHES_COUNT_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		var loc4 = 0;
		while(loc4 < loc2.getNoDashesOnTheseIndexes().length)
		{
			if(!this.checkBorderingDashes(loc2.getNoDashesOnTheseIndexes()[loc4]))
			{
				loc3.FAILED_ON_DASHES_AT_INDEXES_CHECK = true;
				loc3.IS_SUCCESS = false;
				break;
			}
			loc4 = loc4 + 1;
		}
		if(loc2.getIfFirstCharMustBeUppercase() && !this.checkUpperCaseOnFirstChar())
		{
			loc3.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		if(loc2.getIfNoCharAfterTheFirstMustBeUppercase() && !this.checkUpperCaseElsewhere(loc2.getCharAllowingUppercase()))
		{
			loc3.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		if(loc2.getIfCannotEndWithUppercase() && !this.checkLastIsUppercase())
		{
			loc3.FAILED_ON_UPPERCASE_AT_THE_END_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		if(!this.checkCannotBeEqualTo(loc2.getStrictlyEqualsProhibedWords()))
		{
			loc3.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		if(!this.checkCannotContain(loc2.getContainingProhibedWords()))
		{
			loc3.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		if(!this.checkCannotStartWith(loc2.getBeginningProhibedWords()))
		{
			loc3.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		if(!this.checkCannotEndWith(loc2.getEndingProhibedWords()))
		{
			loc3.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		if(!this.checkContainsAtLeastNFromArray(loc2.getMinimumVowelsCount(),dofus.utils.nameChecker.NameChecker.VOWELS))
		{
			loc3.FAILED_ON_VOWELS_COUNT_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		if(!this.checkContainsAtLeastNFromArray(loc2.getMinimumConsonantsCount(),dofus.utils.nameChecker.NameChecker.CONSONANTS))
		{
			loc3.FAILED_ON_CONSONANTS_COUNT_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		if(!this.checkMaximumRepetitionOfSimultaneousLetters(loc2.getMaxRepetitionForOneChar()))
		{
			loc3.FAILED_ON_REPETITION_CHECK = true;
			loc3.IS_SUCCESS = false;
		}
		return loc3;
	}
	function checkLength(loc2, loc3)
	{
		if(this.name.length < loc2 || this.name.length > loc3)
		{
			return false;
		}
		return true;
	}
	function checkContainSpaces()
	{
		var loc2 = 0;
		while(loc2 < this.name.length)
		{
			if(this.name.charAt(loc2) == " ")
			{
				return true;
			}
			loc2 = loc2 + 1;
		}
		return false;
	}
	function checkBorderingDashes(loc2)
	{
		if(this.name.charAt(loc2) == "-" || this.name.charAt(this.name.length - 1 - loc2) == "-")
		{
			return false;
		}
		return true;
	}
	function checkDashesCount(loc2)
	{
		var loc3 = 0;
		var loc4 = 0;
		while(loc4 < this.name.length)
		{
			if(this.name.charAt(loc4) == "-")
			{
				if((loc3 = loc3 + 1) > loc2)
				{
					return false;
				}
			}
			loc4 = loc4 + 1;
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
	function checkUpperCaseElsewhere(loc2)
	{
		var loc3 = 1;
		while(loc3 < this.name.length)
		{
			if(this.lowerName.charAt(loc3) != this.name.charAt(loc3))
			{
				var loc4 = false;
				var loc5 = 0;
				while(loc5 < loc2.length)
				{
					if(this.name.charAt(loc3 - 1) == loc2[loc5])
					{
						loc4 = true;
					}
					loc5 = loc5 + 1;
				}
				if(!loc4)
				{
					return false;
				}
			}
			loc3 = loc3 + 1;
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
	function checkCannotBeEqualTo(loc2)
	{
		if(loc2 == null)
		{
			return true;
		}
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			if(this.upperName == loc2[loc3])
			{
				return false;
			}
			loc3 = loc3 + 1;
		}
		return true;
	}
	function checkCannotContain(loc2)
	{
		if(loc2 == null)
		{
			return true;
		}
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			if(this.upperName.indexOf(loc2[loc3]) > -1)
			{
				return false;
			}
			loc3 = loc3 + 1;
		}
		return true;
	}
	function checkCannotStartWith(loc2)
	{
		if(loc2 == null)
		{
			return true;
		}
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			if(this.upperName.indexOf(loc2[loc3]) == 0)
			{
				return false;
			}
			loc3 = loc3 + 1;
		}
		return true;
	}
	function checkCannotEndWith(loc2)
	{
		if(loc2 == null)
		{
			return true;
		}
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			if(this.upperName.indexOf(loc2[loc3],this.upperName.length - loc2[loc3].length) == this.upperName.length - loc2[loc3].length)
			{
				return false;
			}
			loc3 = loc3 + 1;
		}
		return true;
	}
	function checkContainsAtLeastNFromArray(loc2, loc3)
	{
		var loc4 = 0;
		var loc5 = 0;
		while(loc5 < this.name.length)
		{
			var loc6 = 0;
			while(loc6 < loc3.length)
			{
				if(this.upperName.charAt(loc5) == loc3[loc6])
				{
					if((loc4 = loc4 + 1) >= loc2)
					{
						return true;
					}
				}
				loc6 = loc6 + 1;
			}
			loc5 = loc5 + 1;
		}
		return false;
	}
	function checkMaximumRepetitionOfSimultaneousLetters(loc2)
	{
		var loc3 = new String();
		var loc4 = 0;
		var loc5 = 0;
		while(loc5 < this.name.length)
		{
			if(loc3 == (loc3 = this.name.charAt(loc5)))
			{
				if((loc4 = loc4 + 1) > loc2 - 1)
				{
					return false;
				}
			}
			loc5 = loc5 + 1;
		}
		return true;
	}
}
