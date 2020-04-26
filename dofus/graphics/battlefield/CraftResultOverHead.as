class dofus.graphics.battlefield.CraftResultOverHead extends ank.gapi.core.UIBasicComponent
{
	function CraftResultOverHead(loc3, loc4)
	{
		super();
		this.initialize();
		this.draw(loc3,loc4);
	}
	function __get__height()
	{
		return 33;
	}
	function __get__width()
	{
		return 62;
	}
	function initialize()
	{
		this.attachMovie("CraftResultOverHeadBubble","_mcBack",10);
	}
	function reverseClip()
	{
		this._mcBack._yscale = -100;
		this._mcBack._y = this._mcBack._y + (this._mcBack._height - 7);
	}
	function draw(loc2, loc3)
	{
		if(loc3 == undefined)
		{
			this.attachMovie("CraftResultOverHeadCross","_mcCross",40);
			this._ldrItem.removeMovieClip();
		}
		else
		{
			this.attachMovie("Loader","_ldrItem",20,{_x:6,_y:4,_width:20,_height:20,scaleContent:true,contentPath:loc3.iconFile});
			this._mcCross.removeMovieClip();
		}
		if(!loc2)
		{
			this.attachMovie("CraftResultOverHeadMiss","_mcMiss",30);
		}
		else
		{
			this._mcMiss.removeMovieClip();
		}
	}
}
