class dofus.datacenter.NonPlayableCharacter extends ank.battlefield.datacenter.Sprite
{
	function NonPlayableCharacter(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, gfxID, §\x12\x13§)
	{
		super();
		this.api = _global.API;
		if(this.__proto__ == dofus.datacenter.NonPlayableCharacter.prototype)
		{
			this.initialize(sID,clipClass,loc5,cellNum,loc7,gfxID,loc9);
		}
	}
	function __set__unicID(loc2)
	{
		this._oNpcText = this.api.lang.getNonPlayableCharactersText(loc2);
		return this.__get__unicID();
	}
	function __get__name()
	{
		return this.api.lang.fetchString(this._oNpcText.n);
	}
	function __get__actions()
	{
		var loc2 = new Array();
		var loc3 = this._oNpcText.a;
		var loc4 = loc3.length;
		while(true)
		{
			loc4;
			if(loc4-- > 0)
			{
				var loc5 = loc3[loc4];
				loc2.push({name:this.api.lang.getNonPlayableCharactersActionText(loc3[loc4]),actionId:loc5,action:this.getActionFunction(loc3[loc4])});
				continue;
			}
			break;
		}
		return loc2;
	}
	function __get__gfxID()
	{
		return this._gfxID;
	}
	function __set__gfxID(loc2)
	{
		this._gfxID = loc2;
		return this.__get__gfxID();
	}
	function __get__extraClipID()
	{
		return this._nExtraClipID;
	}
	function __set__extraClipID(loc2)
	{
		this._nExtraClipID = loc2;
		return this.__get__extraClipID();
	}
	function __get__customArtwork()
	{
		return this._nCustomArtwork;
	}
	function __set__customArtwork(loc2)
	{
		this._nCustomArtwork = loc2;
		return this.__get__customArtwork();
	}
	function initialize(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, gfxID, §\x12\x13§)
	{
		super.initialize(sID,clipClass,loc5,cellNum,loc7);
		this._gfxID = gfxID;
		this._nCustomArtwork = loc9;
	}
	function getActionFunction(loc2)
	{
		switch(loc2)
		{
			case 1:
				return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[0,this.id]};
			case 2:
				return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[2,this.id]};
			case 3:
				return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startDialog,params:[this.id]};
			case 4:
				return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[9,this.id]};
			default:
				switch(null)
				{
					case 5:
						return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[10,this.id]};
					case 6:
						return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[11,this.id]};
					case 7:
						return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[17,this.id]};
					case 8:
						return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[18,this.id]};
					default:
						return new Object();
				}
		}
	}
}
