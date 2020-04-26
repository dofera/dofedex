class dofus.graphics.gapi.controls.itemviewer.ItemViewerItem extends ank.gapi.core.UIBasicComponent
{
	function ItemViewerItem()
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
		this._oItem = loc4;
		if(loc2)
		{
			this.showButton(false);
			this.showLoader(false);
			if(loc4 instanceof dofus.datacenter.Effect)
			{
				this._lbl.text = loc4.description;
				switch(loc4.operator)
				{
					case "+":
						this._lbl.styleName = "GreenLeftSmallLabel";
						break;
					case "-":
						this._lbl.styleName = "RedLeftSmallLabel";
						break;
					default:
						this._lbl.styleName = "BrownLeftSmallLabel";
				}
				if((loc0 = loc4.type) !== 995)
				{
					this.showButton(false,"");
					this._btn.removeEventListener();
				}
				else
				{
					this.showButton(true,"ItemViewerUseHand");
					this._btn.addEventListener("click",this);
				}
				if(loc4.element != undefined)
				{
					if((loc0 = loc4.element) !== "W")
					{
						switch(null)
						{
							case "F":
								this.showLoader(true,"IconFireDommage");
								break;
							case "E":
								this.showLoader(true,"IconEarthDommage");
								break;
							case "A":
								this.showLoader(true,"IconAirDommage");
								break;
							case "N":
								this.showLoader(true,"IconNeutralDommage");
						}
					}
					else
					{
						this.showLoader(true,"IconWaterDommage");
					}
				}
				else
				{
					loop2:
					switch(Number(loc4.characteristic))
					{
						case 13:
							this.showLoader(true,"IconWaterBonus");
							break;
						case 35:
							this.showLoader(true,"IconWater");
							break;
						case 15:
							this.showLoader(true,"IconFireBonus");
							break;
						case 34:
							this.showLoader(true,"IconFire");
							break;
						default:
							switch(null)
							{
								case 10:
									this.showLoader(true,"IconEarthBonus");
									break loop2;
								case 33:
									this.showLoader(true,"IconEarth");
									break loop2;
								case 14:
									this.showLoader(true,"IconAirBonus");
									break loop2;
								case 36:
									this.showLoader(true,"IconAir");
									break loop2;
								case 37:
									this.showLoader(true,"IconNeutral");
									break loop2;
								case 1:
									this.showLoader(true,"Star");
									break loop2;
								default:
									switch(null)
									{
										case 11:
											this.showLoader(true,"IconVita");
											break loop2;
										case 12:
											this.showLoader(true,"IconWisdom");
											break loop2;
										case 44:
											this.showLoader(true,"IconInit");
											break loop2;
										case 48:
											this.showLoader(true,"IconPP");
											break loop2;
										case 2:
											this.showLoader(true,"KamaSymbol");
											break loop2;
										default:
											if(loc0 !== 23)
											{
												break loop2;
											}
											this.showLoader(true,"IconMP");
											break loop2;
									}
							}
					}
				}
			}
			else
			{
				this._lbl.text = loc3;
				this._lbl.styleName = "BrownLeftSmallLabel";
			}
		}
		else if(this._lbl.text != undefined)
		{
			this.showButton(false,"");
			this._btn.removeEventListener();
			this._lbl.text = "";
			this.showLoader(false,"");
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
		this._lbl.setSize(this.__width,this.__height);
	}
	function showButton(loc2, loc3)
	{
		this._btn._visible = loc2;
		this._btn.icon = loc3;
		this.moveLabel(!loc2?0:20);
		if(loc2 == false)
		{
			this._btn.removeEventListener("click",this);
		}
	}
	function showLoader(loc2, loc3)
	{
		this._ldr._visible = loc2;
		this._ldr.contentPath = loc3;
		this._ldr._x = this.__width - 17;
	}
	function moveLabel(loc2)
	{
		this._lbl._x = loc2;
	}
	function click()
	{
		this._mcList.gapi.api.network.Mount.data(this._oItem.param1,this._oItem.param2);
	}
}
