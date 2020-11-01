class dofus.graphics.gapi.ui.ItemFound extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ItemFound";
	var _nTimer = 0;
	function ItemFound()
	{
		super();
	}
	function __set__itemId(var2)
	{
		this._nItemId = var2;
		return this.__get__itemId();
	}
	function __set__qty(var2)
	{
		this._nQty = var2;
		return this.__get__qty();
	}
	function __set__ressourceId(var2)
	{
		this._nRessourceId = var2;
		return this.__get__ressourceId();
	}
	function __set__timer(var2)
	{
		this._nTimer = var2;
		return this.__get__timer();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.ItemFound.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		if(this._nTimer != 0)
		{
			ank.utils.Timer.setTimer(this,"itemFound",this,this.hide,this._nTimer);
		}
	}
	function initTexts()
	{
		var var2 = new dofus.datacenter.(0,this._nItemId,this._nQty);
		var var3 = new dofus.datacenter.(0,this._nRessourceId,1);
		this._ldrItem.contentPath = var2.iconFile;
		this._txtDescription.text = this.api.lang.getText("ITEM_FOUND",[this._nQty,var2.name,var3.name]);
	}
	function hide()
	{
		this._alpha = this._alpha - 5;
		if(this._alpha < 1)
		{
			this.unloadThis();
			return undefined;
		}
		this.addToQueue({object:this,method:this.hide});
	}
}
