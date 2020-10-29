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
		var var2 = this.api.datacenter.Player.FullStats;
		var var3 = new ank.utils.();
		§§enumerate(var2);
		while((var var0 = §§enumeration()) != null)
		{
			var3.push({isCat:true,name:this.api.lang.getText("FULL_STATS_CAT" + k)});
			var var4 = new ank.utils.();
			var var5 = 0;
			while(var5 < var2[k].length)
			{
				var4.push({name:this.api.lang.getText("FULL_STATS_ID" + var2[k][var5].id),s:var2[k][var5].s,i:var2[k][var5].i,d:var2[k][var5].d,b:var2[k][var5].b,o:Number(var2[k][var5].o),c:k,p:var2[k][var5].p});
				var5 = var5 + 1;
			}
			var4.sortOn("o",Array.NUMERIC);
			var var6 = var3.concat(var4);
			var3 = new ank.utils.();
			var3.createFromArray(var6);
		}
		this._dgStats.dataProvider = var3;
	}
	function fullStatsChanged(var2)
	{
		this.initData();
	}
}
