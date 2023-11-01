class dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItem extends ank.gapi.core.UIBasicComponent
{
	function ListInventoryViewerItem()
	{
		super();
	}
	function __set__list(var2)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			this._lblPrice.text = !var2?"":new ank.utils.(var4.price).addMiddleChar(this._mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
			var var5 = this._lblPrice.textWidth;
			this._lblName.text = !var2?"":(var4.Quantity <= 1?"":"x" + var4.Quantity + " ") + var4.name;
			this._lblName.setSize(this.__width - var5 - 30,this.__height);
			this._lblName.styleName = var4.style != ""?var4.style + "LeftSmallLabel":"BrownLeftSmallLabel";
			this._ldrIcon.contentPath = !var2?"":var4.iconFile;
			this._ldrIcon.contentParams = var4.params;
		}
		else if(this._lblPrice.text != undefined)
		{
			this._lblPrice.text = "";
			this._lblName.text = "";
			this._ldrIcon.contentPath = "";
		}
	}
	function init()
	{
		super.init(false);
	}
	function createChildren()
	{
		this.arrange();
	}
	function size()
	{
		super.size();
		this.addToQueue({object:this,method:this.arrange});
	}
	function arrange()
	{
		this._lblName.setSize(this.__width - 50,this.__height);
		this._lblPrice.setSize(this.__width - 20,this.__height);
	}
}
