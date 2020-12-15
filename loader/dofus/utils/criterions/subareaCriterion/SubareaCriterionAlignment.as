class dofus.utils.criterions.subareaCriterion.SubareaCriterionAlignment extends dofus.utils.ApiElement implements dofus.utils.criterions.ICriterion
{
	function SubareaCriterionAlignment()
	{
		super();
	}
	function AreaCriterionAlignment(var2, var3)
	{
		this._sOperator = var2;
		this._nAlignmentIndex = var3;
		this._aSubarea = (dofus.datacenter.Subarea)this.api.datacenter.Subareas.getItemAt(this.api.datacenter.Map.subarea);
	}
	function isFilled()
	{
		var var2 = this._aSubarea.alignment;
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
