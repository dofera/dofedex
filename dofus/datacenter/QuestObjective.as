class dofus.datacenter.QuestObjective
{
	function QuestObjective(loc3, loc4)
	{
		this.initialize(loc2,loc3);
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__description()
	{
		var loc2 = this.api.lang.getQuestObjectiveText(this._nID);
		var loc3 = loc2.t;
		var loc4 = loc2.p;
		var loc5 = new Array();
		var loc6 = this.api.lang.getQuestObjectiveTypeText(loc3);
		loop0:
		switch(loc3)
		{
			case 0:
			case 4:
				loc5 = [loc4[0]];
				break;
			default:
				switch(null)
				{
					case 1:
					case 9:
					case 10:
						loc5 = [this.api.lang.getNonPlayableCharactersText(loc4[0]).n];
						break loop0;
					default:
						switch(null)
						{
							case 3:
							case 5:
								loc5[0] = this.api.lang.getMapSubAreaText(loc4[0]).n;
								break loop0;
							case 6:
							case 7:
								loc5[0] = this.api.lang.getMonstersText(loc4[0]).n;
								loc5[1] = loc4[1];
								break loop0;
							case 8:
								loc5[0] = this.api.lang.getItemUnicText(loc4[0]).n;
								break loop0;
							default:
								if(loc0 !== 12)
								{
									break loop0;
								}
								loc5[0] = this.api.lang.getNonPlayableCharactersText(loc4[0]).n;
								loc5[1] = this.api.lang.getMonstersText(loc4[1]).n;
								loc5[2] = loc4[2];
								break loop0;
						}
					case 2:
						loc5[0] = this.api.lang.getNonPlayableCharactersText(loc4[0]).n;
						loc5[1] = this.api.lang.getItemUnicText(loc4[1]).n;
						loc5[2] = loc4[2];
				}
		}
		return ank.utils.PatternDecoder.getDescription(loc6,loc5);
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
	function initialize(loc2, loc3)
	{
		this.api = _global.API;
		this._nID = loc2;
		this._bFinished = loc3;
	}
}
