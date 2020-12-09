class dofus.utils.criterions.basicCriterion.BasicCriterionEpisod extends dofus.utils.ApiElement implements dofus.utils.criterions.ICriterion
{
	function BasicCriterionEpisod(§\x1e\x0f\x18§, §\x1e\x1b\x17§)
	{
		super();
		this._sOperator = var3;
		this._nValue = var4;
	}
	function isFilled()
	{
		var var2 = this.api.datacenter.Basics.aks_current_regional_version;
		switch(this._sOperator)
		{
			case "=":
				return var2 == this._nValue;
			case "!":
				return var2 != this._nValue;
			case ">":
				return var2 > this._nValue;
			case "<":
				return var2 < this._nValue;
			default:
				return false;
		}
	}
	function check()
	{
		return "=!<>".indexOf(this._sOperator) > -1;
	}
}
