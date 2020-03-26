class dofus.utils.criterions.subareaCriterion.SubareaCriterionAlignment extends dofus.utils.ApiElement implements dofus.utils.criterions.ICriterion
{
   function SubareaCriterionAlignment()
   {
      super();
   }
   function AreaCriterionAlignment(sOperator, nAlignmentIndex)
   {
      this._sOperator = sOperator;
      this._nAlignmentIndex = nAlignmentIndex;
      this._aSubarea = (dofus.datacenter.Subarea)this.api.datacenter.Subareas.getItemAt(this.api.datacenter.Map.subarea);
   }
   function isFilled()
   {
      var _loc2_ = this._aSubarea.alignment;
      switch(this._sOperator)
      {
         case "=":
            return this._aSubarea.alignment.index == this._nAlignmentIndex;
         case "!":
            return this._aSubarea.alignment.index != this._nAlignmentIndex;
         default:
            return false;
      }
   }
   function check()
   {
      return "=!".indexOf(this._sOperator) > -1;
   }
}
