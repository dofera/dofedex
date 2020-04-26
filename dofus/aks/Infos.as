class dofus.aks.Infos extends dofus.aks.Handler
{
	function Infos(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function getMaps()
	{
		this.aks.send("IM");
	}
	function sendScreenInfo()
	{
		var loc2 = Stage.scaleMode;
		Stage.scaleMode = "noScale";
		switch(Stage.displayState)
		{
			case "normal":
				var loc3 = "0";
				break;
			case "fullscreen":
				loc3 = "1";
				break;
			default:
				loc3 = "2";
		}
		this.aks.send("Ir" + Stage.width + ";" + Stage.height + ";" + loc3);
		Stage.scaleMode = loc2;
	}
	function onInfoMaps(loc2)
	{
		var loc3 = loc2.split("|");
	}
	function onInfoCompass(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = this.api.ui.getUIComponent("MapExplorer");
		if(loc6 != undefined)
		{
			loc6.select({coordinates:{x:loc4,y:loc5}});
		}
		if(_global.isNaN(loc4) && _global.isNaN(loc5))
		{
			this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1],false);
		}
		else
		{
			this.api.kernel.GameManager.updateCompass(loc4,loc5,true);
		}
	}
	function onInfoCoordinatespHighlight(loc2)
	{
		var loc3 = new Array();
		if(String(loc2).length != 0)
		{
			var loc4 = loc2.split("|");
			var loc5 = 0;
			while(loc5 < loc4.length)
			{
				var loc6 = loc4[loc5].split(";");
				var loc7 = Number(loc6[0]);
				var loc8 = Number(loc6[1]);
				var loc9 = Number(loc6[2]);
				var loc10 = Number(loc6[3]);
				var loc11 = Number(loc6[4]);
				var loc12 = String(loc6[5]);
				loc3.push({x:loc7,y:loc8,mapID:loc9,type:loc10,playerID:loc11,playerName:loc12});
				loc5 = loc5 + 1;
			}
		}
		var loc13 = this.api.ui.getUIComponent("MapExplorer");
		if(loc13 != undefined)
		{
			loc13.multipleSelect(loc3);
		}
		this.api.datacenter.Basics.aks_infos_highlightCoords = String(loc2).length != 0?loc3:undefined;
	}
	function onMessage(loc2)
	{
		var loc3 = new Array();
		var loc4 = loc2.charAt(0);
		var loc5 = loc2.substr(1).split("|");
		var loc7 = 0;
		while(loc7 < loc5.length)
		{
			var loc8 = loc5[loc7].split(";");
			var loc9 = loc8[0];
			var loc10 = Number(loc9);
			var loc11 = loc8[1].split("~");
			switch(loc4)
			{
				case "0":
					var loc6 = "INFO_CHAT";
					if(!_global.isNaN(loc10))
					{
						var loc13 = true;
						loop4:
						switch(loc10)
						{
							case 21:
							case 22:
								var loc14 = new dofus.datacenter.(0,loc11[1]);
								loc11 = [loc11[0],loc14.name];
								break;
							default:
								switch(null)
								{
									case 17:
										loc11 = [loc11[0],this.api.lang.getJobText(loc11[1]).n];
										break loop4;
									case 2:
										loc11 = [this.api.lang.getJobText(Number(loc11[0])).n];
										break loop4;
									case 3:
										loc11 = [this.api.lang.getSpellText(Number(loc11[0])).n];
										break loop4;
									default:
										switch(null)
										{
											case 55:
											case 56:
											case 65:
											case 73:
												var loc15 = new dofus.datacenter.(0,loc11[1]);
												loc11[2] = loc15.name;
												break loop4;
											default:
												switch(null)
												{
													case 82:
													case 83:
														this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("INFOS_" + loc10,loc11),"ERROR_BOX");
														break loop4;
													case 84:
														break loop4;
													case 120:
														if(dofus.Constants.SAVING_THE_WORLD)
														{
															dofus.SaveTheWorld.getInstance().safeWasBusy();
															dofus.SaveTheWorld.getInstance().nextAction();
														}
														break loop4;
													case 123:
														var loc12 = this.api.kernel.ChatManager.parseInlineItems(this.api.lang.getText("INFOS_" + loc10),loc11);
														loc13 = false;
														break loop4;
													case 150:
														loc6 = "MESSAGE_CHAT";
														var loc16 = new dofus.datacenter.(0,loc11[0]);
														var loc17 = new Array();
														var loc18 = 3;
														while(loc18 < loc11.length)
														{
															loc17.push(loc11[loc18]);
															loc18 = loc18 + 1;
														}
														loc11 = [loc16.name,loc11[1],this.api.lang.getText("OBJECT_CHAT_" + loc11[2],loc17)];
														break loop4;
													default:
														if(loc0 !== 151)
														{
															break loop4;
														}
														loc6 = "WHISP_CHAT";
														var loc19 = new dofus.datacenter.(0,loc11[0]);
														var loc20 = new Array();
														var loc21 = 2;
														while(loc21 < loc11.length)
														{
															loc20.push(loc11[loc21]);
															loc21 = loc21 + 1;
														}
														loc11 = [loc19.name,this.api.lang.getText("OBJECT_CHAT_" + loc11[1],loc20)];
														break loop4;
												}
										}
									case 54:
										loc11[0] = this.api.lang.getQuestText(loc11[0]);
								}
						}
						if(loc13)
						{
							loc12 = this.api.lang.getText("INFOS_" + loc10,loc11);
						}
					}
					else
					{
						loc12 = this.api.lang.getText(loc9,loc11);
					}
					if(loc12 != undefined)
					{
						loc3.push(loc12);
					}
					break;
				case "1":
					loc6 = "ERROR_CHAT";
					if(!_global.isNaN(loc10))
					{
						var loc23 = loc10.toString(10);
						switch(loc10)
						{
							case 16:
								this.api.electron.makeNotification(loc22);
								break;
							default:
								switch(null)
								{
									case 49:
										break;
									case 7:
										loc11 = [this.api.lang.getSpellText(loc11[0]).n];
										break;
									case 89:
										if(this.api.config.isStreaming)
										{
											loc23 = "89_MINICLIP";
											break;
										}
								}
								break;
							case 6:
							case 46:
								loc11 = [this.api.lang.getJobText(loc11[0]).n];
						}
						var loc22 = this.api.lang.getText("ERROR_" + loc23,loc11);
					}
					else
					{
						loc22 = this.api.lang.getText(loc9,loc11);
					}
					if(loc22 != undefined)
					{
						loc3.push(loc22);
					}
					break;
				default:
					if(loc0 !== "2")
					{
						break;
					}
					loc6 = "PVP_CHAT";
					if(!_global.isNaN(loc10))
					{
						switch(loc10)
						{
							case 41:
								loc11 = [this.api.lang.getMapSubAreaText(loc11[0]).n,this.api.lang.getMapAreaText(loc11[1]).n];
								break;
							default:
								switch(null)
								{
									case 87:
									case 88:
									case 89:
									case 90:
								}
								break;
							case 86:
								loc11[0] = this.api.lang.getMapAreaText(loc11[0]).n;
						}
						var loc24 = this.api.lang.getText("PVP_" + loc10,loc11);
					}
					else
					{
						loc24 = this.api.lang.getText(loc9,loc11);
					}
					if(loc24 != undefined)
					{
						loc3.push(loc24);
						break;
					}
					break;
			}
			loc7 = loc7 + 1;
		}
		var loc25 = loc3.join(" ");
		if(loc25 != "")
		{
			this.api.kernel.showMessage(undefined,loc25,loc6);
		}
	}
	function onQuantity(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = loc3[1];
		this.api.gfx.addSpritePoints(loc4,loc5,11552256);
	}
	function onObject(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = loc3[1].charAt(0) == "+";
		var loc6 = loc3[1].substr(1);
		var loc7 = loc6 != ""?new dofus.datacenter.(0,loc6,1):undefined;
		if(!this.api.datacenter.Basics.isCraftLooping)
		{
			this.api.gfx.addSpriteOverHeadItem(loc4,"craft",dofus.graphics.battlefield.CraftResultOverHead,[loc5,loc7],2000);
		}
	}
	function onLifeRestoreTimerStart(loc2)
	{
		var loc3 = Number(loc2);
		_global.clearInterval(this.api.datacenter.Basics.aks_infos_lifeRestoreInterval);
		if(!_global.isNaN(loc3))
		{
			var loc4 = this.api.datacenter.Player;
			this.api.datacenter.Basics.aks_infos_lifeRestoreInterval = _global.setInterval(loc4,"updateLP",loc3,1);
		}
	}
	function onLifeRestoreTimerFinish(loc2)
	{
		var loc3 = Number(loc2);
		_global.clearInterval(this.api.datacenter.Basics.aks_infos_lifeRestoreInterval);
		if(loc3 > 0)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("YOU_RESTORE_LIFE",[loc3]),"INFO_CHAT");
		}
	}
}
