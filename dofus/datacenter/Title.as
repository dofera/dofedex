class dofus.datacenter.Title
{
	function Title(§\r\x1d§, param)
	{
		this.api = _global.API;
		this._id = loc2;
		switch(this.api.lang.getTitle(loc2).pt)
		{
			case 1:
				var loc4 = this.api.lang.getTitle(loc2).t.split("%1").join(this.api.lang.getMonsters()[_global.parseInt(param)].n);
				break;
			case 0:
			default:
				loc4 = this.api.lang.getTitle(loc2).t.split("%1").join(param);
		}
		this._text = "« " + loc4 + " »";
		this._color = this.api.lang.getTitle(loc2).c;
	}
	function __get__color()
	{
		return this._color;
	}
	function __get__text()
	{
		return this._text;
	}
}
