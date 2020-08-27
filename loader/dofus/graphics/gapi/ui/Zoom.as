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
	function setZoom(var2)
	{
		if(this._vsZoom.value < this._vsZoom.min + this._vsZoom.min * 10 / 100)
		{
			this.api.kernel.GameManager.zoomGfx();
		}
		else if(var2)
		{
			this.api.kernel.GameManager.zoomGfx(this._vsZoom.value,this._oSprite.mc._x,this._oSprite.mc._y - 20);
		}
		else
		{
			var var3 = this.api.gfx.getZoom();
			var var4 = (_root._xmouse - this.api.gfx.container._x) * 100 / var3;
			var var5 = (_root._ymouse - this.api.gfx.container._y) * 100 / var3;
			this.api.kernel.GameManager.zoomGfx(this._vsZoom.value,var4,var5,_root._xmouse,_root._ymouse);
		}
	}
	function onMouseWheel(var2)
	{
		this._vsZoom.value = this._vsZoom.value + var2 * 5;
		this.setZoom(false);
	}
	function click(var2)
	{
		if((var var0 = var2.target) === this._btnCancel)
		{
			this.callClose();
		}
	}
	function change(var2)
	{
		this.setZoom(true);
	}
	function over(var2)
	{
		this.gapi.showTooltip(this.api.lang.getText("CLOSE"),var2.target,-20);
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
}
