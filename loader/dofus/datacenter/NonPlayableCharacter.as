class dofus.datacenter.NonPlayableCharacter extends ank.battlefield.datacenter.Sprite
{
	function NonPlayableCharacter(sID, clipClass, §\x1e\x12\f§, §\x13\n§, §\x11\b§, gfxID, §\x11\x1b§)
	{
		super();
		this.api = _global.API;
		if(this.__proto__ == dofus.datacenter.NonPlayableCharacter.prototype)
		{
			this.initialize(sID,clipClass,var5,var6,var7,gfxID,var9);
		}
	}
	function __get__unicID()
	{
		return this._nUnicID;
	}
	function __set__unicID(§\x1e\n\x0f§)
	{
		this._nUnicID = var2;
		this._oNpcText = this.api.lang.getNonPlayableCharactersText(var2);
		return this.__get__unicID();
	}
	function __get__name()
	{
		return this.api.lang.fetchString(this._oNpcText.n);
	}
	function __get__actions()
	{
		var var2 = new Array();
		var var3 = this._oNpcText.a;
		var var4 = var3.length;
		while(true)
		{
			var4;
			if(var4-- > 0)
			{
				var var5 = var3[var4];
				var2.push({name:this.api.lang.getNonPlayableCharactersActionText(var3[var4]),actionId:var5,action:this.getActionFunction(var3[var4])});
				continue;
			}
			break;
		}
		return var2;
	}
	function __get__gfxID()
	{
		return this._gfxID;
	}
	function __set__gfxID(§\x1e\n\x0f§)
	{
		this._gfxID = var2;
		return this.__get__gfxID();
	}
	function __get__extraClipID()
	{
		return this._nExtraClipID;
	}
	function __set__extraClipID(§\x05\x19§)
	{
		this._nExtraClipID = var2;
		return this.__get__extraClipID();
	}
	function __get__customArtwork()
	{
		return this._nCustomArtwork;
	}
	function __set__customArtwork(§\x07\x01§)
	{
		this._nCustomArtwork = var2;
		return this.__get__customArtwork();
	}
	function initialize(sID, clipClass, §\x1e\x12\f§, §\x13\n§, §\x11\b§, gfxID, §\x11\x1b§)
	{
		super.initialize(sID,clipClass,var5,var6,var7);
		this._gfxID = gfxID;
		this._nCustomArtwork = var9;
	}
	function getActionFunction(§\t\x0f§)
	{
		switch(var2)
		{
			case 1:
				return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[0,this.id]};
			case 2:
				return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[2,this.id]};
			case 3:
				return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startDialog,params:[this.id]};
			default:
				switch(null)
				{
					case 4:
						return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[9,this.id]};
					case 5:
						return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[10,this.id]};
					case 6:
						return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[11,this.id]};
					case 7:
						return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[17,this.id]};
					default:
						if(var0 !== 8)
						{
							return new Object();
						}
						return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[18,this.id]};
				}
		}
	}
}
