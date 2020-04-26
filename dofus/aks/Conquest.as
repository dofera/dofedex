class dofus.aks.Conquest extends dofus.aks.Handler
{
	function Conquest(loc3, loc4)
	{
		super.initialize(loc3,loc4);
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
	function switchPlaces(loc2)
	{
		this.aks.send("CFS" + loc2,true);
	}
	function requestBalance()
	{
		this.aks.send("Cb",true);
	}
	function onAreaAlignmentChanged(loc2)
	{
		var loc3 = String(loc2).split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = this.api.lang.getMapAreaText(loc4).n;
		var loc7 = this.api.lang.getAlignment(loc5).n;
		if(loc5 == -1)
		{
			this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("AREA_ALIGNMENT_PRISM_REMOVED",[loc6]) + "</b>","PVP_CHAT");
		}
		else
		{
			this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("AREA_ALIGNMENT_IS",[loc6,loc7]) + "</b>","PVP_CHAT");
		}
	}
	function onConquestBonus(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = String(loc3[0]).split(",");
		var loc5 = new dofus.datacenter.
();
		loc5.xp = Number(loc4[0]);
		loc5.drop = Number(loc4[1]);
		loc5.recolte = Number(loc4[2]);
		loc4 = String(loc3[1]).split(",");
		var loc6 = new dofus.datacenter.
();
		loc6.xp = Number(loc4[0]);
		loc6.drop = Number(loc4[1]);
		loc6.recolte = Number(loc4[2]);
		loc4 = String(loc3[2]).split(",");
		var loc7 = new dofus.datacenter.
();
		loc7.xp = Number(loc4[0]);
		loc7.drop = Number(loc4[1]);
		loc7.recolte = Number(loc4[2]);
		this.api.datacenter.Conquest.alignBonus = loc5;
		this.api.datacenter.Conquest.rankMultiplicator = loc6;
		this.api.datacenter.Conquest.alignMalus = loc7;
	}
	function onConquestBalance(loc2)
	{
		var loc3 = (dofus.graphics.gapi.ui.Conquest)this.api.ui.getUIComponent("Conquest");
		var loc4 = loc2.split(";");
		loc3.setBalance(Number(loc4[0]),Number(loc4[1]));
	}
	function onWorldData(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = new dofus.datacenter.();
		loc4.ownedAreas = Number(loc3[0]);
		loc4.totalAreas = Number(loc3[1]);
		loc4.possibleAreas = Number(loc3[2]);
		var loc5 = loc3[3];
		var loc6 = loc5.split(";");
		loc4.areas = new ank.utils.();
		for(var loc7 in loc6)
		{
			if(loc7.length >= 5)
			{
				var loc8 = new dofus.datacenter.(Number(loc7[0]),Number(loc7[1]),Number(loc7[2]) == 1,Number(loc7[3]),Number(loc7[4]) == 1);
				loc4.areas.push(loc8);
			}
		}
		loc4.areas.sortOn("areaName");
		loc4.ownedVillages = Number(loc3[4]);
		loc4.totalVillages = Number(loc3[5]);
		var loc9 = loc3[6];
		var loc10 = loc9.split(";");
		loc4.villages = new ank.utils.();
		for(var loc11 in loc10)
		{
			if(loc11.length == 4)
			{
				var loc12 = new dofus.datacenter.(Number(loc11[0]),Number(loc11[1]),Number(loc11[2]) == 1,Number(loc11[3]) == 1);
				loc4.villages.push(loc12);
			}
		}
		loc4.villages.sortOn("areaName");
		this.api.datacenter.Conquest.worldDatas = loc4;
	}
	function onPrismInfosJoined(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = Number(loc3[0]);
		var loc5 = (dofus.graphics.gapi.ui.Conquest)this.api.ui.getUIComponent("Conquest");
		if(loc4 == 0)
		{
			var loc6 = Number(loc3[1]);
			var loc7 = Number(loc3[2]);
			var loc8 = Number(loc3[3]);
			var loc9 = new Object();
			loc9.error = 0;
			loc9.timer = loc6;
			loc9.maxTimer = loc7;
			loc9.timerReference = getTimer();
			loc9.maxTeamPositions = loc8;
			loc5.sharePropertiesWithTab(loc9);
		}
		else
		{
			var loc10 = new Object();
			if((var loc0 = loc4) !== -1)
			{
				switch(null)
				{
					case -2:
					case -3:
				}
				loc5.sharePropertiesWithTab(loc10);
			}
			loc10.error = loc4;
			loc5.sharePropertiesWithTab(loc10);
		}
	}
	function onPrismInfosClosing(loc2)
	{
		var loc3 = (dofus.graphics.gapi.ui.Conquest)this.api.ui.getUIComponent("Conquest");
		loc3.sharePropertiesWithTab({noUnsubscribe:true});
		this.api.ui.unloadUIComponent("Conquest");
	}
	function onPrismAttacked(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1];
		var loc6 = loc3[2];
		var loc7 = "[" + loc5 + ", " + loc6 + "]";
		var loc8 = Number(this.api.lang.getMapText(loc4).sa);
		var loc9 = String(this.api.lang.getMapSubAreaText(loc8).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(loc8).n:String(this.api.lang.getMapSubAreaText(loc8).n).substr(2);
		if(loc8 == this.api.datacenter.Basics.gfx_lastSubarea)
		{
			this.api.kernel.showMessage(undefined,"<img src=\"CautionIcon\" hspace=\'0\' vspace=\'0\' width=\'13\' height=\'13\' />" + this.api.lang.getText("PRISM_ATTACKED",[loc9,loc7]),"PVP_CHAT");
			this.api.sounds.events.onTaxcollectorAttack();
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("PRISM_ATTACKED",[loc9,loc7]),"PVP_CHAT");
		}
	}
	function onPrismSurvived(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1];
		var loc6 = loc3[2];
		var loc7 = "[" + loc5 + ", " + loc6 + "]";
		var loc8 = Number(this.api.lang.getMapText(loc4).sa);
		var loc9 = String(this.api.lang.getMapSubAreaText(loc8).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(loc8).n:String(this.api.lang.getMapSubAreaText(loc8).n).substr(2);
		this.api.kernel.showMessage(undefined,this.api.lang.getText("PRISM_ATTACKED_SUVIVED",[loc9,loc7]),"PVP_CHAT");
	}
	function onPrismDead(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1];
		var loc6 = loc3[2];
		var loc7 = "[" + loc5 + ", " + loc6 + "]";
		var loc8 = Number(this.api.lang.getMapText(loc4).sa);
		var loc9 = String(this.api.lang.getMapSubAreaText(loc8).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(loc8).n:String(this.api.lang.getMapSubAreaText(loc8).n).substr(2);
		this.api.kernel.showMessage(undefined,this.api.lang.getText("PRISM_ATTACKED_DIED",[loc9,loc7]),"PVP_CHAT");
	}
	function onPrismFightAddPlayer(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("|");
		var loc5 = _global.parseInt(loc4[0],36);
		var loc6 = 1;
		while(loc6 < loc4.length)
		{
			var loc7 = loc4[loc6].split(";");
			if(loc3)
			{
				var loc8 = new Object();
				loc8.id = _global.parseInt(loc7[0],36);
				loc8.name = loc7[1];
				loc8.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + loc7[2] + ".swf";
				loc8.level = Number(loc7[3]);
				loc8.color1 = _global.parseInt(loc7[4],36);
				loc8.color2 = _global.parseInt(loc7[5],36);
				loc8.color3 = _global.parseInt(loc7[6],36);
				loc8.reservist = loc7[7] == "1";
				var loc9 = this.api.datacenter.Conquest.players.findFirstItem("id",loc8.id);
				if(loc9.index != -1)
				{
					this.api.datacenter.Conquest.players.updateItem(loc9.index,loc8);
				}
				else
				{
					this.api.datacenter.Conquest.players.push(loc8);
				}
			}
			else
			{
				var loc10 = _global.parseInt(loc7[0],36);
				var loc11 = this.api.datacenter.Conquest.players.findFirstItem("id",loc10);
				if(loc11.index != -1)
				{
					this.api.datacenter.Conquest.players.removeItems(loc11.index,1);
				}
			}
			loc6 = loc6 + 1;
		}
	}
	function onPrismFightAddEnemy(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("|");
		var loc5 = _global.parseInt(loc4[0],36);
		var loc6 = this.api.datacenter.Conquest.attackers;
		var loc7 = 1;
		while(loc7 < loc4.length)
		{
			var loc8 = loc4[loc7].split(";");
			if(loc3)
			{
				var loc9 = new Object();
				loc9.id = _global.parseInt(loc8[0],36);
				loc9.name = loc8[1];
				loc9.level = Number(loc8[2]);
				var loc10 = loc6.findFirstItem("id",loc9.id);
				if(loc10.index != -1)
				{
					loc6.updateItem(loc10.index,loc9);
				}
				else
				{
					loc6.push(loc9);
				}
			}
			else
			{
				var loc11 = _global.parseInt(loc8[0],36);
				var loc12 = loc6.findFirstItem("id",loc11);
				if(loc12.index != -1)
				{
					loc6.removeItems(loc12.index,1);
				}
			}
			loc7 = loc7 + 1;
		}
	}
}
