class dofus.graphics.gapi.ui.knownledgebase.KnownledgeBaseItem extends ank.gapi.core.UIBasicComponent
{
	function KnownledgeBaseItem()
	{
		super();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._lblItem.text = loc4.n;
			var loc5 = loc4.c == undefined;
			this._mcCategory._visible = loc5;
			this._mcArticle._visible = !loc5;
			if(!loc5 && !this._bWasArticle)
			{
				this._lblItem._x = this._lblItem._x + 10;
				this._mcArticle._x = this._mcArticle._x + 10;
				this._bWasArticle = true;
			}
		}
		else if(this._lblItem.text != undefined)
		{
			this._lblItem.text = "";
			this._mcArticle._visible = false;
			this._mcCategory._visible = false;
			if(this._bWasArticle)
			{
				this._lblItem._x = this._lblItem._x - 10;
				this._mcArticle._x = this._mcArticle._x - 10;
				this._bWasArticle = false;
			}
		}
	}
	function KnownledgeBaseCategoryItem()
	{
		this._mcArticle._visible = false;
		this._mcCategory._visible = false;
	}
	function init()
	{
		super.init(false);
	}
}
