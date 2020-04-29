class dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTreeItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var DEPTH_X_OFFSET = 10;
	function AlignmentViewerTreeItem()
	{
		super();
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			var var5 = dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTreeItem.DEPTH_X_OFFSET * var4.depth;
			if(var4.data instanceof dofus.datacenter.Alignment)
			{
				this._ldrIcon._x = this._nLdrX + var5;
				this._lblName._x = this._nLdrX + var5;
				this._lblName.width = this.__width - this._lblName._x;
				this._lblName.styleName = "BrownLeftMediumBoldLabel";
				this._mcBackgroundLight._visible = false;
				this._mcBackgroundDark._visible = true;
				this._ldrIcon.contentPath = "";
				this._lblName.text = var4.data.name;
				this._lblLevel.text = "";
			}
			if(var4.data instanceof dofus.datacenter.Order)
			{
				this._ldrIcon._x = this._nLdrX + var5;
				this._lblName._x = this._nLblX + var5;
				this._lblName.width = this.__width - this._lblName._x;
				this._lblName.styleName = "BrownLeftSmallBoldLabel";
				this._mcBackgroundLight._visible = false;
				this._mcBackgroundDark._visible = false;
				this._ldrIcon.contentPath = var4.data.iconFile;
				this._lblName.text = var4.data.name;
				this._lblLevel.text = "";
			}
			else if(var4.data instanceof dofus.datacenter.Specialization)
			{
				this._ldrIcon._x = this._nLdrX + var5;
				this._lblName._x = this._nLblX + var5;
				this._lblName.width = this.__width - this._lblName._x;
				this._lblName.styleName = "BrownLeftSmallLabel";
				this._mcBackgroundLight._visible = false;
				this._mcBackgroundDark._visible = false;
				this._ldrIcon.contentPath = "";
				this._lblLevel.text = var4.data.alignment.value <= 0?"- ":var4.data.alignment.value + " ";
				this._lblName.text = var4.data.name;
				this._lblLevel.setSize(this.__width);
				this._lblName.setSize(this.__width - this._lblName._x - this._lblLevel.textWidth - 30);
			}
		}
		else if(this._lblName.text != undefined)
		{
			this._ldrIcon._x = this._nLdrX;
			this._lblName._x = this._nLblX;
			this._ldrIcon.contentPath = "";
			this._lblName.text = "";
			this._lblLevel.text = "";
			this._mcBackgroundLight._visible = false;
			this._mcBackgroundDark._visible = false;
		}
	}
	function init()
	{
		super.init(false);
		this._nLdrX = this._ldrIcon._x;
		this._nLblX = this._lblName._x;
	}
}
