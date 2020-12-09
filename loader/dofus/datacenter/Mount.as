class dofus.datacenter.Mount extends Object
{
	var useCustomColor = false;
	function Mount(nModelID, nChevauchorGfxID, bNewBorn)
	{
		super();
		mx.events.EventDispatcher.initialize(this);
		this.newBorn = bNewBorn;
		this.modelID = nModelID;
		this._lang = _global.API.lang.getMountText(this.modelID);
		this.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + this._lang.g + ".swf";
		this.chevauchorGfxID = nChevauchorGfxID;
	}
	function __set__name(§\x1e\n\x0f§)
	{
		this._sName = var2;
		this.dispatchEvent({type:"nameChanged",name:var2});
		return this.__get__name();
	}
	function __get__name()
	{
		return this._sName;
	}
	function __set__pods(§\x1e\n\x0f§)
	{
		this._nPods = var2;
		this.dispatchEvent({type:"podsChanged",pods:var2});
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
	function __set__chevauchorGfxID(§\x05\x02§)
	{
		this._nChevauchorGfxID = var2;
		this.chevauchorGfxFile = dofus.Constants.CHEVAUCHOR_PATH + var2 + ".swf";
		return this.__get__chevauchorGfxID();
	}
	function __get__chevauchorGfxID()
	{
		return this._nChevauchorGfxID;
	}
	function __get__isChameleon()
	{
		for(var var2 in this.capacities)
		{
			if(var2 == 9)
			{
				return true;
			}
		}
		return false;
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
	function setEffects(§\x12\x14§)
	{
		this._sEffects = var2;
		this._aEffects = new Array();
		var var3 = var2.split(",");
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = var3[var4].split("#");
			var5[0] = _global.parseInt(var5[0],16);
			var5[1] = var5[1] != "0"?_global.parseInt(var5[1],16):undefined;
			var5[2] = var5[2] != "0"?_global.parseInt(var5[2],16):undefined;
			var5[3] = var5[3] != "0"?_global.parseInt(var5[3],16):undefined;
			var5[4] = var5[4];
			this._aEffects.push(var5);
			var4 = var4 + 1;
		}
	}
	function getToolTip()
	{
		var var2 = this.modelName;
		var2 = var2 + ("\n" + _global.API.lang.getText("NAME_BIG") + " : " + this.name);
		var2 = var2 + ("\n" + _global.API.lang.getText("LEVEL") + " : " + this.level);
		var2 = var2 + ("\n" + _global.API.lang.getText("CREATE_SEX") + " : " + (!this.sex?_global.API.lang.getText("ANIMAL_MEN"):_global.API.lang.getText("ANIMAL_WOMEN")));
		var2 = var2 + ("\n" + _global.API.lang.getText("MOUNTABLE") + " : " + (!this.mountable?_global.API.lang.getText("NO"):_global.API.lang.getText("YES")));
		var2 = var2 + ("\n" + _global.API.lang.getText("WILD") + " : " + (!this.wild?_global.API.lang.getText("NO"):_global.API.lang.getText("YES")));
		if(this.fecondation > 0)
		{
			var2 = var2 + ("\n" + _global.API.lang.getText("PREGNANT_SINCE",[this.fecondation]));
		}
		else if(this.fecondable)
		{
			var2 = var2 + ("\n" + _global.API.lang.getText("FECONDABLE"));
		}
		return var2;
	}
}
