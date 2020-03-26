class dofus.utils.criterions.basicCriterion.BasicCriterionEpisod extends dofus.utils.ApiElement implements dofus.utils.criterions.ICriterion
{
   function BasicCriterionEpisod(sOperator, nValue)
   {
      super();
      this._sOperator = sOperator;
      this._nValue = nValue;
   }
   function isFilled()
   {
      var _loc2_ = this.api.datacenter.Basics.aks_current_regional_version;
      switch(this._sOperator)
      {
         case "=":
            return _loc2_ == this._nValue;
         case "!":
            return _loc2_ != this._nValue;
         case ">":
            return _loc2_ > this._nValue;
         case "<":
            return _loc2_ < this._nValue;
         default:
            return false;
      }
   }
   function check()
   {
      return "=!<>".indexOf(this._sOperator) > -1;
   }
}
