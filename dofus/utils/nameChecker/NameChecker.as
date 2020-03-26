class dofus.utils.nameChecker.NameChecker
{
   static var VOWELS = ["A","E","I","O","U","Y"];
   static var CONSONANTS = ["B","C","D","F","G","H","J","K","L","M","N","P","Q","R","S","T","V","W","X","Z"];
   function NameChecker(sName)
   {
      this.name = sName;
      this.upperName = sName.toUpperCase();
      this.lowerName = sName.toLowerCase();
   }
   function isValidAgainst(rules)
   {
      if(!this.checkLength(rules.getMinNameLength(),rules.getMaxNameLength()))
      {
         return false;
      }
      if(!rules.getIsAllowingSpaces() && this.checkContainSpaces())
      {
         return false;
      }
      if(!this.checkDashesCount(rules.getNumberOfAllowedDashes()))
      {
         return false;
      }
      var _loc3_ = 0;
      while(_loc3_ < rules.getNoDashesOnTheseIndexes().length)
      {
         if(!this.checkBorderingDashes(rules.getNoDashesOnTheseIndexes()[_loc3_]))
         {
            return false;
         }
         _loc3_ = _loc3_ + 1;
      }
      if(rules.getIfFirstCharMustBeUppercase() && !this.checkUpperCaseOnFirstChar())
      {
         return false;
      }
      if(rules.getIfNoCharAfterTheFirstMustBeUppercase() && !this.checkUpperCaseElsewhere(rules.getCharAllowingUppercase()))
      {
         return false;
      }
      if(rules.getIfCannotEndWithUppercase() && !this.checkLastIsUppercase())
      {
         return false;
      }
      if(!this.checkCannotBeEqualTo(rules.getStrictlyEqualsProhibedWords()))
      {
         return false;
      }
      if(!this.checkCannotContain(rules.getContainingProhibedWords()))
      {
         return false;
      }
      if(!this.checkCannotStartWith(rules.getBeginningProhibedWords()))
      {
         return false;
      }
      if(!this.checkCannotEndWith(rules.getEndingProhibedWords()))
      {
         return false;
      }
      if(!this.checkContainsAtLeastNFromArray(rules.getMinimumVowelsCount(),dofus.utils.nameChecker.NameChecker.VOWELS))
      {
         return false;
      }
      if(!this.checkContainsAtLeastNFromArray(rules.getMinimumConsonantsCount(),dofus.utils.nameChecker.NameChecker.CONSONANTS))
      {
         return false;
      }
      if(!this.checkMaximumRepetitionOfSimultaneousLetters(rules.getMaxRepetitionForOneChar()))
      {
         return false;
      }
      return true;
   }
   function isValidAgainstWithDetails(rules)
   {
      var _loc3_ = new dofus.utils.nameChecker.CheckResults();
      _loc3_.IS_SUCCESS = true;
      if(!this.checkLength(rules.getMinNameLength(),rules.getMaxNameLength()))
      {
         _loc3_.FAILED_ON_LENGTH_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      if(this.name.length == 0)
      {
         _loc3_.FAILED_ON_LENGTH_CHECK = true;
         _loc3_.IS_SUCCESS = false;
         return _loc3_;
      }
      if(!rules.getIsAllowingSpaces() && this.checkContainSpaces())
      {
         _loc3_.FAILED_ON_SPACES_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      if(!this.checkDashesCount(rules.getNumberOfAllowedDashes()))
      {
         _loc3_.FAILED_ON_DASHES_COUNT_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      var _loc4_ = 0;
      while(_loc4_ < rules.getNoDashesOnTheseIndexes().length)
      {
         if(!this.checkBorderingDashes(rules.getNoDashesOnTheseIndexes()[_loc4_]))
         {
            _loc3_.FAILED_ON_DASHES_AT_INDEXES_CHECK = true;
            _loc3_.IS_SUCCESS = false;
            break;
         }
         _loc4_ = _loc4_ + 1;
      }
      if(rules.getIfFirstCharMustBeUppercase() && !this.checkUpperCaseOnFirstChar())
      {
         _loc3_.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      if(rules.getIfNoCharAfterTheFirstMustBeUppercase() && !this.checkUpperCaseElsewhere(rules.getCharAllowingUppercase()))
      {
         _loc3_.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      if(rules.getIfCannotEndWithUppercase() && !this.checkLastIsUppercase())
      {
         _loc3_.FAILED_ON_UPPERCASE_AT_THE_END_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      if(!this.checkCannotBeEqualTo(rules.getStrictlyEqualsProhibedWords()))
      {
         _loc3_.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      if(!this.checkCannotContain(rules.getContainingProhibedWords()))
      {
         _loc3_.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      if(!this.checkCannotStartWith(rules.getBeginningProhibedWords()))
      {
         _loc3_.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      if(!this.checkCannotEndWith(rules.getEndingProhibedWords()))
      {
         _loc3_.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      if(!this.checkContainsAtLeastNFromArray(rules.getMinimumVowelsCount(),dofus.utils.nameChecker.NameChecker.VOWELS))
      {
         _loc3_.FAILED_ON_VOWELS_COUNT_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      if(!this.checkContainsAtLeastNFromArray(rules.getMinimumConsonantsCount(),dofus.utils.nameChecker.NameChecker.CONSONANTS))
      {
         _loc3_.FAILED_ON_CONSONANTS_COUNT_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      if(!this.checkMaximumRepetitionOfSimultaneousLetters(rules.getMaxRepetitionForOneChar()))
      {
         _loc3_.FAILED_ON_REPETITION_CHECK = true;
         _loc3_.IS_SUCCESS = false;
      }
      return _loc3_;
   }
   function checkLength(nMinLength, nMaxLength)
   {
      if(this.name.length < nMinLength || this.name.length > nMaxLength)
      {
         return false;
      }
      return true;
   }
   function checkContainSpaces()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.name.length)
      {
         if(this.name.charAt(_loc2_) == " ")
         {
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
   function checkBorderingDashes(nIndex)
   {
      if(this.name.charAt(nIndex) == "-" || this.name.charAt(this.name.length - 1 - nIndex) == "-")
      {
         return false;
      }
      return true;
   }
   function checkDashesCount(nMaxCount)
   {
      var _loc3_ = 0;
      var _loc4_ = 0;
      while(_loc4_ < this.name.length)
      {
         if(this.name.charAt(_loc4_) == "-")
         {
            if((_loc3_ = _loc3_ + 1) > nMaxCount)
            {
               return false;
            }
         }
         _loc4_ = _loc4_ + 1;
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
   function checkUpperCaseElsewhere(aExceptionsAfter)
   {
      var _loc3_ = 1;
      while(_loc3_ < this.name.length)
      {
         if(this.lowerName.charAt(_loc3_) != this.name.charAt(_loc3_))
         {
            var _loc4_ = false;
            var _loc5_ = 0;
            while(_loc5_ < aExceptionsAfter.length)
            {
               if(this.name.charAt(_loc3_ - 1) == aExceptionsAfter[_loc5_])
               {
                  _loc4_ = true;
               }
               _loc5_ = _loc5_ + 1;
            }
            if(!_loc4_)
            {
               return false;
            }
         }
         _loc3_ = _loc3_ + 1;
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
   function checkCannotBeEqualTo(aProhibedWords)
   {
      if(aProhibedWords == null)
      {
         return true;
      }
      var _loc3_ = 0;
      while(_loc3_ < aProhibedWords.length)
      {
         if(this.upperName == aProhibedWords[_loc3_])
         {
            return false;
         }
         _loc3_ = _loc3_ + 1;
      }
      return true;
   }
   function checkCannotContain(aProhibedWords)
   {
      if(aProhibedWords == null)
      {
         return true;
      }
      var _loc3_ = 0;
      while(_loc3_ < aProhibedWords.length)
      {
         if(this.upperName.indexOf(aProhibedWords[_loc3_]) > -1)
         {
            return false;
         }
         _loc3_ = _loc3_ + 1;
      }
      return true;
   }
   function checkCannotStartWith(aProhibedWords)
   {
      if(aProhibedWords == null)
      {
         return true;
      }
      var _loc3_ = 0;
      while(_loc3_ < aProhibedWords.length)
      {
         if(this.upperName.indexOf(aProhibedWords[_loc3_]) == 0)
         {
            return false;
         }
         _loc3_ = _loc3_ + 1;
      }
      return true;
   }
   function checkCannotEndWith(aProhibedWords)
   {
      if(aProhibedWords == null)
      {
         return true;
      }
      var _loc3_ = 0;
      while(_loc3_ < aProhibedWords.length)
      {
         if(this.upperName.indexOf(aProhibedWords[_loc3_],this.upperName.length - aProhibedWords[_loc3_].length) == this.upperName.length - aProhibedWords[_loc3_].length)
         {
            return false;
         }
         _loc3_ = _loc3_ + 1;
      }
      return true;
   }
   function checkContainsAtLeastNFromArray(nCountToContain, aCharsToBeContained)
   {
      var _loc4_ = 0;
      var _loc5_ = 0;
      while(_loc5_ < this.name.length)
      {
         var _loc6_ = 0;
         while(_loc6_ < aCharsToBeContained.length)
         {
            if(this.upperName.charAt(_loc5_) == aCharsToBeContained[_loc6_])
            {
               if((_loc4_ = _loc4_ + 1) >= nCountToContain)
               {
                  return true;
               }
            }
            _loc6_ = _loc6_ + 1;
         }
         _loc5_ = _loc5_ + 1;
      }
      return false;
   }
   function checkMaximumRepetitionOfSimultaneousLetters(nMaxSimultaneousLetters)
   {
      var _loc3_ = new String();
      var _loc4_ = 0;
      var _loc5_ = 0;
      while(_loc5_ < this.name.length)
      {
         if(_loc3_ == (_loc3_ = this.name.charAt(_loc5_)))
         {
            if((_loc4_ = _loc4_ + 1) > nMaxSimultaneousLetters - 1)
            {
               return false;
            }
         }
         _loc5_ = _loc5_ + 1;
      }
      return true;
   }
}
