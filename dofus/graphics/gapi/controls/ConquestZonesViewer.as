class dofus.graphics.gapi.controls.ConquestZonesViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ConquestZonesViewer";
	static var FILTER_VULNERALE_AREAS = -4;
	static var FILTER_CAPTURABLE_AREAS = -3;
	static var FILTER_ALL_AREAS = -2;
	static var FILTER_HOSTILE_AREAS = -1;
	function ConquestZonesViewer()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ConquestZonesViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function initTexts()
	{
		this._lblFilter.text = this.api.lang.getText("FILTER");
		this._lblAreas.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_AREA_WORD"),null,false);
		this._lblAreaTitle.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_AREA_WORD"),null,true);
		this._lblAreaDetails.text = this.api.lang.getText("CONQUEST_STATE_WORD") + " / " + this.api.lang.getText("CONQUEST_PRISM_WORD");
		this._lblVillages.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_VILLAGE_WORD"),null,false);
		this._lblVillageTitle.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_VILLAGE_WORD"),null,true);
		this._lblVillageDetails.text = this.api.lang.getText("CONQUEST_STATE_WORD") + " / " + this.api.lang.getText("CONQUEST_DOOR_WORD") + " / " + this.api.lang.getText("CONQUEST_PRISM_WORD");
	}
	function addListeners()
	{
		var ref = this;
		this._mcGotAreasInteractivity.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcGotAreasInteractivity.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcGotVillagesInteractivity.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcGotVillagesInteractivity.onRollOut = function()
		{
			ref.out({target:this});
		};
		this.api.datacenter.Conquest.addEventListener("worldDataChanged",this);
		this._cbFilter.addEventListener("itemSelected",this);
	}
	function refreshAreaList()
	{
		var loc2 = this.api.datacenter.Conquest.worldDatas;
		var loc3 = this._cbFilter.selectedItem.value;
		var loc4 = new ank.utils.();
		var loc5 = new String();
		var loc6 = 0;
		while(loc6 < loc2.areas.length)
		{
			if(!(loc3 == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_HOSTILE_AREAS && !loc2.areas[loc6].fighting))
			{
				if(!(loc3 == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_CAPTURABLE_AREAS && !loc2.areas[loc6].isCapturable()))
				{
					if(!(loc3 == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_VULNERALE_AREAS && !loc2.areas[loc6].isVulnerable()))
					{
						if(!(loc3 >= 0 && loc2.areas[loc6].alignment != loc3))
						{
							if(loc5 != loc2.areas[loc6].areaName)
							{
								loc4.push({area:loc2.areas[loc6].areaId});
								loc5 = loc2.areas[loc6].areaName;
							}
							loc4.push(loc2.areas[loc6]);
						}
					}
				}
			}
			loc6 = loc6 + 1;
		}
		this._lstAreas.dataProvider = loc4;
	}
	function initData()
	{
		var loc2 = this.api.datacenter.Conquest.worldDatas;
		this._lblGotAreas.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_POSSESSED_WORD"),"f",false) + " : " + loc2.ownedAreas + " / " + loc2.possibleAreas + " / " + loc2.totalAreas;
		this._lblGotVillages.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_POSSESSED_WORD"),"m",false) + " : " + loc2.ownedVillages + " / " + loc2.totalVillages;
		this.refreshAreaList();
		this._lstVillages.dataProvider = loc2.villages;
		var loc3 = new ank.utils.();
		var loc4 = this.api.lang.getAlignments();
		for(var s in loc4)
		{
			if(loc4[s].c)
			{
				loc3.push({label:this.api.lang.getText("CONQUEST_ALIGNED_AREAS",[loc4[s].n]),value:s});
			}
		}
		loc3.push({label:this.api.lang.getText("CONQUEST_HOSTILE_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_HOSTILE_AREAS});
		loc3.push({label:this.api.lang.getText("CONQUEST_CAPTURABLE_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_CAPTURABLE_AREAS});
		loc3.push({label:this.api.lang.getText("CONQUEST_VULNERALE_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_VULNERALE_AREAS});
		loc3.push({label:this.api.lang.getText("CONQUEST_ALL_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_ALL_AREAS});
		this._cbFilter.dataProvider = loc3;
		this._cbFilter.selectedIndex = loc3.findFirstItem("value",this.api.kernel.OptionsManager.getOption("ConquestFilter")).index;
	}
	function over(loc2)
	{
		var loc3 = this.api.datacenter.Conquest.worldDatas;
		switch(loc2.target)
		{
			case this._mcGotAreasInteractivity:
				this.api.ui.showTooltip(this.api.lang.getText("CONQUEST_GOT_ZONES",[loc3.ownedAreas,loc3.possibleAreas,loc3.ownedVillages,loc3.totalAreas]),this._mcGotAreasInteractivity,-55);
				break;
			case this._mcGotVillagesInteractivity:
				this.api.ui.showTooltip(this.api.lang.getText("CONQUEST_GOT_VILLAGES",[loc3.ownedVillages,loc3.totalVillages]),this._mcGotVillagesInteractivity,-20);
		}
	}
	function out(loc2)
	{
		this.api.ui.hideTooltip();
	}
	function worldDataChanged(loc2)
	{
		this.addToQueue({object:this,method:this.initData});
	}
	function itemSelected(loc2)
	{
		this.api.kernel.OptionsManager.setOption("ConquestFilter",this._cbFilter.selectedItem.value);
		this.refreshAreaList();
	}
}
