class ank.gapi.controls.BackgroundHidder extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "BackgroundHidder";
	function BackgroundHidder()
	{
		super();
	}
	function __set__handCursor(loc2)
	{
		this.useHandCursor = loc2;
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
		var loc2 = this.getStyle();
		var loc3 = loc2.backgroundcolor != undefined?loc2.backgroundcolor:0;
		var loc4 = loc2.backgroundalpha != undefined?loc2.backgroundalpha:10;
		this.hidden_mc.clear();
		this.drawRoundRect(this.hidden_mc,0,0,1,1,0,loc3,loc4);
	}
}
