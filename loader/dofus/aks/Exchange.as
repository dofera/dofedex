class dofus.aks.Exchange extends dofus.aks.Handler
{
	function Exchange(var3, var4)
	{
		super.initialize(var3,var4);
	}
	function leave()
	{
		this.aks.send("EV",true);
	}
	function request(§\x1e\f\x16§, §\r\x1b§, cellNum)
	{
		this.aks.send("ER" + var2 + "|" + (!(var3 == undefined || _global.isNaN(var3))?var3:"") + (!(cellNum == undefined || _global.isNaN(cellNum))?"|" + cellNum:""),true);
	}
	function shop(var2)
	{
		this.aks.send("Es" + var2);
	}
	function accept()
	{
		this.aks.send("EA",false);
	}
	function ready()
	{
		this.aks.send("EK",true);
	}
	function movementItem(var2, var3, var4, var5)
	{
		this.aks.send("EMO" + (!var2?"-":"+") + var3 + "|" + var4 + (var5 != undefined?"|" + var5:""),true);
	}
	function movementItems(var2)
	{
		var var3 = "";
		var var8 = 0;
		while(var8 < var2.length)
		{
			var var4 = var2[var8].Add;
			var var5 = var2[var8].ID;
			var var6 = var2[var8].Quantity;
			var var7 = var2[var8].Price;
			var3 = var3 + ((!var4?"-":"+") + var5 + "|" + var6 + (var7 != undefined?"|" + var7:""));
			var8 = var8 + 1;
		}
		this.aks.send("EMO" + var3,true);
	}
	function movementPayItem(var2, var3, var4, var5, var6)
	{
		this.aks.send("EP" + var2 + "O" + (!var3?"-":"+") + var4 + "|" + var5 + (var6 != undefined?"|" + var6:""),true);
	}
	function movementKama(var2)
	{
		this.aks.send("EMG" + var2,true);
	}
	function movementPayKama(var2, var3)
	{
		this.aks.send("EP" + var2 + "G" + var3,true);
	}
	function sell(var2, var3)
	{
		this.aks.send("ES" + var2 + "|" + var3,true);
	}
	function buy(var2, var3)
	{
		this.aks.send("EB" + var2 + "|" + var3,true);
	}
	function offlineExchange()
	{
		this.aks.send("EQ",true);
	}
	function askOfflineExchange()
	{
		this.aks.send("Eq",true);
	}
	function bigStoreType(var2)
	{
		this.aks.send("EHT" + var2);
	}
	function bigStoreItemList(var2)
	{
		this.aks.send("EHl" + var2);
	}
	function bigStoreBuy(var2, var3, var4)
	{
		this.aks.send("EHB" + var2 + "|" + var3 + "|" + var4,true);
	}
	function bigStoreSearch(var2, var3)
	{
		this.aks.send("EHS" + var2 + "|" + var3);
	}
	function setPublicMode(var2)
	{
		this.aks.send("EW" + (!var2?"-":"+"),false);
	}
	function getCrafterForJob(var2)
	{
		this.aks.send("EJF" + var2,true);
	}
	function putInShedFromInventory(var2)
	{
		this.aks.send("Erp" + var2,true);
	}
	function putInInventoryFromShed(var2)
	{
		this.aks.send("Erg" + var2,true);
	}
	function putInCertificateFromShed(var2)
	{
		this.aks.send("Erc" + var2,true);
	}
	function putInShedFromCertificate(var2)
	{
		this.aks.send("ErC" + var2,true);
	}
	function putInMountParkFromShed(var2)
	{
		this.aks.send("Efp" + var2,true);
	}
	function putInShedFromMountPark(var2)
	{
		this.aks.send("Efg" + var2,true);
	}
	function killMountInPark(var2)
	{
		this.aks.send("Eff" + var2,false);
	}
	function killMount(var2)
	{
		this.aks.send("Erf" + var2,false);
	}
	function getItemMiddlePriceInBigStore(var2)
	{
		this.aks.send("EHP" + var2,false);
	}
	function replayCraft()
	{
		this.aks.send("EL",false);
	}
	function repeatCraft(var2)
	{
		this._nItemsToCraft = var2;
		this.aks.send("EMR" + var2,false);
		this.api.datacenter.Basics.isCraftLooping = true;
	}
	function stopRepeatCraft()
	{
		this.aks.send("EMr",false);
	}
	function onRequest(var2, var3)
	{
		if(var2)
		{
			var var4 = var3.split("|");
			var var5 = var4[0];
			var var6 = var4[1];
			var var7 = Number(var4[2]);
			var var8 = this.api.datacenter.Player.ID != var5?var5:var6;
			if(var7 == 12 || var7 == 13)
			{
				var var9 = new dofus.datacenter.(var8);
			}
			else
			{
				var9 = new dofus.datacenter.Exchange(var8);
			}
			this.api.datacenter.Exchange = var9;
			if(this.api.datacenter.Player.ID == var5)
			{
				var var10 = this.api.datacenter.Sprites.getItemAt(var6);
				switch(var7)
				{
					case 1:
						var var11 = "WAIT_FOR_EXCHANGE";
						break;
					case 12:
						var11 = "WAIT_FOR_CRAFT_CLIENT";
						break;
					default:
						if(var0 !== 13)
						{
							break;
						}
						var11 = "WAIT_FOR_CRAFT_ARTISAN";
						break;
				}
				this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"),this.api.lang.getText(var11,[var10.name]),"INFO_CANCEL",{name:"Exchange",listener:this});
			}
			else
			{
				var var12 = this.api.datacenter.Sprites.getItemAt(var5);
				if(this.api.kernel.ChatManager.isBlacklisted(var12.name))
				{
					this.leave();
					return undefined;
				}
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CHAT_A_WANT_EXCHANGE",[this.api.kernel.ChatManager.getLinkName(var12.name)]),"INFO_CHAT");
				switch(var7)
				{
					case 1:
						var var13 = "A_WANT_EXCHANGE";
						break;
					case 12:
						var13 = "A_WANT_CRAFT_CLIENT";
						break;
					case 13:
						var13 = "A_WANT_CRAFT_ARTISAN";
				}
				this.api.electron.makeNotification(this.api.lang.getText(var13,[var12.name]));
				this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"),this.api.lang.getText(var13,[var12.name]),"CAUTION_YESNOIGNORE",{name:"Exchange",player:var12.name,listener:this,params:{player:var12.name}});
			}
		}
		else
		{
			var var14 = var3.charAt(0);
			switch(var14)
			{
				case "O":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("ALREADY_EXCHANGE"),"ERROR_CHAT");
					break;
				case "T":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_NEAR_CRAFT_TABLE"),"ERROR_CHAT");
					break;
				case "J":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_85"),"ERROR_CHAT");
					break;
				case "o":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_70"),"ERROR_CHAT");
					break;
				case "S":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_62"),"ERROR_CHAT");
					break;
				default:
					if(var0 !== "I")
					{
					}
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_EXCHANGE"),"ERROR_CHAT");
			}
		}
	}
	function onAskOfflineExchange(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]) / 10;
		var var6 = Number(var3[2]);
		this.api.kernel.GameManager.askOfflineExchange(var4,var5,var6);
	}
	function onReady(var2)
	{
		var var3 = var2.charAt(0) == "1";
		var var4 = Number(var2.substr(1));
		var var5 = var4 != this.api.datacenter.Player.ID?1:0;
		this.api.datacenter.Exchange.readyStates.updateItem(var5,var3);
	}
	function onLeave(var2, var3)
	{
		delete this.api.datacenter.Basics.aks_exchange_echangeType;
		delete this.api.datacenter.Exchange;
		this.api.ui.unloadUIComponent("AskYesNoIgnoreExchange");
		this.api.ui.unloadUIComponent("AskCancelExchange");
		if(this.api.ui.getUIComponent("Exchange"))
		{
			if(var3 == "a")
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("EXCHANGE_OK"),"INFO_CHAT");
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("EXCHANGE_CANCEL"),"INFO_CHAT");
			}
		}
		this.api.ui.unloadUIComponent("Exchange");
		this.api.ui.unloadUIComponent("Craft");
		this.api.ui.unloadUIComponent("NpcShop");
		this.api.ui.unloadUIComponent("PlayerShop");
		this.api.ui.unloadUIComponent("TaxCollectorStorage");
		this.api.ui.unloadUIComponent("PlayerShopModifier");
		this.api.ui.unloadUIComponent("Storage");
		this.api.ui.unloadUIComponent("BigStoreSell");
		this.api.ui.unloadUIComponent("BigStoreBuy");
		this.api.ui.unloadUIComponent("SecureCraft");
		this.api.ui.unloadUIComponent("CrafterList");
		this.api.ui.unloadUIComponent("ItemUtility");
		this.api.ui.unloadUIComponent("MountStorage");
		this.api.ui.unloadUIComponent("MountParkSale");
		this.api.ui.unloadUIComponent("HouseSale");
		if(dofus.Constants.SAVING_THE_WORLD)
		{
			dofus.SaveTheWorld.getInstance().nextAction();
		}
	}
	function onCreate(var2, var3)
	{
		if(!var2)
		{
			return undefined;
		}
		var var4 = var3.split("|");
		var var5 = Number(var4[0]);
		var var6 = var4[1];
		this.api.datacenter.Basics.aks_exchange_echangeType = var5;
		var var7 = this.api.datacenter.Temporary;
		if((var var0 = var5) !== 0)
		{
			loop3:
			switch(null)
			{
				case 4:
					break;
				case 1:
					this.api.datacenter.Exchange.inventory = this.api.datacenter.Player.Inventory.clone();
					this.api.ui.unloadUIComponent("AskYesNoIgnoreExchange");
					this.api.ui.unloadUIComponent("AskCancelExchange");
					this.api.ui.loadUIComponent("Exchange","Exchange");
					break;
				default:
					switch(null)
					{
						case 18:
						case 3:
						case 5:
							var7.Storage = new dofus.datacenter.Storage();
							this.api.ui.loadUIComponent("Storage","Storage",{data:var7.Storage});
							break loop3;
						case 8:
							var7.Storage = new dofus.datacenter.TaxCollectorStorage();
							var var12 = this.api.datacenter.Sprites.getItemAt(var6);
							var7.Storage.name = var12.name;
							var7.Storage.gfx = var12.gfxID;
							this.api.ui.loadUIComponent("TaxCollectorStorage","TaxCollectorStorage",{data:var7.Storage});
							break loop3;
						case 6:
							var7.Shop = new dofus.datacenter.Shop();
							this.api.ui.loadUIComponent("PlayerShopModifier","PlayerShopModifier",{data:var7.Shop});
							break loop3;
						default:
							switch(null)
							{
								case 10:
									var7.Shop = new dofus.datacenter.();
									var4 = var6.split(";");
									var var13 = var4[0].split(",");
									var7.Shop.quantity1 = Number(var13[0]);
									var7.Shop.quantity2 = Number(var13[1]);
									var7.Shop.quantity3 = Number(var13[2]);
									var7.Shop.types = var4[1].split(",");
									var7.Shop.tax = Number(var4[2]);
									var7.Shop.maxLevel = Number(var4[3]);
									var7.Shop.maxItemCount = Number(var4[4]);
									var7.Shop.npcID = Number(var4[5]);
									var7.Shop.maxSellTime = Number(var4[6]);
									this.api.ui.loadUIComponent("BigStoreSell","BigStoreSell",{data:var7.Shop});
									break loop3;
								case 11:
									var7.Shop = new dofus.datacenter.();
									var4 = var6.split(";");
									var var14 = var4[0].split(",");
									var7.Shop.quantity1 = Number(var14[0]);
									var7.Shop.quantity2 = Number(var14[1]);
									var7.Shop.quantity3 = Number(var14[2]);
									var7.Shop.types = var4[1].split(",");
									var7.Shop.tax = Number(var4[2]);
									var7.Shop.maxLevel = Number(var4[3]);
									var7.Shop.maxItemCount = Number(var4[4]);
									var7.Shop.npcID = Number(var4[5]);
									var7.Shop.maxSellTime = Number(var4[6]);
									this.api.ui.loadUIComponent("BigStoreBuy","BigStoreBuy",{data:var7.Shop});
									break loop3;
								case 12:
								case 13:
									this.api.datacenter.Exchange.inventory = this.api.datacenter.Player.Inventory.clone();
									var4 = var6.split(";");
									var var15 = Number(var4[0]);
									var var16 = Number(var4[1]);
									this.api.ui.unloadUIComponent("AskYesNoIgnoreExchange");
									this.api.ui.unloadUIComponent("AskCancelExchange");
									this.api.ui.loadUIComponent("SecureCraft","SecureCraft",{skillId:var16,maxItem:var15});
									break loop3;
								case 14:
									var var17 = new ank.utils.();
									var var18 = var6.split(";");
									var var19 = 0;
									while(var19 < var18.length)
									{
										var var20 = Number(var18[var19]);
										var17.push({label:this.api.lang.getJobText(var20).n,id:var20});
										var19 = var19 + 1;
									}
									this.api.ui.loadUIComponent("CrafterList","CrafterList",{crafters:new ank.utils.(),jobs:var17});
									break loop3;
								default:
									switch(null)
									{
										case 15:
											this.api.ui.unloadUIComponent("Mount");
											var7.Storage = new dofus.datacenter.Storage();
											this.api.ui.loadUIComponent("Storage","Storage",{isMount:true,data:var7.Storage});
											break;
										case 16:
											var var21 = new ank.utils.();
											var var22 = new ank.utils.();
											var4 = var6.split("~");
											var var23 = var4[0].split(";");
											var var24 = var4[1].split(";");
											if(var23 != undefined)
											{
												var var25 = 0;
												while(var25 < var23.length)
												{
													if(var23[var25] != "")
													{
														var21.push(this.api.network.Mount.createMount(var23[var25]));
													}
													var25 = var25 + 1;
												}
											}
											if(var24 != undefined)
											{
												var var26 = 0;
												while(var26 < var24.length)
												{
													if(var24[var26] != "")
													{
														var22.push(this.api.network.Mount.createMount(var24[var26]));
													}
													var26 = var26 + 1;
												}
											}
											this.api.ui.loadUIComponent("MountStorage","MountStorage",{mounts:var21,parkMounts:var22});
									}
							}
					}
				case 2:
				case 9:
				case 17:
					if(var5 == 3)
					{
						this.api.datacenter.Exchange = new dofus.datacenter.Exchange();
					}
					else
					{
						this.api.datacenter.Exchange = new dofus.datacenter.Exchange(Number(var6));
					}
					this.api.datacenter.Exchange.inventory = this.api.datacenter.Player.Inventory.clone();
					if(var5 == 3)
					{
						var4 = var6.split(";");
						var var10 = Number(var4[0]);
						var var11 = Number(var4[1]);
						if(_global.API.lang.getSkillForgemagus(var11) > 0)
						{
							this.api.ui.loadUIComponent("ForgemagusCraft","Craft",{skillId:var11,maxItem:var10});
						}
						else
						{
							this.api.ui.loadUIComponent("Craft","Craft",{skillId:var11,maxItem:var10});
						}
					}
					else
					{
						this.api.ui.unloadUIComponent("AskYesNoIgnoreExchange");
						this.api.ui.unloadUIComponent("AskCancelExchange");
						this.api.ui.loadUIComponent("Exchange","Exchange");
					}
			}
		}
		var7.Shop = new dofus.datacenter.Shop();
		var var8 = this.api.datacenter.Sprites.getItemAt(var6);
		var7.Shop.name = var8.name;
		var7.Shop.gfx = var8.gfxID;
		var var9 = new Array();
		var9[1] = var8.color1 != undefined?var8.color1:-1;
		var9[2] = var8.color2 != undefined?var8.color2:-1;
		var9[3] = var8.color3 != undefined?var8.color3:-1;
		if(var5 == 0)
		{
			this.api.ui.loadUIComponent("NpcShop","NpcShop",{data:var7.Shop,colors:var9});
		}
		else if(var5 == 4)
		{
			this.api.ui.loadUIComponent("PlayerShop","PlayerShop",{data:var7.Shop,colors:var9});
		}
	}
	function onCrafterReference(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = Number(var2.substr(1));
		this.api.kernel.showMessage(undefined,this.api.lang.getText(!var3?"CRAFTER_REFERENCE_REMOVE":"CRAFTER_REFERENCE_ADD",[this.api.lang.getJobText(var4).n]),"INFO_CHAT");
	}
	function onCrafterListChanged(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split(";");
		var var5 = this.api.ui.getUIComponent("CrafterList").crafters;
		var var6 = Number(var4[0]);
		var var7 = var4[1];
		var var8 = var5.findFirstItem("id",var7);
		if(var3)
		{
			var var9 = var4[2];
			var var10 = Number(var4[3]);
			var var11 = Number(var4[4]);
			var var12 = !!Number(var4[5]);
			var var13 = Number(var4[6]);
			var var14 = Number(var4[7]);
			var var15 = var4[8].split(",");
			var var16 = var4[9];
			var var17 = var4[10].split(",");
			var var18 = new dofus.datacenter.(var7,var9);
			var18.job = new dofus.datacenter.Job(var6,new ank.utils.(),new dofus.datacenter.(Number(var17[0]),Number(var17[1])));
			var18.job.level = var10;
			var18.mapId = var11;
			var18.inWorkshop = var12;
			var18.breedId = var13;
			var18.sex = var14;
			var18.color1 = var15[0];
			var18.color2 = var15[1];
			var18.color3 = var15[2];
			this.api.kernel.CharactersManager.setSpriteAccessories(var18,var16);
			if(var8.index != -1)
			{
				var5.updateItem(var8.index,var18);
			}
			else
			{
				var5.push(var18);
			}
		}
		else if(var8.index != -1)
		{
			var5.removeItems(var8.index,1);
		}
	}
	function onMountStorage(var2)
	{
		var var3 = var2.charAt(0);
		var var4 = false;
		if((var var0 = var3) !== "~")
		{
			switch(null)
			{
				case "+":
					break;
				case "-":
					var var5 = Number(var2.substr(1));
					var var6 = this.api.ui.getUIComponent("MountStorage").mounts;
					for(var a in var6)
					{
						if(var6[a].ID == var5)
						{
							var6.removeItems(Number(a),1);
						}
					}
					break;
				case "E":
			}
			break loop0;
		}
		var4 = true;
		this.api.ui.getUIComponent("MountStorage").mounts.push(this.api.network.Mount.createMount(var2.substr(1),var4));
	}
	function onMountPark(var2)
	{
		var var3 = var2.charAt(0);
		switch(var3)
		{
			case "+":
				this.api.ui.getUIComponent("MountStorage").parkMounts.push(this.api.network.Mount.createMount(var2.substr(1)));
				break;
			case "-":
				var var4 = Number(var2.substr(1));
				var var5 = this.api.ui.getUIComponent("MountStorage").parkMounts;
				for(var a in var5)
				{
					if(var5[a].ID == var4)
					{
						var5.removeItems(Number(a),1);
					}
				}
				break;
			default:
				if(§§enum_assign() !== "E")
				{
					break;
				}
		}
		break loop0;
	}
	function onCraft(var2, var3)
	{
		if(this.api.datacenter.Basics.aks_exchange_isForgemagus || !this.api.datacenter.Basics.isCraftLooping)
		{
			this.api.datacenter.Exchange.clearLocalGarbage();
		}
		var var4 = this.api.datacenter.Basics.aks_exchange_echangeType;
		if(var4 == 12 || var4 == 13)
		{
			var var5 = this.api.datacenter.Exchange;
			var5.clearDistantGarbage();
			var5.clearPayGarbage();
			var5.clearPayIfSuccessGarbage();
			var5.payKama = 0;
			var5.payIfSuccessKama = 0;
			this.api.ui.getUIComponent("SecureCraft").updateInventory();
		}
		var var6 = !this.api.datacenter.Basics.aks_exchange_isForgemagus;
		switch(var3.substr(0,1))
		{
			case "I":
				if(!var2)
				{
					this.api.kernel.showMessage(this.api.lang.getText("CRAFT"),this.api.lang.getText("NO_CRAFT_RESULT"),"ERROR_BOX",{name:"Impossible"});
				}
				break;
			case "F":
				if(!var2 && var6)
				{
					this.api.kernel.showMessage(this.api.lang.getText("CRAFT"),this.api.lang.getText("CRAFT_FAILED"),"ERROR_BOX",{name:"CraftFailed"});
				}
				this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CRAFT_KO);
				break;
			case ";":
				if(var2)
				{
					var var7 = var3.substr(1).split(";");
					if(var7.length == 1)
					{
						var var8 = new dofus.datacenter.(0,Number(var7[0]),undefined,undefined,undefined);
						this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_SUCCESS_SELF",[var8.name]),"INFO_CHAT");
						this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CRAFT_KO);
						break;
					}
					var var9 = var7[1].substr(0,1);
					var var10 = var7[1].substr(1);
					var var11 = Number(var7[0]);
					var var12 = var7[2];
					var var13 = new Array();
					var13.push(var11);
					var13.push(var12);
					switch(var9)
					{
						case "T":
							this.api.kernel.showMessage(undefined,this.api.kernel.ChatManager.parseInlineItems(this.api.lang.getText("CRAFT_SUCCESS_TARGET",[var10]),var13),"INFO_CHAT");
							break;
						case "B":
							this.api.kernel.showMessage(undefined,this.api.kernel.ChatManager.parseInlineItems(this.api.lang.getText("CRAFT_SUCCESS_OTHER",[var10]),var13),"INFO_CHAT");
					}
					break;
				}
		}
		if(!var2)
		{
			this.api.datacenter.Exchange.clearCoopGarbage();
		}
	}
	function onCraftLoop(var2)
	{
		var var3 = Number(var2);
		this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_LOOP_PROCESS",[this._nItemsToCraft - var3 + 1,this._nItemsToCraft + 1]),"INFO_CHAT");
	}
	function onCraftLoopEnd(var2)
	{
		var var3 = Number(var2);
		this.api.datacenter.Basics.isCraftLooping = false;
		switch(var3)
		{
			case 1:
				this.api.electron.makeNotification(this.api.lang.getText("CRAFT_LOOP_END_OK"));
				var var4 = this.api.lang.getText("CRAFT_LOOP_END_OK");
				break;
			case 2:
				var4 = this.api.lang.getText("CRAFT_LOOP_END_INTERRUPT");
				break;
			case 3:
				var4 = this.api.lang.getText("CRAFT_LOOP_END_FAIL");
				break;
			case 4:
				var4 = this.api.lang.getText("CRAFT_LOOP_END_INVALID");
		}
		this.api.kernel.showMessage(undefined,var4,"INFO_CHAT");
		this.api.kernel.showMessage(this.api.lang.getText("CRAFT"),var4,"ERROR_BOX");
		this.api.ui.getUIComponent("Craft").onCraftLoopEnd();
		if(!this.api.datacenter.Basics.aks_exchange_isForgemagus)
		{
			this.api.datacenter.Exchange.clearLocalGarbage();
		}
	}
	function onLocalMovement(var2, var3)
	{
		this.modifyLocal(var3,this.api.datacenter.Exchange.localGarbage,"localKama");
	}
	function onDistantMovement(var2, var3)
	{
		loop0:
		switch(this.api.datacenter.Basics.aks_exchange_echangeType)
		{
			default:
				switch(null)
				{
					case 3:
					case 9:
					case 12:
					case 13:
						break loop0;
					case 10:
						var var4 = var3.charAt(0) == "+";
						var var5 = var3.substr(1).split("|");
						var var6 = Number(var5[0]);
						var var7 = Number(var5[1]);
						var var8 = Number(var5[2]);
						var var9 = var5[3];
						var var10 = Number(var5[4]);
						var var11 = Number(var5[5]);
						var var12 = this.api.datacenter.Temporary.Shop;
						var var13 = var12.inventory.findFirstItem("ID",var6);
						if(var4)
						{
							var var14 = new dofus.datacenter.(var6,var8,var7,-1,var9,var10);
							var14.remainingHours = var11;
							if(var13.index != -1)
							{
								var12.inventory.updateItem(var13.index,var14);
							}
							else
							{
								var12.inventory.push(var14);
							}
						}
						else if(var13.index != -1)
						{
							var12.inventory.removeItems(var13.index,1);
						}
						else
						{
							ank.utils.Logger.err("[onDistantMovement] cet objet n\'existe pas id=" + var6);
						}
						this.api.ui.getUIComponent("BigStoreSell").updateItemCount();
				}
			case 1:
			case 2:
		}
		this.modifyDistant(var3,this.api.datacenter.Exchange.distantGarbage,"distantKama");
	}
	function onCoopMovement(var2, var3)
	{
		this.api.datacenter.Exchange.clearCoopGarbage();
		switch(this.api.datacenter.Basics.aks_exchange_echangeType)
		{
			case 12:
				this.modifyDistant(var3,this.api.datacenter.Exchange.coopGarbage,"distantKama",false);
				break;
			case 13:
				this.modifyDistant(var3,this.api.datacenter.Exchange.coopGarbage,"distantKama",true);
		}
	}
	function onPayMovement(var2, var3)
	{
		var var4 = Number(var3.charAt(0));
		if(var4 != 1)
		{
			addr36:
			loop0:
			while(true)
			{
				var var5 = §§pop();
				var var6 = var4 != 1?"payIfSuccessKama":"payKama";
				switch(this.api.datacenter.Basics.aks_exchange_echangeType)
				{
					case 12:
						this.modifyDistant(var3.substr(2),var5,var6,false);
						break loop0;
					case 13:
						this.modifyLocal(var3.substr(2),var5,var6);
				}
			}
			§§push(this.api.datacenter.Exchange.payIfSuccessGarbage);
		}
		else
		{
			§§push(this.api.datacenter.Exchange);
			§§push("payGarbage");
		}
		while(true)
		{
			§§goto(addr36);
		}
	}
	function modifyLocal(var2, var3, var4)
	{
		var var5 = var2.charAt(0);
		var var6 = this.api.datacenter.Exchange;
		switch(var5)
		{
			case "O":
				var var7 = var2.charAt(1) == "+";
				var var8 = var2.substr(2).split("|");
				var var9 = Number(var8[0]);
				var var10 = Number(var8[1]);
				var var11 = this.api.datacenter.Player.Inventory.findFirstItem("ID",var9);
				var var12 = var6.inventory.findFirstItem("ID",var9);
				var var13 = var3.findFirstItem("ID",var9);
				if(var7)
				{
					var var14 = var12.item;
					var var15 = new dofus.datacenter.(var9,var14.unicID,var10,-2,var14.compressedEffects);
					var var16 = -1;
					var var17 = var11.item.Quantity - var10;
					if(var17 == 0)
					{
						var16 = -3;
					}
					var12.item.Quantity = var17;
					var12.item.position = var16;
					var6.inventory.updateItem(var12.index,var12.item);
					if(var13.index != -1)
					{
						var3.updateItem(var13.index,var15);
					}
					else
					{
						var3.push(var15);
					}
				}
				else if(var13.index != -1)
				{
					var12.item.position = -1;
					var12.item.Quantity = var11.item.Quantity;
					var6.inventory.updateItem(var12.index,var12.item);
					var3.removeItems(var13.index,1);
				}
				break;
			case "G":
				var var18 = Number(var2.substr(1));
				var6[var4] = var18;
		}
	}
	function modifyDistant(var2, var3, var4, var5)
	{
		var var6 = var2.charAt(0);
		var var7 = this.api.datacenter.Exchange;
		switch(var6)
		{
			case "O":
				var var8 = var2.charAt(1) == "+";
				var var9 = var2.substr(2).split("|");
				var var10 = Number(var9[0]);
				var var11 = Number(var9[1]);
				var var12 = Number(var9[2]);
				var var13 = var9[3];
				var var14 = var3.findFirstItem("ID",var10);
				if(var8)
				{
					var var15 = new dofus.datacenter.(var10,var12,var11,-1,var13);
					var var16 = var5 == undefined?var7.distantPlayerID == undefined:var5;
					if(var14.index != -1)
					{
						var3.updateItem(var14.index,var15);
					}
					else
					{
						var3.push(var15);
					}
					if(var16)
					{
						var var17 = var7.inventory.findFirstItem("ID",var10);
						if(var17.index != -1)
						{
							var17.item.position = -1;
							var17.item.Quantity = Number(var17.item.Quantity) + Number(var11);
							var7.inventory.updateItem(var17.index,var17.item);
						}
						else
						{
							var7.inventory.push(var15);
							_global.API.ui.getUIComponent("Craft").updateForgemagusResult(var15);
						}
					}
				}
				else if(var14.index != -1)
				{
					var3.removeItems(var14.index,1);
				}
				break;
			case "G":
				var var18 = Number(var2.substr(1));
				var7[var4] = var18;
		}
	}
	function onStorageMovement(var2, var3)
	{
		var var4 = var3.charAt(0);
		var var5 = this.api.datacenter.Temporary.Storage;
		switch(var4)
		{
			case "O":
				var var6 = var3.charAt(1) == "+";
				var var7 = var3.substr(2).split("|");
				var var8 = Number(var7[0]);
				var var9 = Number(var7[1]);
				var var10 = Number(var7[2]);
				var var11 = var7[3];
				var var12 = var5.inventory.findFirstItem("ID",var8);
				if(var6)
				{
					var var13 = new dofus.datacenter.(var8,var10,var9,-1,var11);
					if(var12.index != -1)
					{
						var5.inventory.updateItem(var12.index,var13);
					}
					else
					{
						var5.inventory.push(var13);
					}
					break;
				}
				if(var12.index != -1)
				{
					var5.inventory.removeItems(var12.index,1);
				}
				else
				{
					ank.utils.Logger.err("[onStorageMovement] cet objet n\'existe pas id=" + var8);
				}
				break;
			case "G":
				var var14 = Number(var3.substr(1));
				var5.Kama = var14;
		}
	}
	function onPlayerShopMovement(var2, var3)
	{
		var var4 = var3.charAt(0) == "+";
		var var5 = var3.substr(1).split("|");
		var var6 = Number(var5[0]);
		var var7 = Number(var5[1]);
		var var8 = Number(var5[2]);
		var var9 = var5[3];
		var var10 = Number(var5[4]);
		var var11 = this.api.datacenter.Temporary.Shop;
		var var12 = var11.inventory.findFirstItem("ID",var6);
		if(var4)
		{
			var var13 = new dofus.datacenter.(var6,var8,var7,-1,var9,var10);
			if(var12.index != -1)
			{
				var11.inventory.updateItem(var12.index,var13);
			}
			else
			{
				var11.inventory.push(var13);
			}
		}
		else if(var12.index != -1)
		{
			var11.inventory.removeItems(var12.index,1);
		}
		else
		{
			ank.utils.Logger.err("[onPlayerShopMovement] cet objet n\'existe pas id=" + var6);
		}
	}
	function onList(var2)
	{
		if((var var0 = this.api.datacenter.Basics.aks_exchange_echangeType) !== 0)
		{
			switch(null)
			{
				case 5:
				case 15:
				case 8:
					var var9 = var2.split(";");
					var var10 = new ank.utils.();
					for(var k in var9)
					{
						var var11 = var9[k];
						var var12 = var11.charAt(0);
						var var13 = var11.substr(1);
						switch(var12)
						{
							case "O":
								var var14 = this.api.kernel.CharactersManager.getItemObjectFromData(var13);
								var10.push(var14);
								break;
							case "G":
								this.onStorageKama(var13);
						}
					}
					this.api.datacenter.Temporary.Storage.inventory = var10;
					if(dofus.Constants.SAVING_THE_WORLD)
					{
						dofus.SaveTheWorld.getInstance().newItems(var2);
						dofus.SaveTheWorld.getInstance().nextAction();
					}
					break;
				case 4:
				case 6:
					var var15 = var2.split("|");
					var var16 = new ank.utils.();
					for(var k in var15)
					{
						var var17 = var15[k].split(";");
						var var18 = Number(var17[0]);
						var var19 = Number(var17[1]);
						var var20 = Number(var17[2]);
						var var21 = var17[3];
						var var22 = Number(var17[4]);
						var var23 = new dofus.datacenter.(var18,var20,var19,-1,var21,var22);
						var16.push(var23);
					}
					this.api.datacenter.Temporary.Shop.inventory = var16;
					break;
				default:
					if(§§enum_assign() !== 10)
					{
						break;
					}
					var var24 = var2.split("|");
					var var25 = new ank.utils.();
					if(var2.length != 0)
					{
						for(var k in var24)
						{
							var var26 = var24[k].split(";");
							var var27 = Number(var26[0]);
							var var28 = Number(var26[1]);
							var var29 = Number(var26[2]);
							var var30 = var26[3];
							var var31 = Number(var26[4]);
							var var32 = Number(var26[5]);
							var var33 = new dofus.datacenter.(var27,var29,var28,-1,var30,var31);
							var33.remainingHours = var32;
							var25.push(var33);
						}
					}
					this.api.datacenter.Temporary.Shop.inventory = var25;
					break;
			}
		}
		else
		{
			var var3 = var2.split("|");
			var var4 = new ank.utils.();
			for(var k in var3)
			{
				var var5 = var3[k].split(";");
				var var6 = Number(var5[0]);
				var var7 = var5[1];
				var var8 = new dofus.datacenter.(0,var6,undefined,undefined,var7);
				var8.priceMultiplicator = this.api.lang.getConfigText("BUY_PRICE_MULTIPLICATOR");
				var4.push(var8);
			}
			this.api.datacenter.Temporary.Shop.inventory = var4;
		}
	}
	function onSell(var2)
	{
		if(var2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("SELL_DONE"),"INFO_CHAT");
		}
		else
		{
			this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"),this.api.lang.getText("CANT_SELL"),"ERROR_BOX",{name:"Sell"});
		}
	}
	function onBuy(var2)
	{
		if(var2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("BUY_DONE"),"INFO_CHAT");
		}
		else
		{
			this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"),this.api.lang.getText("CANT_BUY"),"ERROR_BOX",{name:"Buy"});
		}
	}
	function onStorageKama(var2)
	{
		var var3 = Number(var2);
		this.api.datacenter.Temporary.Storage.Kama = var3;
	}
	function onBigStoreTypeItemsList(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = var3[1].split(";");
		var var6 = new ank.utils.();
		if(var3[1].length != 0)
		{
			var var7 = 0;
			while(var7 < var5.length)
			{
				var var8 = Number(var5[var7]);
				var var9 = new dofus.datacenter.(0,var8,1,-1,"",0);
				var6.push(var9);
				var7 = var7 + 1;
			}
		}
		this.api.datacenter.Temporary.Shop.inventory = var6;
		this.api.ui.getUIComponent("BigStoreBuy").setType(var4);
	}
	function onItemMiddlePriceInBigStore(var2)
	{
		var var3 = var2.split("|");
		this.api.ui.getUIComponent("BigStoreBuy").setMiddlePrice(Number(var3[0]),Number(var3[1]));
		this.api.ui.getUIComponent("BigStoreSell").setMiddlePrice(Number(var3[0]),Number(var3[1]));
	}
	function onBigStoreTypeItemsMovement(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = Number(var2.substr(1));
		var var5 = this.api.datacenter.Temporary.Shop;
		var var6 = var5.inventory.findFirstItem("unicID",var4);
		if(var3)
		{
			var var7 = new dofus.datacenter.(0,var4,0,-1,"",0);
			if(var6.index != -1)
			{
				var5.inventory.updateItem(var6.index,var7);
			}
			else
			{
				var5.inventory.push(var7);
			}
		}
		else if(var6.index != -1)
		{
			var5.inventory.removeItems(var6.index,1);
		}
		else
		{
			ank.utils.Logger.err("[onBigStoreTypeItemsMovement] cet objet n\'existe pas unicID=" + var4);
		}
	}
	function onBigStoreItemsList(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var3.shift();
		var var5 = new ank.utils.();
		for(var k in var3)
		{
			var var6 = var3[k].split(";");
			var var7 = Number(var6[0]);
			var var8 = var6[1];
			var var9 = Number(var6[2]);
			var var10 = Number(var6[3]);
			var var11 = Number(var6[4]);
			var var12 = new dofus.datacenter.(var7,var4,0,-1,var8,0);
			var var13 = {id:var7,item:var12,priceSet1:var9,priceSet2:var10,priceSet3:var11};
			var5.push(var13);
		}
		this.api.datacenter.Temporary.Shop.inventory2 = var5;
		this.api.ui.getUIComponent("BigStoreBuy").setItem(var4);
	}
	function onBigStoreItemsMovement(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("|");
		var var5 = Number(var4[0]);
		var var6 = Number(var4[1]);
		var var7 = var4[2];
		var var8 = Number(var4[3]);
		var var9 = Number(var4[4]);
		var var10 = Number(var4[5]);
		var var11 = this.api.datacenter.Temporary.Shop;
		var var12 = var11.inventory2.findFirstItem("id",var5);
		if(var3)
		{
			var var13 = new dofus.datacenter.(var5,var6,0,-1,var7,0);
			var var14 = {id:var5,item:var13,priceSet1:var8,priceSet2:var9,priceSet3:var10};
			if(var12.index != -1)
			{
				var11.inventory2.updateItem(var12.index,var14);
			}
			else
			{
				var11.inventory2.push(var14);
			}
			return undefined;
		}
		if(var12.index != -1)
		{
			var11.inventory2.removeItems(var12.index,1);
		}
		else
		{
			ank.utils.Logger.err("[onBigStoreItemsMovement] cet objet n\'existe pas id=" + var5);
		}
		this.api.ui.getUIComponent("BigStoreBuy").fullSoulItemsMovement();
	}
	function onSearch(var2)
	{
		this.api.ui.getUIComponent("BigStoreBuy").onSearchResult(var2 == "K");
	}
	function onCraftPublicMode(var2)
	{
		if(var2.length == 1)
		{
			var var3 = var2;
			this.api.datacenter.Player.craftPublicMode = var3 != "+"?false:true;
		}
		else
		{
			var var4 = var2.charAt(0);
			var var5 = var2.substr(1).split("|");
			var var6 = var5[0];
			var var7 = this.api.datacenter.Sprites.getItemAt(var6);
			if(var4 == "+" && var5[1].length > 0)
			{
				var var8 = var5[1].split(";");
				var7.multiCraftSkillsID = var8;
			}
			else
			{
				var7.multiCraftSkillsID = undefined;
			}
		}
	}
	function onMountPods(var2)
	{
		var var3 = var2.split(";");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		this.api.datacenter.Player.mount.podsMax = var5;
		this.api.datacenter.Player.mount.pods = var4;
	}
	function cancel(var2)
	{
		this.leave();
	}
	function yes(var2)
	{
		this.accept();
	}
	function no(var2)
	{
		this.leave();
	}
	function ignore(var2)
	{
		this.api.kernel.ChatManager.addToBlacklist(var2.params.player);
		this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[var2.params.player]),"INFO_CHAT");
		this.leave();
	}
}
