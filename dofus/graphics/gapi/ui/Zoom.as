class dofus.graphics.gapi.ui.Zoom extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Zoom";
	function Zoom()
	{
		super();
	}
	function __set__sprite(oSprite)
	{
		this._oSprite = oSprite;
		return this.__get__sprite();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Zoom.CLASS_NAME);
	}
	function callClose()
	{
		Mouse.removeListener(this);
		this.api.kernel.GameManager.zoomGfx();
		this.unloadThis();
	}
	function createChildren()
	{
		Mouse.addListener(this);
		this.api.kernel.GameManager.zoomGfx();
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnCancel.addEventListener("click",this);
		this._btnCancel.addEventListener("over",this);
		this._btnCancel.addEventListener("out",this);
		this._vsZoom.addEventListener("change",this);
		this._vsZoom.min = this.api.gfx.getZoom();
	}
	function setZoom(loc2)
	{
		if(this._vsZoom.value < this._vsZoom.min + this._vsZoom.min * 10 / 100)
		{
			this.api.kernel.GameManager.zoomGfx();
		}
		else if(loc2)
		{
			this.api.kernel.GameManager.zoomGfx(this._vsZoom.value,this._oSprite.mc._x,this._oSprite.mc._y - 20);
		}
		else
		{
			var loc3 = this.api.gfx.getZoom();
			var loc4 = (_root._xmouse - this.api.gfx.container._x) * 100 / loc3;
			var loc5 = (_root._ymouse - this.api.gfx.container._y) * 100 / loc3;
			this.api.kernel.GameManager.zoomGfx(this._vsZoom.value,loc4,loc5,_root._xmouse,_root._ymouse);
		}
	}
	function onMouseWheel(loc2)
	{
		this._vsZoom.value = this._vsZoom.value + loc2 * 5;
		this.setZoom(false);
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target) === this._btnCancel)
		{
			this.callClose();
		}
	}
	function change(loc2)
	{
		this.setZoom(true);
	}
	function over(loc2)
	{
		this.gapi.showTooltip(this.api.lang.getText("CLOSE"),loc2.target,-20);
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
