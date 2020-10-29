class dofus.graphics.gapi.ui.banner.Gauge
{
	function Gauge()
	{
	}
	static function showGaugeMode(var2)
	{
		if(var2.api.datacenter.Player.XP == undefined || var2.api.datacenter.Game.isFight)
		{
			return undefined;
		}
		var var3 = var2.api.kernel.OptionsManager.getOption("BannerGaugeMode");
		if(var2._mcCurrentXtraMask == var2._mcCircleXtraMaskBig || var3 == "none")
		{
			var2.setXtraFightMask(false);
			return undefined;
		}
		var2.setXtraFightMask(true);
		switch(var3)
		{
			case "xp":
				var var4 = Math.floor((var2.api.datacenter.Player.XP - var2.api.datacenter.Player.XPlow) / (var2.api.datacenter.Player.XPhigh - var2.api.datacenter.Player.XPlow) * 100);
				var var5 = 8298148;
				break;
			case "xpmount":
				if(var2.api.datacenter.Player.mount == undefined)
				{
					var4 = 0;
				}
				else
				{
					var4 = Math.floor((var2.api.datacenter.Player.mount.xp - var2.api.datacenter.Player.mount.xpMin) / (var2.api.datacenter.Player.mount.xpMax - var2.api.datacenter.Player.mount.xpMin) * 100);
				}
				var5 = 8298148;
				break;
			case "pods":
				var4 = Math.floor(var2.api.datacenter.Player.currentWeight / var2.api.datacenter.Player.maxWeight * 100);
				var5 = 6340148;
				break;
			case "energy":
				if(var2.api.datacenter.Player.EnergyMax == -1)
				{
					var4 = 0;
				}
				else
				{
					var4 = Math.floor(var2.api.datacenter.Player.Energy / var2.api.datacenter.Player.EnergyMax * 100);
				}
				var5 = 10994717;
				break;
			case "xpcurrentjob":
				var var6 = var2.api.datacenter.Player.currentJobID;
				if(var6 != undefined)
				{
					var var7 = var2.api.datacenter.Player.Jobs.findFirstItem("id",var6).item;
					if(var7.xpMax != -1)
					{
						var4 = Math.floor((var7.xp - var7.xpMin) / (var7.xpMax - var7.xpMin) * 100);
					}
					else
					{
						var4 = 0;
					}
				}
				else
				{
					var4 = 0;
				}
				var5 = 10441125;
		}
		if(!_global.isNaN(var5))
		{
			if(_global.isNaN(var4))
			{
				var4 = 0;
			}
			var2._ccChrono._visible = true;
			var2._ccChrono.setGaugeChrono(var4,var5);
		}
	}
	static function setGaugeMode(var2, var3)
	{
		var2._mcCurrentXtraMask = var3 != "none"?var2._mcCircleXtraMask:var2._mcCircleXtraMaskBig;
		var var4 = var2.api.kernel.OptionsManager.getOption("BannerGaugeMode");
		switch(var4)
		{
			case "xp":
				var2.api.datacenter.Player.removeEventListener("xpChanged",var2);
				break;
			case "xpmount":
				var2.api.datacenter.Player.removeEventListener("mountChanged",var2);
				break;
			case "pods":
				var2.api.datacenter.Player.removeEventListener("currentWeightChanged",var2);
				break;
			case "energy":
				var2.api.datacenter.Player.removeEventListener("energyChanged",var2);
				break;
			case "xpcurrentjob":
				var2.api.datacenter.Player.removeEventListener("currentJobChanged",var2);
		}
		var2.api.kernel.OptionsManager.setOption("BannerGaugeMode",var3);
		if((var0 = var3) !== "xp")
		{
			switch(null)
			{
				case "xpmount":
					var2.api.datacenter.Player.addEventListener("mountChanged",var2);
					break;
				case "pods":
					var2.api.datacenter.Player.addEventListener("currentWeightChanged",var2);
					break;
				case "energy":
					var2.api.datacenter.Player.addEventListener("energyChanged",var2);
					break;
				case "xpcurrentjob":
					var2.api.datacenter.Player.addEventListener("currentJobChanged",var2);
			}
		}
		else
		{
			var2.api.datacenter.Player.addEventListener("xpChanged",var2);
		}
		dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(var2);
	}
	static function showGaugeModeSelectMenu(var2)
	{
		var var3 = var2.api.kernel.OptionsManager.getOption("BannerGaugeMode");
		var var4 = var2.api.ui.createPopupMenu();
		var4.addItem(var2.api.lang.getText("DISABLE"),dofus.graphics.gapi.ui.banner.Gauge,dofus.graphics.gapi.ui.banner.Gauge.setGaugeMode,[var2,"none"],var3 != "none");
		var4.addItem(var2.api.lang.getText("WORD_XP"),dofus.graphics.gapi.ui.banner.Gauge,dofus.graphics.gapi.ui.banner.Gauge.setGaugeMode,[var2,"xp"],var3 != "xp");
		var4.addItem(var2.api.lang.getText("WORD_XP") + " " + var2.api.lang.getText("JOB"),dofus.graphics.gapi.ui.banner.Gauge,dofus.graphics.gapi.ui.banner.Gauge.setGaugeMode,[var2,"xpcurrentjob"],var3 != "xpcurrentjob");
		var4.addItem(var2.api.lang.getText("WORD_XP") + " " + var2.api.lang.getText("MOUNT"),dofus.graphics.gapi.ui.banner.Gauge,dofus.graphics.gapi.ui.banner.Gauge.setGaugeMode,[var2,"xpmount"],var3 != "xpmount");
		var4.addItem(var2.api.lang.getText("WEIGHT"),dofus.graphics.gapi.ui.banner.Gauge,dofus.graphics.gapi.ui.banner.Gauge.setGaugeMode,[var2,"pods"],var3 != "pods");
		var4.addItem(var2.api.lang.getText("ENERGY"),dofus.graphics.gapi.ui.banner.Gauge,dofus.graphics.gapi.ui.banner.Gauge.setGaugeMode,[var2,"energy"],var3 != "energy");
		var4.show(_root._xmouse,_root._ymouse,true);
	}
}
