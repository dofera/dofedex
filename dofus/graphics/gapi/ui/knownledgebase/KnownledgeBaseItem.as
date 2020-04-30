class dofus.graphics.gapi.ui.Login.KnownledgeBaseItem extends ank.gapi.core.UIBasicComponent
{
	function KnownledgeBaseItem()
	{
		super();
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			this._lblItem.text = var4.n;
			var var5 = var4.c == undefined;
			this._mcCategory._visible = var5;
			this._mcArticle._visible = !var5;
			if(!var5 && !this._bWasArticle)
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
