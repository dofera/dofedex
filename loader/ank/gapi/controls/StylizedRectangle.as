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
		var var2 = this.getStyle();
		var var3 = var2.cornerradius;
		var var4 = var2.bgcolor;
		var var5 = var2.alpha;
		this._mcBackground.clear();
		this.drawRoundRect(this._mcBackground,0,0,this.__width,this.__height,var3,var4,var5);
	}
}
