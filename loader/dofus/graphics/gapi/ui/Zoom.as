class dofus.graphics.gapi.ui.Zoom extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Zoom";
	function Zoom()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Zoom.CLASS_NAME);
		this._visible = false;
	}
	function callClose()
	{
		Mouse.removeListener(this);
		this.unloadThis();
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnCancel.addEventListener("click",this);
		this._btnCancel.addEventListener("over",this);
		this._btnCancel.addEventListener("out",this);
		this._vsZoom.addEventListener("change",this);
		this._vsZoom.min = this.api.gfx.getZoom();
		var var2 = this.createEmptyMovieClip("mouseupevent",this.getNextHighestDepth());
		var oAPI = this.api;
		var2.onMouseUp = function()
		{
			oAPI.mouseClicksMemorizer.storeCurrentMouseClick(false);
		};
		Mouse.addListener(this);
	}
	function setZoom()
	{
		this.api.kernel.GameManager.zoomGfxRoot(this._vsZoom.value,this._nXScreenPos,this._nYScreenPos);
	}
	function onMouseWheel(var2, var3)
	{
		if(!dofus.graphics.gapi.ui.Zoom.isZooming())
		{
			return undefined;
		}
		if(this._vsZoom.value == 100)
		{
			this._nXScreenPos = _root._xmouse;
			this._nYScreenPos = _root._ymouse;
		}
		this._vsZoom.value = this._vsZoom.value + var2 * 10;
		this.setZoom();
	}
	function click(var2)
	{
		if((var var0 = var2.target) === this._btnCancel)
		{
			this.callClose();
		}
	}
	static function isZooming()
	{
		return Key.isDown(Key.CONTROL) && !Key.isDown(Key.SHIFT);
	}
}
