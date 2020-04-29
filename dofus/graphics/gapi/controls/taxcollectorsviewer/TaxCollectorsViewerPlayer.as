class dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerPlayer extends ank.gapi.core.UIBasicComponent
{
	function TaxCollectorsViewerPlayer()
	{
		super();
	}
	function __set__data(var2)
	{
		if(var2 != this._oData)
		{
			this._oData = var2;
			this.addToQueue({object:this,method:this.setSprite});
		}
		return this.__get__data();
	}
	function init()
	{
		super.init(false);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._ldrSprite.addEventListener("initialization",this);
	}
	function setSprite()
	{
		this._ldrSprite.contentPath = this._oData.gfxFile != undefined?this._oData.gfxFile:"";
	}
	function initialization(var2)
	{
		var var3 = var2.clip;
		_global.GAC.addSprite(var3,this._oData);
		var3.attachMovie("staticR","mcAnim",10);
		var3._xscale = -80;
		var3._yscale = 80;
	}
}
