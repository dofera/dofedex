class dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var MOVING_INDICE = 5;
	function ConquestZonesViewerAreaItem()
	{
		super();
		this.api = _global.API;
		this._ldrAlignment._alpha = 0;
		this._mcNotAligned._alpha = 0;
		this._mcFighting._alpha = 0;
		this._mcLocate._alpha = 0;
		this._mcSubtitleBackground._alpha = 0;
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
			if(this._oItem.area == undefined || (Number(loc4.area) < 0 || _global.isNaN(loc4.area)))
			{
				var loc5 = this.api.lang.getMapSubAreaText(loc4.id).n;
				this._lblArea.text = loc5.substr(0,2) != "//"?loc5:loc5.substr(2);
				this._mcFighting._alpha = !loc4.fighting?0:100;
				if(loc4.alignment == -1)
				{
					this._ldrAlignment._alpha = 0;
					this._mcNotAligned._alpha = 100;
				}
				else
				{
					this._mcNotAligned._alpha = 0;
					this._ldrAlignment._alpha = 100;
					this._ldrAlignment.contentPath = dofus.Constants.ALIGNMENTS_MINI_PATH + loc4.alignment + ".swf";
				}
				var ref = this;
				this._mcTooltip.onRollOver = function()
				{
					ref.over({target:this});
				};
				this._mcTooltip.onRollOut = function()
				{
					ref.out({target:this});
				};
				if(loc4.prism == 0)
				{
					delete this._oPrismData;
					this._lblPrism.text = "-";
					this._mcLocate._alpha = 0;
					delete this._mcLocate.onRelease;
					delete this._mcLocate.onRollOver;
					delete this._mcLocate.onRollOut;
				}
				else
				{
					this._oPrismData = this.api.lang.getMapText(loc4.prism);
					this._lblPrism.text = this._oPrismData.x + ";" + this._oPrismData.y;
					this._mcLocate._alpha = 100;
					this._mcLocate.onRelease = function()
					{
						ref.click({target:this});
					};
					this._mcLocate.onRollOver = function()
					{
						ref.over({target:this});
					};
					this._mcLocate.onRollOut = function()
					{
						ref.out({target:this});
					};
				}
				this._mcAlignmentInteractivity.onRollOver = function()
				{
					ref.over({target:this});
				};
				this._mcAlignmentInteractivity.onRollOut = function()
				{
					ref.out({target:this});
				};
				if(this._mcFighting._alpha == 0)
				{
					if(!this._mcNotAligned.moved)
					{
						this._mcNotAligned._x = this._mcNotAligned._x + dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
						this._mcNotAligned.moved = true;
					}
					if(!this._ldrAlignment.moved)
					{
						this._ldrAlignment._x = this._ldrAlignment._x + dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
						this._ldrAlignment.moved = true;
					}
					if(!this._mcAlignmentInteractivity.moved)
					{
						this._mcAlignmentInteractivity._x = this._mcAlignmentInteractivity._x + dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
						this._mcAlignmentInteractivity.moved = true;
					}
				}
				else
				{
					this._mcFightingInteractivity.onRollOver = function()
					{
						ref.over({target:this});
					};
					this._mcFightingInteractivity.onRollOut = function()
					{
						ref.out({target:this});
					};
					if(this._mcNotAligned.moved)
					{
						this._mcNotAligned._x = this._mcNotAligned._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
						this._mcNotAligned.moved = false;
					}
					if(this._ldrAlignment.moved)
					{
						this._ldrAlignment._x = this._ldrAlignment._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
						this._ldrAlignment.moved = false;
					}
					if(this._mcAlignmentInteractivity.moved)
					{
						this._mcAlignmentInteractivity._x = this._mcAlignmentInteractivity._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
						this._mcAlignmentInteractivity.moved = false;
					}
				}
				this._mcSubtitleBackground._alpha = 0;
				this._lblSubtitle.text = "";
			}
			else
			{
				this._lblArea.text = "";
				this._ldrAlignment._alpha = 0;
				this._mcNotAligned._alpha = 0;
				this._mcFighting._alpha = 0;
				this._mcLocate._alpha = 0;
				delete this._mcLocate.onRelease;
				delete this._mcAlignmentInteractivity.onRollOver;
				delete this._mcAlignmentInteractivity.onRollOut;
				delete this._mcFightingInteractivity.onRollOver;
				delete this._mcFightingInteractivity.onRollOut;
				delete this._mcTooltip.onRollOver;
				delete this._mcTooltip.onRollOut;
				this._lblPrism.text = "";
				if(this._mcNotAligned.moved)
				{
					this._mcNotAligned._x = this._mcNotAligned._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
					this._mcNotAligned.moved = false;
				}
				if(this._ldrAlignment.moved)
				{
					this._ldrAlignment._x = this._ldrAlignment._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
					this._ldrAlignment.moved = false;
				}
				if(this._mcAlignmentInteractivity.moved)
				{
					this._mcAlignmentInteractivity._x = this._mcAlignmentInteractivity._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
					this._mcAlignmentInteractivity.moved = false;
				}
				this._mcSubtitleBackground._alpha = 100;
				this._lblSubtitle.text = this.api.lang.getMapAreaText(this._oItem.area).n;
			}
		}
		else if(this._lblArea.text != undefined)
		{
			this._lblArea.text = "";
			this._ldrAlignment._alpha = 0;
			this._mcNotAligned._alpha = 0;
			this._mcFighting._alpha = 0;
			this._mcLocate._alpha = 0;
			this._mcSubtitleBackground._alpha = 0;
			this._lblSubtitle.text = "";
			delete this._mcLocate.onRelease;
			delete this._mcAlignmentInteractivity.onRollOver;
			delete this._mcAlignmentInteractivity.onRollOut;
			delete this._mcFightingInteractivity.onRollOver;
			delete this._mcFightingInteractivity.onRollOut;
			delete this._mcTooltip.onRollOver;
			delete this._mcTooltip.onRollOut;
			this._lblPrism.text = "";
			if(this._mcNotAligned.moved)
			{
				this._mcNotAligned._x = this._mcNotAligned._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
				this._mcNotAligned.moved = false;
			}
			if(this._ldrAlignment.moved)
			{
				this._ldrAlignment._x = this._ldrAlignment._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
				this._ldrAlignment.moved = false;
			}
			if(this._mcAlignmentInteractivity.moved)
			{
				this._mcAlignmentInteractivity._x = this._mcAlignmentInteractivity._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
				this._mcAlignmentInteractivity.moved = false;
			}
		}
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target) === this._mcLocate)
		{
			this.api.kernel.GameManager.updateCompass(this._oPrismData.x,this._oPrismData.y,true);
		}
	}
	function over(loc2)
	{
		switch(loc2.target)
		{
			case this._mcAlignmentInteractivity:
				this.api.ui.showTooltip(this.api.lang.getText("ALIGNMENT") + ": " + (this._oItem.alignment <= 0?this._oItem.alignment != -1?this.api.lang.getText("NEUTRAL_WORD"):this.api.lang.getText("NON_ALIGNED"):new dofus.datacenter.(this._oItem.alignment,1).name),_root._xmouse,_root._ymouse - 20);
				break;
			case this._mcFightingInteractivity:
				this.api.ui.showTooltip(this.api.lang.getText("FIGHTING_PRISM"),_root._xmouse,_root._ymouse - 20);
				break;
			default:
				switch(null)
				{
					case this._mcLocate:
						this.api.ui.showTooltip(this.api.lang.getText("LOCATE"),_root._xmouse,_root._ymouse - 20);
						break;
					case this._mcTooltip:
						var loc3 = new String();
						if(this._oItem.alignment == this.api.datacenter.Player.alignment.index)
						{
							loc3 = this.api.lang.getText("CONQUEST_AREA_OWNED") + "\n";
							if(this._oItem.isVulnerable())
							{
								loc3 = loc3 + (this.api.lang.getText("CONQUEST_AREA_VULNERABLE") + "\n");
							}
							loc3 = loc3 + "\n";
						}
						else if(this._oItem.isCapturable())
						{
							loc3 = this.api.lang.getText("CONQUEST_AREA_CAN_BE_CAPTURED") + "\n\n";
						}
						else
						{
							loc3 = this.api.lang.getText("CONQUEST_AREA_CANT_BE_CAPTURED") + "\n\n";
						}
						loc3 = loc3 + (this.api.lang.getText("CONQUEST_NEAR_ZONES") + ":\n");
						var loc4 = this._oItem.getNearZonesList();
						for(var s in loc4)
						{
							var loc5 = this.api.lang.getMapSubAreaText(loc4[s]).n;
							if(loc5.substr(0,2) == "//")
							{
								loc5 = loc5.substr(2);
							}
							loc3 = loc3 + (" - " + loc5 + "\n");
						}
						this.api.ui.showTooltip(loc3,_root._xmouse,_root._ymouse + 20);
				}
		}
	}
	function out(loc2)
	{
		this.api.ui.hideTooltip();
	}
}
