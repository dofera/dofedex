class dofus.datacenter.Mount extends Object
{
	var useCustomColor = false;
	function Mount(nModelID, nChevauchorGfxID, bNewBorn)
	{
		super();
		eval("\n\x0b").events.EventDispatcher.initialize(this);
		this.newBorn = bNewBorn;
		this.modelID = nModelID;
		this._lang = _global.API.lang.getMountText(this.modelID);
		this.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + this._lang.g + ".swf";
		this.chevauchorGfxID = nChevauchorGfxID;
	}
	function __set__name(loc2)
	{
		this._sName = loc2;
		this.dispatchEvent({type:"nameChanged",name:loc2});
		return this.__get__name();
	}
	function __get__name()
	{
		return this._sName;
	}
	function __set__pods(loc2)
	{
		this._nPods = loc2;
		this.dispatchEvent({type:"podsChanged",pods:loc2});
		return this.__get__pods();
	}
	function __get__pods()
	{
		return this._nPods;
	}
	function __get__label()
	{
		return this._lang.n;
	}
	function __get__modelName()
	{
		return this._lang.n;
	}
	function __get__gfxID()
	{
		return this._lang.g;
	}
	function __set__chevauchorGfxID(loc2)
	{
		this._nChevauchorGfxID = loc2;
		this.chevauchorGfxFile = dofus.Constants.CHEVAUCHOR_PATH + loc2 + ".swf";
		return this.__get__chevauchorGfxID();
	}
	function __get__chevauchorGfxID()
	{
		return this._nChevauchorGfxID;
	}
	function __get__color1()
	{
		if(!_global.isNaN(this.customColor1))
		{
			return this.customColor1;
		}
		return this._lang.c1;
	}
	function __get__color2()
	{
		if(!_global.isNaN(this.customColor2))
		{
			return this.customColor2;
		}
		return this._lang.c2;
	}
	function __get__color3()
	{
		if(!_global.isNaN(this.customColor3))
		{
			return this.customColor3;
		}
		return this._lang.c3;
	}
	function __get__mature()
	{
		return this.maturity == this.maturityMax && (this.maturity != undefined && this.maturityMax != undefined);
	}
	function __get__effects()
	{
		return dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects);
	}
	function setEffects(loc2)
	{
		this._sEffects = loc2;
		this._aEffects = new Array();
		var loc3 = loc2.split(",");
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = loc3[loc4].split("#");
			loc5[0] = _global.parseInt(loc5[0],16);
			loc5[1] = loc5[1] != "0"?_global.parseInt(loc5[1],16):undefined;
			loc5[2] = loc5[2] != "0"?_global.parseInt(loc5[2],16):undefined;
			loc5[3] = loc5[3] != "0"?_global.parseInt(loc5[3],16):undefined;
			loc5[4] = loc5[4];
			this._aEffects.push(loc5);
			loc4 = loc4 + 1;
		}
	}
	function getToolTip()
	{
		var loc2 = this.modelName;
		loc2 = loc2 + ("\n" + _global.API.lang.getText("NAME_BIG") + " : " + this.name);
		loc2 = loc2 + ("\n" + _global.API.lang.getText("LEVEL") + " : " + this.level);
		loc2 = loc2 + ("\n" + _global.API.lang.getText("CREATE_SEX") + " : " + (!this.sex?_global.API.lang.getText("ANIMAL_MEN"):_global.API.lang.getText("ANIMAL_WOMEN")));
		loc2 = loc2 + ("\n" + _global.API.lang.getText("MOUNTABLE") + " : " + (!this.mountable?_global.API.lang.getText("NO"):_global.API.lang.getText("YES")));
		loc2 = loc2 + ("\n" + _global.API.lang.getText("WILD") + " : " + (!this.wild?_global.API.lang.getText("NO"):_global.API.lang.getText("YES")));
		if(this.fecondation > 0)
		{
			loc2 = loc2 + ("\n" + _global.API.lang.getText("PREGNANT_SINCE",[this.fecondation]));
		}
		else if(this.fecondable)
		{
			loc2 = loc2 + ("\n" + _global.API.lang.getText("FECONDABLE"));
		}
		return loc2;
	}
}
