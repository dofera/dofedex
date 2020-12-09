class dofus.graphics.gapi.ui.chooseserver.ChooseServerListItem extends ank.gapi.core.UIBasicComponent
{
	function ChooseServerListItem()
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
		var var5 = this._mcList._parent._parent.api;
		if(var2)
		{
			this._oItem = var4;
			var4.sortFlag = var4.language;
			var4.sortName = var4.label;
			var4.sortType = var4.type;
			var4.sortOnline = var4.stateStrShort;
			var4.sortCommunity = var4.communityStr;
			var4.sortPopulation = var4.population;
			var var6 = new String();
			loop0:
			switch(var4.community)
			{
				case 0:
					var6 = "fr";
					break;
				case 1:
					var6 = "en";
					break;
				case 3:
					var6 = "de";
					break;
				default:
					switch(null)
					{
						case 4:
							var6 = "es";
							break loop0;
						case 5:
							var6 = "ru";
							break loop0;
						case 6:
							var6 = "pt";
							break loop0;
						case 7:
							var6 = "nl";
							break loop0;
						default:
							switch(null)
							{
								case 8:
									var6 = "jp";
									break loop0;
								case 9:
									var6 = "it";
									break loop0;
								case 2:
								default:
									var6 = "us";
							}
					}
			}
			this._ldrFlag.contentPath = "Flag_" + var6;
			this._lblName.text = var4.sortName;
			this._lblCommunity.text = var4.sortCommunity;
			switch(var4.state)
			{
				case dofus.datacenter.Server.SERVER_OFFLINE:
					this._lblOnline.styleName = "RedCenterSmallLabel";
					break;
				case dofus.datacenter.Server.SERVER_ONLINE:
					this._lblOnline.styleName = "GreenCenterSmallLabel";
					break;
				default:
					this._lblOnline.styleName = "BrownCenterSmallLabel";
			}
			this._lblOnline.text = var4.sortOnline;
			if((var0 = var4.sortPopulation) !== 0)
			{
				switch(null)
				{
					case 1:
						this._lblPopulation.styleName = "BlueCenterSmallLabel";
						break;
					case 2:
						this._lblPopulation.styleName = "RedCenterSmallLabel";
						break;
					default:
						this._lblPopulation.styleName = "BrownCenterSmallLabel";
				}
			}
			else
			{
				this._lblPopulation.styleName = "GreenCenterSmallLabel";
			}
			this._lblPopulation.text = var4.populationStr;
			this._lblType.text = var4.type;
			if(var4.typeNum == dofus.datacenter.Server.SERVER_HARDCORE)
			{
				this._lblName.styleName = "RedLeftSmallLabel";
				this._lblType.styleName = "RedCenterSmallLabel";
				this._mcHeroic._visible = true;
			}
			else
			{
				this._lblName.styleName = "BrownLeftSmallLabel";
				this._lblType.styleName = "BrownCenterSmallLabel";
				this._mcHeroic._visible = false;
			}
		}
		else if(this._lblName.text != undefined)
		{
			this._ldrFlag.contentPath = "";
			this._lblName.text = "";
			this._lblType.text = "";
			this._lblOnline.text = "";
			this._lblCommunity.text = "";
			this._lblPopulation.text = "";
			this._mcHeroic._visible = false;
		}
	}
	function init()
	{
		super.init(false);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
	}
	function over()
	{
		if(!this._oItem.friendCharactersCount)
		{
			return undefined;
		}
		var var2 = this._mcList.gapi.api;
		var var3 = ank.utils.PatternDecoder.combine(var2.lang.getText("A_POSSESS_CHARACTER",[this._oItem.search,this._oItem.friendCharactersCount]),null,this._oItem.friendCharactersCount == 1);
		var2.ui.showTooltip(var3,this._mcOver,-20);
	}
	function out(§\x1e\x19\x18§)
	{
		this._mcList.gapi.api.ui.hideTooltip();
	}
}
