class dofus.graphics.battlefield.SmileyOverHead extends MovieClip
{
	function SmileyOverHead(loc3)
	{
		super();
		this.draw(loc3);
	}
	function __get__height()
	{
		return 20;
	}
	function __get__width()
	{
		return 20;
	}
	function draw(loc2)
	{
		this.attachMovie("Loader","_ldrSmiley",10,{_x:-10,_width:20,_height:20,scaleContent:true,contentPath:dofus.Constants.SMILEYS_ICONS_PATH + loc2 + ".swf"});
	}
}
