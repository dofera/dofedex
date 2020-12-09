class dofus.graphics.gapi.controls.statsviewer.StatsViewerStatItem extends ank.gapi.core.UIBasicComponent
{
	function StatsViewerStatItem()
	{
		super();
	}
	function __set__list(§\x0b\x05§)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		if(var2)
		{
			this._oItem = var4;
			if(var4.isCat)
			{
				this._mcCatBackground._visible = true;
				this._ldrIcon.contentPath = "";
				this._lblCatName.text = var4.name;
				this._lblName.text = "";
				this._lblBase.text = "";
				this._lblItems.text = "";
				this._lblAlign.text = "";
				this._lblBoost.text = "";
				this._lblTotal.text = "";
			}
			else
			{
				this._mcCatBackground._visible = false;
				if(var4.p != undefined)
				{
					this._ldrIcon.contentPath = var4.p;
				}
				else
				{
					this._ldrIcon.contentPath = "";
				}
				this._lblCatName.text = "";
				this._lblName.text = var4.name;
				if(var4.s != 0)
				{
					this._lblBase.text = var4.s;
					if(var4.s > 0)
					{
						this._lblBase.styleName = "GreenCenterSmallLabel";
					}
					else
					{
						this._lblBase.styleName = "RedCenterSmallLabel";
					}
				}
				else
				{
					this._lblBase.text = "-";
					this._lblBase.styleName = "BrownCenterSmallLabel";
				}
				if(var4.i != 0)
				{
					this._lblItems.text = var4.i;
					if(var4.i > 0)
					{
						this._lblItems.styleName = "GreenCenterSmallLabel";
					}
					else
					{
						this._lblItems.styleName = "RedCenterSmallLabel";
					}
				}
				else
				{
					this._lblItems.text = "-";
					this._lblItems.styleName = "BrownCenterSmallLabel";
				}
				if(var4.d != 0)
				{
					this._lblAlign.text = var4.d;
					if(var4.d > 0)
					{
						this._lblAlign.styleName = "GreenCenterSmallLabel";
					}
					else
					{
						this._lblAlign.styleName = "RedCenterSmallLabel";
					}
				}
				else
				{
					this._lblAlign.text = "-";
					this._lblAlign.styleName = "BrownCenterSmallLabel";
				}
				if(var4.b != 0)
				{
					this._lblBoost.text = var4.b;
					if(var4.b > 0)
					{
						this._lblBoost.styleName = "GreenCenterSmallLabel";
					}
					else
					{
						this._lblBoost.styleName = "RedCenterSmallLabel";
					}
				}
				else
				{
					this._lblBoost.text = "-";
					this._lblBoost.styleName = "BrownCenterSmallLabel";
				}
				var var5 = var4.b + var4.d + var4.i + var4.s;
				if(var5 != 0)
				{
					this._lblTotal.text = String(var5);
					if(var5 > 0)
					{
						this._lblTotal.styleName = "GreenCenterSmallLabel";
					}
					else
					{
						this._lblTotal.styleName = "RedCenterSmallLabel";
					}
				}
				else
				{
					this._lblTotal.text = "-";
					this._lblTotal.styleName = "BrownCenterSmallLabel";
				}
			}
		}
		else if(this._lblName.text != undefined)
		{
			this._mcCatBackground._visible = false;
			this._ldrIcon.contentPath = "";
			this._lblCatName.text = "";
			this._lblName.text = "";
			this._lblBase.text = "";
			this._lblBase.styleName = "BrownCenterSmallLabel";
			this._lblItems.text = "";
			this._lblItems.styleName = "BrownCenterSmallLabel";
			this._lblAlign.text = "";
			this._lblAlign.styleName = "BrownCenterSmallLabel";
			this._lblBoost.text = "";
			this._lblBoost.styleName = "BrownCenterSmallLabel";
			this._lblTotal.text = "";
			this._lblTotal.styleName = "BrownCenterSmallLabel";
		}
	}
	function init()
	{
		super.init(false);
		this._mcCatBackground._visible = false;
	}
}
