class ank.gapi.controls.StylizedRectangle extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "StylizedRectangle";
	function StylizedRectangle()
	{
		super();
	}
	function init()
	{
		super.init(false,ank.gapi.controls.StylizedRectangle.CLASS_NAME);
	}
	function createChildren()
	{
		this.createEmptyMovieClip("_mcBackground",10);
	}
	function size()
	{
		super.size();
		this.arrange();
	}
	function arrange()
	{
		if(this._bInitialized)
		{
			this.draw();
		}
	}
	function draw()
	{
		var loc2 = this.getStyle();
		var loc3 = loc2.cornerradius;
		var loc4 = loc2.bgcolor;
		var loc5 = loc2.alpha;
		this._mcBackground.clear();
		this.drawRoundRect(this._mcBackground,0,0,this.__width,this.__height,loc3,loc4,loc5);
	}
}
