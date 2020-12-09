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
	function __get__rollOverMcSprite()
	{
		return this._rollOverMcSprite;
	}
	function __get__rollOverMcObject()
	{
		return this._rollOverMcObject;
	}
	function __set__rollOverMcObject(rollOverMcObject)
	{
		this._rollOverMcObject = rollOverMcObject;
		return this.__get__rollOverMcObject();
	}
	function initialize(§\x1e\x1a\x01§, §\x1e\x12\t§, §\x1e\x0f\x1c§, §\x1e\x15\b§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4,var5,var6);
		mx.events.EventDispatcher.initialize(this);
		this._oAPI = var7;
	}
	function addSpritePoints(sID, §\x1e\f\t§, §\x07\x0e§)
	{
		if(this.api.kernel.OptionsManager.getOption("PointsOverHead") && this.api.electron.isWindowFocused)
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
		this._rollOverMcObject = undefined;
		this._rollOverMcSprite = undefined;
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
				var var11 = new dofus.datacenter.(var9[var10]);
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
		else
		{
			this.api.kernel.NightManager.setState();
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
	function onCellRelease(§\x0b\n§)
	{
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"CELL_RELEASE",params:[var2.num]});
			return false;
		}
		if((var var0 = this.api.datacenter.Game.interactionType) !== 1)
		{
			switch(null)
			{
				case 2:
					if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
					{
						var var8 = this.api.datacenter.Player.data;
						var var9 = var8.sequencer;
						var9.addAction(123,false,var8.GameActionsManager,var8.GameActionsManager.transmittingOther,[300,[this.api.datacenter.Player.currentUseObject.ID,var2.num]]);
						var9.execute();
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
				case 3:
					if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
					{
						var var10 = this.api.datacenter.Player.data;
						var var11 = var10.sequencer;
						var11.addAction(124,false,var10.GameActionsManager,var10.GameActionsManager.transmittingOther,[303,[var2.num]]);
						var11.execute();
						this.api.datacenter.Player.currentUseObject = null;
					}
					this.api.ui.removeCursor();
					this.api.kernel.GameManager.lastSpellLaunch = getTimer();
					this.api.datacenter.Game.setInteractionType("move");
					break;
				case 4:
					var var12 = this.mapHandler.getCellData(var2.num).spriteOnID;
					if(var12 != undefined)
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
		var var3 = this.api.datacenter.Player.data;
		var var4 = false;
		var var5 = this.api.datacenter.Player.canMoveInAllDirections;
		if(this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler,var2.num,true,this.api.datacenter.Game.isFight,false,var5))
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
			if(this.api.datacenter.Player.InteractionsManager.calculatePath(this.mapHandler,var2.num,true,this.api.datacenter.Game.isFight,true,var5))
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
				var var6 = ank.battlefield.utils.Compressor.compressPath(this.api.datacenter.Basics.interactionsManager_path);
				if(var6 != undefined)
				{
					if(this.api.datacenter.Game.isFight && this.api.datacenter.Game.isRunning)
					{
						var var7 = var3.sequencer;
						var7.addAction(122,false,var3.GameActionsManager,var3.GameActionsManager.transmittingMove,[1,[var6]]);
						var7.execute();
					}
					else
					{
						var3.GameActionsManager.transmittingMove(1,[var6]);
					}
					delete this.api.datacenter.Basics.interactionsManager_path;
				}
			}
			return true;
		}
		return false;
	}
	function onCellRollOver(§\x0b\n§)
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
				this.api.gfx.mapHandler.resetEmptyCells();
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
	function onCellRollOut(§\x0b\n§)
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
		switch(this.api.datacenter.Game.interactionType)
		{
			case 1:
				this.hideSpriteInfos();
				this.unSelect(true);
				break;
			case 2:
			case 3:
				this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
				this.hidePointer();
				this.api.datacenter.Basics.gfx_canLaunch = false;
				this.hideSpriteInfos();
				break;
			default:
				if(var0 !== 6)
				{
					break;
				}
			case 5:
				this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
				this.api.datacenter.Basics.gfx_canLaunch = false;
				this.hidePointer();
		}
	}
	function onSpriteRelease(§\n\x1b§, §\x16\b§)
	{
		if(var3 == undefined)
		{
			var3 = false;
		}
		var var4 = var2.data;
		var var5 = var4.id;
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"SPRITE_RELEASE",params:[var4.id]});
			return undefined;
		}
		if(var4.hasParent)
		{
			this.onSpriteRelease(var4.linkedParent.mc);
			return undefined;
		}
		if((var var0 = this.api.datacenter.Game.interactionType) !== 5)
		{
			if(var4 instanceof dofus.datacenter.Mutant && !var4.showIsPlayer)
			{
				if(!this.api.datacenter.Game.isRunning)
				{
					if(this.api.datacenter.Player.isMutant)
					{
						return undefined;
					}
				}
				var var6 = this.mapHandler.getCellData(var4.cellNum).mc;
				this.onCellRelease(var6);
			}
			else if(var4 instanceof dofus.datacenter.Character || var4 instanceof dofus.datacenter.Mutant && var4.showIsPlayer)
			{
				if(this.api.datacenter.Game.isFight && (this.api.datacenter.Game.isRunning && !(this.api.datacenter.Player.isAuthorized && (this.api.datacenter.Game.interactionType == dofus.datacenter.Game.INTERACTION_TYPE_MOVE && this.api.datacenter.Player.currentUseObject == null))))
				{
					var var7 = this.mapHandler.getCellData(var4.cellNum).mc;
					this.onCellRelease(var7);
					return undefined;
				}
				if(Key.isDown(Key.CONTROL))
				{
					var var8 = this.mapHandler.getCellData(var4.cellNum).allSpritesOn;
					this.api.kernel.GameManager.showCellPlayersPopupMenu(var8);
				}
				else
				{
					this.api.kernel.GameManager.showPlayerPopupMenu(var4,undefined);
				}
			}
			else if(var4 instanceof dofus.datacenter.NonPlayableCharacter)
			{
				if(this.api.datacenter.Player.cantSpeakNPC)
				{
					return undefined;
				}
				var var9 = var4.actions;
				if(var9 != undefined && var9.length != 0)
				{
					var var10 = true;
					var var11 = this.api.ui.createPopupMenu();
					var var12 = var9.length;
					while(true)
					{
						var12;
						if(var12-- > 0)
						{
							var var13 = var9[var12];
							var var14 = var13.actionId;
							var var15 = var13.action;
							var var16 = var15.method;
							var var17 = var15.object;
							var var18 = var15.params;
							if((Key.isDown(Key.SHIFT) || var3) && var14 == 3)
							{
								var10 = false;
								var16.apply(var17,var18);
								break;
							}
							var11.addItem(var13.name,var17,var16,var18);
							continue;
						}
						break;
					}
					if(var10)
					{
						var11.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(var4 instanceof dofus.datacenter.Team)
			{
				var var19 = this.api.datacenter.Player.data.alignment.index;
				var var20 = var4.alignment.index;
				var var21 = var4.enemyTeam.alignment.index;
				var var22 = var4.challenge.fightType;
				var var23 = false;
				switch(var22)
				{
					case 0:
						if((var0 = var4.type) !== 0)
						{
							if(var0 !== 2)
							{
							}
							addr708:
							break;
						}
						var23 = this.api.datacenter.Player.canChallenge && (!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant);
						§§goto(addr708);
						break;
					case 1:
					case 2:
						switch(var4.type)
						{
							case 0:
							case 1:
								if(var19 == var20)
								{
									var23 = !this.api.datacenter.Player.isMutant;
									break;
								}
								var23 = this.api.lang.getAlignmentCanJoin(var19,var20) && (this.api.lang.getAlignmentCanAttack(var19,var21) && !this.api.datacenter.Player.isMutant);
								break;
						}
						break;
					case 3:
						switch(var4.type)
						{
							case 0:
								var23 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
								break;
							case 1:
								var23 = false;
						}
						break;
					case 4:
						switch(var4.type)
						{
							case 0:
								var23 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
								break;
							case 1:
								var23 = false;
						}
						break;
					default:
						switch(null)
						{
							case 5:
								switch(var4.type)
								{
									case 0:
										var23 = !this.api.datacenter.Player.isMutant && !this.api.datacenter.Player.cantInteractWithTaxCollector;
										break;
									case 3:
										var23 = false;
								}
								break;
							case 6:
								switch(var4.type)
								{
									case 0:
										var23 = !this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant;
										break;
									case 2:
										var23 = this.api.datacenter.Player.isMutant && !this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant == true;
								}
						}
				}
				if(var23)
				{
					var var24 = true;
					var var25 = this.api.ui.createPopupMenu();
					var var26 = this.api.lang.getMapMaxTeam(this.api.datacenter.Map.id);
					var var27 = this.api.lang.getMapMaxChallenge(this.api.datacenter.Map.id);
					if(var4.challenge.count >= var27)
					{
						var25.addItem(this.api.lang.getText("CHALENGE_FULL"));
					}
					else if(var4.count >= var26)
					{
						var25.addItem(this.api.lang.getText("TEAM_FULL"));
					}
					else if(Key.isDown(Key.SHIFT) || var3)
					{
						var24 = false;
						this.api.network.GameActions.joinChallenge(var4.challenge.id,var4.id);
						this.api.ui.hideTooltip();
					}
					else
					{
						var25.addItem(this.api.lang.getText("JOIN_SMALL"),this.api.network.GameActions,this.api.network.GameActions.joinChallenge,[var4.challenge.id,var4.id]);
					}
					if(var24)
					{
						var25.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(var4 instanceof dofus.datacenter.ParkMount)
			{
				if(var4.ownerName == this.api.datacenter.Player.Name || this.api.datacenter.Map.mountPark.guildName == this.api.datacenter.Player.guildInfos.name && this.api.datacenter.Player.guildInfos.playerRights.canManageOtherMount)
				{
					if(Key.isDown(Key.SHIFT) || var3)
					{
						this.api.network.Mount.parkMountData(var4.id);
					}
					else
					{
						var var28 = this.api.ui.createPopupMenu();
						var28.addStaticItem(this.api.lang.getText("MOUNT_OF",[var4.ownerName]));
						var28.addItem(this.api.lang.getText("VIEW_MOUNT_DETAILS"),this.api.network.Mount,this.api.network.Mount.parkMountData,[var4.id]);
						var28.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(var4 instanceof dofus.datacenter.Creature)
			{
				var var29 = this.mapHandler.getCellData(var4.cellNum).mc;
				this.onCellRelease(var29);
			}
			else if(var4 instanceof dofus.datacenter.MonsterGroup || var4 instanceof dofus.datacenter.Monster)
			{
				if(var4 instanceof dofus.datacenter.Monster && this.api.kernel.GameManager.isInMyTeam(var4))
				{
					this.api.kernel.GameManager.showMonsterPopupMenu(var4);
				}
				if(!this.api.datacenter.Player.isMutant || (this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant || this.api.datacenter.Player.canAttackMonstersAnywhereWhenMutant))
				{
					var var30 = this.mapHandler.getCellData(var4.cellNum);
					var var31 = var30.mc;
					if(!Key.isDown(Key.SHIFT) && (!var3 && (!this.api.datacenter.Game.isFight && var4 instanceof dofus.datacenter.MonsterGroup)))
					{
						var var32 = var30.isTrigger;
						if(!var32 && this.api.kernel.OptionsManager.getOption("ViewAllMonsterInGroup") == true)
						{
							var var33 = this.api.ui.createPopupMenu();
							var33.addItem(this.api.lang.getText("ATTACK"),this,this.onCellRelease,[var31]);
							var33.show();
						}
						else
						{
							this.onCellRelease(var31);
						}
					}
					else
					{
						this.onCellRelease(var31);
					}
				}
			}
			else if(var4 instanceof dofus.datacenter.OfflineCharacter)
			{
				if(!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant)
				{
					if(!this.api.datacenter.Player.canExchange)
					{
						return undefined;
					}
					if(Key.isDown(Key.SHIFT) || var3)
					{
						this.api.kernel.GameManager.startExchange(4,var4.id,var4.cellNum);
					}
					else
					{
						var var35 = var4.name;
						if(this.api.datacenter.Player.isAuthorized)
						{
							var var34 = this.api.kernel.AdminManager.getAdminPopupMenu(var35,false);
						}
						else
						{
							var34 = this.api.ui.createPopupMenu();
						}
						var34.addStaticItem(this.api.lang.getText("SHOP") + " " + this.api.lang.getText("OF") + " " + var4.name);
						var34.addItem(this.api.lang.getText("BUY"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[4,var4.id,var4.cellNum]);
						var var36 = 2;
						if(this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id))
						{
							var34.addItem(this.api.lang.getText("KICKOFF"),this.api.network.Basics,this.api.network.Basics.kick,[var4.cellNum]);
							var36 = var36 + 1;
						}
						if(this.api.datacenter.Player.isAuthorized)
						{
							var var37 = 0;
							while(var37 < var36)
							{
								var34.items.unshift(var34.items.pop());
								var37 = var37 + 1;
							}
						}
						var34.show(_root._xmouse,_root._ymouse,true);
					}
				}
			}
			else if(var4 instanceof dofus.datacenter.TaxCollector)
			{
				if(!this.api.datacenter.Player.isMutant)
				{
					if(this.api.datacenter.Player.cantInteractWithTaxCollector)
					{
						return undefined;
					}
					if(this.api.datacenter.Game.isFight)
					{
						var var38 = this.mapHandler.getCellData(var4.cellNum).mc;
						this.onCellRelease(var38);
					}
					else if(Key.isDown(Key.SHIFT) || var3)
					{
						this.api.network.Dialog.create(var5);
					}
					else
					{
						var var39 = this.api.datacenter.Player.guildInfos.playerRights;
						var var40 = var4.guildName == this.api.datacenter.Player.guildInfos.name;
						var var41 = var40 && var39.canHireTaxCollector;
						var var42 = this.api.ui.createPopupMenu();
						var42.addItem(this.api.lang.getText("SPEAK"),this.api.network.Dialog,this.api.network.Dialog.create,[var5]);
						var42.addItem(this.api.lang.getText("COLLECT_TAX"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[8,var5],var40);
						var42.addItem(this.api.lang.getText("ATTACK"),this.api.network.GameActions,this.api.network.GameActions.attackTaxCollector,[[var5]],!var40);
						var42.addItem(this.api.lang.getText("REMOVE"),this.api.kernel.GameManager,this.api.kernel.GameManager.askRemoveTaxCollector,[[var5]],var41);
						var42.show(_root._xmouse,_root._ymouse);
					}
				}
			}
			else if(var4 instanceof dofus.datacenter.PrismSprite)
			{
				if(!this.api.datacenter.Player.isMutant)
				{
					if(this.api.datacenter.Game.isFight)
					{
						var var43 = this.mapHandler.getCellData(var4.cellNum).mc;
						this.onCellRelease(var43);
					}
					else
					{
						var var44 = this.api.datacenter.Player.alignment.index == 0;
						var var45 = this.api.datacenter.Player.alignment.compareTo(var4.alignment) == 0;
						if((Key.isDown(Key.SHIFT) || var3) && var45)
						{
							this.api.network.GameActions.usePrism([var5]);
						}
						else
						{
							var var46 = this.api.ui.createPopupMenu();
							var46.addItem(this.api.lang.getText("USE_WORD"),this.api.network.GameActions,this.api.network.GameActions.usePrism,[[var5]],var45);
							var46.addItem(this.api.lang.getText("ATTACK"),this.api.network.GameActions,this.api.network.GameActions.attackPrism,[[var5]],!var45 && !var44);
							var46.show(_root._xmouse,_root._ymouse);
						}
					}
				}
			}
		}
		else
		{
			if(this.api.datacenter.Player.currentUseObject != null && this.api.datacenter.Basics.gfx_canLaunch == true)
			{
				this.api.network.Items.use(this.api.datacenter.Player.currentUseObject.ID,var4.id,var4.cellNum);
			}
			this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
			this.api.gfx.clearPointer();
			this.unSelect(true);
			this.api.datacenter.Player.reset();
			this.api.ui.removeCursor();
			this.api.datacenter.Game.setInteractionType("move");
		}
	}
	function onSpriteRollOver(§\n\x1b§, §\x1a\f§)
	{
		if(!var3)
		{
			this._rollOverMcSprite = var2;
		}
		if(_root._xscale != 100)
		{
			return undefined;
		}
		var var6 = var2.data;
		var var7 = dofus.Constants.OVERHEAD_TEXT_OTHER;
		if(var6.isClear)
		{
			return undefined;
		}
		if(var6.hasParent)
		{
			this.onSpriteRollOver(var6.linkedParent.mc,var3);
			return undefined;
		}
		if(this.api.datacenter.Game.isRunning || this.api.datacenter.Game.interactionType == 5)
		{
			var var9 = this.mapHandler.getCellData(var6.cellNum).mc;
			if(var6.isVisible)
			{
				this.onCellRollOver(var9);
			}
		}
		var var10 = var6.name;
		if(var6 instanceof dofus.datacenter.Mutant && var6.showIsPlayer)
		{
			if(this.api.datacenter.Game.isRunning)
			{
				var10 = var6.playerName + " (" + var6.LP + ")";
				this.showSpriteInfosIfWeNeed(var6);
			}
			else
			{
				var10 = var6.playerName + " [" + var6.monsterName + " (" + var6.Level + ")]";
			}
		}
		else if(var6 instanceof dofus.datacenter.Mutant || (var6 instanceof dofus.datacenter.Creature || var6 instanceof dofus.datacenter.Monster))
		{
			var7 = dofus.Constants.NPC_ALIGNMENT_COLOR[var6.alignment.index];
			if(this.api.datacenter.Game.isRunning)
			{
				var10 = var10 + (" (" + var6.LP + ")");
				this.showSpriteInfosIfWeNeed(var6);
			}
			else
			{
				var10 = var10 + (" (" + var6.Level + ")");
			}
		}
		else if(var6 instanceof dofus.datacenter.Character)
		{
			var7 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
			if(this.api.datacenter.Game.isRunning)
			{
				var10 = var10 + (" (" + var6.LP + ")");
				if(var6.isVisible)
				{
					var var11 = var6.EffectsManager.getEffects();
					if(var11.length != 0)
					{
						this.addSpriteOverHeadItem(var6.id,"effects",dofus.graphics.battlefield.EffectsOverHead,[var11]);
					}
				}
				this.showSpriteInfosIfWeNeed(var6);
			}
			else if(this.api.datacenter.Game.isFight)
			{
				var10 = var10 + (" (" + var6.Level + ")");
			}
			if(!var6.isVisible)
			{
				return undefined;
			}
			var var4 = dofus.Constants.DEMON_ANGEL_FILE;
			if(var6.alignment.fallenAngelDemon)
			{
				var4 = dofus.Constants.FALLEN_DEMON_ANGEL_FILE;
			}
			var var12 = !var6.haveFakeAlignement?var6.alignment.index:var6.fakeAlignment.index;
			if(var6.rank.value > 0)
			{
				if(var12 == 1)
				{
					var var5 = var6.rank.value;
				}
				else if(var12 == 2)
				{
					var5 = 10 + var6.rank.value;
				}
				else if(var12 == 3)
				{
					var5 = 20 + var6.rank.value;
				}
			}
			var var8 = var6.title;
			if(var6.guildName != undefined && var6.guildName.length != 0)
			{
				var10 = "";
				this.addSpriteOverHeadItem(var6.id,"text",dofus.graphics.battlefield.GuildOverHead,[var6.guildName,var6.name,var6.emblem,var4,var5,var6.pvpGain,var8],undefined,true);
			}
		}
		else if(var6 instanceof dofus.datacenter.TaxCollector)
		{
			if(this.api.datacenter.Game.isRunning)
			{
				var10 = var10 + (" (" + var6.LP + ")");
				this.showSpriteInfosIfWeNeed(var6);
			}
			else if(this.api.datacenter.Game.isFight)
			{
				var10 = var10 + (" (" + var6.Level + ")");
			}
			else
			{
				var10 = "";
				this.addSpriteOverHeadItem(var6.id,"text",dofus.graphics.battlefield.GuildOverHead,[var6.guildName,var6.name,var6.emblem]);
			}
		}
		else if(var6 instanceof dofus.datacenter.PrismSprite)
		{
			var4 = dofus.Constants.DEMON_ANGEL_FILE;
			if(var6.alignment.value > 0)
			{
				if(var6.alignment.index == 1)
				{
					var5 = var6.alignment.value;
				}
				else if(var6.alignment.index == 2)
				{
					var5 = 10 + var6.alignment.value;
				}
				else if(var6.alignment.index == 3)
				{
					var5 = 20 + var6.alignment.value;
				}
			}
			var7 = dofus.Constants.NPC_ALIGNMENT_COLOR[var6.alignment.index];
			this.addSpriteOverHeadItem(var6.id,"text",dofus.graphics.battlefield.TextOverHead,[var10,var4,var7,var5]);
		}
		else if(var6 instanceof dofus.datacenter.ParkMount)
		{
			var7 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
			var10 = this.api.lang.getText("MOUNT_PARK_OVERHEAD",[var6.modelName,var6.level,var6.ownerName]);
			this.addSpriteOverHeadItem(var6.id,"text",dofus.graphics.battlefield.TextOverHead,[var10,var4,var7,var5]);
		}
		else if(var6 instanceof dofus.datacenter.OfflineCharacter)
		{
			var7 = dofus.Constants.OVERHEAD_TEXT_CHARACTER;
			var10 = "";
			this.addSpriteOverHeadItem(var6.id,"text",dofus.graphics.battlefield.OfflineOverHead,[var6]);
		}
		else if(var6 instanceof dofus.datacenter.NonPlayableCharacter)
		{
			var var13 = this.api.datacenter.Map;
			var var14 = this.api.datacenter.Subareas.getItemAt(var13.subarea);
			if(var14 != undefined)
			{
				var7 = dofus.Constants.NPC_ALIGNMENT_COLOR[var14.alignment.index];
			}
		}
		else if(var6 instanceof dofus.datacenter.MonsterGroup || var6 instanceof dofus.datacenter.Team)
		{
			if(var6.alignment.index != -1)
			{
				var7 = dofus.Constants.NPC_ALIGNMENT_COLOR[var6.alignment.index];
			}
			var var15 = var6.challenge.fightType;
			if(var6.isVisible && (var6 instanceof dofus.datacenter.MonsterGroup || var6.type == 1 && (var15 == 2 || (var15 == 3 || var15 == 4))))
			{
				if(var10 != "")
				{
					var var16 = dofus.Constants.OVERHEAD_TEXT_TITLE;
					this.addSpriteOverHeadItem(var6.id,"text",dofus.graphics.battlefield.TextWithTitleOverHead,[var10,var4,var7,var5,this.api.lang.getText("LEVEL") + " " + var6.totalLevel,var16,var6.bonusValue]);
				}
				this.selectSprite(var6.id,true);
				return undefined;
			}
		}
		if(var6.isVisible)
		{
			if(var10 != "")
			{
				this.addSpriteOverHeadItem(var6.id,"text",dofus.graphics.battlefield.TextOverHead,[var10,var4,var7,var5,var6.pvpGain,var8]);
			}
			this.selectSprite(var6.id,true);
		}
	}
	function onSpriteRollOut(§\n\x1b§, §\x1a\f§)
	{
		if(!var3)
		{
			this._rollOverMcSprite = undefined;
		}
		var var4 = var2.data;
		if(this.api.gfx.spriteHandler.isShowingMonstersTooltip && var4 instanceof dofus.datacenter.MonsterGroup)
		{
			return undefined;
		}
		if(var4.hasParent)
		{
			this.onSpriteRollOut(var4.linkedParent.mc);
			return undefined;
		}
		if(this.api.datacenter.Game.isRunning || this.api.datacenter.Game.interactionType == 5)
		{
			this.hideSpriteInfos();
			var var5 = this.mapHandler.getCellData(var4.cellNum).mc;
			this.onCellRollOut(var5);
		}
		this.removeSpriteOverHeadLayer(var4.id,"text");
		this.removeSpriteOverHeadLayer(var4.id,"effects");
		this.selectSprite(var4.id,false);
	}
	function onObjectRelease(§\x0b\x03§, §\x16\b§)
	{
		if(var3 == undefined)
		{
			var3 = false;
		}
		this.api.ui.hideTooltip();
		var var4 = var2.cellData;
		var var5 = var4.mc;
		var var6 = var4.layerObject2Num;
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			this.api.kernel.TutorialManager.onWaitingCase({code:"OBJECT_RELEASE",params:[var4.num,var6]});
			return undefined;
		}
		var var7 = var4.layerObjectExternalData;
		if(var7 != undefined)
		{
			if(var7.durability != undefined)
			{
				if(this.api.datacenter.Map.mountPark.isMine(this.api))
				{
					var var8 = this.api.ui.createPopupMenu();
					var8.addStaticItem(var7.name);
					var8.addItem(this.api.lang.getText("REMOVE"),this.api.network.Mount,this.api.network.Mount.removeObjectInPark,[var5.num]);
					var8.show(_root._xmouse,_root._ymouse);
					return undefined;
				}
			}
		}
		if(!_global.isNaN(var6) && (this.api.datacenter.Player.canUseInteractiveObjects && this.api.datacenter.Game.interactionType != 5))
		{
			var var9 = this.api.lang.getInteractiveObjectDataByGfxText(var6);
			var var10 = var9.n;
			var var11 = var9.sk;
			var var12 = var9.t;
			switch(var12)
			{
				default:
					loop6:
					switch(null)
					{
						default:
							switch(null)
							{
								case 12:
								case 14:
								case 15:
									break loop6;
								case 5:
									var var23 = true;
									var var24 = this.api.ui.createPopupMenu();
									var var25 = this.api.lang.getHousesDoorText(this.api.datacenter.Map.id,var5.num);
									var var26 = this.api.datacenter.Houses.getItemAt(var25);
									var24.addStaticItem(var10 + " " + var26.name);
									if(var26.localOwner)
									{
										var24.addStaticItem(this.api.lang.getText("MY_HOME"));
									}
									else if(var26.ownerName != undefined)
									{
										if(var26.ownerName == "?")
										{
											var24.addStaticItem(this.api.lang.getText("HOUSE_WITH_NO_OWNER"));
										}
										else
										{
											var24.addStaticItem(this.api.lang.getText("HOME_OF",[var26.ownerName]));
										}
									}
									if(this.api.datacenter.Player.isAuthorized && (var26.ownerName != undefined && var26.ownerName != "?"))
									{
										var24.addItem(this.api.lang.getText("HOME_OF",[var26.ownerName]),this.api.kernel.GameManager,this.api.kernel.GameManager.showPlayerPopupMenu,[undefined,"*" + var26.ownerName]);
									}
									for(var k in var11)
									{
										var var27 = var11[k];
										var var28 = new dofus.datacenter.(var27);
										var var29 = var28.getState(true,var26.localOwner,var26.isForSale,var26.isLocked);
										if(var29 != "X")
										{
											var var30 = var29 == "V";
											if(var30 && ((Key.isDown(Key.SHIFT) || var3) && var27 == 84))
											{
												this.api.kernel.GameManager.useRessource(var5,var5.num,var27);
												var23 = false;
												break;
											}
											var24.addItem(var28.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[var5,var5.num,var27],var30);
										}
									}
									if(var23)
									{
										var24.show(_root._xmouse,_root._ymouse);
									}
									break;
								case 6:
									var var31 = this.api.datacenter.Map.id + "_" + var5.num;
									var var32 = this.api.datacenter.Storages.getItemAt(var31);
									var var33 = var32.isLocked;
									var var34 = this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id);
									var var35 = true;
									var var36 = this.api.ui.createPopupMenu();
									var36.addStaticItem(var10);
									for(var k in var11)
									{
										var var37 = var11[k];
										var var38 = new dofus.datacenter.(var37);
										var var39 = var38.getState(true,var34,true,var33);
										if(var39 != "X")
										{
											var var40 = var39 == "V";
											if(var40 && (Key.isDown(Key.SHIFT) || var3))
											{
												this.api.kernel.GameManager.useRessource(var5,var5.num,var37);
												var35 = false;
												break;
											}
											var36.addItem(var38.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[var5,var5.num,var37],var40);
										}
									}
									if(var35)
									{
										var36.show(_root._xmouse,_root._ymouse);
									}
									break;
								default:
									if(§§enum_assign() !== 13)
									{
										this.onCellRelease(var5);
										break;
									}
									var var41 = this.api.datacenter.Map.mountPark;
									var var42 = true;
									var var43 = this.api.ui.createPopupMenu();
									var43.addStaticItem(var10);
									for(var k in var11)
									{
										var var44 = var11[k];
										var var45 = new dofus.datacenter.(var44);
										var var46 = var45.getState(true,var41.isMine(this.api),var41.price > 0,var41.isPublic || var41.isMine(this.api),false,var41.isPublic);
										if(var46 != "X")
										{
											var var47 = var46 == "V";
											if(var47 && (Key.isDown(Key.SHIFT) || var3))
											{
												this.api.kernel.GameManager.useRessource(var5,var5.num,var44);
												var42 = false;
												break;
											}
											var43.addItem(var45.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[var5,var5.num,var44],var47);
										}
									}
									if(var42)
									{
										var43.show(_root._xmouse,_root._ymouse);
									}
									break;
							}
						case 3:
						case 4:
						case 7:
						case 10:
					}
					break;
				case 1:
				case 2:
			}
			var var13 = this.api.datacenter.Player.currentJobID != undefined;
			if(var13)
			{
				var var14 = this.api.datacenter.Player.Jobs.findFirstItem("id",this.api.datacenter.Player.currentJobID).item.skills;
			}
			else
			{
				var14 = new ank.utils.
();
			}
			var var15 = true;
			var var16 = this.api.ui.createPopupMenu();
			var16.addStaticItem(var10);
			loop3:
			for(var k in var11)
			{
				var var17 = var11[k];
				var var18 = new dofus.datacenter.(var17);
				var var19 = var14.findFirstItem("id",var17).index != -1;
				var var20 = this.api.datacenter.Player.Level <= dofus.Constants.NOVICE_LEVEL;
				var var21 = var18.getState(var19,false,false,false,false,var20);
				if(var21 != "X")
				{
					var var22 = var21 == "V";
					if(var22 && ((Key.isDown(Key.SHIFT) || var3) && (var17 != 44 && var12 != 1)))
					{
						this.api.kernel.GameManager.useRessource(var5,var5.num,var17);
						var15 = false;
						while(true)
						{
							if(§§pop() == null)
							{
								break loop3;
							}
						}
					}
					else
					{
						var16.addItem(var18.description,this.api.kernel.GameManager,this.api.kernel.GameManager.useRessource,[var5,var5.num,var17],var22);
					}
				}
			}
			if(var15)
			{
				var16.show(_root._xmouse,_root._ymouse);
			}
		}
		else
		{
			this.onCellRelease(var5);
		}
	}
	function onObjectRollOver(§\x0b\x03§)
	{
		this._rollOverMcObject = var2;
		if(_root._xscale != 100)
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
			var var8 = new dofus.datacenter.("itemOnCell",ank.battlefield.mc.Sprite,"",var4.num,0,0);
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
					var var15 = new dofus.datacenter.("porte",ank.battlefield.mc.Sprite,"",var4.num,0,0);
					this.api.datacenter.Sprites.addItemAt("porte",var15);
					this.api.gfx.addSprite("porte");
					this.addSpriteOverHeadItem("porte","text",dofus.graphics.battlefield.GuildOverHead,[this.api.lang.getText("GUILD_HOUSE"),var14.guildName,var14.guildEmblem]);
				}
				break;
			case 13:
				var var16 = this.api.datacenter.Map.mountPark;
				var var17 = new dofus.datacenter.("enclos",ank.battlefield.mc.Sprite,"",var4.num,0,0);
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
	function onObjectRollOut(§\x0b\x03§)
	{
		this._rollOverMcObject = undefined;
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
