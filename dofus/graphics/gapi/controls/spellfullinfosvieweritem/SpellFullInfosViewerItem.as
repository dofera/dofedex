class dofus.graphics.gapi.controls.spellfullinfosvieweritem.SpellFullInfosViewerItem extends ank.gapi.core.UIBasicComponent
{
	function SpellFullInfosViewerItem()
	{
		super();
		this._mcArea._visible = false;
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._oItem = loc4;
			if(loc4.fx.description == undefined && loc4.description == undefined)
			{
				this._lbl.text = loc3;
			}
			else
			{
				if(loc4.fx.description != undefined)
				{
					this._lbl.text = loc4.fx.description;
				}
				else if(loc4.description != undefined)
				{
					this._lbl.text = loc4.description;
				}
				var loc5 = undefined;
				if(loc4.fx.element != undefined)
				{
					loc5 = loc4.fx.element;
				}
				else if(loc4.element != undefined)
				{
					loc5 = loc4.element;
				}
				if(loc5 != undefined)
				{
					switch(loc5)
					{
						case "N":
							this._ctrElement.contentPath = "IconNeutralDommage";
							break;
						case "F":
							this._ctrElement.contentPath = "IconFireDommage";
							break;
						case "A":
							this._ctrElement.contentPath = "IconAirDommage";
							break;
						case "W":
							this._ctrElement.contentPath = "IconWaterDommage";
							break;
						case "E":
							this._ctrElement.contentPath = "IconEarthDommage";
							break;
						default:
							this._ctrElement.contentPath = "";
					}
				}
				else if(loc4.fx.icon != undefined)
				{
					this._ctrElement.contentPath = loc4.fx.icon;
				}
				else if(loc4.icon != undefined)
				{
					this._ctrElement.contentPath = loc4.icon;
				}
				else
				{
					this._ctrElement.contentPath = "";
				}
			}
			if(loc4.ar > 1)
			{
				this._mcArea._visible = true;
				this._mcArea.onRollOver = function()
				{
					this._parent.onTooltipOver();
				};
				this._mcArea.onRollOut = function()
				{
					this._parent.onTooltipOut();
				};
				this._lblArea.text = (loc4.ar != 63?loc4.ar:_global.API.lang.getText("INFINIT_SHORT")) + " (" + loc4.at + ")";
			}
			else
			{
				this._mcArea._visible = false;
				this._mcArea.onRollOver = undefined;
				this._mcArea.onRollOut = undefined;
				this._lblArea.text = "";
			}
		}
		else if(this._lbl.text != undefined)
		{
			this._oItem = undefined;
			this._lbl.text = "";
			this._lblArea.text = "";
			this._mcArea._visible = false;
			this._ctrElement.contentPath = "";
		}
		else
		{
			this._oItem = undefined;
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
		this._lbl.setSize(this.__width - (this._oItem.ar <= 1?20:78),this.__height);
	}
	function onTooltipOver()
	{
		_global.API.ui.showTooltip(_global.API.lang.getText("EFFECT_SHAPE_TYPE_" + this._oItem.at,[this._oItem.ar != 63?this._oItem.ar:_global.API.lang.getText("INFINIT")]),this._mcArea,-20);
	}
	function onTooltipOut()
	{
		_global.API.ui.hideTooltip();
	}
}
