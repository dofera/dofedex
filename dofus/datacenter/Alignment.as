class dofus.datacenter.Alignment implements com.ankamagames.interfaces.IComparable
{
	var fallenAngelDemon = false;
	function Alignment(loc3, loc4)
	{
		this.api = _global.API;
		this.initialize(loc2,loc3);
	}
	function __get__index()
	{
		return this._nIndex;
	}
	function __set__index(loc2)
	{
		this._nIndex = !(_global.isNaN(loc2) || loc2 == undefined)?loc2:0;
		return this.__get__index();
	}
	function __get__name()
	{
		if(this._nIndex == -1)
		{
			return "";
		}
		return this.api.lang.getAlignment(this._nIndex).n;
	}
	function __get__value()
	{
		return this._nValue;
	}
	function __set__value(loc2)
	{
		this._nValue = !(_global.isNaN(loc2) || loc2 == undefined)?loc2:0;
		return this.__get__value();
	}
	function __get__frame()
	{
		if(this._nValue <= 20)
		{
			return 1;
		}
		if(this._nValue <= 40)
		{
			return 2;
		}
		if(this._nValue <= 60)
		{
			return 3;
		}
		if(this._nValue <= 80)
		{
			return 4;
		}
		return 5;
	}
	function __get__iconFile()
	{
		return dofus.Constants.ALIGNMENTS_PATH + this._nIndex + ".swf";
	}
	function initialize(loc2, loc3)
	{
		this._nIndex = !(_global.isNaN(loc2) || loc2 == undefined)?loc2:0;
		this._nValue = !(_global.isNaN(loc3) || loc3 == undefined)?loc3:0;
	}
	function clone()
	{
		return new dofus.datacenter.(this._nIndex,this._nValue);
	}
	function compareTo(loc2)
	{
		var loc3 = (dofus.datacenter.Alignment)loc2;
		if(loc3.index == this._nIndex)
		{
			return 0;
		}
		return -1;
	}
}
