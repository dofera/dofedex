class dofus.graphics.gapi.controls.itemviewer.ItemViewerItem extends ank.gapi.core.UIBasicComponent
{
	function ItemViewerItem()
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
		this._oItem = var4;
		if(var2)
		{
			this.showButton(false);
			this.showLoader(false);
			if(var4 instanceof dofus.datacenter.Effect)
			{
				this._lbl.text = var4.description;
				switch(var4.operator)
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
				if((var0 = var4.type) !== 995)
				{
					this.showButton(false,"");
					this._btn.removeEventListener();
				}
				else
				{
					this.showButton(true,"ItemViewerUseHand");
					this._btn.addEventListener("click",this);
				}
				if(var4.element != undefined)
				{
					switch(var4.element)
					{
						case "W":
							this.showLoader(true,"IconWaterDommage");
							break;
						case "F":
							this.showLoader(true,"IconFireDommage");
							break;
						default:
							switch(null)
							{
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
				}
				else
				{
					loop3:
					switch(Number(var4.characteristic))
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
						default:
							switch(null)
							{
								case 34:
									this.showLoader(true,"IconFire");
									break loop3;
								case 10:
									this.showLoader(true,"IconEarthBonus");
									break loop3;
								case 33:
									this.showLoader(true,"IconEarth");
									break loop3;
								case 14:
									this.showLoader(true,"IconAirBonus");
									break loop3;
								case 36:
									this.showLoader(true,"IconAir");
									break loop3;
								default:
									switch(null)
									{
										case 37:
											this.showLoader(true,"IconNeutral");
											break loop3;
										case 1:
											this.showLoader(true,"Star");
											break loop3;
										case 11:
											this.showLoader(true,"IconVita");
											break loop3;
										case 12:
											this.showLoader(true,"IconWisdom");
											break loop3;
										case 44:
											this.showLoader(true,"IconInit");
											break loop3;
										default:
											switch(null)
											{
												case 48:
													this.showLoader(true,"IconPP");
													break;
												case 2:
													this.showLoader(true,"KamaSymbol");
													break;
												case 23:
													this.showLoader(true,"IconMP");
											}
									}
							}
					}
				}
			}
			else
			{
				this._lbl.text = var3;
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
	function showButton(var2, var3)
	{
		this._btn._visible = var2;
		this._btn.icon = var3;
		this.moveLabel(!var2?0:20);
		if(var2 == false)
		{
			this._btn.removeEventListener("click",this);
		}
	}
	function showLoader(var2, var3)
	{
		this._ldr._visible = var2;
		this._ldr.contentPath = var3;
		this._ldr._x = this.__width - 17;
	}
	function moveLabel(var2)
	{
		this._lbl._x = var2;
	}
	function click()
	{
		this._mcList.gapi.api.network.Mount.data(this._oItem.param1,this._oItem.param2);
	}
}
