class dofus.graphics.gapi.ui.chooseserver.ChooseServerListItem extends ank.gapi.core.UIBasicComponent
{
	function ChooseServerListItem()
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
		var loc5 = this._mcList._parent._parent.api;
		if(loc2)
		{
			this._oItem = loc4;
			loc4.sortFlag = loc4.language;
			loc4.sortName = loc4.label;
			loc4.sortType = loc4.type;
			loc4.sortOnline = loc4.stateStrShort;
			loc4.sortCommunity = loc4.communityStr;
			loc4.sortPopulation = loc4.population;
			var loc6 = new String();
			loop0:
			switch(loc4.community)
			{
				case 0:
					loc6 = "fr";
					break;
				case 1:
					loc6 = "en";
					break;
				case 3:
					loc6 = "de";
					break;
				case 4:
					loc6 = "es";
					break;
				case 5:
					loc6 = "ru";
					break;
				default:
					switch(null)
					{
						case 6:
							loc6 = "pt";
							break loop0;
						case 7:
							loc6 = "nl";
							break loop0;
						case 8:
							loc6 = "jp";
							break loop0;
						case 9:
							loc6 = "it";
							break loop0;
						case 2:
						default:
							loc6 = "us";
					}
			}
			this._ldrFlag.contentPath = "Flag_" + loc6;
			this._lblName.text = loc4.sortName;
			this._lblCommunity.text = loc4.sortCommunity;
			if((loc0 = loc4.state) !== dofus.datacenter.Server.SERVER_OFFLINE)
			{
				if(loc0 !== dofus.datacenter.Server.SERVER_ONLINE)
				{
					this._lblOnline.styleName = "BrownCenterSmallLabel";
				}
				else
				{
					this._lblOnline.styleName = "GreenCenterSmallLabel";
				}
			}
			else
			{
				this._lblOnline.styleName = "RedCenterSmallLabel";
			}
			this._lblOnline.text = loc4.sortOnline;
			switch(loc4.sortPopulation)
			{
				case 0:
					this._lblPopulation.styleName = "GreenCenterSmallLabel";
					break;
				case 1:
					this._lblPopulation.styleName = "BlueCenterSmallLabel";
					break;
				default:
					if(loc0 !== 2)
					{
						this._lblPopulation.styleName = "BrownCenterSmallLabel";
						break;
					}
					this._lblPopulation.styleName = "RedCenterSmallLabel";
					break;
			}
			this._lblPopulation.text = loc4.populationStr;
			this._lblType.text = loc4.type;
			if(loc4.typeNum == dofus.datacenter.Server.SERVER_HARDCORE)
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
		var loc2 = this._mcList.gapi.api;
		var loc3 = ank.utils.PatternDecoder.combine(loc2.lang.getText("A_POSSESS_CHARACTER",[this._oItem.search,this._oItem.friendCharactersCount]),null,this._oItem.friendCharactersCount == 1);
		loc2.ui.showTooltip(loc3,this._mcOver,-20);
	}
	function out(loc2)
	{
		this._mcList.gapi.api.ui.hideTooltip();
	}
}
