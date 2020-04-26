class dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerPlayer extends ank.gapi.core.UIBasicComponent
{
	function TaxCollectorsViewerPlayer()
	{
		super();
	}
	function __set__data(loc2)
	{
		if(loc2 != this._oData)
		{
			this._oData = loc2;
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
	function initialization(loc2)
	{
		var loc3 = loc2.clip;
		_global.GAC.addSprite(loc3,this._oData);
		loc3.attachMovie("staticR","mcAnim",10);
		loc3._xscale = -80;
		loc3._yscale = 80;
	}
}
