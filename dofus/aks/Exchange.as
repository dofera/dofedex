class dofus.aks.Exchange extends dofus.aks.Handler
{
	function Exchange(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function leave()
	{
		this.aks.send("EV",true);
	}
	function request(§\x1e\f\x18§, §\r\x1d§, cellNum)
	{
		this.aks.send("ER" + loc2 + "|" + (!(loc3 == undefined || _global.isNaN(loc3))?loc3:"") + (!(cellNum == undefined || _global.isNaN(cellNum))?"|" + cellNum:""),true);
	}
	function shop(loc2)
	{
		this.aks.send("Es" + loc2);
	}
	function accept()
	{
		this.aks.send("EA",false);
	}
	function ready()
	{
		this.aks.send("EK",true);
	}
	function movementItem(loc2, loc3, loc4, loc5)
	{
		this.aks.send("EMO" + (!loc2?"-":"+") + loc3 + "|" + loc4 + (loc5 != undefined?"|" + loc5:""),true);
	}
	function movementItems(loc2)
	{
		var loc3 = "";
		var loc8 = 0;
		while(loc8 < loc2.length)
		{
			var loc4 = loc2[loc8].Add;
			var loc5 = loc2[loc8].ID;
			var loc6 = loc2[loc8].Quantity;
			var loc7 = loc2[loc8].Price;
			loc3 = loc3 + ((!loc4?"-":"+") + loc5 + "|" + loc6 + (loc7 != undefined?"|" + loc7:""));
			loc8 = loc8 + 1;
		}
		this.aks.send("EMO" + loc3,true);
	}
	function movementPayItem(loc2, loc3, loc4, loc5, loc6)
	{
		this.aks.send("EP" + loc2 + "O" + (!loc3?"-":"+") + loc4 + "|" + loc5 + (loc6 != undefined?"|" + loc6:""),true);
	}
	function movementKama(loc2)
	{
		this.aks.send("EMG" + loc2,true);
	}
	function movementPayKama(loc2, loc3)
	{
		this.aks.send("EP" + loc2 + "G" + loc3,true);
	}
	function sell(loc2, loc3)
	{
		this.aks.send("ES" + loc2 + "|" + loc3,true);
	}
	function buy(loc2, loc3)
	{
		this.aks.send("EB" + loc2 + "|" + loc3,true);
	}
	function offlineExchange()
	{
		this.aks.send("EQ",true);
	}
	function askOfflineExchange()
	{
		this.aks.send("Eq",true);
	}
	function bigStoreType(loc2)
	{
		this.aks.send("EHT" + loc2);
	}
	function bigStoreItemList(loc2)
	{
		this.aks.send("EHl" + loc2);
	}
	function bigStoreBuy(loc2, loc3, loc4)
	{
		this.aks.send("EHB" + loc2 + "|" + loc3 + "|" + loc4,true);
	}
	function bigStoreSearch(loc2, loc3)
	{
		this.aks.send("EHS" + loc2 + "|" + loc3);
	}
	function setPublicMode(loc2)
	{
		this.aks.send("EW" + (!loc2?"-":"+"),false);
	}
	function getCrafterForJob(loc2)
	{
		this.aks.send("EJF" + loc2,true);
	}
	function putInShedFromInventory(loc2)
	{
		this.aks.send("Erp" + loc2,true);
	}
	function putInInventoryFromShed(loc2)
	{
		this.aks.send("Erg" + loc2,true);
	}
	function putInCertificateFromShed(loc2)
	{
		this.aks.send("Erc" + loc2,true);
	}
	function putInShedFromCertificate(loc2)
	{
		this.aks.send("ErC" + loc2,true);
	}
	function putInMountParkFromShed(loc2)
	{
		this.aks.send("Efp" + loc2,true);
	}
	function putInShedFromMountPark(loc2)
	{
		this.aks.send("Efg" + loc2,true);
	}
	function killMountInPark(loc2)
	{
		this.aks.send("Eff" + loc2,false);
	}
	function killMount(loc2)
	{
		this.aks.send("Erf" + loc2,false);
	}
	function getItemMiddlePriceInBigStore(loc2)
	{
		this.aks.send("EHP" + loc2,false);
	}
	function replayCraft()
	{
		this.aks.send("EL",false);
	}
	function repeatCraft(loc2)
	{
		this._nItemsToCraft = loc2;
		this.aks.send("EMR" + loc2,false);
		this.api.datacenter.Basics.isCraftLooping = true;
	}
	function stopRepeatCraft()
	{
		this.aks.send("EMr",false);
	}
	function onRequest(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = loc3.split("|");
			var loc5 = loc4[0];
			var loc6 = loc4[1];
			var loc7 = Number(loc4[2]);
			var loc8 = this.api.datacenter.Player.ID != loc5?loc5:loc6;
			if(loc7 == 12 || loc7 == 13)
			{
				var loc9 = new dofus.datacenter.(loc8);
			}
			else
			{
				loc9 = new dofus.datacenter.Exchange(loc8);
			}
			this.api.datacenter.Exchange = loc9;
			if(this.api.datacenter.Player.ID == loc5)
			{
				var loc10 = this.api.datacenter.Sprites.getItemAt(loc6);
				if((var loc0 = loc7) !== 1)
				{
					switch(null)
					{
						case 12:
							var loc11 = "WAIT_FOR_CRAFT_CLIENT";
							break;
						case 13:
							loc11 = "WAIT_FOR_CRAFT_ARTISAN";
					}
				}
				else
				{
					loc11 = "WAIT_FOR_EXCHANGE";
				}
				this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"),this.api.lang.getText(loc11,[loc10.name]),"INFO_CANCEL",{name:"Exchange",listener:this});
			}
			else
			{
				var loc12 = this.api.datacenter.Sprites.getItemAt(loc5);
				if(this.api.kernel.ChatManager.isBlacklisted(loc12.name))
				{
					this.leave();
					return undefined;
				}
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CHAT_A_WANT_EXCHANGE",[this.api.kernel.ChatManager.getLinkName(loc12.name)]),"INFO_CHAT");
				switch(loc7)
				{
					case 1:
						var loc13 = "A_WANT_EXCHANGE";
						break;
					case 12:
						loc13 = "A_WANT_CRAFT_CLIENT";
						break;
					case 13:
						loc13 = "A_WANT_CRAFT_ARTISAN";
				}
				this.api.electron.makeNotification(this.api.lang.getText(loc13,[loc12.name]));
				this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"),this.api.lang.getText(loc13,[loc12.name]),"CAUTION_YESNOIGNORE",{name:"Exchange",player:loc12.name,listener:this,params:{player:loc12.name}});
			}
		}
		else
		{
			var loc14 = loc3.charAt(0);
			switch(loc14)
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
					if(loc0 !== "I")
					{
					}
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_EXCHANGE"),"ERROR_CHAT");
			}
		}
	}
	function onAskOfflineExchange(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]) / 10;
		var loc6 = Number(loc3[2]);
		this.api.kernel.GameManager.askOfflineExchange(loc4,loc5,loc6);
	}
	function onReady(loc2)
	{
		var loc3 = loc2.charAt(0) == "1";
		var loc4 = Number(loc2.substr(1));
		var loc5 = loc4 != this.api.datacenter.Player.ID?1:0;
		this.api.datacenter.Exchange.readyStates.updateItem(loc5,loc3);
	}
	function onLeave(loc2, loc3)
	{
		delete this.api.datacenter.Basics.aks_exchange_echangeType;
		delete this.api.datacenter.Exchange;
		this.api.ui.unloadUIComponent("AskYesNoIgnoreExchange");
		this.api.ui.unloadUIComponent("AskCancelExchange");
		if(this.api.ui.getUIComponent("Exchange"))
		{
			if(loc3 == "a")
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
	function onCreate(loc2, loc3)
	{
		if(!loc2)
		{
			return undefined;
		}
		var loc4 = loc3.split("|");
		var loc5 = Number(loc4[0]);
		var loc6 = loc4[1];
		this.api.datacenter.Basics.aks_exchange_echangeType = loc5;
		var loc7 = this.api.datacenter.Temporary;
		if((var loc0 = loc5) !== 0)
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
							loc7.Storage = new dofus.datacenter.Storage();
							this.api.ui.loadUIComponent("Storage","Storage",{data:loc7.Storage});
							break loop3;
						case 8:
							loc7.Storage = new dofus.datacenter.TaxCollectorStorage();
							var loc12 = this.api.datacenter.Sprites.getItemAt(loc6);
							loc7.Storage.name = loc12.name;
							loc7.Storage.gfx = loc12.gfxID;
							this.api.ui.loadUIComponent("TaxCollectorStorage","TaxCollectorStorage",{data:loc7.Storage});
							break loop3;
						default:
							switch(null)
							{
								case 6:
									loc7.Shop = new dofus.datacenter.Shop();
									this.api.ui.loadUIComponent("PlayerShopModifier","PlayerShopModifier",{data:loc7.Shop});
									break loop3;
								case 10:
									loc7.Shop = new dofus.datacenter.();
									loc4 = loc6.split(";");
									var loc13 = loc4[0].split(",");
									loc7.Shop.quantity1 = Number(loc13[0]);
									loc7.Shop.quantity2 = Number(loc13[1]);
									loc7.Shop.quantity3 = Number(loc13[2]);
									loc7.Shop.types = loc4[1].split(",");
									loc7.Shop.tax = Number(loc4[2]);
									loc7.Shop.maxLevel = Number(loc4[3]);
									loc7.Shop.maxItemCount = Number(loc4[4]);
									loc7.Shop.npcID = Number(loc4[5]);
									loc7.Shop.maxSellTime = Number(loc4[6]);
									this.api.ui.loadUIComponent("BigStoreSell","BigStoreSell",{data:loc7.Shop});
									break loop3;
								case 11:
									loc7.Shop = new dofus.datacenter.();
									loc4 = loc6.split(";");
									var loc14 = loc4[0].split(",");
									loc7.Shop.quantity1 = Number(loc14[0]);
									loc7.Shop.quantity2 = Number(loc14[1]);
									loc7.Shop.quantity3 = Number(loc14[2]);
									loc7.Shop.types = loc4[1].split(",");
									loc7.Shop.tax = Number(loc4[2]);
									loc7.Shop.maxLevel = Number(loc4[3]);
									loc7.Shop.maxItemCount = Number(loc4[4]);
									loc7.Shop.npcID = Number(loc4[5]);
									loc7.Shop.maxSellTime = Number(loc4[6]);
									this.api.ui.loadUIComponent("BigStoreBuy","BigStoreBuy",{data:loc7.Shop});
									break loop3;
								default:
									switch(null)
									{
										case 13:
											break;
										case 14:
											var loc17 = new ank.utils.();
											var loc18 = loc6.split(";");
											var loc19 = 0;
											while(loc19 < loc18.length)
											{
												var loc20 = Number(loc18[loc19]);
												loc17.push({label:this.api.lang.getJobText(loc20).n,id:loc20});
												loc19 = loc19 + 1;
											}
											this.api.ui.loadUIComponent("CrafterList","CrafterList",{crafters:new ank.utils.(),jobs:loc17});
											break;
										case 15:
											this.api.ui.unloadUIComponent("Mount");
											loc7.Storage = new dofus.datacenter.Storage();
											this.api.ui.loadUIComponent("Storage","Storage",{isMount:true,data:loc7.Storage});
											break;
										case 16:
											var loc21 = new ank.utils.();
											var loc22 = new ank.utils.();
											loc4 = loc6.split("~");
											var loc23 = loc4[0].split(";");
											var loc24 = loc4[1].split(";");
											if(loc23 != undefined)
											{
												var loc25 = 0;
												while(loc25 < loc23.length)
												{
													if(loc23[loc25] != "")
													{
														loc21.push(this.api.network.Mount.createMount(loc23[loc25]));
													}
													loc25 = loc25 + 1;
												}
											}
											if(loc24 != undefined)
											{
												var loc26 = 0;
												while(loc26 < loc24.length)
												{
													if(loc24[loc26] != "")
													{
														loc22.push(this.api.network.Mount.createMount(loc24[loc26]));
													}
													loc26 = loc26 + 1;
												}
											}
											this.api.ui.loadUIComponent("MountStorage","MountStorage",{mounts:loc21,parkMounts:loc22});
									}
									break loop3;
								case 12:
									this.api.datacenter.Exchange.inventory = this.api.datacenter.Player.Inventory.clone();
									loc4 = loc6.split(";");
									var loc15 = Number(loc4[0]);
									var loc16 = Number(loc4[1]);
									this.api.ui.unloadUIComponent("AskYesNoIgnoreExchange");
									this.api.ui.unloadUIComponent("AskCancelExchange");
									this.api.ui.loadUIComponent("SecureCraft","SecureCraft",{skillId:loc16,maxItem:loc15});
							}
					}
				case 2:
				case 9:
				case 17:
					if(loc5 == 3)
					{
						this.api.datacenter.Exchange = new dofus.datacenter.Exchange();
					}
					else
					{
						this.api.datacenter.Exchange = new dofus.datacenter.Exchange(Number(loc6));
					}
					this.api.datacenter.Exchange.inventory = this.api.datacenter.Player.Inventory.clone();
					if(loc5 == 3)
					{
						loc4 = loc6.split(";");
						var loc10 = Number(loc4[0]);
						var loc11 = Number(loc4[1]);
						if(_global.API.lang.getSkillForgemagus(loc11) > 0)
						{
							this.api.ui.loadUIComponent("ForgemagusCraft","Craft",{skillId:loc11,maxItem:loc10});
						}
						else
						{
							this.api.ui.loadUIComponent("Craft","Craft",{skillId:loc11,maxItem:loc10});
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
		loc7.Shop = new dofus.datacenter.Shop();
		var loc8 = this.api.datacenter.Sprites.getItemAt(loc6);
		loc7.Shop.name = loc8.name;
		loc7.Shop.gfx = loc8.gfxID;
		var loc9 = new Array();
		loc9[1] = loc8.color1 != undefined?loc8.color1:-1;
		loc9[2] = loc8.color2 != undefined?loc8.color2:-1;
		loc9[3] = loc8.color3 != undefined?loc8.color3:-1;
		if(loc5 == 0)
		{
			this.api.ui.loadUIComponent("NpcShop","NpcShop",{data:loc7.Shop,colors:loc9});
		}
		else if(loc5 == 4)
		{
			this.api.ui.loadUIComponent("PlayerShop","PlayerShop",{data:loc7.Shop,colors:loc9});
		}
	}
	function onCrafterReference(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = Number(loc2.substr(1));
		this.api.kernel.showMessage(undefined,this.api.lang.getText(!loc3?"CRAFTER_REFERENCE_REMOVE":"CRAFTER_REFERENCE_ADD",[this.api.lang.getJobText(loc4).n]),"INFO_CHAT");
	}
	function onCrafterListChanged(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split(";");
		var loc5 = this.api.ui.getUIComponent("CrafterList").crafters;
		var loc6 = Number(loc4[0]);
		var loc7 = loc4[1];
		var loc8 = loc5.findFirstItem("id",loc7);
		if(loc3)
		{
			var loc9 = loc4[2];
			var loc10 = Number(loc4[3]);
			var loc11 = Number(loc4[4]);
			var loc12 = !!Number(loc4[5]);
			var loc13 = Number(loc4[6]);
			var loc14 = Number(loc4[7]);
			var loc15 = loc4[8].split(",");
			var loc16 = loc4[9];
			var loc17 = loc4[10].split(",");
			var loc18 = new dofus.datacenter.(loc7,loc9);
			loc18.job = new dofus.datacenter.Job(loc6,new ank.utils.(),new dofus.datacenter.(Number(loc17[0]),Number(loc17[1])));
			loc18.job.level = loc10;
			loc18.mapId = loc11;
			loc18.inWorkshop = loc12;
			loc18.breedId = loc13;
			loc18.sex = loc14;
			loc18.color1 = loc15[0];
			loc18.color2 = loc15[1];
			loc18.color3 = loc15[2];
			this.api.kernel.CharactersManager.setSpriteAccessories(loc18,loc16);
			if(loc8.index != -1)
			{
				loc5.updateItem(loc8.index,loc18);
			}
			else
			{
				loc5.push(loc18);
			}
		}
		else if(loc8.index != -1)
		{
			loc5.removeItems(loc8.index,1);
		}
	}
	function onMountStorage(loc2)
	{
		var loc3 = loc2.charAt(0);
		var loc4 = false;
		if((var loc0 = loc3) !== "~")
		{
			switch(null)
			{
				case "+":
					break;
				case "-":
					var loc5 = Number(loc2.substr(1));
					var loc6 = this.api.ui.getUIComponent("MountStorage").mounts;
					for(var a in loc6)
					{
						if(loc6[a].ID == loc5)
						{
							loc6.removeItems(Number(a),1);
						}
					}
					break;
				case "E":
			}
			break loop0;
		}
		loc4 = true;
		this.api.ui.getUIComponent("MountStorage").mounts.push(this.api.network.Mount.createMount(loc2.substr(1),loc4));
	}
	function onMountPark(loc2)
	{
		var loc3 = loc2.charAt(0);
		switch(loc3)
		{
			case "+":
				this.api.ui.getUIComponent("MountStorage").parkMounts.push(this.api.network.Mount.createMount(loc2.substr(1)));
				break;
			case "-":
				var loc4 = Number(loc2.substr(1));
				var loc5 = this.api.ui.getUIComponent("MountStorage").parkMounts;
				for(var a in loc5)
				{
					if(loc5[a].ID == loc4)
					{
						loc5.removeItems(Number(a),1);
					}
				}
				break;
			case "E":
		}
		break loop0;
	}
	function onCraft(loc2, loc3)
	{
		if(this.api.datacenter.Basics.aks_exchange_isForgemagus || !this.api.datacenter.Basics.isCraftLooping)
		{
			this.api.datacenter.Exchange.clearLocalGarbage();
		}
		var loc4 = this.api.datacenter.Basics.aks_exchange_echangeType;
		if(loc4 == 12 || loc4 == 13)
		{
			var loc5 = this.api.datacenter.Exchange;
			loc5.clearDistantGarbage();
			loc5.clearPayGarbage();
			loc5.clearPayIfSuccessGarbage();
			loc5.payKama = 0;
			loc5.payIfSuccessKama = 0;
			this.api.ui.getUIComponent("SecureCraft").updateInventory();
		}
		var loc6 = !this.api.datacenter.Basics.aks_exchange_isForgemagus;
		switch(loc3.substr(0,1))
		{
			case "I":
				if(!loc2)
				{
					this.api.kernel.showMessage(this.api.lang.getText("CRAFT"),this.api.lang.getText("NO_CRAFT_RESULT"),"ERROR_BOX",{name:"Impossible"});
				}
				break;
			case "F":
				if(!loc2 && loc6)
				{
					this.api.kernel.showMessage(this.api.lang.getText("CRAFT"),this.api.lang.getText("CRAFT_FAILED"),"ERROR_BOX",{name:"CraftFailed"});
				}
				this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CRAFT_KO);
				break;
			default:
				if(loc0 !== ";")
				{
					break;
				}
				if(loc2)
				{
					var loc7 = loc3.substr(1).split(";");
					if(loc7.length == 1)
					{
						var loc8 = new dofus.datacenter.(0,Number(loc7[0]),undefined,undefined,undefined);
						this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_SUCCESS_SELF",[loc8.name]),"INFO_CHAT");
						this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_CRAFT_KO);
						break;
					}
					var loc9 = loc7[1].substr(0,1);
					var loc10 = loc7[1].substr(1);
					var loc11 = Number(loc7[0]);
					var loc12 = loc7[2];
					var loc13 = new Array();
					loc13.push(loc11);
					loc13.push(loc12);
					switch(loc9)
					{
						case "T":
							this.api.kernel.showMessage(undefined,this.api.kernel.ChatManager.parseInlineItems(this.api.lang.getText("CRAFT_SUCCESS_TARGET",[loc10]),loc13),"INFO_CHAT");
							break;
						case "B":
							this.api.kernel.showMessage(undefined,this.api.kernel.ChatManager.parseInlineItems(this.api.lang.getText("CRAFT_SUCCESS_OTHER",[loc10]),loc13),"INFO_CHAT");
					}
					break;
				}
				break;
		}
		if(!loc2)
		{
			this.api.datacenter.Exchange.clearCoopGarbage();
		}
	}
	function onCraftLoop(loc2)
	{
		var loc3 = Number(loc2);
		this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_LOOP_PROCESS",[this._nItemsToCraft - loc3 + 1,this._nItemsToCraft + 1]),"INFO_CHAT");
	}
	function onCraftLoopEnd(loc2)
	{
		var loc3 = Number(loc2);
		this.api.datacenter.Basics.isCraftLooping = false;
		switch(loc3)
		{
			case 1:
				this.api.electron.makeNotification(this.api.lang.getText("CRAFT_LOOP_END_OK"));
				var loc4 = this.api.lang.getText("CRAFT_LOOP_END_OK");
				break;
			case 2:
				loc4 = this.api.lang.getText("CRAFT_LOOP_END_INTERRUPT");
				break;
			case 3:
				loc4 = this.api.lang.getText("CRAFT_LOOP_END_FAIL");
				break;
			default:
				if(loc0 !== 4)
				{
					break;
				}
				loc4 = this.api.lang.getText("CRAFT_LOOP_END_INVALID");
				break;
		}
		this.api.kernel.showMessage(undefined,loc4,"INFO_CHAT");
		this.api.kernel.showMessage(this.api.lang.getText("CRAFT"),loc4,"ERROR_BOX");
		this.api.ui.getUIComponent("Craft").onCraftLoopEnd();
		if(!this.api.datacenter.Basics.aks_exchange_isForgemagus)
		{
			this.api.datacenter.Exchange.clearLocalGarbage();
		}
	}
	function onLocalMovement(loc2, loc3)
	{
		this.modifyLocal(loc3,this.api.datacenter.Exchange.localGarbage,"localKama");
	}
	function onDistantMovement(loc2, loc3)
	{
		if((var loc0 = this.api.datacenter.Basics.aks_exchange_echangeType) !== 1)
		{
			loop0:
			switch(null)
			{
				default:
					switch(null)
					{
						case 13:
							break loop0;
						case 10:
							var loc4 = loc3.charAt(0) == "+";
							var loc5 = loc3.substr(1).split("|");
							var loc6 = Number(loc5[0]);
							var loc7 = Number(loc5[1]);
							var loc8 = Number(loc5[2]);
							var loc9 = loc5[3];
							var loc10 = Number(loc5[4]);
							var loc11 = Number(loc5[5]);
							var loc12 = this.api.datacenter.Temporary.Shop;
							var loc13 = loc12.inventory.findFirstItem("ID",loc6);
							if(loc4)
							{
								var loc14 = new dofus.datacenter.(loc6,loc8,loc7,-1,loc9,loc10);
								loc14.remainingHours = loc11;
								if(loc13.index != -1)
								{
									loc12.inventory.updateItem(loc13.index,loc14);
								}
								else
								{
									loc12.inventory.push(loc14);
								}
							}
							else if(loc13.index != -1)
							{
								loc12.inventory.removeItems(loc13.index,1);
							}
							else
							{
								ank.utils.Logger.err("[onDistantMovement] cet objet n\'existe pas id=" + loc6);
							}
							this.api.ui.getUIComponent("BigStoreSell").updateItemCount();
					}
				case 2:
				case 3:
				case 9:
				case 12:
			}
		}
		this.modifyDistant(loc3,this.api.datacenter.Exchange.distantGarbage,"distantKama");
	}
	function onCoopMovement(loc2, loc3)
	{
		this.api.datacenter.Exchange.clearCoopGarbage();
		switch(this.api.datacenter.Basics.aks_exchange_echangeType)
		{
			case 12:
				this.modifyDistant(loc3,this.api.datacenter.Exchange.coopGarbage,"distantKama",false);
				break;
			case 13:
				this.modifyDistant(loc3,this.api.datacenter.Exchange.coopGarbage,"distantKama",true);
		}
	}
	function onPayMovement(loc2, loc3)
	{
		var loc4 = Number(loc3.charAt(0));
		var loc5 = loc4 != 1?this.api.datacenter.Exchange.payIfSuccessGarbage:this.api.datacenter.Exchange.payGarbage;
		var loc6 = loc4 != 1?"payIfSuccessKama":"payKama";
		switch(this.api.datacenter.Basics.aks_exchange_echangeType)
		{
			case 12:
				this.modifyDistant(loc3.substr(2),loc5,loc6,false);
				break;
			case 13:
				this.modifyLocal(loc3.substr(2),loc5,loc6);
		}
	}
	function modifyLocal(loc2, loc3, loc4)
	{
		var loc5 = loc2.charAt(0);
		var loc6 = this.api.datacenter.Exchange;
		switch(loc5)
		{
			case "O":
				var loc7 = loc2.charAt(1) == "+";
				var loc8 = loc2.substr(2).split("|");
				var loc9 = Number(loc8[0]);
				var loc10 = Number(loc8[1]);
				var loc11 = this.api.datacenter.Player.Inventory.findFirstItem("ID",loc9);
				var loc12 = loc6.inventory.findFirstItem("ID",loc9);
				var loc13 = loc3.findFirstItem("ID",loc9);
				if(loc7)
				{
					var loc14 = loc12.item;
					var loc15 = new dofus.datacenter.(loc9,loc14.unicID,loc10,-2,loc14.compressedEffects);
					var loc16 = -1;
					var loc17 = loc11.item.Quantity - loc10;
					if(loc17 == 0)
					{
						loc16 = -3;
					}
					loc12.item.Quantity = loc17;
					loc12.item.position = loc16;
					loc6.inventory.updateItem(loc12.index,loc12.item);
					if(loc13.index != -1)
					{
						loc3.updateItem(loc13.index,loc15);
					}
					else
					{
						loc3.push(loc15);
					}
				}
				else if(loc13.index != -1)
				{
					loc12.item.position = -1;
					loc12.item.Quantity = loc11.item.Quantity;
					loc6.inventory.updateItem(loc12.index,loc12.item);
					loc3.removeItems(loc13.index,1);
				}
				break;
			case "G":
				var loc18 = Number(loc2.substr(1));
				loc6[loc4] = loc18;
		}
	}
	function modifyDistant(loc2, loc3, loc4, loc5)
	{
		var loc6 = loc2.charAt(0);
		var loc7 = this.api.datacenter.Exchange;
		switch(loc6)
		{
			case "O":
				var loc8 = loc2.charAt(1) == "+";
				var loc9 = loc2.substr(2).split("|");
				var loc10 = Number(loc9[0]);
				var loc11 = Number(loc9[1]);
				var loc12 = Number(loc9[2]);
				var loc13 = loc9[3];
				var loc14 = loc3.findFirstItem("ID",loc10);
				if(loc8)
				{
					var loc15 = new dofus.datacenter.(loc10,loc12,loc11,-1,loc13);
					var loc16 = loc5 == undefined?loc7.distantPlayerID == undefined:loc5;
					if(loc14.index != -1)
					{
						loc3.updateItem(loc14.index,loc15);
					}
					else
					{
						loc3.push(loc15);
					}
					if(loc16)
					{
						var loc17 = loc7.inventory.findFirstItem("ID",loc10);
						if(loc17.index != -1)
						{
							loc17.item.position = -1;
							loc17.item.Quantity = Number(loc17.item.Quantity) + Number(loc11);
							loc7.inventory.updateItem(loc17.index,loc17.item);
						}
						else
						{
							loc7.inventory.push(loc15);
							_global.API.ui.getUIComponent("Craft").updateForgemagusResult(loc15);
						}
					}
				}
				else if(loc14.index != -1)
				{
					loc3.removeItems(loc14.index,1);
				}
				break;
			case "G":
				var loc18 = Number(loc2.substr(1));
				loc7[loc4] = loc18;
		}
	}
	function onStorageMovement(loc2, loc3)
	{
		var loc4 = loc3.charAt(0);
		var loc5 = this.api.datacenter.Temporary.Storage;
		switch(loc4)
		{
			case "O":
				var loc6 = loc3.charAt(1) == "+";
				var loc7 = loc3.substr(2).split("|");
				var loc8 = Number(loc7[0]);
				var loc9 = Number(loc7[1]);
				var loc10 = Number(loc7[2]);
				var loc11 = loc7[3];
				var loc12 = loc5.inventory.findFirstItem("ID",loc8);
				if(loc6)
				{
					var loc13 = new dofus.datacenter.(loc8,loc10,loc9,-1,loc11);
					if(loc12.index != -1)
					{
						loc5.inventory.updateItem(loc12.index,loc13);
					}
					else
					{
						loc5.inventory.push(loc13);
					}
					break;
				}
				if(loc12.index != -1)
				{
					loc5.inventory.removeItems(loc12.index,1);
				}
				else
				{
					ank.utils.Logger.err("[onStorageMovement] cet objet n\'existe pas id=" + loc8);
				}
				break;
			case "G":
				var loc14 = Number(loc3.substr(1));
				loc5.Kama = loc14;
		}
	}
	function onPlayerShopMovement(loc2, loc3)
	{
		var loc4 = loc3.charAt(0) == "+";
		var loc5 = loc3.substr(1).split("|");
		var loc6 = Number(loc5[0]);
		var loc7 = Number(loc5[1]);
		var loc8 = Number(loc5[2]);
		var loc9 = loc5[3];
		var loc10 = Number(loc5[4]);
		var loc11 = this.api.datacenter.Temporary.Shop;
		var loc12 = loc11.inventory.findFirstItem("ID",loc6);
		if(loc4)
		{
			var loc13 = new dofus.datacenter.(loc6,loc8,loc7,-1,loc9,loc10);
			if(loc12.index != -1)
			{
				loc11.inventory.updateItem(loc12.index,loc13);
			}
			else
			{
				loc11.inventory.push(loc13);
			}
		}
		else if(loc12.index != -1)
		{
			loc11.inventory.removeItems(loc12.index,1);
		}
		else
		{
			ank.utils.Logger.err("[onPlayerShopMovement] cet objet n\'existe pas id=" + loc6);
		}
	}
	function onList(loc2)
	{
		if((var loc0 = this.api.datacenter.Basics.aks_exchange_echangeType) !== 0)
		{
			switch(null)
			{
				case 5:
				case 15:
				case 8:
					var loc9 = loc2.split(";");
					var loc10 = new ank.utils.();
					for(var k in loc9)
					{
						var loc11 = loc9[k];
						var loc12 = loc11.charAt(0);
						var loc13 = loc11.substr(1);
						switch(loc12)
						{
							case "O":
								var loc14 = this.api.kernel.CharactersManager.getItemObjectFromData(loc13);
								loc10.push(loc14);
								break;
							case "G":
								this.onStorageKama(loc13);
						}
					}
					this.api.datacenter.Temporary.Storage.inventory = loc10;
					if(dofus.Constants.SAVING_THE_WORLD)
					{
						dofus.SaveTheWorld.getInstance().newItems(loc2);
						dofus.SaveTheWorld.getInstance().nextAction();
					}
					break;
				case 4:
				case 6:
					var loc15 = loc2.split("|");
					var loc16 = new ank.utils.();
					for(var k in loc15)
					{
						var loc17 = loc15[k].split(";");
						var loc18 = Number(loc17[0]);
						var loc19 = Number(loc17[1]);
						var loc20 = Number(loc17[2]);
						var loc21 = loc17[3];
						var loc22 = Number(loc17[4]);
						var loc23 = new dofus.datacenter.(loc18,loc20,loc19,-1,loc21,loc22);
						loc16.push(loc23);
					}
					this.api.datacenter.Temporary.Shop.inventory = loc16;
					break;
				default:
					if(§§enum_assign() !== 10)
					{
						break;
					}
					var loc24 = loc2.split("|");
					var loc25 = new ank.utils.();
					if(loc2.length != 0)
					{
						for(var k in loc24)
						{
							var loc26 = loc24[k].split(";");
							var loc27 = Number(loc26[0]);
							var loc28 = Number(loc26[1]);
							var loc29 = Number(loc26[2]);
							var loc30 = loc26[3];
							var loc31 = Number(loc26[4]);
							var loc32 = Number(loc26[5]);
							var loc33 = new dofus.datacenter.(loc27,loc29,loc28,-1,loc30,loc31);
							loc33.remainingHours = loc32;
							loc25.push(loc33);
						}
					}
					this.api.datacenter.Temporary.Shop.inventory = loc25;
					break;
			}
		}
		else
		{
			var loc3 = loc2.split("|");
			var loc4 = new ank.utils.();
			for(var k in loc3)
			{
				var loc5 = loc3[k].split(";");
				var loc6 = Number(loc5[0]);
				var loc7 = loc5[1];
				var loc8 = new dofus.datacenter.(0,loc6,undefined,undefined,loc7);
				loc8.priceMultiplicator = this.api.lang.getConfigText("BUY_PRICE_MULTIPLICATOR");
				loc4.push(loc8);
			}
			this.api.datacenter.Temporary.Shop.inventory = loc4;
		}
	}
	function onSell(loc2)
	{
		if(loc2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("SELL_DONE"),"INFO_CHAT");
		}
		else
		{
			this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"),this.api.lang.getText("CANT_SELL"),"ERROR_BOX",{name:"Sell"});
		}
	}
	function onBuy(loc2)
	{
		if(loc2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("BUY_DONE"),"INFO_CHAT");
		}
		else
		{
			this.api.kernel.showMessage(this.api.lang.getText("EXCHANGE"),this.api.lang.getText("CANT_BUY"),"ERROR_BOX",{name:"Buy"});
		}
	}
	function onStorageKama(loc2)
	{
		var loc3 = Number(loc2);
		this.api.datacenter.Temporary.Storage.Kama = loc3;
	}
	function onBigStoreTypeItemsList(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1].split(";");
		var loc6 = new ank.utils.();
		if(loc3[1].length != 0)
		{
			var loc7 = 0;
			while(loc7 < loc5.length)
			{
				var loc8 = Number(loc5[loc7]);
				var loc9 = new dofus.datacenter.(0,loc8,1,-1,"",0);
				loc6.push(loc9);
				loc7 = loc7 + 1;
			}
		}
		this.api.datacenter.Temporary.Shop.inventory = loc6;
		this.api.ui.getUIComponent("BigStoreBuy").setType(loc4);
	}
	function onItemMiddlePriceInBigStore(loc2)
	{
		var loc3 = loc2.split("|");
		this.api.ui.getUIComponent("BigStoreBuy").setMiddlePrice(Number(loc3[0]),Number(loc3[1]));
		this.api.ui.getUIComponent("BigStoreSell").setMiddlePrice(Number(loc3[0]),Number(loc3[1]));
	}
	function onBigStoreTypeItemsMovement(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = Number(loc2.substr(1));
		var loc5 = this.api.datacenter.Temporary.Shop;
		var loc6 = loc5.inventory.findFirstItem("unicID",loc4);
		if(loc3)
		{
			var loc7 = new dofus.datacenter.(0,loc4,0,-1,"",0);
			if(loc6.index != -1)
			{
				loc5.inventory.updateItem(loc6.index,loc7);
			}
			else
			{
				loc5.inventory.push(loc7);
			}
		}
		else if(loc6.index != -1)
		{
			loc5.inventory.removeItems(loc6.index,1);
		}
		else
		{
			ank.utils.Logger.err("[onBigStoreTypeItemsMovement] cet objet n\'existe pas unicID=" + loc4);
		}
	}
	function onBigStoreItemsList(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		loc3.shift();
		var loc5 = new ank.utils.();
		for(var k in loc3)
		{
			var loc6 = loc3[k].split(";");
			var loc7 = Number(loc6[0]);
			var loc8 = loc6[1];
			var loc9 = Number(loc6[2]);
			var loc10 = Number(loc6[3]);
			var loc11 = Number(loc6[4]);
			var loc12 = new dofus.datacenter.(loc7,loc4,0,-1,loc8,0);
			var loc13 = {id:loc7,item:loc12,priceSet1:loc9,priceSet2:loc10,priceSet3:loc11};
			loc5.push(loc13);
		}
		this.api.datacenter.Temporary.Shop.inventory2 = loc5;
		this.api.ui.getUIComponent("BigStoreBuy").setItem(loc4);
	}
	function onBigStoreItemsMovement(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("|");
		var loc5 = Number(loc4[0]);
		var loc6 = Number(loc4[1]);
		var loc7 = loc4[2];
		var loc8 = Number(loc4[3]);
		var loc9 = Number(loc4[4]);
		var loc10 = Number(loc4[5]);
		var loc11 = this.api.datacenter.Temporary.Shop;
		var loc12 = loc11.inventory2.findFirstItem("id",loc5);
		if(loc3)
		{
			var loc13 = new dofus.datacenter.(loc5,loc6,0,-1,loc7,0);
			var loc14 = {id:loc5,item:loc13,priceSet1:loc8,priceSet2:loc9,priceSet3:loc10};
			if(loc12.index != -1)
			{
				loc11.inventory2.updateItem(loc12.index,loc14);
			}
			else
			{
				loc11.inventory2.push(loc14);
			}
			return undefined;
		}
		if(loc12.index != -1)
		{
			loc11.inventory2.removeItems(loc12.index,1);
		}
		else
		{
			ank.utils.Logger.err("[onBigStoreItemsMovement] cet objet n\'existe pas id=" + loc5);
		}
		this.api.ui.getUIComponent("BigStoreBuy").fullSoulItemsMovement();
	}
	function onSearch(loc2)
	{
		this.api.ui.getUIComponent("BigStoreBuy").onSearchResult(loc2 == "K");
	}
	function onCraftPublicMode(loc2)
	{
		if(loc2.length == 1)
		{
			var loc3 = loc2;
			this.api.datacenter.Player.craftPublicMode = loc3 != "+"?false:true;
		}
		else
		{
			var loc4 = loc2.charAt(0);
			var loc5 = loc2.substr(1).split("|");
			var loc6 = loc5[0];
			var loc7 = this.api.datacenter.Sprites.getItemAt(loc6);
			if(loc4 == "+" && loc5[1].length > 0)
			{
				var loc8 = loc5[1].split(";");
				loc7.multiCraftSkillsID = loc8;
			}
			else
			{
				loc7.multiCraftSkillsID = undefined;
			}
		}
	}
	function onMountPods(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		this.api.datacenter.Player.mount.podsMax = loc5;
		this.api.datacenter.Player.mount.pods = loc4;
	}
	function cancel(loc2)
	{
		this.leave();
	}
	function yes(loc2)
	{
		this.accept();
	}
	function no(loc2)
	{
		this.leave();
	}
	function ignore(loc2)
	{
		this.api.kernel.ChatManager.addToBlacklist(loc2.params.player);
		this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[loc2.params.player]),"INFO_CHAT");
		this.leave();
	}
}
