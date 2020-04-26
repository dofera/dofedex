class ank.gapi.controls.scrollbar.ScrollThumb extends MovieClip
{
	function ScrollThumb()
	{
		super();
	}
	function __set__height(loc2)
	{
		this.top_mc._y = 0;
		this.middle_mc._y = this.top_mc._height;
		this.middle_mc._height = loc2 - this.top_mc._height - this.bottom_mc._height;
		this.bottom_mc._y = this.middle_mc._y + this.middle_mc._height;
		return this.__get__height();
	}
}
