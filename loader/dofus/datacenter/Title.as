class dofus.datacenter.Title
{
	function Title(§\r\x1b§, param)
	{
		this.api = _global.API;
		this._id = var2;
		switch(this.api.lang.getTitle(var2).pt)
		{
			case 1:
				var var4 = this.api.lang.getTitle(var2).t.split("%1").join(this.api.lang.getMonsters()[_global.parseInt(param)].n);
				break;
			case 0:
			default:
				var4 = this.api.lang.getTitle(var2).t.split("%1").join(param);
		}
		this._text = "« " + var4 + " »";
		this._color = this.api.lang.getTitle(var2).c;
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
