class dofus.datacenter.QuestObjective
{
	function QuestObjective(§\x05\x02§, §\x1a\b§)
	{
		this.initialize(var2,var3);
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__description()
	{
		var var2 = this.api.lang.getQuestObjectiveText(this._nID);
		var var3 = var2.t;
		var var4 = var2.p;
		var var5 = new Array();
		var var6 = this.api.lang.getQuestObjectiveTypeText(var3);
		org.flashdevelop.utils.FlashConnect.mtrace("[wtf] nType = " + var3,"dofus.datacenter.QuestObjective::description","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/datacenter/QuestObjective.as",38);
		loop0:
		switch(var3)
		{
			case 0:
			case 4:
				var5 = [var4[0]];
				break;
			case 1:
			case 9:
			case 10:
				var5 = [this.api.lang.getNonPlayableCharactersText(var4[0]).n];
				break;
			default:
				switch(null)
				{
					case 2:
					case 3:
						var5[0] = this.api.lang.getNonPlayableCharactersText(var4[0]).n;
						var5[1] = this.api.lang.getItemUnicText(var4[1]).n;
						var5[2] = var4[2];
						break loop0;
					case 5:
						var5[0] = this.api.lang.getMapSubAreaText(var4[0]).n;
						break loop0;
					case 6:
					case 7:
						var5[0] = this.api.lang.getMonstersText(var4[0]).n;
						var5[1] = var4[1];
						break loop0;
					default:
						switch(null)
						{
							case 8:
								var5[0] = this.api.lang.getItemUnicText(var4[0]).n;
								break;
							case 12:
								var5[0] = this.api.lang.getNonPlayableCharactersText(var4[0]).n;
								var5[1] = this.api.lang.getMonstersText(var4[1]).n;
								var5[2] = var4[2];
						}
				}
		}
		var var7 = ank.utils.PatternDecoder.getDescription(var6,var5);
		if(var7 != null && dofus.Constants.DEBUG)
		{
			var7 = var7 + " (" + this._nID + ")";
		}
		return var7;
	}
	function __get__isFinished()
	{
		return this._bFinished;
	}
	function __get__x()
	{
		return this.api.lang.getQuestObjectiveText(this._nID).x;
	}
	function __get__y()
	{
		return this.api.lang.getQuestObjectiveText(this._nID).y;
	}
	function initialize(§\x05\x02§, §\x1a\b§)
	{
		this.api = _global.API;
		this._nID = var2;
		this._bFinished = var3;
	}
}
