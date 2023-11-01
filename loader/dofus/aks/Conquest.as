class dofus.aks.Conquest extends dofus.aks.Handler
{
	function Conquest(§\x1e\x1a\x0e§, oAPI)
	{
		super.initialize(var3,oAPI);
	}
	function getAlignedBonus()
	{
		this.aks.send("CB",true);
	}
	function prismInfosJoin()
	{
		this.api.datacenter.Conquest.clear();
		this.aks.send("CIJ",true);
	}
	function prismInfosLeave()
	{
		this.aks.send("CIV",false);
	}
	function prismFightJoin()
	{
		this.aks.send("CFJ",true);
	}
	function prismFightLeave()
	{
		this.aks.send("CFV",false);
	}
	function worldInfosJoin()
	{
		this.aks.send("CWJ",false);
	}
	function worldInfosLeave()
	{
		this.aks.send("CWV",false);
	}
	function switchPlaces(var2)
	{
		this.aks.send("CFS" + var2,true);
	}
	function requestBalance()
	{
		this.aks.send("Cb",true);
	}
	function onAreaAlignmentChanged(var2)
	{
		var var3 = String(var2).split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = this.api.lang.getMapAreaText(var4).n;
		var var7 = this.api.lang.getAlignment(var5).n;
		if(var5 == -1)
		{
			this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("AREA_ALIGNMENT_PRISM_REMOVED",[var6]) + "</b>","PVP_CHAT");
		}
		else
		{
			this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("AREA_ALIGNMENT_IS",[var6,var7]) + "</b>","PVP_CHAT");
		}
	}
	function onConquestBonus(var2)
	{
		var var3 = var2.split(";");
		var var4 = String(var3[0]).split(",");
		var var5 = new dofus.datacenter.();
		var5.xp = Number(var4[0]);
		var5.drop = Number(var4[1]);
		var5.recolte = Number(var4[2]);
		var4 = String(var3[1]).split(",");
		var var6 = new dofus.datacenter.();
		var6.xp = Number(var4[0]);
		var6.drop = Number(var4[1]);
		var6.recolte = Number(var4[2]);
		var4 = String(var3[2]).split(",");
		var var7 = new dofus.datacenter.();
		var7.xp = Number(var4[0]);
		var7.drop = Number(var4[1]);
		var7.recolte = Number(var4[2]);
		this.api.datacenter.Conquest.alignBonus = var5;
		this.api.datacenter.Conquest.rankMultiplicator = var6;
		this.api.datacenter.Conquest.alignMalus = var7;
	}
	function onConquestBalance(var2)
	{
		var var3 = (dofus.graphics.gapi.ui.Conquest)this.api.ui.getUIComponent("Conquest");
		var var4 = var2.split(";");
		var3.setBalance(Number(var4[0]),Number(var4[1]));
	}
	function onWorldData(var2)
	{
		var var3 = var2.split("|");
		var var4 = new dofus.datacenter.();
		var4.ownedAreas = Number(var3[0]);
		var4.totalAreas = Number(var3[1]);
		var4.possibleAreas = Number(var3[2]);
		var var5 = var3[3];
		var var6 = var5.split(";");
		var4.areas = new ank.utils.();
		for(var var7 in var6)
		{
			if(var7.length >= 5)
			{
				var var8 = new dofus.datacenter.(Number(var7[0]),Number(var7[1]),Number(var7[2]) == 1,Number(var7[3]),Number(var7[4]) == 1);
				var4.areas.push(var8);
			}
		}
		var4.areas.sortOn("areaName");
		var4.ownedVillages = Number(var3[4]);
		var4.totalVillages = Number(var3[5]);
		var var9 = var3[6];
		var var10 = var9.split(";");
		var4.villages = new ank.utils.();
		for(var var11 in var10)
		{
			if(var11.length == 4)
			{
				var var12 = new dofus.datacenter.	(Number(var11[0]),Number(var11[1]),Number(var11[2]) == 1,Number(var11[3]) == 1);
				var4.villages.push(var12);
			}
		}
		var4.villages.sortOn("areaName");
		this.api.datacenter.Conquest.worldDatas = var4;
	}
	function onPrismInfosJoined(var2)
	{
		var var3 = var2.split(";");
		var var4 = Number(var3[0]);
		var var5 = (dofus.graphics.gapi.ui.Conquest)this.api.ui.getUIComponent("Conquest");
		if(var4 == 0)
		{
			var var6 = Number(var3[1]);
			var var7 = Number(var3[2]);
			var var8 = Number(var3[3]);
			var var9 = new Object();
			var9.error = 0;
			var9.timer = var6;
			var9.maxTimer = var7;
			var9.timerReference = getTimer();
			var9.maxTeamPositions = var8;
			var5.sharePropertiesWithTab(var9);
		}
		else
		{
			var var10 = new Object();
			switch(var4)
			{
				default:
					if(var0 !== -3)
					{
						var5.sharePropertiesWithTab(var10);
					}
					else
					{
						break;
					}
				case -1:
				case -2:
			}
			var10.error = var4;
			var5.sharePropertiesWithTab(var10);
		}
	}
	function onPrismInfosClosing(var2)
	{
		var var3 = (dofus.graphics.gapi.ui.Conquest)this.api.ui.getUIComponent("Conquest");
		var3.sharePropertiesWithTab({noUnsubscribe:true});
		this.api.ui.unloadUIComponent("Conquest");
	}
	function onPrismAttacked(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = var3[1];
		var var6 = var3[2];
		var var7 = "[" + var5 + ", " + var6 + "]";
		var var8 = Number(this.api.lang.getMapText(var4).sa);
		var var9 = String(this.api.lang.getMapSubAreaText(var8).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(var8).n:String(this.api.lang.getMapSubAreaText(var8).n).substr(2);
		if(var8 == this.api.datacenter.Basics.gfx_lastSubarea)
		{
			this.api.kernel.showMessage(undefined,"<img src=\"CautionIcon\" hspace=\'0\' vspace=\'0\' width=\'13\' height=\'13\' />" + this.api.lang.getText("PRISM_ATTACKED",[var9,var7]),"PVP_CHAT");
			this.api.sounds.events.onTaxcollectorAttack();
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("PRISM_ATTACKED",[var9,var7]),"PVP_CHAT");
		}
	}
	function onPrismSurvived(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = var3[1];
		var var6 = var3[2];
		var var7 = "[" + var5 + ", " + var6 + "]";
		var var8 = Number(this.api.lang.getMapText(var4).sa);
		var var9 = String(this.api.lang.getMapSubAreaText(var8).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(var8).n:String(this.api.lang.getMapSubAreaText(var8).n).substr(2);
		this.api.kernel.showMessage(undefined,this.api.lang.getText("PRISM_ATTACKED_SUVIVED",[var9,var7]),"PVP_CHAT");
	}
	function onPrismDead(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = var3[1];
		var var6 = var3[2];
		var var7 = "[" + var5 + ", " + var6 + "]";
		var var8 = Number(this.api.lang.getMapText(var4).sa);
		var var9 = String(this.api.lang.getMapSubAreaText(var8).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(var8).n:String(this.api.lang.getMapSubAreaText(var8).n).substr(2);
		this.api.kernel.showMessage(undefined,this.api.lang.getText("PRISM_ATTACKED_DIED",[var9,var7]),"PVP_CHAT");
	}
	function onPrismFightAddPlayer(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("|");
		var var5 = _global.parseInt(var4[0],36);
		var var6 = 1;
		while(var6 < var4.length)
		{
			var var7 = var4[var6].split(";");
			if(var3)
			{
				var var8 = new Object();
				var8.id = _global.parseInt(var7[0],36);
				var8.name = var7[1];
				var8.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + var7[2] + ".swf";
				var8.level = Number(var7[3]);
				var8.color1 = _global.parseInt(var7[4],36);
				var8.color2 = _global.parseInt(var7[5],36);
				var8.color3 = _global.parseInt(var7[6],36);
				var8.reservist = var7[7] == "1";
				var var9 = this.api.datacenter.Conquest.players.findFirstItem("id",var8.id);
				if(var9.index != -1)
				{
					this.api.datacenter.Conquest.players.updateItem(var9.index,var8);
				}
				else
				{
					this.api.datacenter.Conquest.players.push(var8);
				}
			}
			else
			{
				var var10 = _global.parseInt(var7[0],36);
				var var11 = this.api.datacenter.Conquest.players.findFirstItem("id",var10);
				if(var11.index != -1)
				{
					this.api.datacenter.Conquest.players.removeItems(var11.index,1);
				}
			}
			var6 = var6 + 1;
		}
	}
	function onPrismFightAddEnemy(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("|");
		var var5 = _global.parseInt(var4[0],36);
		var var6 = this.api.datacenter.Conquest.attackers;
		var var7 = 1;
		while(var7 < var4.length)
		{
			var var8 = var4[var7].split(";");
			if(var3)
			{
				var var9 = new Object();
				var9.id = _global.parseInt(var8[0],36);
				var9.name = var8[1];
				var9.level = Number(var8[2]);
				var var10 = var6.findFirstItem("id",var9.id);
				if(var10.index != -1)
				{
					var6.updateItem(var10.index,var9);
				}
				else
				{
					var6.push(var9);
				}
			}
			else
			{
				var var11 = _global.parseInt(var8[0],36);
				var var12 = var6.findFirstItem("id",var11);
				if(var12.index != -1)
				{
					var6.removeItems(var12.index,1);
				}
			}
			var7 = var7 + 1;
		}
	}
}
