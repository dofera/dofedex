class dofus.graphics.gapi.controls.statsviewer.StatsViewerStatItem extends ank.gapi.core.UIBasicComponent
{
	function StatsViewerStatItem()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._oItem = loc4;
			if(loc4.isCat)
			{
				this._mcCatBackground._visible = true;
				this._ldrIcon.contentPath = "";
				this._lblCatName.text = loc4.name;
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
				if(loc4.p != undefined)
				{
					this._ldrIcon.contentPath = loc4.p;
				}
				else
				{
					this._ldrIcon.contentPath = "";
				}
				this._lblCatName.text = "";
				this._lblName.text = loc4.name;
				if(loc4.s != 0)
				{
					this._lblBase.text = loc4.s;
					if(loc4.s > 0)
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
				if(loc4.i != 0)
				{
					this._lblItems.text = loc4.i;
					if(loc4.i > 0)
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
				if(loc4.d != 0)
				{
					this._lblAlign.text = loc4.d;
					if(loc4.d > 0)
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
				if(loc4.b != 0)
				{
					this._lblBoost.text = loc4.b;
					if(loc4.b > 0)
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
				var loc5 = loc4.b + loc4.d + loc4.i + loc4.s;
				if(loc5 != 0)
				{
					this._lblTotal.text = String(loc5);
					if(loc5 > 0)
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
