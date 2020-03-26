class dofus.utils.nameChecker.rules.NameCheckerGuildNameRules implements dofus.utils.nameChecker.rules.INameCheckerRules
{
   var MIN_NAME_LENGTH = 2;
   var MAX_NAME_LENGTH = 30;
   var NUMBER_OF_ALLOWED_DASHES = 3;
   var ALLOW_SPACES = true;
   var NO_DASHES_ON_INDEXES = [0,1];
   var FIRST_CHAR_MUST_BE_UPPERCASE = true;
   var NO_UPPERCASE_AFTER_THE_FIRST = true;
   var UPPERCASE_ALLOWED_AFTER = ["-"," "];
   var CANNOT_END_WITH_UPPERCASE = true;
   var PROHIBED_WORDS_STRICTLY_EQUAL = [];
   var PROHIBED_WORDS_INSIDE = [];
   var PROHIBED_WORDS_ON_BEGINNING = [];
   var PROHIBED_WORDS_ON_ENDING = [];
   var AT_LEAST_X_VOWELS = 1;
   var AT_LEAST_X_CONSONANTS = 0;
   var REPETING_CHAR_MAX = 3;
   function NameCheckerGuildNameRules()
   {
   }
   function NameCheckerCharacterNameRules()
   {
   }
   function getMinNameLength()
   {
      return this.MIN_NAME_LENGTH;
   }
   function getMaxNameLength()
   {
      return this.MAX_NAME_LENGTH;
   }
   function getNumberOfAllowedDashes()
   {
      return this.NUMBER_OF_ALLOWED_DASHES;
   }
   function getIsAllowingSpaces()
   {
      return this.ALLOW_SPACES;
   }
   function getNoDashesOnTheseIndexes()
   {
      return this.NO_DASHES_ON_INDEXES;
   }
   function getIfFirstCharMustBeUppercase()
   {
      return this.FIRST_CHAR_MUST_BE_UPPERCASE;
   }
   function getIfNoCharAfterTheFirstMustBeUppercase()
   {
      return this.NO_UPPERCASE_AFTER_THE_FIRST;
   }
   function getCharAllowingUppercase()
   {
      return this.UPPERCASE_ALLOWED_AFTER;
   }
   function getIfCannotEndWithUppercase()
   {
      return this.CANNOT_END_WITH_UPPERCASE;
   }
   function getStrictlyEqualsProhibedWords()
   {
      return this.PROHIBED_WORDS_STRICTLY_EQUAL;
   }
   function getContainingProhibedWords()
   {
      return this.PROHIBED_WORDS_INSIDE;
   }
   function getBeginningProhibedWords()
   {
      return this.PROHIBED_WORDS_ON_BEGINNING;
   }
   function getEndingProhibedWords()
   {
      return this.PROHIBED_WORDS_ON_ENDING;
   }
   function getMinimumVowelsCount()
   {
      return this.AT_LEAST_X_VOWELS;
   }
   function getMinimumConsonantsCount()
   {
      return this.AT_LEAST_X_CONSONANTS;
   }
   function getMaxRepetitionForOneChar()
   {
      return this.REPETING_CHAR_MAX;
   }
}
