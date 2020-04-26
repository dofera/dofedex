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
	function initialize(loc2, loc3, loc4, loc5, loc6)
	{
		super.initialize(loc3,loc4,loc5,loc6);
		mx.events.EventDispatcher.initialize(this);
		this._oAPI = loc7;
	}
	function addSpritePoints(sID, §\x1e\x0e\x04§, §\b\t§)
	{
		if(this.api.kernel.OptionsManager.getOption("PointsOverHead"))
		{
			super.addSpritePoints(sID,loc4,loc5);
		}
	}
	function onInitError()
	{
		_root.onCriticalError(this.api.lang.getText("CRITICAL_ERROR_LOADING_BATTLEFIELD"));
	}
	function onMapLoaded()
	{
		var loc2 = this.api.datacenter.Map;
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
		var loc3 = loc2.subarea;
		if(loc3 != this.api.datacenter.Basics.gfx_lastSubarea)
		{
			var loc4 = this.api.datacenter.Subareas.getItemAt(loc3);
			var loc5 = new String();
			var loc6 = new String();
			var loc7 = this.api.lang.getMapAreaText(loc2.area).n;
			if(loc4 == undefined)
			{
				loc6 = String(this.api.lang.getMapSubAreaText(loc3).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(loc3).n:String(this.api.lang.getMapSubAreaText(loc3).n).substr(2);
				if(loc7 != loc6)
				{
					loc5 = loc7 + "\n(" + loc6 + ")";
				}
				else
				{
					loc5 = loc7;
				}
			}
			else
			{
				loc6 = loc4.name;
				loc5 = loc4.name + " (" + loc4.alignment.name + ")";
				if(loc7 != loc6)
				{
					loc5 = loc7 + "\n(" + loc6 + ")\n" + loc4.alignment.name;
				}
				else
				{
					loc5 = loc7 + "\n" + loc4.alignment.name;
				}
			}
			if(!this.api.kernel.TutorialManager.isTutorialMode)
			{
				this.api.ui.loadUIComponent("CenterText","CenterText",{text:loc5,background:false,timer:2000},{bForceLoad:true});
			}
			this.api.datacenter.Basics.gfx_lastSubarea = loc3;
		}
		if(this.api.datacenter.Player.isAtHome(loc2.id))
		{
			var loc8 = new Array();
			var loc9 = this.api.lang.getHousesIndoorSkillsText();
			var loc10 = 0;
			while(loc10 < loc9.length)
			{
				var loc11 = new dofus.datacenter.(loc9[loc10]);
				loc8.push(loc11);
				loc10 = loc10 + 1;
			}
			var loc12 = this.api.lang.getHousesMapText(loc2.id);
			if(loc12 != undefined)
			{
				var loc13 = this.api.datacenter.Houses.getItemAt(loc12);
				this.api.ui.loadUIComponent("HouseIndoor","HouseIndoor",{skills:loc8,house:loc13},{bStayIfPresent:true});
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
		this.api.ui.getUIComponent("Banner").setCircleXtraParams({currentCoords:[loc2.x,loc2.y]});
		if(Number(loc2.ambianceID) > 0)
		{
			this.api.sounds.playEnvironment(loc2.ambianceID);
		}
		if(Number(loc2.musicID) > 0)
		{
			this.api.sounds.playMusic(loc2.musicID,true);
		}
		if(!loc2.bOutdoor)
		{
			this.api.kernel.NightManager.noEffects();
		}
		var loc14 = (Array)this.api.lang.getMapText(loc2.id).p;
		var loc15 = 0;
		while(loc14.length > loc15)
		{
			var loc16 = loc14[loc15][0];
			var loc17 = loc14[loc15][1];
			var loc18 = loc14[loc15][2];
			if(!dofus.utils.criterions.CriterionManager.fillingCriterions(loc18))
			{
				var loc19 = this.api.gfx.mapHandler.getCellData(loc17);
				var loc20 = 0;
				while(loc20 < loc16.length)
				{
					if(loc19.layerObject1Num == loc16[loc20])
					{
						loc19.mcObject1._visible = false;
					}
					if(loc19.layerObject2Num == loc16[loc20])
					{
						loc19.mcObject2._visible = false;
					}
					loc20 = loc20 + 1;
				}
			}
			loc15 = loc15 + 1;
		}
		this.dispatchEvent({type:"mapLoaded"});
	}
	function onCellRelease(loc2)
	{
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"CELL_RELEASE",params:[loc2.num]});
			return false;
		}
		switch(this.api.datacenter.Game.interactionType)
		{
			case 1:
				var loc3 = this.api.datacenter.Player.data;
				var loc4 = false;
				var loc5 = this.api.datacenter.Player.canMoveInAllDirections;
				var loc6 = this.api.datacenter.Player.data.isInMove;
				if(this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler,loc2.num,true,this.api.datacenter.Game.isFight,false,loc5,loc6))
				{
					if(this.api.datacenter.Game.isFight)
					{
						loc4 = true;
					}
					else
					{
						loc4 = this.api.datacenter.Basics.interactionsManager_path[this.api.datacenter.Basics.interactionsManager_path.length - 1].num == loc2.num;
					}
				}
				if(!this.api.datacenter.Game.isFight && !loc4)
				{
					if(this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler,loc2.num,true,this.api.datacenter.Game.isFight,true,loc5,loc6))
					{
						loc4 = true;
					}
				}
				if(loc4)
				{
					if(getTimer() - this.api.datacenter.Basics.gfx_lastActionTime < dofus.Constants.CLICK_MIN_DELAY && (loc3 == undefined || !loc3.isAdminSonicSpeed))
					{
						ank.utils.Logger.err("T trop rapide du clic");
						return null;
					}
					this.api.datacenter.Basics.gfx_lastActionTime = getTimer();
					if(this.api.datacenter.Basics.interactionsManager_path.length != 0)
					{
						var loc7 = ank.battlefield.utils.Compressor.compressPath(this.api.datacenter.Basics.interactionsManager_path);
						if(loc7 != undefined)
						{
							loc3.GameActionsManager.transmittingMove(1,[loc7]);
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
					var loc8 = this.api.datacenter.Player.data;
					loc8.GameActionsManager.transmittingOther(300,[this.api.datacenter.Player.currentUseObject.ID,loc2.num]);
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
							var loc9 = this.api.datacenter.Player.data;
							loc9.GameActionsManager.transmittingOther(303,[loc2.num]);
							this.api.datacenter.Player.currentUseObject = null;
						}
						this.api.ui.removeCursor();
						this.api.kernel.GameManager.lastSpellLaunch = getTimer();
						this.api.datacenter.Game.setInteractionType("move");
						break;
					case 4:
						var loc10 = this.mapHandler.getCellData(loc2.num).spriteOnID;
						if(loc10 != undefined)
						{
							break;
						}
						this.api.network.Game.setPlayerPosition(loc2.num);
						break;
					case 5:
						if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
						{
							this.api.network.Items.use(this.api.datacenter.Player.currentUseObject.ID,this.mapHandler.getCellData(loc2.num).spriteOnID,loc2.num);
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
							if(loc2.num != undefined)
							{
								this.api.network.Game.setFlag(loc2.num);
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
	function onCellRollOver(loc2)
	{
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"CELL_OVER",params:[loc2.num]});
			return undefined;
		}
		if(this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isCurrentPlayer && this.api.datacenter.Game.interactionType != 6))
		{
			return undefined;
		}
		switch(this.api.datacenter.Game.interactionType)
		{
			case 1:
				var loc3 = this.api.datacenter.Player;
				var loc4 = loc3.data;
				var loc5 = this.mapHandler.getCellData(loc2.num).spriteOnID;
				var loc6 = this.api.datacenter.Sprites.getItemAt(loc5);
				if(loc6 != undefined)
				{
					this.showSpriteInfosIfWeNeed(loc6);
				}
				if(ank.battlefield.utils.Pathfinding.checkRange(this.mapHandler,loc4.cellNum,loc2.num,false,0,loc4.MP,0))
				{
					this.api.datacenter.Player.InteractionsManager.setState(this.api.datacenter.Game.isFight);
					this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler,loc2.num,false,this.api.datacenter.Game.isFight);
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
						this.drawPointer(loc2.num);
				}
				break;
			case 2:
				var loc7 = this.api.datacenter.Player;
				var loc8 = loc7.data;
				var loc9 = loc8.cellNum;
				var loc10 = loc7.currentUseObject;
				var loc11 = loc7.SpellsManager;
				var loc12 = !loc10.canBoostRange?0:loc8.CharacteristicsManager.getModeratorValue(19) + loc7.RangeModerator;
				this.api.datacenter.Basics.gfx_canLaunch = loc11.checkCanLaunchSpellOnCell(this.mapHandler,loc10,this.mapHandler.getCellData(loc2.num),loc12);
				if(this.api.datacenter.Basics.gfx_canLaunch)
				{
					this.api.ui.setCursorForbidden(false);
					this.drawPointer(loc2.num);
				}
				else
				{
					this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
				}
		}
	}
	function onCellRollOut(loc2)
	{
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"CELL_OUT",params:[loc2.num]});
			return undefined;
		}
		if(this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isCurrentPlayer && this.api.datacenter.Game.interactionType != 6))
		{
			return undefined;
		}
		if((var loc0 = this.api.datacenter.Game.interactionType) !== 1)
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
	function onSpriteRelease(loc2)
	{
		var loc3 = loc2.data;
		var loc4 = loc3.id;
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"SPRITE_RELEASE",params:[loc3.id]});
			return undefined;
		}
		if(loc3.hasParent)
		{
			this.onSpriteRelease(loc3.linkedParent.mc);
			return undefined;
		}
		if((var loc0 = this.api.datacenter.Game.interactionType) !== 5)
		{
			if(loc3 instanceof dofus.datacenter.Mutant && !loc3.showIsPlayer)
			{
				if(!this.api.datacenter.Game.isRunning)
				{
					if(this.api.datacenter.Player.isMutant)
					{
						return undefined;
					}
				}
				var loc5 = this.mapHandler.getCellData(loc3.cellNum).mc;
				this.onCellRelease(loc5);
			}
			else if(loc3 instanceof dofus.datacenter.Character || loc3 instanceof dofus.datacenter.Mutant && loc3.showIsPlayer)
			{
				if(this.api.datacenter.Game.isFight)
				{
					if(this.api.datacenter.Game.isRunning)
					{
						var loc6 = this.mapHandler.getCellData(loc3.cellNum).mc;
						this.onCellRelease(loc6);
						return undefined;
					}
				}
				if(Key.isDown(Key.CONTROL))
				{
					var loc7 = this.mapHandler.getCellData(loc3.cellNum).allSpritesOn;
					this.api.kernel.GameManager.showCellPlayersPopupMenu(loc7);
				}
				else
				{
					this.api.kernel.GameManager.showPlayerPopupMenu(loc3,undefined);
				}
			}
			else if(loc3 instanceof dofus.datacenter.NonPlayableCharacter)
			{
				if(this.api.datacenter.Player.cantSpeakNPC)
				{
					return undefined;
				}
				var loc8 = loc3.actions;
				if(loc8 != undefined && loc8.length != 0)
				{
					var loc9 = true;
					var loc10 = this.api.ui.createPopupMenu();
					var loc11 = loc8.length;
					while(true)
					{
						loc11;
						if(loc11-- > 0)
						{
							var loc12 = loc8[loc11];
							var loc13 = loc12.actionId;
							var loc14 = loc12.action;
							var loc15 = loc14.method;
							var loc16 = loc14.object;
							var loc17 = loc14.params;
							if(Key.isDown(Key.SHIFT) && loc13 == 3)
							{
								loc9 = false;
								loc15.apply(loc16,loc17);
								break;
							}
							loc10.addItem(loc12.name,loc16,loc15,loc17);
							continue;
						}
						break;
					}
					if(loc9)
					{
						loc10.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(loc3 instanceof dofus.datacenter.Team)
			{
				var loc18 = this.api.datacenter.Player.data.alignment.index;
				var loc19 = loc3.alignment.index;
				var loc20 = loc3.enemyTeam.alignment.index;
				var loc21 = loc3.challenge.fightType;
				var loc22 = false;
				switch(loc21)
				{
					case 0:
						switch(loc3.type)
						{
							case 0:
							case 2:
								loc22 = this.api.datacenter.Player.canChallenge && (!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant);
						}
						break;
					case 1:
					case 2:
						switch(loc3.type)
						{
							case 0:
							case 1:
								if(loc18 == loc19)
								{
									loc22 = !this.api.datacenter.Player.isMutant;
									break;
								}
								loc22 = this.api.lang.getAlignmentCanJoin(loc18,loc19) && (this.api.lang.getAlignmentCanAttack(loc18,loc20) && !this.api.datacenter.Player.isMutant);
								break;
						}
						break;
					case 3:
						switch(loc3.type)
						{
							case 0:
								loc22 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
								break;
							case 1:
								loc22 = false;
						}
						break;
					default:
						switch(null)
						{
							case 4:
								switch(loc3.type)
								{
									case 0:
										loc22 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
										break;
									case 1:
										loc22 = false;
								}
								break;
							case 5:
								switch(loc3.type)
								{
									case 0:
										loc22 = !this.api.datacenter.Player.isMutant && !this.api.datacenter.Player.cantInteractWithTaxCollector;
										break;
									case 3:
										loc22 = false;
								}
								break;
							case 6:
								switch(loc3.type)
								{
									case 0:
										loc22 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
										break;
									case 2:
										loc22 = this.api.datacenter.Player.isMutant && !this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant == true;
								}
						}
				}
				if(loc22)
				{
					var loc23 = true;
					var loc24 = this.api.ui.createPopupMenu();
					var loc25 = this.api.lang.getMapMaxTeam(this.api.datacenter.Map.id);
					var loc26 = this.api.lang.getMapMaxChallenge(this.api.datacenter.Map.id);
					if(loc3.challenge.count >= loc26)
					{
						loc24.addItem(this.api.lang.getText("CHALENGE_FULL"));
					}
					else if(loc3.count >= loc25)
					{
						loc24.addItem(this.api.lang.getText("TEAM_FULL"));
					}
					else if(Key.isDown(Key.SHIFT))
					{
						loc23 = false;
						this.api.network.GameActions.joinChallenge(loc3.challenge.id,loc3.id);
						this.api.ui.hideTooltip();
					}
					else
					{
						loc24.addItem(this.api.lang.getText("JOIN_SMALL"),this.api.network.GameActions,this.api.network.GameActions.joinChallenge,[loc3.challenge.id,loc3.id]);
					}
					if(loc23)
					{
						loc24.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(loc3 instanceof dofus.datacenter.ParkMount)
			{
				if(loc3.ownerName == this.api.datacenter.Player.Name || this.api.datacenter.Map.mountPark.guildName == this.api.datacenter.Player.guildInfos.name && this.api.datacenter.Player.guildInfos.playerRights.canManageOtherMount)
				{
					if(Key.isDown(Key.SHIFT))
					{
						this.api.network.Mount.parkMountData(loc3.id);
					}
					else
					{
						var loc27 = this.api.ui.createPopupMenu();
						loc27.addStaticItem(this.api.lang.getText("MOUNT_OF",[loc3.ownerName]));
						loc27.addItem(this.api.lang.getText("VIEW_MOUNT_DETAILS"),this.api.network.Mount,this.api.network.Mount.parkMountData,[loc3.id]);
						loc27.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(loc3 instanceof dofus.datacenter.Creature)
			{
				var loc28 = this.mapHandler.getCellData(loc3.cellNum).mc;
				this.onCellRelease(loc28);
			}
			else if(loc3 instanceof dofus.datacenter.MonsterGroup || loc3 instanceof dofus.datacenter.Monster)
			{
				if(loc3 instanceof dofus.datacenter.Monster && this.api.kernel.GameManager.isInMyTeam(loc3))
				{
					this.api.kernel.GameManager.showMonsterPopupMenu(loc3);
				}
				if(!this.api.datacenter.Player.isMutant || (this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant || this.api.datacenter.Player.canAttackMonstersAnywhereWhenMutant))
				{
					var loc29 = this.mapHandler.getCellData(loc3.cellNum);
					var loc30 = loc29.mc;
					if(!Key.isDown(Key.SHIFT) && (!this.api.datacenter.Game.isFight && loc3 instanceof dofus.datacenter.MonsterGroup))
					{
						var loc31 = loc29.isTrigger;
						if(!loc31 && this.api.kernel.OptionsManager.getOption("ViewAllMonsterInGroup") == true)
						{
							var loc32 = this.api.ui.createPopupMenu();
							loc32.addItem(this.api.lang.getText("ATTACK"),this,this.onCellRelease,[loc30]);
							loc32.show();
						}
						else
						{
							this.onCellRelease(loc30);
						}
					}
					else
					{
						this.onCellRelease(loc30);
					}
				}
			}
			else if(loc3 instanceof dofus.datacenter.OfflineCharacter)
			{
				if(!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant)
				{
					if(!this.api.datacenter.Player.canExchange)
					{
						return undefined;
					}
					if(Key.isDown(Key.SHIFT))
					{
						this.api.kernel.GameManager.startExchange(4,loc3.id,loc3.cellNum);
					}
					else
					{
						var loc34 = loc3.name;
						if(this.api.datacenter.Player.isAuthorized)
						{
							var loc33 = this.api.kernel.AdminManager.getAdminPopupMenu(loc34);
						}
						else
						{
							loc33 = this.api.ui.createPopupMenu();
						}
						loc33.addStaticItem(this.api.lang.getText("SHOP") + " " + this.api.lang.getText("OF") + " " + loc3.name);
						loc33.addItem(this.api.lang.getText("BUY"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[4,loc3.id,loc3.cellNum]);
						var loc35 = 2;
						if(this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id))
						{
							loc33.addItem(this.api.lang.getText("KICKOFF"),this.api.network.Basics,this.api.network.Basics.kick,[loc3.cellNum]);
							loc35 = loc35 + 1;
						}
						if(this.api.datacenter.Player.isAuthorized)
						{
							var loc36 = 0;
							while(loc36 < loc35)
							{
								loc33.items.unshift(loc33.items.pop());
								loc36 = loc36 + 1;
							}
						}
						loc33.show(_root._xmouse,_root._ymouse,true);
					}
				}
			}
			else if(loc3 instanceof dofus.datacenter.TaxCollector)
			{
				if(!this.api.datacenter.Player.isMutant)
				{
					if(this.api.datacenter.Player.cantInteractWithTaxCollector)
					{
						return undefined;
					}
					if(this.api.datacenter.Game.isFight)
					{
						var loc37 = this.mapHandler.getCellData(loc3.cellNum).mc;
						this.onCellRelease(loc37);
					}
					else if(Key.isDown(Key.SHIFT))
					{
						this.api.network.Dialog.create(loc4);
					}
					else
					{
						var loc38 = this.api.datacenter.Player.guildInfos.playerRights;
						var loc39 = loc3.guildName == this.api.datacenter.Player.guildInfos.name;
						var loc40 = loc39 && loc38.canHireTaxCollector;
						var loc41 = this.api.ui.createPopupMenu();
						loc41.addItem(this.api.lang.getText("SPEAK"),this.api.network.Dialog,this.api.network.Dialog.create,[loc4]);
						loc41.addItem(this.api.lang.getText("COLLECT_TAX"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[8,loc4],loc39);
						loc41.addItem(this.api.lang.getText("ATTACK"),this.api.network.GameActions,this.api.network.GameActions.attackTaxCollector,[[loc4]],!loc39);
						loc41.addItem(this.api.lang.getText("REMOVE"),this.api.kernel.GameManager,this.api.kernel.GameManager.askRemoveTaxCollector,[[loc4]],loc40);
						loc41.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(loc3 instanceof dofus.datacenter.PrismSprite)
			{
				if(!this.api.datacenter.Player.isMutant)
				{
					if(this.api.datacenter.Game.isFight)
					{
						var loc42 = this.mapHandler.getCellData(loc3.cellNum).mc;
						this.onCellRelease(loc42);
					}
					else
					{
						var loc43 = this.api.datacenter.Player.alignment.index == 0;
						var loc44 = this.api.datacenter.Player.alignment.compareTo(loc3.alignment) == 0;
						if(Key.isDown(Key.SHIFT) && loc44)
						{
							this.api.network.GameActions.usePrism([loc4]);
						}
						else
						{
							var loc45 = this.api.ui.createPopupMenu();
							loc45.addItem(this.api.lang.getText("USE_WORD"),this.api.network.GameActions,this.api.network.GameActions.usePrism,[[loc4]],loc44);
							loc45.addItem(this.api.lang.getText("ATTACK"),this.api.network.GameActions,this.api.network.GameActions.attackPrism,[[loc4]],!loc44 && !loc43);
							loc45.show(_root._xmouse,_root._ymouse);
						}
					}
				}
			}
		}
		else
		{
			if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
			{
				this.api.network.Items.use(this.api.datacenter.Player.currentUseObject.ID,loc3.id,loc3.cellNum);
			}
			this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
			this.api.gfx.clearPointer();
			this.unSelect(true);
			this.api.datacenter.Player.reset();
			this.api.ui.removeCursor();
			this.api.datacenter.Game.setInteractionType("move");
		}
	}
	function onSpriteRollOver(loc2)
	{
		if(this.api.ui.getUIComponent("Zoom") != undefined)
		{
			return undefined;
		}
		var loc5 = loc2.data;
		var loc6 = dofus.Constants.OVERHEAD_TEXT_OTHER;
		if(loc5.isClear)
		{
			return undefined;
		}
		if(loc5.hasParent)
		{
			this.onSpriteRollOver(loc5.linkedParent.mc);
			return undefined;
		}
		if(this.api.datacenter.Game.isRunning || this.api.datacenter.Game.interactionType == 5)
		{
			var loc8 = this.mapHandler.getCellData(loc5.cellNum).mc;
			if(loc5.isVisible)
			{
				this.onCellRollOver(loc8);
			}
		}
		var loc9 = loc5.name;
		if(loc5 instanceof dofus.datacenter.Mutant && loc5.showIsPlayer)
		{
			if(this.api.datacenter.Game.isRunning)
			{
				loc9 = loc5.playerName + " (" + loc5.LP + ")";
				this.showSpriteInfosIfWeNeed(loc5);
			}
			else
			{
				loc9 = loc5.playerName + " [" + loc5.monsterName + " (" + loc5.Level + ")]";
			}
		}
		else if(loc5 instanceof dofus.datacenter.Mutant || (loc5 instanceof dofus.datacenter.Creature || loc5 instanceof dofus.datacenter.Monster))
		{
			loc6 = dofus.Constants.NPC_ALIGNMENT_COLOR[loc5.alignment.index];
			if(this.api.datacenter.Game.isRunning)
			{
				loc9 = loc9 + (" (" + loc5.LP + ")");
				this.showSpriteInfosIfWeNeed(loc5);
			}
			else
			{
				loc9 = loc9 + (" (" + loc5.Level + ")");
			}
		}
		else if(loc5 instanceof dofus.datacenter.Character)
		{
			loc6 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
			if(this.api.datacenter.Game.isRunning)
			{
				loc9 = loc9 + (" (" + loc5.LP + ")");
				if(loc5.isVisible)
				{
					var loc10 = loc5.EffectsManager.getEffects();
					if(loc10.length != 0)
					{
						this.addSpriteOverHeadItem(loc5.id,"effects",dofus.graphics.battlefield.EffectsOverHead,[loc10]);
					}
				}
				this.showSpriteInfosIfWeNeed(loc5);
			}
			else if(this.api.datacenter.Game.isFight)
			{
				loc9 = loc9 + (" (" + loc5.Level + ")");
			}
			if(!loc5.isVisible)
			{
				return undefined;
			}
			var loc3 = dofus.Constants.DEMON_ANGEL_FILE;
			if(loc5.alignment.fallenAngelDemon)
			{
				loc3 = dofus.Constants.FALLEN_DEMON_ANGEL_FILE;
			}
			var loc11 = !loc5.haveFakeAlignement?loc5.alignment.index:loc5.fakeAlignment.index;
			if(loc5.rank.value > 0)
			{
				if(loc11 == 1)
				{
					var loc4 = loc5.rank.value;
				}
				else if(loc11 == 2)
				{
					loc4 = 10 + loc5.rank.value;
				}
				else if(loc11 == 3)
				{
					loc4 = 20 + loc5.rank.value;
				}
			}
			var loc7 = loc5.title;
			if(loc5.guildName != undefined && loc5.guildName.length != 0)
			{
				loc9 = "";
				this.addSpriteOverHeadItem(loc5.id,"text",dofus.graphics.battlefield.GuildOverHead,[loc5.guildName,loc5.name,loc5.emblem,loc3,loc4,loc5.pvpGain,loc7],undefined,true);
			}
		}
		else if(loc5 instanceof dofus.datacenter.TaxCollector)
		{
			if(this.api.datacenter.Game.isRunning)
			{
				loc9 = loc9 + (" (" + loc5.LP + ")");
				this.showSpriteInfosIfWeNeed(loc5);
			}
			else if(this.api.datacenter.Game.isFight)
			{
				loc9 = loc9 + (" (" + loc5.Level + ")");
			}
			else
			{
				loc9 = "";
				this.addSpriteOverHeadItem(loc5.id,"text",dofus.graphics.battlefield.GuildOverHead,[loc5.guildName,loc5.name,loc5.emblem]);
			}
		}
		else if(loc5 instanceof dofus.datacenter.PrismSprite)
		{
			loc3 = dofus.Constants.DEMON_ANGEL_FILE;
			if(loc5.alignment.value > 0)
			{
				if(loc5.alignment.index == 1)
				{
					loc4 = loc5.alignment.value;
				}
				else if(loc5.alignment.index == 2)
				{
					loc4 = 10 + loc5.alignment.value;
				}
				else if(loc5.alignment.index == 3)
				{
					loc4 = 20 + loc5.alignment.value;
				}
			}
			loc6 = dofus.Constants.NPC_ALIGNMENT_COLOR[loc5.alignment.index];
			this.addSpriteOverHeadItem(loc5.id,"text",dofus.graphics.battlefield.TextOverHead,[loc9,loc3,loc6,loc4]);
		}
		else if(loc5 instanceof dofus.datacenter.ParkMount)
		{
			loc6 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
			loc9 = this.api.lang.getText("MOUNT_PARK_OVERHEAD",[loc5.modelName,loc5.level,loc5.ownerName]);
			this.addSpriteOverHeadItem(loc5.id,"text",dofus.graphics.battlefield.TextOverHead,[loc9,loc3,loc6,loc4]);
		}
		else if(loc5 instanceof dofus.datacenter.OfflineCharacter)
		{
			loc6 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
			loc9 = "";
			this.addSpriteOverHeadItem(loc5.id,"text",dofus.graphics.battlefield.OfflineOverHead,[loc5]);
		}
		else if(loc5 instanceof dofus.datacenter.NonPlayableCharacter)
		{
			var loc12 = this.api.datacenter.Map;
			var loc13 = this.api.datacenter.Subareas.getItemAt(loc12.subarea);
			if(loc13 != undefined)
			{
				loc6 = dofus.Constants.NPC_ALIGNMENT_COLOR[loc13.alignment.index];
			}
		}
		else if(loc5 instanceof dofus.datacenter.MonsterGroup || loc5 instanceof dofus.datacenter.Team)
		{
			if(loc5.alignment.index != -1)
			{
				loc6 = dofus.Constants.NPC_ALIGNMENT_COLOR[loc5.alignment.index];
			}
			var loc14 = loc5.challenge.fightType;
			if(loc5.isVisible && (loc5 instanceof dofus.datacenter.MonsterGroup || loc5.type == 1 && (loc14 == 2 || (loc14 == 3 || loc14 == 4))))
			{
				if(loc9 != "")
				{
					var loc15 = dofus.Constants.OVERHEAD_TEXT_TITLE;
					this.addSpriteOverHeadItem(loc5.id,"text",dofus.graphics.battlefield.TextWithTitleOverHead,[loc9,loc3,loc6,loc4,this.api.lang.getText("LEVEL") + " " + loc5.totalLevel,loc15,loc5.bonusValue]);
				}
				this.selectSprite(loc5.id,true);
				return undefined;
			}
		}
		if(loc5.isVisible)
		{
			if(loc9 != "")
			{
				this.addSpriteOverHeadItem(loc5.id,"text",dofus.graphics.battlefield.TextOverHead,[loc9,loc3,loc6,loc4,loc5.pvpGain,loc7]);
			}
			this.selectSprite(loc5.id,true);
		}
	}
	function onSpriteRollOut(loc2)
	{
		var loc3 = loc2.data;
		if(this.api.gfx.spriteHandler.isShowingMonstersTooltip && loc3 instanceof dofus.datacenter.MonsterGroup)
		{
			return undefined;
		}
		if(loc3.hasParent)
		{
			this.onSpriteRollOut(loc3.linkedParent.mc);
			return undefined;
		}
		if(this.api.datacenter.Game.isRunning || this.api.datacenter.Game.interactionType == 5)
		{
			this.hideSpriteInfos();
			var loc4 = this.mapHandler.getCellData(loc3.cellNum).mc;
			this.onCellRollOut(loc4);
		}
		this.removeSpriteOverHeadLayer(loc3.id,"text");
		this.removeSpriteOverHeadLayer(loc3.id,"effects");
		this.selectSprite(loc3.id,false);
	}
	function onObjectRelease(loc2)
	{
		this.api.ui.hideTooltip();
		var loc3 = loc2.cellData;
		var loc4 = loc3.mc;
		var loc5 = loc3.layerObject2Num;
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"OBJECT_RELEASE",params:[loc3.num,loc5]});
			return undefined;
		}
		var loc6 = loc3.layerObjectExternalData;
		if(loc6 != undefined)
		{
			if(loc6.durability != undefined)
			{
				if(this.api.datacenter.Map.mountPark.isMine(this.api))
				{
					var loc7 = this.api.ui.createPopupMenu();
					loc7.addStaticItem(loc6.name);
					loc7.addItem(this.api.lang.getText("REMOVE"),this.api.network.Mount,this.api.network.Mount.removeObjectInPark,[loc4.num]);
					loc7.show(_root._xmouse,_root._ymouse);
					return undefined;
				}
			}
		}
		if(!_global.isNaN(loc5) && (this.api.datacenter.Player.canUseInteractiveObjects && this.api.datacenter.Game.interactionType != 5))
		{
			var loc8 = this.api.lang.getInteractiveObjectDataByGfxText(loc5);
			var loc9 = loc8.n;
			var loc10 = loc8.sk;
			var loc11 = loc8.t;
			if((var loc0 = loc11) !== 1)
			{
				loop5:
				switch(null)
				{
					default:
						switch(null)
						{
							case 10:
							case 12:
							case 14:
							case 15:
								break loop5;
							default:
								switch(null)
								{
									case 5:
										var loc22 = true;
										var loc23 = this.api.ui.createPopupMenu();
										var loc24 = this.api.lang.getHousesDoorText(this.api.datacenter.Map.id,loc4.num);
										var loc25 = this.api.datacenter.Houses.getItemAt(loc24);
										loc23.addStaticItem(loc9 + " " + loc25.name);
										if(loc25.localOwner)
										{
											loc23.addStaticItem(this.api.lang.getText("MY_HOME"));
										}
										else if(loc25.ownerName != undefined)
										{
											if(loc25.ownerName == "?")
											{
												loc23.addStaticItem(this.api.lang.getText("HOUSE_WITH_NO_OWNER"));
											}
											else
											{
												loc23.addStaticItem(this.api.lang.getText("HOME_OF",[loc25.ownerName]));
											}
										}
										if(this.api.datacenter.Player.isAuthorized && (loc25.ownerName != undefined && loc25.ownerName != "?"))
										{
											loc23.addItem(this.api.lang.getText("HOME_OF",[loc25.ownerName]),this.api.kernel.GameManager,this.api.kernel.GameManager.showPlayerPopupMenu,[undefined,"*" + loc25.ownerName]);
										}
										for(var k in loc10)
										{
											var loc26 = loc10[k];
											var loc27 = new dofus.datacenter.(loc26);
											var loc28 = loc27.getState(true,loc25.localOwner,loc25.isForSale,loc25.isLocked);
											if(loc28 != "X")
											{
												var loc29 = loc28 == "V";
												if(loc29 && (Key.isDown(Key.SHIFT) && loc26 == 84))
												{
													this.api.kernel.GameManager.useRessource(loc4,loc4.num,loc26);
													loc22 = false;
													break;
												}
												loc23.addItem(loc27.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[loc4,loc4.num,loc26],loc29);
											}
										}
										if(loc22)
										{
											loc23.show(_root._xmouse,_root._ymouse);
										}
										break;
									case 6:
										var loc30 = this.api.datacenter.Map.id + "_" + loc4.num;
										var loc31 = this.api.datacenter.Storages.getItemAt(loc30);
										var loc32 = loc31.isLocked;
										var loc33 = this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id);
										var loc34 = true;
										var loc35 = this.api.ui.createPopupMenu();
										loc35.addStaticItem(loc9);
										for(var k in loc10)
										{
											var loc36 = loc10[k];
											var loc37 = new dofus.datacenter.(loc36);
											var loc38 = loc37.getState(true,loc33,true,loc32);
											if(loc38 != "X")
											{
												var loc39 = loc38 == "V";
												if(loc39 && Key.isDown(Key.SHIFT))
												{
													this.api.kernel.GameManager.useRessource(loc4,loc4.num,loc36);
													loc34 = false;
													break;
												}
												loc35.addItem(loc37.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[loc4,loc4.num,loc36],loc39);
											}
										}
										if(loc34)
										{
											loc35.show(_root._xmouse,_root._ymouse);
										}
										break;
									case 13:
										var loc40 = this.api.datacenter.Map.mountPark;
										var loc41 = true;
										var loc42 = this.api.ui.createPopupMenu();
										loc42.addStaticItem(loc9);
										loop2:
										for(var k in loc10)
										{
											var loc43 = loc10[k];
											var loc44 = new dofus.datacenter.(loc43);
											var loc45 = loc44.getState(true,loc40.isMine(this.api),loc40.price > 0,loc40.isPublic || loc40.isMine(this.api),false,loc40.isPublic);
											if(loc45 != "X")
											{
												var loc46 = loc45 == "V";
												if(loc46 && Key.isDown(Key.SHIFT))
												{
													this.api.kernel.GameManager.useRessource(loc4,loc4.num,loc43);
													loc41 = false;
													while(true)
													{
														if(§§pop() == null)
														{
															break loop2;
														}
													}
												}
												else
												{
													loc42.addItem(loc44.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[loc4,loc4.num,loc43],loc46);
												}
											}
										}
										if(loc41)
										{
											loc42.show(_root._xmouse,_root._ymouse);
										}
										break;
									default:
										this.onCellRelease(loc4);
								}
						}
					case 2:
					case 3:
					case 4:
					case 7:
				}
			}
			var loc12 = this.api.datacenter.Player.currentJobID != undefined;
			if(loc12)
			{
				var loc13 = this.api.datacenter.Player.Jobs.findFirstItem("id",this.api.datacenter.Player.currentJobID).item.skills;
			}
			else
			{
				loc13 = new ank.utils.();
			}
			var loc14 = true;
			var loc15 = this.api.ui.createPopupMenu();
			loc15.addStaticItem(loc9);
			for(var k in loc10)
			{
				var loc16 = loc10[k];
				var loc17 = new dofus.datacenter.(loc16);
				var loc18 = loc13.findFirstItem("id",loc16).index != -1;
				var loc19 = this.api.datacenter.Player.Level <= dofus.Constants.NOVICE_LEVEL;
				var loc20 = loc17.getState(loc18,false,false,false,false,loc19);
				if(loc20 != "X")
				{
					var loc21 = loc20 == "V";
					if(loc21 && (Key.isDown(Key.SHIFT) && loc16 != 44))
					{
						this.api.kernel.GameManager.useRessource(loc4,loc4.num,loc16);
						loc14 = false;
						break;
					}
					loc15.addItem(loc17.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[loc4,loc4.num,loc16],loc21);
				}
			}
			if(loc14)
			{
				loc15.show(_root._xmouse,_root._ymouse);
			}
		}
		else
		{
			this.onCellRelease(loc4);
		}
	}
	function onObjectRollOver(loc2)
	{
		if(this.api.ui.getUIComponent("Zoom") != undefined)
		{
			return undefined;
		}
		var loc3 = loc2.cellData;
		var loc4 = loc3.mc;
		var loc5 = loc3.layerObject2Num;
		if(this.api.datacenter.Game.interactionType == 5)
		{
			loc4 = loc2.cellData.mc;
			this.onCellRollOver(loc4);
		}
		loc2.select(true);
		var loc6 = loc3.layerObjectExternalData;
		if(loc6 != undefined)
		{
			var loc7 = loc6.name;
			if(loc6.durability != undefined)
			{
				if(this.api.datacenter.Map.mountPark.isMine(this.api))
				{
					loc7 = loc7 + ("\n" + this.api.lang.getText("DURABILITY") + " : " + loc6.durability + "/" + loc6.durabilityMax);
				}
			}
			var loc8 = new dofus.datacenter.("itemOnCell",ank.battlefield.mc.Sprite,"",loc4.num,0,0);
			this.api.datacenter.Sprites.addItemAt("itemOnCell",loc8);
			this.api.gfx.addSprite("itemOnCell");
			this.addSpriteOverHeadItem("itemOnCell","text",dofus.graphics.battlefield.TextOverHead,[loc7,"",dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
		}
		var loc9 = this.api.lang.getInteractiveObjectDataByGfxText(loc5);
		var loc10 = loc9.n;
		var loc11 = loc9.sk;
		var loc12 = loc9.t;
		switch(loc12)
		{
			case 5:
				var loc13 = this.api.lang.getHousesDoorText(this.api.datacenter.Map.id,loc4.num);
				var loc14 = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(loc13);
				if(loc14.guildName.length > 0)
				{
					var loc15 = new dofus.datacenter.("porte",ank.battlefield.mc.Sprite,"",loc4.num,0,0);
					this.api.datacenter.Sprites.addItemAt("porte",loc15);
					this.api.gfx.addSprite("porte");
					this.addSpriteOverHeadItem("porte","text",dofus.graphics.battlefield.GuildOverHead,[this.api.lang.getText("GUILD_HOUSE"),loc14.guildName,loc14.guildEmblem]);
				}
				break;
			case 13:
				var loc16 = this.api.datacenter.Map.mountPark;
				var loc17 = new dofus.datacenter.("enclos",ank.battlefield.mc.Sprite,"",loc4.num,0,0);
				this.api.datacenter.Sprites.addItemAt("enclos",loc17);
				this.api.gfx.addSprite("enclos");
				if(loc16.isPublic)
				{
					this.addSpriteOverHeadItem("enclos","text",dofus.graphics.battlefield.TextOverHead,[this.api.lang.getText("MOUNTPARK_PUBLIC"),"",dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
					break;
				}
				if(loc16.hasNoOwner)
				{
					this.addSpriteOverHeadItem("enclos","text",dofus.graphics.battlefield.TextOverHead,[this.api.lang.getText("MOUNTPARK_TO_BUY",[loc16.price,loc16.size,loc16.items]),"",dofus.Constants.OVERHEAD_TEXT_CHARACTER]);
					break;
				}
				if(loc16.price > 0)
				{
					var loc18 = this.api.lang.getText("MOUNTPARK_PRIVATE_TO_BUY",[loc16.price]);
				}
				else
				{
					loc18 = this.api.lang.getText("MOUNTPARK_PRIVATE");
				}
				this.addSpriteOverHeadItem("enclos","text",dofus.graphics.battlefield.GuildOverHead,[loc16.guildName,loc18,loc16.guildEmblem]);
				break;
		}
	}
	function onObjectRollOut(loc2)
	{
		this.api.ui.hideTooltip();
		if(this.api.datacenter.Game.interactionType == 5)
		{
			var loc3 = loc2.cellData.mc;
			this.onCellRollOut(loc3);
		}
		loc2.select(false);
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
