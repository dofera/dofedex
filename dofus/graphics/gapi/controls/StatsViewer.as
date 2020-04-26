class dofus.graphics.gapi.controls.StatsViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "StatsViewer";
	function StatsViewer()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.StatsViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function initTexts()
	{
		this._winBg.title = this.api.lang.getText("ADVANCED_STATS");
		this._dgStats.columnsNames = [this.api.lang.getText("STAT_WORD"),this.api.lang.getText("BASE_WORD"),this.api.lang.getText("STUFF_WORD"),this.api.lang.getText("FEATS"),this.api.lang.getText("BOOST"),this.api.lang.getText("TOTAL_WORD")];
	}
	function addListeners()
	{
		this.api.datacenter.Player.addEventListener("fullStatsChanged",this);
	}
	function initData()
	{
		var loc2 = this.api.datacenter.Player.FullStats;
		var loc3 = new ank.utils.();
		for(var k in loc2)
		{
			loc3.push({isCat:true,name:this.api.lang.getText("FULL_STATS_CAT" + k)});
			var loc4 = new ank.utils.();
			var loc5 = 0;
			while(loc5 < loc2[k].length)
			{
				loc4.push({name:this.api.lang.getText("FULL_STATS_ID" + loc2[k][loc5].id),s:loc2[k][loc5].s,i:loc2[k][loc5].i,d:loc2[k][loc5].d,b:loc2[k][loc5].b,o:Number(loc2[k][loc5].o),c:k,p:loc2[k][loc5].p});
				loc5 = loc5 + 1;
			}
			loc4.sortOn("o",Array.NUMERIC);
			var loc6 = loc3.concat(loc4);
			loc3 = new ank.utils.();
			loc3.createFromArray(loc6);
		}
		this._dgStats.dataProvider = loc3;
	}
	function fullStatsChanged(loc2)
	{
		this.initData();
	}
}
