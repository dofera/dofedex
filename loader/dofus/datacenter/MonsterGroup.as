class dofus.datacenter.MonsterGroup extends ank.battlefield.datacenter.Sprite
{
	var _sDefaultAnimation = "static";
	var _bAllDirections = false;
	var _bForceWalk = true;
	var _nAlignmentIndex = -1;
	function MonsterGroup(sID, clipClass, §\x1e\x12\f§, §\x13\n§, §\x11\b§, bonus)
	{
		super();
		this.api = _global.API;
		this._nBonusValue = bonus;
		this.initialize(sID,clipClass,var5,var6,var7,null);
	}
	function __set__name(§\x1e\n\x0f§)
	{
		this._aNamesList = new Array();
		var var3 = var2.split(",");
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = this.api.lang.getMonstersText(var3[var4]);
			this._aNamesList.push(var5.n);
			if(var5.a != -1)
			{
				this._nAlignmentIndex = var5.a;
			}
			var4 = var4 + 1;
		}
		return this.__get__name();
	}
	function __get__name()
	{
		return this.getName();
	}
	function getName(§\x1e\x13\x06§)
	{
		var2 = var2 != undefined?var2:"\n";
		var var3 = new Array();
		var var4 = 0;
		while(var4 < this._aLevelsList.length)
		{
			var3.push({level:Number(this._aLevelsList[var4]),name:this._aNamesList[var4]});
			var4 = var4 + 1;
		}
		var3.sortOn(["level"],Array.DESCENDING | Array.NUMERIC);
		var var5 = new String();
		var var6 = 0;
		while(var6 < var3.length)
		{
			var var7 = var3[var6];
			var5 = var5 + (var7.name + " (" + var7.level + ")" + var2);
			var6 = var6 + 1;
		}
		return var5;
	}
	function alertChatText()
	{
		var var2 = this.api.datacenter.Map;
		return "Groupe niveau " + this.totalLevel + " en " + var2.x + "," + var2.y + " : <br/>" + this.getName("<br/>");
	}
	function __set__Level(§\x1e\n\x0f§)
	{
		this._aLevelsList = var2.split(",");
		return this.__get__Level();
	}
	function __get__totalLevel()
	{
		var var2 = 0;
		var var3 = 0;
		while(var3 < this._aLevelsList.length)
		{
			var2 = var2 + Number(this._aLevelsList[var3]);
			var3 = var3 + 1;
		}
		return var2;
	}
	function __get__bonusValue()
	{
		return this._nBonusValue;
	}
	function __get__alignment()
	{
		return new dofus.datacenter.(this._nAlignmentIndex,0);
	}
}
