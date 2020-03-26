class dofus.datacenter.Question extends Object
{
   function Question(nQuestionID, aResponsesID, aQuestionParams)
   {
      super();
      this.initialize(nQuestionID,aResponsesID,aQuestionParams);
   }
   function __get__id()
   {
      return this._nQuestionID;
   }
   function __get__label()
   {
      return this.api.lang.fetchString(this._sQuestionText);
   }
   function __get__responses()
   {
      return this._eaResponsesObjects;
   }
   function initialize(nQuestionID, aResponsesID, aQuestionParams)
   {
      this.api = _global.API;
      this._nQuestionID = nQuestionID;
      this._sQuestionText = ank.utils.PatternDecoder.getDescription(this.api.lang.getDialogQuestionText(nQuestionID),aQuestionParams);
      this._eaResponsesObjects = new ank.utils.ExtendedArray();
      var _loc5_ = 0;
      while(_loc5_ < aResponsesID.length)
      {
         var _loc6_ = Number(aResponsesID[_loc5_]);
         this._eaResponsesObjects.push({label:this.api.lang.fetchString(this.api.lang.getDialogResponseText(_loc6_)),id:_loc6_});
         _loc5_ = _loc5_ + 1;
      }
   }
}
