class ank.gapi.controls.RightClick extends ContextMenu
{
	function RightClick(oAPI, callbackFunction)
	{
		super(callbackFunction);
		this.hideBuiltInItems();
		var proto = ank.gapi.controls.RightClick.prototype;
		this.onSelect = function()
		{
			proto.onRightClick(oAPI);
		};
	}
	function onRightClick(var2)
	{
		var2.ui.hideTooltip();
		var var3 = ank.gapi.controls.PopupMenu.currentPopupMenu;
		if(var3 != undefined)
		{
			var3.onMouseUp();
		}
		var2.mouseClicksMemorizer.storeCurrentMouseClick(true);
		if(var2.gfx.rollOverMcSprite != undefined && !(var2.gfx.rollOverMcSprite.data instanceof dofus.datacenter.Character))
		{
			var2.gfx.onSpriteRelease(var2.gfx.rollOverMcSprite,true);
			return undefined;
		}
		if(var2.gfx.rollOverMcObject != undefined)
		{
			var2.gfx.onObjectRelease(var2.gfx.rollOverMcObject,true);
			return undefined;
		}
		var var4 = 0;
		while(var4 < dofus.Constants.INTERFACES_MANIPULATING_ITEMS.length)
		{
			var var5 = var2.ui.getUIComponent(dofus.Constants.INTERFACES_MANIPULATING_ITEMS[var4]);
			var var6 = var5.currentOverItem;
			if(var6 != undefined)
			{
				var5.itemViewer.createActionPopupMenu(var6);
				return undefined;
			}
			var4 = var4 + 1;
		}
		if(var2.datacenter.Basics.inGame && var2.datacenter.Player.isAuthorized)
		{
			var var7 = var2.kernel.AdminManager.getAdminPopupMenu(var2.datacenter.Player.Name,true);
			var7.addItem("Client v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + " >>",this,this.printRightClickPopupMenu,[var2]);
			var7.items.unshift(var7.items.pop());
			var7.show(_root._xmouse,_root._ymouse,true);
		}
		else
		{
			this.printRightClickPopupMenu(var2);
		}
	}
	function printRightClickPopupMenu(api)
	{
		var var2 = api.ui.createPopupMenu();
		var2.addStaticItem("DOFUS RETRO Client v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION);
		var2.addStaticItem("Flash player " + System.capabilities.version);
		var o = new Object();
		var gapi = api.ui;
		o.selectQualities = function()
		{
			var var2 = gapi.createPopupMenu();
			var2.addStaticItem(api.lang.getText("OPTION_DEFAULTQUALITY"));
			var2.addItem(api.lang.getText("QUALITY_LOW"),o,o.setQualityOption,["low"],o.getOption("DefaultQuality") != "low");
			var2.addItem(api.lang.getText("QUALITY_MEDIUM"),o,o.setQualityOption,["medium"],o.getOption("DefaultQuality") != "medium");
			var2.addItem(api.lang.getText("QUALITY_HIGH"),o,o.setQualityOption,["high"],o.getOption("DefaultQuality") != "high");
			var2.addItem(api.lang.getText("QUALITY_BEST"),o,o.setQualityOption,["best"],o.getOption("DefaultQuality") != "best");
			var2.show();
		};
		o.setQualityOption = function(var2)
		{
			o.setOption("DefaultQuality",var2);
		};
		o.setOption = function(var2, var3)
		{
			api.kernel.OptionsManager.setOption(var2,var3);
		};
		o.getOption = function(var2)
		{
			return api.kernel.OptionsManager.getOption(var2);
		};
		var2.addItem(api.lang.getText("OPTION_DEFAULTQUALITY") + " >>",o,o.selectQualities);
		var2.addItem(api.lang.getText("OPTIONS"),gapi,gapi.loadUIComponent,["Options","Options",{_y:(gapi.screenHeight != 432?0:-50)},{bAlwaysOnTop:true}]);
		var2.addItem(api.lang.getText("OPTION_MOVABLEBAR"),o,o.setOption,["MovableBar",!o.getOption("MovableBar")]);
		var2.show(_root._xmouse,_root._ymouse,true);
	}
}
