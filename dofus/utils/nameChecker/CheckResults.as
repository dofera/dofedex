class dofus.utils.nameChecker.CheckResults extends dofus.utils.ApiElement
{
   function CheckResults()
   {
      super();
   }
   function toString(sJoin)
   {
      var _loc3_ = new String();
      if(this.IS_SUCCESS)
      {
         _loc3_ = "OK!";
      }
      else if(this.api.lang.getText != undefined)
      {
         var _loc4_ = new Array();
         if(this.FAILED_ON_LENGTH_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_3"));
         }
         if(this.FAILED_ON_SPACES_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_11"));
         }
         if(this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_1"));
         }
         if(this.FAILED_ON_DASHES_COUNT_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_2"));
         }
         if(this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_4"));
         }
         if(this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_5"));
         }
         if(this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_6"));
         }
         if(this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_7"));
         }
         if(this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_8"));
         }
         if(this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_9"));
         }
         if(this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_10"));
         }
         if(this.FAILED_ON_VOWELS_COUNT_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_12"));
         }
         if(this.FAILED_ON_CONSONANTS_COUNT_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_13"));
         }
         if(this.FAILED_ON_REPETITION_CHECK)
         {
            _loc4_.push(this.api.lang.getText("CHARACTER_NAME_ERROR_14"));
         }
         _loc3_ = _loc4_.join(sJoin);
      }
      else
      {
         var _loc5_ = new Array();
         if(this.FAILED_ON_LENGTH_CHECK)
         {
            _loc5_.push("FAILED_ON_LENGTH_CHECK");
         }
         if(this.FAILED_ON_SPACES_CHECK)
         {
            _loc5_.push("FAILED_ON_SPACES_CHECK");
         }
         if(this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
         {
            _loc5_.push("FAILED_ON_DASHES_AT_INDEXES_CHECK");
         }
         if(this.FAILED_ON_DASHES_COUNT_CHECK)
         {
            _loc5_.push("FAILED_ON_DASHES_COUNT_CHECK");
         }
         if(this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
         {
            _loc5_.push("FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK");
         }
         if(this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
         {
            _loc5_.push("FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK");
         }
         if(this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
         {
            _loc5_.push("FAILED_ON_UPPERCASE_AT_THE_END_CHECK");
         }
         if(this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
         {
            _loc5_.push("FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK");
         }
         if(this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
         {
            _loc5_.push("FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK");
         }
         if(this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
         {
            _loc5_.push("FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK");
         }
         if(this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
         {
            _loc5_.push("FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK");
         }
         if(this.FAILED_ON_VOWELS_COUNT_CHECK)
         {
            _loc5_.push("FAILED_ON_VOWELS_COUNT_CHECK");
         }
         if(this.FAILED_ON_CONSONANTS_COUNT_CHECK)
         {
            _loc5_.push("FAILED_ON_CONSONANTS_COUNT_CHECK");
         }
         if(this.FAILED_ON_REPETITION_CHECK)
         {
            _loc5_.push("FAILED_ON_REPETITION_CHECK");
         }
         _loc3_ = _loc5_.join(sJoin);
      }
      return _loc3_;
   }
   function errorCount()
   {
      var _loc2_ = 0;
      if(this.FAILED_ON_LENGTH_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_SPACES_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_DASHES_COUNT_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_VOWELS_COUNT_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_CONSONANTS_COUNT_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      if(this.FAILED_ON_REPETITION_CHECK)
      {
         _loc2_ = _loc2_ + 1;
      }
      return _loc2_;
   }
}
