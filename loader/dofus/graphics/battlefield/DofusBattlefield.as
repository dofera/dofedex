class dofus.graphics.battlefield.DofusBattlefield extends ank.battlefield.Battlefield
{
	function DofusBattlefield()
	{
		super();
	}
	function __get__api()
	{
		return this._oAPI;
	}
	function initialize(var2, var3, var4, var5, var6)
	{
		super.initialize(var3,var4,var5,var6);
		mx.events.EventDispatcher.initialize(this);
		this._oAPI = var7;
	}
	function addSpritePoints(sID, §\x1e\x0e\x02§, §\b\x07§)
	{
		if(this.api.kernel.OptionsManager.getOption("PointsOverHead"))
		{
			super.addSpritePoints(sID,var4,var5);
		}
	}
	function onInitError()
	{
		_root.onCriticalError(this.api.lang.getText("CRITICAL_ERROR_LOADING_BATTLEFIELD"));
	}
	function onMapLoaded()
	{
		var var2 = this.api.datacenter.Map;
		this.api.ui.unloadUIComponent("CenterText");
		this.api.ui.unloadUIComponent("CenterTextMap");
		this.api.ui.unloadUIComponent("FightsInfos");
		this.setInteraction(ank.battlefield.Constants.INTERACTION_NONE);
		this.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
		this.setInteraction(ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE_OVER_OUT);
		if(this.api.datacenter.Game.isFight)
		{
			this.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_NONE);
		}
		else
		{
			this.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT);
		}
		this.api.datacenter.Game.setInteractionType("move");
		this.api.network.Game.getExtraInformations();
		this.api.ui.unloadLastUIAutoHideComponent();
		this.api.ui.removePopupMenu();
		this.api.ui.getUIComponent("MapInfos").update();
		var var3 = var2.subarea;
		if(var3 != this.api.datacenter.Basics.gfx_lastSubarea)
		{
			var var4 = this.api.datacenter.Subareas.getItemAt(var3);
			var var5 = new String();
			var var6 = new String();
			var var7 = this.api.lang.getMapAreaText(var2.area).n;
			if(var4 == undefined)
			{
				var6 = String(this.api.lang.getMapSubAreaText(var3).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(var3).n:String(this.api.lang.getMapSubAreaText(var3).n).substr(2);
				if(var7 != var6)
				{
					var5 = var7 + "\n(" + var6 + ")";
				}
				else
				{
					var5 = var7;
				}
			}
			else
			{
				var6 = var4.name;
				var5 = var4.name + " (" + var4.alignment.name + ")";
				if(var7 != var6)
				{
					var5 = var7 + "\n(" + var6 + ")\n" + var4.alignment.name;
				}
				else
				{
					var5 = var7 + "\n" + var4.alignment.name;
				}
			}
			if(!this.api.kernel.TutorialManager.isTutorialMode)
			{
				this.api.ui.loadUIComponent("CenterText","CenterText",{text:var5,background:false,timer:2000},{bForceLoad:true});
			}
			this.api.datacenter.Basics.gfx_lastSubarea = var3;
		}
		if(this.api.datacenter.Player.isAtHome(var2.id))
		{
			var var8 = new Array();
			var var9 = this.api.lang.getHousesIndoorSkillsText();
			var var10 = 0;
			while(var10 < var9.length)
			{
				var var11 = new dofus.datacenter.(var9[var10]);
				var8.push(var11);
				var10 = var10 + 1;
			}
			var var12 = this.api.lang.getHousesMapText(var2.id);
			if(var12 != undefined)
			{
				var var13 = this.api.datacenter.Houses.getItemAt(var12);
				this.api.ui.loadUIComponent("HouseIndoor","HouseIndoor",{skills:var8,house:var13},{bStayIfPresent:true});
			}
			this.api.ui.getUIComponent("MapInfos")._visible = false;
		}
		else
		{
			this.api.ui.unloadUIComponent("HouseIndoor");
		}
		if(this.api.kernel.OptionsManager.getOption("Grid") == true)
		{
			this.api.gfx.drawGrid();
		}
		else
		{
			this.api.gfx.removeGrid();
		}
		this.api.ui.getUIComponent("Banner").setCircleXtraParams({currentCoords:[var2.x,var2.y]});
		if(Number(var2.ambianceID) > 0)
		{
			this.api.sounds.playEnvironment(var2.ambianceID);
		}
		if(Number(var2.musicID) > 0)
		{
			this.api.sounds.playMusic(var2.musicID,true);
		}
		if(!var2.bOutdoor)
		{
			this.api.kernel.NightManager.noEffects();
		}
		var var14 = (Array)this.api.lang.getMapText(var2.id).p;
		var var15 = 0;
		while(var14.length > var15)
		{
			var var16 = var14[var15][0];
			var var17 = var14[var15][1];
			var var18 = var14[var15][2];
			if(!dofus.utils.criterions.CriterionManager.fillingCriterions(var18))
			{
				var var19 = this.api.gfx.mapHandler.getCellData(var17);
				var var20 = 0;
				while(var20 < var16.length)
				{
					if(var19.layerObject1Num == var16[var20])
					{
						var19.mcObject1._visible = false;
					}
					if(var19.layerObject2Num == var16[var20])
					{
						var19.mcObject2._visible = false;
					}
					var20 = var20 + 1;
				}
			}
			var15 = var15 + 1;
		}
		this.dispatchEvent({type:"mapLoaded"});
	}
	function onCellRelease(var2)
	{
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"CELL_RELEASE",params:[var2.num]});
			return false;
		}
		switch(this.api.datacenter.Game.interactionType)
		{
			case 1:
				var var3 = this.api.datacenter.Player.data;
				var var4 = false;
				var var5 = this.api.datacenter.Player.canMoveInAllDirections;
				var var6 = this.api.datacenter.Player.data.isInMove;
				if(this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler,var2.num,true,this.api.datacenter.Game.isFight,false,var5,var6))
				{
					if(this.api.datacenter.Game.isFight)
					{
						var4 = true;
					}
					else
					{
						var4 = this.api.datacenter.Basics.interactionsManager_path[this.api.datacenter.Basics.interactionsManager_path.length - 1].num == var2.num;
					}
				}
				if(!this.api.datacenter.Game.isFight && !var4)
				{
					if(this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler,var2.num,true,this.api.datacenter.Game.isFight,true,var5,var6))
					{
						var4 = true;
					}
				}
				if(var4)
				{
					if(getTimer() - this.api.datacenter.Basics.gfx_lastActionTime < dofus.Constants.CLICK_MIN_DELAY && (var3 == undefined || !var3.isAdminSonicSpeed))
					{
						ank.utils.Logger.err("T trop rapide du clic");
						return null;
					}
					this.api.datacenter.Basics.gfx_lastActionTime = getTimer();
					if(this.api.datacenter.Basics.interactionsManager_path.length != 0)
					{
						var var7 = ank.battlefield.utils.Compressor.compressPath(this.api.datacenter.Basics.interactionsManager_path);
						if(var7 != undefined)
						{
							if(this.api.datacenter.Game.isFight && this.api.datacenter.Game.isRunning)
							{
								var var8 = var3.sequencer;
								var8.addAction(false,var3.GameActionsManager,var3.GameActionsManager.transmittingMove,[1,[var7]]);
								var8.execute();
							}
							else
							{
								var3.GameActionsManager.transmittingMove(1,[var7]);
							}
							delete this.api.datacenter.Basics.interactionsManager_path;
						}
					}
					return true;
				}
				return false;
				break;
			case 2:
				if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
				{
					var var9 = this.api.datacenter.Player.data;
					var var10 = var9.sequencer;
					var10.addAction(false,var9.GameActionsManager,var9.GameActionsManager.transmittingOther,[300,[this.api.datacenter.Player.currentUseObject.ID,var2.num]]);
					var10.execute();
					this.api.datacenter.Player.currentUseObject = null;
				}
				else if(this.api.datacenter.Basics.spellManager_errorMsg != undefined)
				{
					this.api.kernel.showMessage(undefined,this.api.datacenter.Basics.spellManager_errorMsg,"ERROR_CHAT");
					delete this.api.datacenter.Basics.spellManager_errorMsg;
				}
				this.api.ui.removeCursor();
				this.api.kernel.GameManager.lastSpellLaunch = getTimer();
				this.api.datacenter.Game.setInteractionType("move");
				break;
			default:
				switch(null)
				{
					case 3:
						if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
						{
							var var11 = this.api.datacenter.Player.data;
							var var12 = var11.sequencer;
							var12.addAction(false,var11.GameActionsManager,var11.GameActionsManager.transmittingOther,[303,[var2.num]]);
							var12.execute();
							this.api.datacenter.Player.currentUseObject = null;
						}
						this.api.ui.removeCursor();
						this.api.kernel.GameManager.lastSpellLaunch = getTimer();
						this.api.datacenter.Game.setInteractionType("move");
						break;
					case 4:
						var var13 = this.mapHandler.getCellData(var2.num).spriteOnID;
						if(var13 != undefined)
						{
							break;
						}
						this.api.network.Game.setPlayerPosition(var2.num);
						break;
					case 5:
						if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
						{
							this.api.network.Items.use(this.api.datacenter.Player.currentUseObject.ID,this.mapHandler.getCellData(var2.num).spriteOnID,var2.num);
						}
						this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
						this.api.gfx.clearPointer();
						this.unSelect(true);
						this.api.datacenter.Player.reset();
						this.api.ui.removeCursor();
						this.api.datacenter.Game.setInteractionType("move");
						break;
					case 6:
						if(this.api.datacenter.Game.isFight)
						{
							if(var2.num != undefined)
							{
								this.api.network.Game.setFlag(var2.num);
							}
							this.api.gfx.clearPointer();
							this.api.gfx.unSelectAllButOne("startPosition");
							this.api.ui.removeCursor();
							if(this.api.datacenter.Game.isRunning && this.api.datacenter.Game.currentPlayerID == this.api.datacenter.Player.ID)
							{
								this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
								this.api.datacenter.Game.setInteractionType("move");
								break;
							}
							this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
							this.api.datacenter.Game.setInteractionType("place");
							break;
						}
				}
		}
	}
	function onCellRollOver(var2)
	{
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"CELL_OVER",params:[var2.num]});
			return undefined;
		}
		if(this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isCurrentPlayer && this.api.datacenter.Game.interactionType != 6))
		{
			return undefined;
		}
		switch(this.api.datacenter.Game.interactionType)
		{
			case 1:
				var var3 = this.api.datacenter.Player;
				var var4 = var3.data;
				var var5 = this.mapHandler.getCellData(var2.num).spriteOnID;
				var var6 = this.api.datacenter.Sprites.getItemAt(var5);
				if(var6 != undefined)
				{
					this.showSpriteInfosIfWeNeed(var6);
				}
				if(ank.battlefield.utils.Pathfinding.checkRange(this.mapHandler,var4.cellNum,var2.num,false,0,var4.MP,0))
				{
					this.api.datacenter.Player.InteractionsManager.setState(this.api.datacenter.Game.isFight);
					this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler,var2.num,false,this.api.datacenter.Game.isFight);
				}
				else
				{
					delete this.api.datacenter.Basics.interactionsManager_path;
				}
				break;
			default:
				switch(null)
				{
					case 3:
						break;
					case 5:
					case 6:
						this.api.datacenter.Basics.gfx_canLaunch = true;
						this.api.ui.setCursorForbidden(false);
						this.drawPointer(var2.num);
				}
				break;
			case 2:
				var var7 = this.api.datacenter.Player;
				var var8 = var7.data;
				var var9 = var8.cellNum;
				var var10 = var7.currentUseObject;
				var var11 = var7.SpellsManager;
				var var12 = !var10.canBoostRange?0:var8.CharacteristicsManager.getModeratorValue(19) + var7.RangeModerator;
				this.api.datacenter.Basics.gfx_canLaunch = var11.checkCanLaunchSpellOnCell(this.mapHandler,var10,this.mapHandler.getCellData(var2.num),var12);
				if(this.api.datacenter.Basics.gfx_canLaunch)
				{
					this.api.ui.setCursorForbidden(false);
					this.drawPointer(var2.num);
				}
				else
				{
					this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
				}
		}
	}
	function onCellRollOut(var2)
	{
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"CELL_OUT",params:[var2.num]});
			return undefined;
		}
		if(this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isCurrentPlayer && this.api.datacenter.Game.interactionType != 6))
		{
			return undefined;
		}
		if((var var0 = this.api.datacenter.Game.interactionType) !== 1)
		{
			switch(null)
			{
				case 2:
				case 3:
					this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
					this.hidePointer();
					this.api.datacenter.Basics.gfx_canLaunch = false;
					this.hideSpriteInfos();
					break;
				case 5:
				case 6:
					this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
					this.api.datacenter.Basics.gfx_canLaunch = false;
					this.hidePointer();
			}
		}
		else
		{
			this.hideSpriteInfos();
			this.unSelect(true);
		}
	}
	function onSpriteRelease(var2)
	{
		var var3 = var2.data;
		var var4 = var3.id;
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"SPRITE_RELEASE",params:[var3.id]});
			return undefined;
		}
		if(var3.hasParent)
		{
			this.onSpriteRelease(var3.linkedParent.mc);
			return undefined;
		}
		if((var var0 = this.api.datacenter.Game.interactionType) !== 5)
		{
			if(var3 instanceof dofus.datacenter.Mutant && !var3.showIsPlayer)
			{
				if(!this.api.datacenter.Game.isRunning)
				{
					if(this.api.datacenter.Player.isMutant)
					{
						return undefined;
					}
				}
				var var5 = this.mapHandler.getCellData(var3.cellNum).mc;
				this.onCellRelease(var5);
			}
			else if(var3 instanceof dofus.datacenter.Character || var3 instanceof dofus.datacenter.Mutant && var3.showIsPlayer)
			{
				if(this.api.datacenter.Game.isFight && (this.api.datacenter.Game.isRunning && !(this.api.datacenter.Player.isAuthorized && this.api.datacenter.Game.isSpectator)))
				{
					var var6 = this.mapHandler.getCellData(var3.cellNum).mc;
					this.onCellRelease(var6);
					return undefined;
				}
				if(Key.isDown(Key.CONTROL))
				{
					var var7 = this.mapHandler.getCellData(var3.cellNum).allSpritesOn;
					this.api.kernel.GameManager.showCellPlayersPopupMenu(var7);
				}
				else
				{
					this.api.kernel.GameManager.showPlayerPopupMenu(var3,undefined);
				}
			}
			else if(var3 instanceof dofus.datacenter.NonPlayableCharacter)
			{
				if(this.api.datacenter.Player.cantSpeakNPC)
				{
					return undefined;
				}
				var var8 = var3.actions;
				if(var8 != undefined && var8.length != 0)
				{
					var var9 = true;
					var var10 = this.api.ui.createPopupMenu();
					var var11 = var8.length;
					while(true)
					{
						var11;
						if(var11-- > 0)
						{
							var var12 = var8[var11];
							var var13 = var12.actionId;
							var var14 = var12.action;
							var var15 = var14.method;
							var var16 = var14.object;
							var var17 = var14.params;
							if(Key.isDown(Key.SHIFT) && var13 == 3)
							{
								var9 = false;
								var15.apply(var16,var17);
								break;
							}
							var10.addItem(var12.name,var16,var15,var17);
							continue;
						}
						break;
					}
					if(var9)
					{
						var10.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(var3 instanceof dofus.datacenter.Team)
			{
				var var18 = this.api.datacenter.Player.data.alignment.index;
				var var19 = var3.alignment.index;
				var var20 = var3.enemyTeam.alignment.index;
				var var21 = var3.challenge.fightType;
				var var22 = false;
				if((var0 = var21) !== 0)
				{
					switch(null)
					{
						case 1:
						case 2:
							switch(var3.type)
							{
								case 0:
								case 1:
									if(var18 == var19)
									{
										var22 = !this.api.datacenter.Player.isMutant;
										break;
									}
									var22 = this.api.lang.getAlignmentCanJoin(var18,var19) && (this.api.lang.getAlignmentCanAttack(var18,var20) && !this.api.datacenter.Player.isMutant);
									break;
							}
							break;
						case 3:
							if((var0 = var3.type) !== 0)
							{
								if(var0 === 1)
								{
									var22 = false;
								}
							}
							else
							{
								var22 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
							}
							break;
						case 4:
							switch(var3.type)
							{
								case 0:
									var22 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
									break;
								case 1:
									var22 = false;
							}
							break;
						case 5:
							switch(var3.type)
							{
								case 0:
									var22 = !this.api.datacenter.Player.isMutant && !this.api.datacenter.Player.cantInteractWithTaxCollector;
									break;
								case 3:
									var22 = false;
							}
							break;
						default:
							if(var0 !== 6)
							{
								break;
							}
							switch(var3.type)
							{
								case 0:
									var22 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
									break;
								case 2:
									var22 = this.api.datacenter.Player.isMutant && !this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant == true;
							}
							break;
					}
				}
				else
				{
					if((var0 = var3.type) !== 0)
					{
						if(var0 !== 2)
						{
						}
						addr700:
					}
					var22 = this.api.datacenter.Player.canChallenge && (!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant);
					§§goto(addr700);
				}
				if(var22)
				{
					var var23 = true;
					var var24 = this.api.ui.createPopupMenu();
					var var25 = this.api.lang.getMapMaxTeam(this.api.datacenter.Map.id);
					var var26 = this.api.lang.getMapMaxChallenge(this.api.datacenter.Map.id);
					if(var3.challenge.count >= var26)
					{
						var24.addItem(this.api.lang.getText("CHALENGE_FULL"));
					}
					else if(var3.count >= var25)
					{
						var24.addItem(this.api.lang.getText("TEAM_FULL"));
					}
					else if(Key.isDown(Key.SHIFT))
					{
						var23 = false;
						this.api.network.GameActions.joinChallenge(var3.challenge.id,var3.id);
						this.api.ui.hideTooltip();
					}
					else
					{
						var24.addItem(this.api.lang.getText("JOIN_SMALL"),this.api.network.GameActions,this.api.network.GameActions.joinChallenge,[var3.challenge.id,var3.id]);
					}
					if(var23)
					{
						var24.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(var3 instanceof dofus.datacenter.ParkMount)
			{
				if(var3.ownerName == this.api.datacenter.Player.Name || this.api.datacenter.Map.mountPark.guildName == this.api.datacenter.Player.guildInfos.name && this.api.datacenter.Player.guildInfos.playerRights.canManageOtherMount)
				{
					if(Key.isDown(Key.SHIFT))
					{
						this.api.network.Mount.parkMountData(var3.id);
					}
					else
					{
						var var27 = this.api.ui.createPopupMenu();
						var27.addStaticItem(this.api.lang.getText("MOUNT_OF",[var3.ownerName]));
						var27.addItem(this.api.lang.getText("VIEW_MOUNT_DETAILS"),this.api.network.Mount,this.api.network.Mount.parkMountData,[var3.id]);
						var27.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(var3 instanceof dofus.datacenter.Creature)
			{
				var var28 = this.mapHandler.getCellData(var3.cellNum).mc;
				this.onCellRelease(var28);
			}
			else if(var3 instanceof dofus.datacenter.MonsterGroup || var3 instanceof dofus.datacenter.Monster)
			{
				if(var3 instanceof dofus.datacenter.Monster && this.api.kernel.GameManager.isInMyTeam(var3))
				{
					this.api.kernel.GameManager.showMonsterPopupMenu(var3);
				}
				if(!this.api.datacenter.Player.isMutant || (this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant || this.api.datacenter.Player.canAttackMonstersAnywhereWhenMutant))
				{
					var var29 = this.mapHandler.getCellData(var3.cellNum);
					var var30 = var29.mc;
					if(!Key.isDown(Key.SHIFT) && (!this.api.datacenter.Game.isFight && var3 instanceof dofus.datacenter.MonsterGroup))
					{
						var var31 = var29.isTrigger;
						if(!var31 && this.api.kernel.OptionsManager.getOption("ViewAllMonsterInGroup") == true)
						{
							var var32 = this.api.ui.createPopupMenu();
							var32.addItem(this.api.lang.getText("ATTACK"),this,this.onCellRelease,[var30]);
							var32.show();
						}
						else
						{
							this.onCellRelease(var30);
						}
					}
					else
					{
						this.onCellRelease(var30);
					}
				}
			}
			else if(var3 instanceof dofus.datacenter.OfflineCharacter)
			{
				if(!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant)
				{
					if(!this.api.datacenter.Player.canExchange)
					{
						return undefined;
					}
					if(Key.isDown(Key.SHIFT))
					{
						this.api.kernel.GameManager.startExchange(4,var3.id,var3.cellNum);
					}
					else
					{
						var var34 = var3.name;
						if(this.api.datacenter.Player.isAuthorized)
						{
							var var33 = this.api.kernel.AdminManager.getAdminPopupMenu(var34);
						}
						else
						{
							var33 = this.api.ui.createPopupMenu();
						}
						var33.addStaticItem(this.api.lang.getText("SHOP") + " " + this.api.lang.getText("OF") + " " + var3.name);
						var33.addItem(this.api.lang.getText("BUY"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[4,var3.id,var3.cellNum]);
						var var35 = 2;
						if(this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id))
						{
							var33.addItem(this.api.lang.getText("KICKOFF"),this.api.network.Basics,this.api.network.Basics.kick,[var3.cellNum]);
							var35 = var35 + 1;
						}
						if(this.api.datacenter.Player.isAuthorized)
						{
							var var36 = 0;
							while(var36 < var35)
							{
								var33.items.unshift(var33.items.pop());
								var36 = var36 + 1;
							}
						}
						var33.show(_root._xmouse,_root._ymouse,true);
					}
				}
			}
			else if(var3 instanceof dofus.datacenter.TaxCollector)
			{
				if(!this.api.datacenter.Player.isMutant)
				{
					if(this.api.datacenter.Player.cantInteractWithTaxCollector)
					{
						return undefined;
					}
					if(this.api.datacenter.Game.isFight)
					{
						var var37 = this.mapHandler.getCellData(var3.cellNum).mc;
						this.onCellRelease(var37);
					}
					else if(Key.isDown(Key.SHIFT))
					{
						this.api.network.Dialog.create(var4);
					}
					else
					{
						var var38 = this.api.datacenter.Player.guildInfos.playerRights;
						var var39 = var3.guildName == this.api.datacenter.Player.guildInfos.name;
						var var40 = var39 && var38.canHireTaxCollector;
						var var41 = this.api.ui.createPopupMenu();
						var41.addItem(this.api.lang.getText("SPEAK"),this.api.network.Dialog,this.api.network.Dialog.create,[var4]);
						var41.addItem(this.api.lang.getText("COLLECT_TAX"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[8,var4],var39);
						var41.addItem(this.api.lang.getText("ATTACK"),this.api.network.GameActions,this.api.network.GameActions.attackTaxCollector,[[var4]],!var39);
						var41.addItem(this.api.lang.getText("REMOVE"),this.api.kernel.GameManager,this.api.kernel.GameManager.askRemoveTaxCollector,[[var4]],var40);
						var41.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(var3 instanceof dofus.datacenter.PrismSprite)
			{
				if(!this.api.datacenter.Player.isMutant)
				{
					if(this.api.datacenter.Game.isFight)
					{
						var var42 = this.mapHandler.getCellData(var3.cellNum).mc;
						this.onCellRelease(var42);
					}
					else
					{
						var var43 = this.api.datacenter.Player.alignment.index == 0;
						var var44 = this.api.datacenter.Player.alignment.compareTo(var3.alignment) == 0;
						if(Key.isDown(Key.SHIFT) && var44)
						{
							this.api.network.GameActions.usePrism([var4]);
						}
						else
						{
							var var45 = this.api.ui.createPopupMenu();
							var45.addItem(this.api.lang.getText("USE_WORD"),this.api.network.GameActions,this.api.network.GameActions.usePrism,[[var4]],var44);
							var45.addItem(this.api.lang.getText("ATTACK"),this.api.network.GameActions,this.api.network.GameActions.attackPrism,[[var4]],!var44 && !var43);
							var45.show(_root._xmouse,_root._ymouse);
						}
					}
				}
			}
		}
		else
		{
			if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
			{
				this.api.network.Items.use(this.api.datacenter.Player.currentUseObject.ID,var3.id,var3.cellNum);
			}
			this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
			this.api.gfx.clearPointer();
			this.unSelect(true);
			this.api.datacenter.Player.reset();
			this.api.ui.removeCursor();
			this.api.datacenter.Game.setInteractionType("move");
		}
	}
	function onSpriteRollOver(var2)
	{
		if(this.api.ui.getUIComponent("Zoom") != undefined)
		{
			return undefined;
		}
		var var5 = var2.data;
		var var6 = dofus.Constants.OVERHEAD_TEXT_OTHER;
		if(var5.isClear)
		{
			return undefined;
		}
		if(var5.hasParent)
		{
			this.onSpriteRollOver(var5.linkedParent.mc);
			return undefined;
		}
		if(this.api.datacenter.Game.isRunning || this.api.datacenter.Game.interactionType == 5)
		{
			var var8 = this.mapHandler.getCellData(var5.cellNum).mc;
			if(var5.isVisible)
			{
				this.onCellRollOver(var8);
			}
		}
		var var9 = var5.name;
		if(var5 instanceof dofus.datacenter.Mutant && var5.showIsPlayer)
		{
			if(this.api.datacenter.Game.isRunning)
			{
				var9 = var5.playerName + " (" + var5.LP + ")";
				this.showSpriteInfosIfWeNeed(var5);
			}
			else
			{
				var9 = var5.playerName + " [" + var5.monsterName + " (" + var5.Level + ")]";
			}
		}
		else if(var5 instanceof dofus.datacenter.Mutant || (var5 instanceof dofus.datacenter.Creature || var5 instanceof dofus.datacenter.Monster))
		{
			var6 = dofus.Constants.NPC_ALIGNMENT_COLOR[var5.alignment.index];
			if(this.api.datacenter.Game.isRunning)
			{
				var9 = var9 + (" (" + var5.LP + ")");
				this.showSpriteInfosIfWeNeed(var5);
			}
			else
			{
				var9 = var9 + (" (" + var5.Level + ")");
			}
		}
		else if(var5 instanceof dofus.datacenter.Character)
		{
			var6 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
			if(this.api.datacenter.Game.isRunning)
			{
				var9 = var9 + (" (" + var5.LP + ")");
				if(var5.isVisible)
				{
					var var10 = var5.EffectsManager.getEffects();
					if(var10.length != 0)
					{
						this.addSpriteOverHeadItem(var5.id,"effects",dofus.graphics.battlefield.EffectsOverHead,[var10]);
					}
				}
				this.showSpriteInfosIfWeNeed(var5);
			}
			else if(this.api.datacenter.Game.isFight)
			{
				var9 = var9 + (" (" + var5.Level + ")");
			}
			if(!var5.isVisible)
			{
				return undefined;
			}
			var var3 = dofus.Constants.DEMON_ANGEL_FILE;
			if(var5.alignment.fallenAngelDemon)
			{
				var3 = dofus.Constants.FALLEN_DEMON_ANGEL_FILE;
			}
			var var11 = !var5.haveFakeAlignement?var5.alignment.index:var5.fakeAlignment.index;
			if(var5.rank.value > 0)
			{
				if(var11 == 1)
				{
					var var4 = var5.rank.value;
				}
				else if(var11 == 2)
				{
					var4 = 10 + var5.rank.value;
				}
				else if(var11 == 3)
				{
					var4 = 20 + var5.rank.value;
				}
			}
			var var7 = var5.title;
			if(var5.guildName != undefined && var5.guildName.length != 0)
			{
				var9 = "";
				this.addSpriteOverHeadItem(var5.id,"text",dofus.graphics.battlefield.GuildOverHead,[var5.guildName,var5.name,var5.emblem,var3,var4,var5.pvpGain,var7],undefined,true);
			}
		}
		else if(var5 instanceof dofus.datacenter.TaxCollector)
		{
			if(this.api.datacenter.Game.isRunning)
			{
				var9 = var9 + (" (" + var5.LP + ")");
				this.showSpriteInfosIfWeNeed(var5);
			}
			else if(this.api.datacenter.Game.isFight)
			{
				var9 = var9 + (" (" + var5.Level + ")");
			}
			else
			{
				var9 = "";
				this.addSpriteOverHeadItem(var5.id,"text",dofus.graphics.battlefield.GuildOverHead,[var5.guildName,var5.name,var5.emblem]);
			}
		}
		else if(var5 instanceof dofus.datacenter.PrismSprite)
		{
			var3 = dofus.Constants.DEMON_ANGEL_FILE;
			if(var5.alignment.value > 0)
			{
				if(var5.alignment.index == 1)
				{
					var4 = var5.alignment.value;
				}
				else if(var5.alignment.index == 2)
				{
					var4 = 10 + var5.alignment.value;
				}
				else if(var5.alignment.index == 3)
				{
					var4 = 20 + var5.alignment.value;
				}
			}
			var6 = dofus.Constants.NPC_ALIGNMENT_COLOR[var5.alignment.index];
			this.addSpriteOverHeadItem(var5.id,"text",dofus.graphics.battlefield.TextOverHead,[var9,var3,var6,var4]);
		}
		else if(var5 instanceof dofus.datacenter.ParkMount)
		{
			var6 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
			var9 = this.api.lang.getText("MOUNT_PARK_OVERHEAD",[var5.modelName,var5.level,var5.ownerName]);
			this.addSpriteOverHeadItem(var5.id,"text",dofus.graphics.battlefield.TextOverHead,[var9,var3,var6,var4]);
		}
		else if(var5 instanceof dofus.datacenter.OfflineCharacter)
		{
			var6 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
			var9 = "";
			this.addSpriteOverHeadItem(var5.id,"text",dofus.graphics.battlefield.OfflineOverHead,[var5]);
		}
		else if(var5 instanceof dofus.datacenter.NonPlayableCharacter)
		{
			var var12 = this.api.datacenter.Map;
			var var13 = this.api.datacenter.Subareas.getItemAt(var12.subarea);
			if(var13 != undefined)
			{
				var6 = dofus.Constants.NPC_ALIGNMENT_COLOR[var13.alignment.index];
			}
		}
		else if(var5 instanceof dofus.datacenter.MonsterGroup || var5 instanceof dofus.datacenter.Team)
		{
			if(var5.alignment.index != -1)
			{
				var6 = dofus.Constants.NPC_ALIGNMENT_COLOR[var5.alignment.index];
			}
			var var14 = var5.challenge.fightType;
			if(var5.isVisible && (var5 instanceof dofus.datacenter.MonsterGroup || var5.type == 1 && (var14 == 2 || (var14 == 3 || var14 == 4))))
			{
				if(var9 != "")
				{
					var var15 = dofus.Constants.OVERHEAD_TEXT_TITLE;
					this.addSpriteOverHeadItem(var5.id,"text",dofus.graphics.battlefield.TextWithTitleOverHead,[var9,var3,var6,var4,this.api.lang.getText("LEVEL") + " " + var5.totalLevel,var15,var5.bonusValue]);
				}
				this.selectSprite(var5.id,true);
				return undefined;
			}
		}
		if(var5.isVisible)
		{
			if(var9 != "")
			{
				this.addSpriteOverHeadItem(var5.id,"text",dofus.graphics.battlefield.TextOverHead,[var9,var3,var6,var4,var5.pvpGain,var7]);
			}
			this.selectSprite(var5.id,true);
		}
	}
	function onSpriteRollOut(var2)
	{
		var var3 = var2.data;
		if(this.api.gfx.spriteHandler.isShowingMonstersTooltip && var3 instanceof dofus.datacenter.MonsterGroup)
		{
			return undefined;
		}
		if(var3.hasParent)
		{
			this.onSpriteRollOut(var3.linkedParent.mc);
			return undefined;
		}
		if(this.api.datacenter.Game.isRunning || this.api.datacenter.Game.interactionType == 5)
		{
			this.hideSpriteInfos();
			var var4 = this.mapHandler.getCellData(var3.cellNum).mc;
			this.onCellRollOut(var4);
		}
		this.removeSpriteOverHeadLayer(var3.id,"text");
		this.removeSpriteOverHeadLayer(var3.id,"effects");
		this.selectSprite(var3.id,false);
	}
	function onObjectRelease(var2)
	{
		this.api.ui.hideTooltip();
		var var3 = var2.cellData;
		var var4 = var3.mc;
		var var5 = var3.layerObject2Num;
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"OBJECT_RELEASE",params:[var3.num,var5]});
			return undefined;
		}
		var var6 = var3.layerObjectExternalData;
		if(var6 != undefined)
		{
			if(var6.durability != undefined)
			{
				if(this.api.datacenter.Map.mountPark.isMine(this.api))
				{
					var var7 = this.api.ui.createPopupMenu();
					var7.addStaticItem(var6.name);
					var7.addItem(this.api.lang.getText("REMOVE"),this.api.network.Mount,this.api.network.Mount.removeObjectInPark,[var4.num]);
					var7.show(_root._xmouse,_root._ymouse);
					return undefined;
				}
			}
		}
		if(!_global.isNaN(var5) && (this.api.datacenter.Player.canUseInteractiveObjects && this.api.datacenter.Game.interactionType != 5))
		{
			var var8 = this.api.lang.getInteractiveObjectDataByGfxText(var5);
			var var9 = var8.n;
			var var10 = var8.sk;
			var var11 = var8.t;
			switch(var11)
			{
				default:
					loop5:
					switch(null)
					{
						default:
							switch(null)
							{
								case 14:
								case 15:
									break loop5;
								case 5:
									var var22 = true;
									var var23 = this.api.ui.createPopupMenu();
									var var24 = this.api.lang.getHousesDoorText(this.api.datacenter.Map.id,var4.num);
									var var25 = this.api.datacenter.Houses.getItemAt(var24);
									var23.addStaticItem(var9 + " " + var25.name);
									if(var25.localOwner)
									{
										var23.addStaticItem(this.api.lang.getText("MY_HOME"));
									}
									else if(var25.ownerName != undefined)
									{
										if(var25.ownerName == "?")
										{
											var23.addStaticItem(this.api.lang.getText("HOUSE_WITH_NO_OWNER"));
										}
										else
										{
											var23.addStaticItem(this.api.lang.getText("HOME_OF",[var25.ownerName]));
										}
									}
									if(this.api.datacenter.Player.isAuthorized && (var25.ownerName != undefined && var25.ownerName != "?"))
									{
										var23.addItem(this.api.lang.getText("HOME_OF",[var25.ownerName]),this.api.kernel.GameManager,this.api.kernel.GameManager.showPlayerPopupMenu,[undefined,"*" + var25.ownerName]);
									}
									for(var k in var10)
									{
										var var26 = var10[k];
										var var27 = new dofus.datacenter.(var26);
										var var28 = var27.getState(true,var25.localOwner,var25.isForSale,var25.isLocked);
										if(var28 != "X")
										{
											var var29 = var28 == "V";
											if(var29 && (Key.isDown(Key.SHIFT) && var26 == 84))
											{
												this.api.kernel.GameManager.useRessource(var4,var4.num,var26);
												var22 = false;
												break;
											}
											var23.addItem(var27.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[var4,var4.num,var26],var29);
										}
									}
									if(var22)
									{
										var23.show(_root._xmouse,_root._ymouse);
									}
									break;
								case 6:
									var var30 = this.api.datacenter.Map.id + "_" + var4.num;
									var var31 = this.api.datacenter.Storages.getItemAt(var30);
									var var32 = var31.isLocked;
									var var33 = this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id);
									var var34 = true;
									var var35 = this.api.ui.createPopupMenu();
									var35.addStaticItem(var9);
									for(var k in var10)
									{
										var var36 = var10[k];
										var var37 = new dofus.datacenter.(var36);
										var var38 = var37.getState(true,var33,true,var32);
										if(var38 != "X")
										{
											var var39 = var38 == "V";
											if(var39 && Key.isDown(Key.SHIFT))
											{
												this.api.kernel.GameManager.useRessource(var4,var4.num,var36);
												var34 = false;
												break;
											}
											var35.addItem(var37.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[var4,var4.num,var36],var39);
										}
									}
									if(var34)
									{
										var35.show(_root._xmouse,_root._ymouse);
									}
									break;
								default:
									if(§§enum_assign() !== 13)
									{
										this.onCellRelease(var4);
										break;
									}
									var var40 = this.api.datacenter.Map.mountPark;
									var var41 = true;
									var var42 = this.api.ui.createPopupMenu();
									var42.addStaticItem(var9);
									for(var k in var10)
									{
										var var43 = var10[k];
										var var44 = new dofus.datacenter.(var43);
										var var45 = var44.getState(true,var40.isMine(this.api),var40.price > 0,var40.isPublic || var40.isMine(this.api),false,var40.isPublic);
										if(var45 != "X")
										{
											var var46 = var45 == "V";
											if(var46 && Key.isDown(Key.SHIFT))
											{
												this.api.kernel.GameManager.useRessource(var4,var4.num,var43);
												var41 = false;
												break;
											}
											var42.addItem(var44.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[var4,var4.num,var43],var46);
										}
									}
									if(var41)
									{
										var42.show(_root._xmouse,_root._ymouse);
									}
									break;
							}
						case 4:
						case 7:
						case 10:
						case 12:
					}
					break;
				case 1:
				case 2:
				case 3:
			}
			var var12 = this.api.datacenter.Player.currentJobID != undefined;
			if(var12)
			{
				var var13 = this.api.datacenter.Player.Jobs.findFirstItem("id",this.api.datacenter.Player.currentJobID).item.skills;
			}
			else
			{
				var13 = new ank.utils.();
			}
			var var14 = true;
			var var15 = this.api.ui.createPopupMenu();
			var15.addStaticItem(var9);
			for(var k in var10)
			{
				var var16 = var10[k];
				var var17 = new dofus.datacenter.(var16);
				var var18 = var13.findFirstItem("id",var16).index != -1;
				var var19 = this.api.datacenter.Player.Level <= dofus.Constants.NOVICE_LEVEL;
				var var20 = var17.getState(var18,false,false,false,false,var19);
				if(var20 != "X")
				{
					var var21 = var20 == "V";
					if(var21 && (Key.isDown(Key.SHIFT) && var16 != 44))
					{
						this.api.kernel.GameManager.useRessource(var4,var4.num,var16);
						var14 = false;
						break;
					}
					var15.addItem(var17.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[var4,var4.num,var16],var21);
				}
			}
			if(var14)
			{
				var15.show(_root._xmouse,_root._ymouse);
			}
		}
		else
		{
			this.onCellRelease(var4);
		}
	}
	function onObjectRollOver(var2)
	{
		if(this.api.ui.getUIComponent("Zoom") != undefined)
		{
			return undefined;
		}
		var var3 = var2.cellData;
		var var4 = var3.mc;
		var var5 = var3.layerObject2Num;
		if(this.api.datacenter.Game.interactionType == 5)
		{
			var4 = var2.cellData.mc;
			this.onCellRollOver(var4);
		}
		var2.select(true);
		var var6 = var3.layerObjectExternalData;
		if(var6 != undefined)
		{
			var var7 = var6.name;
			if(var6.durability != undefined)
			{
				if(this.api.datacenter.Map.mountPark.isMine(this.api))
				{
					var7 = var7 + ("\n" + this.api.lang.getText("DURABILITY") + " : " + var6.durability + "/" + var6.durabilityMax);
				}
			}
			var var8 = new dofus.datacenter.("itemOnCell",ank.battlefield.mc.Sprite,"",var4.num,0,0);
			this.api.datacenter.Sprites.addItemAt("itemOnCell",var8);
			this.api.gfx.addSprite("itemOnCell");
			this.addSpriteOverHeadItem("itemOnCell","text",dofus.graphics.battlefield.TextOverHead,[var7,"",dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
		}
		var var9 = this.api.lang.getInteractiveObjectDataByGfxText(var5);
		var var10 = var9.n;
		var var11 = var9.sk;
		var var12 = var9.t;
		switch(var12)
		{
			case 5:
				var var13 = this.api.lang.getHousesDoorText(this.api.datacenter.Map.id,var4.num);
				var var14 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(var13);
				if(var14.guildName.length > 0)
				{
					var var15 = new dofus.datacenter.("porte",ank.battlefield.mc.Sprite,"",var4.num,0,0);
					this.api.datacenter.Sprites.addItemAt("porte",var15);
					this.api.gfx.addSprite("porte");
					this.addSpriteOverHeadItem("porte","text",dofus.graphics.battlefield.GuildOverHead,[this.api.lang.getText("GUILD_HOUSE"),var14.guildName,var14.guildEmblem]);
				}
				break;
			case 13:
				var var16 = this.api.datacenter.Map.mountPark;
				var var17 = new dofus.datacenter.("enclos",ank.battlefield.mc.Sprite,"",var4.num,0,0);
				this.api.datacenter.Sprites.addItemAt("enclos",var17);
				this.api.gfx.addSprite("enclos");
				if(var16.isPublic)
				{
					this.addSpriteOverHeadItem("enclos","text",dofus.graphics.battlefield.TextOverHead,[this.api.lang.getText("MOUNTPARK_PUBLIC"),"",dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
					break;
				}
				if(var16.hasNoOwner)
				{
					this.addSpriteOverHeadItem("enclos","text",dofus.graphics.battlefield.TextOverHead,[this.api.lang.getText("MOUNTPARK_TO_BUY",[var16.price,var16.size,var16.items]),"",dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
					break;
				}
				if(var16.price > 0)
				{
					var var18 = this.api.lang.getText("MOUNTPARK_PRIVATE_TO_BUY",[var16.price]);
				}
				else
				{
					var18 = this.api.lang.getText("MOUNTPARK_PRIVATE");
				}
				this.addSpriteOverHeadItem("enclos","text",dofus.graphics.battlefield.GuildOverHead,[var16.guildName,var18,var16.guildEmblem]);
				break;
		}
	}
	function onObjectRollOut(var2)
	{
		this.api.ui.hideTooltip();
		if(this.api.datacenter.Game.interactionType == 5)
		{
			var var3 = var2.cellData.mc;
			this.onCellRollOut(var3);
		}
		var2.select(false);
		this.removeSpriteOverHeadLayer("enclos","text");
		this.removeSprite("enclos",false);
		this.removeSpriteOverHeadLayer("porte","text");
		this.removeSprite("porte",false);
		this.removeSpriteOverHeadLayer("itemOnCell","text");
		this.removeSprite("itemOnCell",false);
	}
	function showSpriteInfosIfWeNeed(oSprite)
	{
		if(this.api.ui.isCursorHidden())
		{
			if(this.api.kernel.OptionsManager.getOption("SpriteInfos"))
			{
				if(this.api.kernel.OptionsManager.getOption("SpriteMove") && oSprite.isVisible)
				{
					this.api.gfx.drawZone(oSprite.cellNum,0,oSprite.MP,"move",dofus.Constants.CELL_MOVE_RANGE_COLOR,"C");
				}
				this.api.ui.getUIComponent("Banner").showRightPanel("BannerSpriteInfos",{data:oSprite},true,true);
			}
		}
	}
	function hideSpriteInfos()
	{
		this.api.ui.getUIComponent("Banner").hideRightPanel(false,true);
		this.api.gfx.clearZoneLayer("move");
	}
}
