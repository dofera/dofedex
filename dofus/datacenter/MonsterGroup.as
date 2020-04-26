class dofus.datacenter.MonsterGroup extends ank.battlefield.datacenter.Sprite
{
	var _sDefaultAnimation = "static";
	var _bAllDirections = false;
	var _bForceWalk = true;
	var _nAlignmentIndex = -1;
	function MonsterGroup(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, bonus)
	{
		super();
		this.api = _global.API;
		this._nBonusValue = bonus;
		this.initialize(sID,clipClass,loc5,cellNum,loc7,null);
	}
	function __set__name(loc2)
	{
		this._aNamesList = new Array();
		var loc3 = loc2.split(",");
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = this.api.lang.getMonstersText(loc3[loc4]);
			this._aNamesList.push(loc5.n);
			if(loc5.a != -1)
			{
				this._nAlignmentIndex = loc5.a;
			}
			loc4 = loc4 + 1;
		}
		return this.__get__name();
	}
	function __get__name()
	{
		return this.getName();
	}
	function getName(loc2)
	{
		loc2 = loc2 != undefined?loc2:"\n";
		var loc3 = new Array();
		var loc4 = 0;
		while(loc4 < this._aLevelsList.length)
		{
			loc3.push({level:Number(this._aLevelsList[loc4]),name:this._aNamesList[loc4]});
			loc4 = loc4 + 1;
		}
		loc3.sortOn(["level"],Array.DESCENDING | Array.NUMERIC);
		var loc5 = new String();
		var loc6 = 0;
		while(loc6 < loc3.length)
		{
			var loc7 = loc3[loc6];
			loc5 = loc5 + (loc7.name + " (" + loc7.level + ")" + loc2);
			loc6 = loc6 + 1;
		}
		return loc5;
	}
	function alertChatText()
	{
		var loc2 = this.api.datacenter.Map;
		return "Groupe niveau " + this.totalLevel + " en " + loc2.x + "," + loc2.y + " : <br/>" + this.getName("<br/>");
	}
	function __set__Level(loc2)
	{
		this._aLevelsList = loc2.split(",");
		return this.__get__Level();
	}
	function __get__totalLevel()
	{
		var loc2 = 0;
		var loc3 = 0;
		while(loc3 < this._aLevelsList.length)
		{
			loc2 = loc2 + Number(this._aLevelsList[loc3]);
			loc3 = loc3 + 1;
		}
		return loc2;
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
