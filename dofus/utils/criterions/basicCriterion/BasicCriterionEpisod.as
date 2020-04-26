class dofus.utils.criterions.basicCriterion.BasicCriterionEpisod extends dofus.utils.ApiElement implements dofus.utils.criterions.ICriterion
{
	function BasicCriterionEpisod(loc3, loc4)
	{
		super();
		this._sOperator = loc3;
		this._nValue = loc4;
	}
	function isFilled()
	{
		var loc2 = this.api.datacenter.Basics.aks_current_regional_version;
		switch(this._sOperator)
		{
			case "=":
				return loc2 == this._nValue;
			case "!":
				return loc2 != this._nValue;
			case ">":
				return loc2 > this._nValue;
			default:
				if(loc0 !== "<")
				{
					return false;
				}
				return loc2 < this._nValue;
		}
	}
	function check()
	{
		return "=!<>".indexOf(this._sOperator) > -1;
	}
}
