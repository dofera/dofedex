class dofus.aks.Infos extends dofus.aks.Handler
{
	function Infos(var2, var3)
	{
		super.initialize(var3,var4);
	}
	function getMaps()
	{
		this.aks.send("IM");
	}
	function sendScreenInfo()
	{
		var var2 = Stage.scaleMode;
		Stage.scaleMode = "noScale";
		switch(Stage.displayState)
		{
			case "normal":
				var var3 = "0";
				break;
			case "fullscreen":
				var3 = "1";
				break;
			default:
				var3 = "2";
		}
		this.aks.send("Ir" + Stage.width + ";" + Stage.height + ";" + var3);
		Stage.scaleMode = var2;
	}
	function onInfoMaps(var2)
	{
		var var3 = var2.split("|");
	}
	function onInfoCompass(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = this.api.ui.getUIComponent("MapExplorer");
		if(var6 != undefined)
		{
			var6.select({coordinates:{x:var4,y:var5}});
		}
		if(_global.isNaN(var4) && _global.isNaN(var5))
		{
			this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1],false);
		}
		else
		{
			this.api.kernel.GameManager.updateCompass(var4,var5,true);
		}
	}
	function onInfoCoordinatespHighlight(var2)
	{
		var var3 = new Array();
		if(String(var2).length != 0)
		{
			var var4 = var2.split("|");
			var var5 = 0;
			while(var5 < var4.length)
			{
				var var6 = var4[var5].split(";");
				var var7 = Number(var6[0]);
				var var8 = Number(var6[1]);
				var var9 = Number(var6[2]);
				var var10 = Number(var6[3]);
				var var11 = Number(var6[4]);
				var var12 = String(var6[5]);
				var3.push({x:var7,y:var8,mapID:var9,type:var10,playerID:var11,playerName:var12});
				var5 = var5 + 1;
			}
		}
		var var13 = this.api.ui.getUIComponent("MapExplorer");
		if(var13 != undefined)
		{
			var13.multipleSelect(var3);
		}
		this.api.datacenter.Basics.aks_infos_highlightCoords = String(var2).length != 0?var3:undefined;
	}
	function onMessage(var2)
	{
		var var3 = new Array();
		var var4 = var2.charAt(0);
		var var5 = var2.substr(1).split("|");
		var var7 = 0;
		while(var7 < var5.length)
		{
			var var8 = var5[var7].split(";");
			var var9 = var8[0];
			var var10 = Number(var9);
			var var11 = var8[1].split("~");
			if((var var0 = var4) !== "0")
			{
				switch(null)
				{
					case "1":
						var var6 = "ERROR_CHAT";
						if(!_global.isNaN(var10))
						{
							var var23 = var10.toString(10);
							switch(var10)
							{
								case 16:
									this.api.electron.makeNotification(var22);
									break;
								default:
									switch(null)
									{
										case 49:
											break;
										case 7:
											var11 = [this.api.lang.getSpellText(var11[0]).n];
											break;
										case 89:
											if(this.api.config.isStreaming)
											{
												var23 = "89_MINICLIP";
											}
											if(dofus.Kernel.FAST_SWITCHING_SERVER_REQUEST != undefined)
											{
												this.addToQueue({object:this.api.kernel,method:this.api.kernel.onFastServerSwitchSuccess});
												break;
											}
									}
									break;
								case 6:
								case 46:
									var11 = [this.api.lang.getJobText(var11[0]).n];
							}
							var var22 = this.api.lang.getText("ERROR_" + var23,var11);
						}
						else
						{
							var22 = this.api.lang.getText(var9,var11);
						}
						if(var22 != undefined)
						{
							var3.push(var22);
						}
						break;
					case "2":
						var6 = "PVP_CHAT";
						if(!_global.isNaN(var10))
						{
							switch(var10)
							{
								case 41:
									var11 = [this.api.lang.getMapSubAreaText(var11[0]).n,this.api.lang.getMapAreaText(var11[1]).n];
									break;
								default:
									switch(null)
									{
										case 89:
										case 90:
									}
									break;
								case 86:
								case 87:
								case 88:
									var11[0] = this.api.lang.getMapAreaText(var11[0]).n;
							}
							var var24 = this.api.lang.getText("PVP_" + var10,var11);
						}
						else
						{
							var24 = this.api.lang.getText(var9,var11);
						}
						if(var24 != undefined)
						{
							var3.push(var24);
							break;
						}
				}
			}
			else
			{
				var6 = "INFO_CHAT";
				if(!_global.isNaN(var10))
				{
					var var13 = true;
					if((var0 = var10) !== 21)
					{
						loop8:
						switch(null)
						{
							case 22:
								break;
							case 17:
								var11 = [var11[0],this.api.lang.getJobText(var11[1]).n];
								break;
							case 2:
								var11 = [this.api.lang.getJobText(Number(var11[0])).n];
								break;
							case 3:
								var11 = [this.api.lang.getSpellText(Number(var11[0])).n];
								break;
							default:
								switch(null)
								{
									case 55:
									case 56:
									case 65:
									case 73:
										var var15 = new dofus.datacenter.(0,var11[1]);
										var11[2] = var15.name;
										break loop8;
									default:
										switch(null)
										{
											case 82:
											case 83:
												this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("INFOS_" + var10,var11),"ERROR_BOX");
												break loop8;
											case 84:
												break loop8;
											case 120:
												if(dofus.Constants.SAVING_THE_WORLD)
												{
													dofus.SaveTheWorld.getInstance().safeWasBusy();
													dofus.SaveTheWorld.getInstance().nextAction();
												}
												break loop8;
											default:
												switch(null)
												{
													case 123:
														var var12 = this.api.kernel.ChatManager.parseInlineItems(this.api.lang.getText("INFOS_" + var10),var11);
														var13 = false;
														break;
													case 150:
														var6 = "MESSAGE_CHAT";
														var var16 = new dofus.datacenter.(0,var11[0]);
														var var17 = new Array();
														var var18 = 3;
														while(var18 < var11.length)
														{
															var17.push(var11[var18]);
															var18 = var18 + 1;
														}
														var11 = [var16.name,var11[1],this.api.lang.getText("OBJECT_CHAT_" + var11[2],var17)];
														break;
													case 151:
														var6 = "WHISP_CHAT";
														var var19 = new dofus.datacenter.(0,var11[0]);
														var var20 = new Array();
														var var21 = 2;
														while(var21 < var11.length)
														{
															var20.push(var11[var21]);
															var21 = var21 + 1;
														}
														var11 = [var19.name,this.api.lang.getText("OBJECT_CHAT_" + var11[1],var20)];
												}
										}
								}
							case 54:
								var11[0] = this.api.lang.getQuestText(var11[0]);
						}
						if(var13)
						{
							var12 = this.api.lang.getText("INFOS_" + var10,var11);
						}
					}
					var var14 = new dofus.datacenter.(0,var11[1]);
					var11 = [var11[0],var14.name];
					if(var13)
					{
						var12 = this.api.lang.getText("INFOS_" + var10,var11);
					}
				}
				else
				{
					var12 = this.api.lang.getText(var9,var11);
				}
				if(var12 != undefined)
				{
					var3.push(var12);
				}
			}
			var7 = var7 + 1;
		}
		var var25 = var3.join(" ");
		if(var25 != "")
		{
			this.api.kernel.showMessage(undefined,var25,var6);
		}
	}
	function onQuantity(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = var3[1];
		this.api.gfx.addSpritePoints(var4,var5,11552256);
	}
	function onObject(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = var3[1].charAt(0) == "+";
		var var6 = var3[1].substr(1);
		var var7 = var6 != ""?new dofus.datacenter.(0,var6,1):undefined;
		if(!this.api.datacenter.Basics.isCraftLooping)
		{
			this.api.gfx.addSpriteOverHeadItem(var4,"craft",dofus.graphics.battlefield.CraftResultOverHead,[var5,var7],2000);
		}
	}
	function onLifeRestoreTimerStart(var2)
	{
		var var3 = Number(var2);
		_global.clearInterval(this.api.datacenter.Basics.aks_infos_lifeRestoreInterval);
		if(!_global.isNaN(var3))
		{
			var var4 = this.api.datacenter.Player;
			this.api.datacenter.Basics.aks_infos_lifeRestoreInterval = _global.setInterval(var4,"updateLP",var3,1);
		}
	}
	function onLifeRestoreTimerFinish(var2)
	{
		var var3 = Number(var2);
		_global.clearInterval(this.api.datacenter.Basics.aks_infos_lifeRestoreInterval);
		if(var3 > 0)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("YOU_RESTORE_LIFE",[var3]),"INFO_CHAT");
		}
	}
}
