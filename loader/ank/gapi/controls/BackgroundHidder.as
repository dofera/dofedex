class ank.gapi.controls.BackgroundHidder extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "BackgroundHidder";
	function BackgroundHidder()
	{
		super();
	}
	function __set__handCursor(§\x19\x0f§)
	{
		this.useHandCursor = var2;
		return this.__get__handCursor();
	}
	function init()
	{
		super.init(false,ank.gapi.controls.BackgroundHidder.CLASS_NAME);
	}
	function createChildren()
	{
		this.createEmptyMovieClip("hidden_mc",10);
		this.onRelease = function()
		{
			this.dispatchEvent({type:"click"});
		};
	}
	function arrange()
	{
		this.hidden_mc._width = this.__width;
		this.hidden_mc._height = this.__height;
	}
	function draw()
	{
		var var2 = this.getStyle();
		var var3 = var2.backgroundcolor != undefined?var2.backgroundcolor:0;
		var var4 = var2.backgroundalpha != undefined?var2.backgroundalpha:10;
		this.hidden_mc.clear();
		this.drawRoundRect(this.hidden_mc,0,0,1,1,0,var3,var4);
	}
}
