class ank.battlefield.SpriteHandler
{
	static var DEFAULT_RUNLINIT = 6;
	static var _bPlayerSpritesHidden = false;
	static var _bShowMonstersTooltip = false;
	function SpriteHandler(var3, var4, var5)
	{
		this.initialize(var2,var3,var4);
	}
	function __get__isShowingMonstersTooltip()
	{
		return ank.battlefield.SpriteHandler._bShowMonstersTooltip;
	}
	function __get__isPlayerSpritesHidden()
	{
		return ank.battlefield.SpriteHandler._bPlayerSpritesHidden;
	}
	function initialize(var2, var3, var4)
	{
		this._mcBattlefield = var2;
		this._oSprites = var4;
		this._mcContainer = var3;
		this.api = _global.API;
	}
	function clear(var2)
	{
		var var3 = this._oSprites.getItems();
		§§enumerate(var3);
		while((var var0 = §§enumeration()) != null)
		{
			this.removeSprite(k,var2);
		}
	}
	function getSprites()
	{
		return this._oSprites;
	}
	function getSprite(sID)
	{
		return this._oSprites.getItemAt(sID);
	}
	function addSprite(sID, oSprite)
	{
		var var4 = true;
		if(oSprite == undefined)
		{
			var4 = false;
			oSprite = this._oSprites.getItemAt(sID);
		}
		if(oSprite == undefined)
		{
			ank.utils.Logger.err("[addSprite] pas de spriteData");
			return undefined;
		}
		if(var4)
		{
			this._oSprites.addItemAt(sID,oSprite);
		}
		this._mcContainer["sprite" + sID].removeMovieClip();
		var var5 = ank.battlefield.utils.SpriteDepthFinder.getFreeDepthOnCell(this._mcBattlefield.mapHandler,this._oSprites,oSprite.cellNum,oSprite.allowGhostMode && this._mcBattlefield.bGhostView);
		var var6 = this._mcContainer.getInstanceAtDepth(var5);
		oSprite.mc = this._mcContainer.attachClassMovie(oSprite.clipClass,"sprite" + sID,var5,[this._mcBattlefield,this._oSprites,oSprite]);
		oSprite.isHidden = this._bAllSpritesMasked;
		if(oSprite.allowGhostMode && this._mcBattlefield.bGhostView)
		{
			oSprite.mc.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
		}
	}
	function addLinkedSprite(sID, §\x1e\x0f\x05§, §\x07\x03§, oSprite)
	{
		var var6 = true;
		var var7 = this._oSprites.getItemAt(var3);
		if(var7 == undefined)
		{
			ank.utils.Logger.err("[addLinkedSprite] pas de spriteData parent");
			return undefined;
		}
		if(oSprite == undefined)
		{
			var6 = false;
			oSprite = this._oSprites.getItemAt(sID);
		}
		if(oSprite == undefined)
		{
			ank.utils.Logger.err("[addLinkedSprite] pas de spriteData");
			return undefined;
		}
		if(var6)
		{
			this._oSprites.addItemAt(sID,oSprite);
		}
		var var8 = ank.battlefield.utils.Pathfinding.getArroundCellNum(this._mcBattlefield.mapHandler,var7.cellNum,var7.direction,var4);
		var var9 = this._mcBattlefield.mapHandler.getCellData(var8);
		if(var9.movement > 0 && var9.active)
		{
			oSprite.cellNum = var8;
		}
		else
		{
			oSprite.cellNum = var7.cellNum;
		}
		oSprite.linkedParent = var7;
		oSprite.childIndex = var4;
		var7.linkedChilds.addItemAt(sID,oSprite);
		this.addSprite(sID);
	}
	function carriedSprite(sID, §\x1e\x0f\x05§)
	{
		var var4 = this._oSprites.getItemAt(sID);
		if(var4 == undefined)
		{
			ank.utils.Logger.err("[carriedSprite] pas de spriteData");
			return undefined;
		}
		var var5 = this._oSprites.getItemAt(var3);
		if(var5 == undefined)
		{
			ank.utils.Logger.err("[carriedSprite] pas de spriteData parent");
			return undefined;
		}
		if(!var5.hasCarriedChild())
		{
			this.autoCalculateSpriteDirection(var3,var4.cellNum);
			var4.direction = var5.direction;
			var4.carriedParent = var5;
			var5.carriedChild = var4;
			var var6 = var5.mc;
			var6.setAnim("carring",false,false);
			var6.onEnterFrame = function()
			{
				this.updateCarriedPosition();
				delete this.onEnterFrame;
			};
			var4.mc.updateMap(var5.cellNum,var4.isVisible);
			var4.mc.setNewCellNum(var5.cellNum);
		}
	}
	function removeEffectsByCasterID(sCasterID)
	{
		if(!this.api.datacenter.Game.isFight || sCasterID == undefined)
		{
			return undefined;
		}
		var var3 = this.getSprites().getItems();
		for(var var4 in var3)
		{
			var var5 = var4.EffectsManager;
			if(var5 != undefined)
			{
				var5.removeEffectsByCasterID(sCasterID);
			}
		}
	}
	function uncarriedSprite(sID, §\x07\x11§, §\x13\x16§, §\x1e\x17\x1c§)
	{
		var oSprite = this._oSprites.getItemAt(sID);
		if(oSprite == undefined)
		{
			ank.utils.Logger.err("[addLinkedSprite] pas de spriteData parent");
			return undefined;
		}
		if(oSprite.hasCarriedParent())
		{
			oSprite.uncarryingSprite = true;
			var var6 = oSprite.mc;
			var var7 = oSprite.carriedParent;
			var var8 = var7.mc;
			var var9 = var7.sequencer;
			if(var5 == undefined)
			{
				var5 = var9;
			}
			else if(var4)
			{
				var5.addAction(1,false,this,function(var2, var3)
				{
					var2.sequencer = var3;
				}
				,[var7,var5]);
			}
			if(var4)
			{
				var5.addAction(2,false,this,this.autoCalculateSpriteDirection,[var7.id,var3]);
				var5.addAction(3,true,var8,var8.setAnim,["carringEnd",false,false]);
				var8.onEnterFrame = function()
				{
					this.updateCarriedPosition();
					delete this.onEnterFrame;
				};
			}
			var5.addAction(4,false,this,function(var2, var3)
			{
				oSprite.uncarryingSprite = false;
				oSprite.carriedParent = undefined;
				var3.carriedChild = undefined;
			}
			,[oSprite,var7]);
			if(!var5.containsAction(var6,var6.setPosition))
			{
				var5.addAction(5,false,this,this.setSpritePosition,[oSprite.id,var3]);
			}
			if(!var7.isPendingClearing)
			{
				var5.addAction(6,false,var8,var8.setAnim,["static",false,false]);
			}
			if(var4)
			{
				var5.addAction(7,false,this,function(var2, var3)
				{
					var2.sequencer = var3;
				}
				,[var7,var9]);
			}
		}
	}
	function mountSprite(sID, §\x1e\x18\x14§)
	{
		var var4 = this._oSprites.getItemAt(sID);
		if(var4 == undefined)
		{
			ank.utils.Logger.err("[mountSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(var3 != var4.mount)
		{
			var4.mount = var3;
			var4.mc.draw();
		}
	}
	function unmountSprite(sID)
	{
		var var3 = this._oSprites.getItemAt(sID);
		if(var3 == undefined)
		{
			ank.utils.Logger.err("[unmountSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(var3.mount != undefined)
		{
			var3.mount = undefined;
			var3.mc.draw();
		}
	}
	function removeSprite(sID, §\x18\x06§)
	{
		this._mcBattlefield.removeSpriteBubble(sID);
		this._mcBattlefield.hideSpriteOverHead(sID);
		if(var3 == undefined)
		{
			var3 = false;
		}
		var var4 = this._oSprites.getItemAt(sID);
		if(var4.mc != undefined && var4.mc == this.api.gfx.rollOverMcSprite)
		{
			this.api.gfx.onSpriteRollOut(var4.mc);
		}
		if(var4.hasChilds)
		{
			var var5 = var4.linkedChilds.getItems();
			§§enumerate(var5);
			while((var var0 = §§enumeration()) != null)
			{
				this.removeSprite(var5[k].id,var3);
			}
		}
		if(var4.hasParent && !var3)
		{
			var4.linkedParent.linkedChilds.removeItemAt(sID);
		}
		if(var4.hasCarriedChild())
		{
			var4.carriedChild.carriedParent = undefined;
			var4.carriedChild.mc.setPosition();
		}
		if(var4.hasCarriedParent())
		{
			var var6 = var4.carriedParent;
			var4.carriedParent.carriedChild = undefined;
			var6.mc.setAnim("static",false,false);
		}
		this._mcContainer["sprite" + sID].__proto__ = MovieClip.prototype;
		this._mcContainer["sprite" + sID].removeMovieClip();
		this._mcBattlefield.mapHandler.getCellData(var4.cellNum).removeSpriteOnID(var4.id);
		if(!var3)
		{
			this._oSprites.removeItemAt(sID);
		}
	}
	function hideSprite(sID, §\x19\t§)
	{
		var var4 = this._oSprites.getItemAt(sID);
		if(var4.hasChilds)
		{
			var var5 = var4.linkedChilds.getItems();
			§§enumerate(var5);
			while((var var0 = §§enumeration()) != null)
			{
				this.hideSprite(var5[k].id,var3);
			}
		}
		var4.mc.setVisible(!var3);
	}
	function unmaskAllSprites()
	{
		this._bAllSpritesMasked = false;
		var var2 = this._oSprites.getItems();
		for(var2[k].isHidden in var2)
		{
		}
	}
	function maskAllSprites()
	{
		this._bAllSpritesMasked = true;
		var var2 = this._oSprites.getItems();
		for(var2[k].isHidden in var2)
		{
		}
	}
	function setSpriteDirection(sID, §\x06\x07§)
	{
		if(var3 == undefined)
		{
			return undefined;
		}
		var var4 = this._oSprites.getItemAt(sID);
		if(var4 == undefined)
		{
			ank.utils.Logger.err("[setSpriteDirection] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(var4.hasChilds)
		{
			var var5 = var4.linkedChilds.getItems();
			§§enumerate(var5);
			while((var var0 = §§enumeration()) != null)
			{
				this.setSpriteDirection(var5[k].id,var3);
			}
		}
		if(var4.hasCarriedChild())
		{
			var4.carriedChild.mc.setDirection(var3);
		}
		var var6 = var4.mc;
		var6.setDirection(var3);
	}
	function setSpritePosition(sID, §\x07\x11§, §\x06\x07§)
	{
		var var5 = this._oSprites.getItemAt(sID);
		if(var5 == undefined)
		{
			ank.utils.Logger.err("[setSpritePosition] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(_global.isNaN(Number(var3)))
		{
			ank.utils.Logger.err("[setSpritePosition] cellNum n\'est pas un nombre");
			return undefined;
		}
		if(Number(var3) < 0 || Number(var3) > this._mcBattlefield.mapHandler.getCellCount())
		{
			ank.utils.Logger.err("[setSpritePosition] cellNum invalide");
			return undefined;
		}
		if(var5.hasChilds)
		{
			var var6 = var5.linkedChilds.getItems();
			for(var var7 in var6)
			{
				this.setSpriteDirection(var6[k].id,var7,var4);
			}
		}
		this._mcBattlefield.removeSpriteBubble(sID);
		this._mcBattlefield.hideSpriteOverHead(sID);
		if(var4 != undefined)
		{
			var5.direction = var4;
		}
		var var8 = var5.mc;
		var8.setPosition(var3);
	}
	function stopSpriteMove(sID, §\x1e\x17\x1c§, §\x07\x11§)
	{
		var3.clearAllNextActions();
		var var5 = this._oSprites.getItemAt(sID);
		var var6 = var5.mc;
		var5.isInMove = false;
		var3.addAction(8,false,var6,var6.setPosition,[var4]);
		var3.addAction(9,false,var6,var6.setAnim,["static"]);
	}
	function slideSprite(sID, §\x13\x05§, §\x1e\x12\x15§, §\x1e\x14\x16§)
	{
		if(var5 == undefined)
		{
			var5 = "static";
		}
		var var6 = this._oSprites.getItemAt(sID);
		var var7 = var6.futureCellNum == -1?var6.cellNum:var6.futureCellNum;
		var var8 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(this._mcBattlefield.mapHandler.getCellData(var7).x,this._mcBattlefield.mapHandler.getCellData(var7).rootY,this._mcBattlefield.mapHandler.getCellData(var3).x,this._mcBattlefield.mapHandler.getCellData(var3).rootY,false);
		var var9 = ank.battlefield.utils.Compressor.makeFullPath(this._mcBattlefield.mapHandler,[{num:var7},{num:var3,dir:var8}]);
		if(var9 != undefined)
		{
			this.moveSprite(sID,var9,var4,false,var5);
		}
	}
	function moveSprite(sID, §\x1e\x16\x1b§, §\x1e\x12\x15§, §\x1b\x0e§, §\x1e\x14\x16§, §\x19\x17§, §\x19\x16§, §\x1e\x14\x1d§)
	{
		this._mcBattlefield.removeSpriteBubble(sID);
		this._mcBattlefield.hideSpriteOverHead(sID);
		var var10 = var6 != undefined;
		if(var9 == undefined)
		{
			var9 = ank.battlefield.SpriteHandler.DEFAULT_RUNLINIT;
		}
		if(var7 == undefined)
		{
			var7 = false;
		}
		if(var8 == undefined)
		{
			var8 = false;
		}
		var var11 = !var10?"walk":"slide";
		if(var8)
		{
			var11 = "walk";
		}
		else if(var7)
		{
			var11 = "run";
		}
		else if(!var7 && (!var8 && !var10))
		{
			if(var3.length > var9)
			{
				var11 = "run";
			}
		}
		var var12 = this._oSprites.getItemAt(sID);
		if(var12 == undefined)
		{
			ank.utils.Logger.err("[moveSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(var4 == undefined)
		{
			var4 = var12.sequencer;
		}
		var var13 = Number(var3[var3.length - 1]);
		var12.futureCellNum = var13;
		if(var12.hasChilds)
		{
			if(var3.length > 1)
			{
				var var14 = ank.battlefield.utils.Pathfinding.getDirection(this._mcBattlefield.mapHandler,Number(var3[var3.length - 2]),var13);
			}
			else
			{
				var14 = var12.direction;
			}
			var var15 = var12.linkedChilds.getItems();
			for(var k in var15)
			{
				var var16 = var15[k];
				var var17 = ank.battlefield.utils.Pathfinding.getArroundCellNum(this._mcBattlefield.mapHandler,var13,var14,var16.childIndex);
				var var18 = ank.battlefield.utils.Pathfinding.pathFind(this.api,this._mcBattlefield.mapHandler,var16.cellNum,var17,{bAllDirections:var16.allDirections,bIgnoreSprites:true,bCellNumOnly:true,bWithBeginCellNum:true});
				if(var18 != null)
				{
					ank.utils.Timer.setTimer(var16,"battlefield",this,this.moveSprite,200 + (var12.cellNum != var16.cellNum?0:200),[var16.id,var18,var16.sequencer,var5,var6,var16.forceRun || var7,var16.forceWalk || var8,var9]);
				}
			}
		}
		var var19 = var12.mc;
		if(var5)
		{
			if(!var10)
			{
				var4.clearAllNextActions();
			}
		}
		var4.addAction(10,false,var19,var19.setPosition,[var3[0]]);
		var var20 = var3.length;
		var var21 = var20 - 1;
		var var22 = 0;
		while(var22 < var20)
		{
			var var23 = var6;
			var var24 = var11;
			var var25 = false;
			if(var22 != 0)
			{
				var var26 = this._mcBattlefield.mapHandler.getCellHeight(var3[var22 - 1]);
				var var27 = this._mcBattlefield.mapHandler.getCellHeight(var3[var22]);
				if(Math.abs(var26 - var27) > 0.5 && this._mcBattlefield.isJumpActivate)
				{
					var23 = "jump";
					var24 = "run";
					var25 = true;
				}
			}
			var4.addAction(11,true,var19,var19.moveToCell,[var4,var3[var22],var22 == var21,var24,var23,var25]);
			var22 = var22 + 1;
		}
		var4.execute();
	}
	function setCreatureMode(var2)
	{
		var var3 = this.api.datacenter.Sprites.getItems();
		for(var var4 in var3)
		{
			if(var4 instanceof dofus.datacenter.Character)
			{
				if(var4.canSwitchInCreaturesMode)
				{
					if(!(var4 instanceof dofus.datacenter.Mutant))
					{
						if(var2)
						{
							if(!var4.bInCreaturesMode)
							{
								var4.tmpGfxFile = var4.gfxFile;
								var4.tmpMount = var4.mount;
								var4.mount = undefined;
								var var5 = dofus.Constants.CLIPS_PERSOS_PATH + var4.Guild + "2.swf";
								this.api.gfx.setSpriteGfx(var4.id,var5);
								var4.bInCreaturesMode = true;
							}
						}
						else if(var4.bInCreaturesMode)
						{
							var4.mount = var4.tmpMount;
							delete register4.tmpMount;
							var var6 = var4.tmpGfxFile != undefined?var4.tmpGfxFile:var4.gfxFile;
							delete register4.tmpGfxFile;
							this.api.gfx.setSpriteGfx(var4.id,var6);
							var4.bInCreaturesMode = false;
						}
					}
				}
			}
		}
	}
	function hidePlayerSprites(var2)
	{
		if(var2 == undefined)
		{
			var2 = true;
		}
		else
		{
			ank.battlefield.SpriteHandler._bPlayerSpritesHidden = var2;
		}
		if(!this.api.datacenter.Game.isFight)
		{
			var var3 = this.getSprites().getItems();
			for(var sID in var3)
			{
				if(sID != this.api.datacenter.Player.ID)
				{
					var var4 = var3[sID];
					var var5 = var4.mc;
					var var6 = var5.data;
					if(var6 instanceof dofus.datacenter.Character || (var6 instanceof dofus.datacenter.OfflineCharacter || var6 instanceof dofus.datacenter.MonsterGroup))
					{
						var4.isHidden = var2;
						var var7 = var4.linkedChilds.getItems();
						for(var sChildID in var7)
						{
							var var8 = var7[sChildID];
							var8.isHidden = var2;
						}
					}
				}
			}
		}
	}
	function showMonstersTooltip(var2)
	{
		ank.battlefield.SpriteHandler._bShowMonstersTooltip = var2;
		var var3 = this.api.gfx.spriteHandler.getSprites().getItems();
		for(var var4 in var3)
		{
			var var5 = var4.data;
			if(var5 instanceof dofus.datacenter.MonsterGroup)
			{
				if(var2)
				{
					var4._rollOver(true);
				}
				else
				{
					var4._rollOut(true);
				}
			}
		}
	}
	function launchVisualEffect(sID, §\x1e\x19\x11§, §\x07\x11§, §\x06\x02§, §\t\x0b§, §\x1e\f\x1b§, §\x1e\x17\x13§, §\x19\x0e§, §\x1c\x01§)
	{
		if(var10 == undefined)
		{
			var10 = true;
		}
		var var11 = this._oSprites.getItemAt(sID);
		if(var11 == undefined)
		{
			ank.utils.Logger.err("[launchVisualEffect] Sprite " + sID + " inexistant");
			return undefined;
		}
		var var12 = this._oSprites.getItemAt(var7);
		if(!this.api.electron.isWindowFocused)
		{
			var3.file = undefined;
		}
		if(!var10)
		{
			this._mcBattlefield.visualEffectHandler.addEffect(var11,var3,var4,var5,var12,!var9?var11.isVisible:true);
			return undefined;
		}
		var var13 = var11.mc;
		var var14 = var11.sequencer;
		var var15 = true;
		if((var var0 = var5) !== 0)
		{
			loop0:
			switch(null)
			{
				case 10:
				case 11:
					var var16 = false;
					break;
				case 12:
					var16 = true;
					break;
				default:
					switch(null)
					{
						case 21:
						case 30:
						case 31:
							var16 = true;
							break loop0;
						default:
							switch(null)
							{
								case 41:
								case 50:
									var16 = false;
									break loop0;
								case 51:
									var16 = true;
									break loop0;
								default:
									var16 = false;
									var15 = false;
							}
						case 40:
							var16 = true;
					}
				case 20:
					var16 = false;
			}
		}
		else
		{
			var16 = false;
			var15 = false;
		}
		var13._ACTION = var11;
		var13._OBJECT = var13;
		var14.addAction(12,false,this,this.autoCalculateSpriteDirection,[sID,var4]);
		if(var6 != undefined)
		{
			var var17 = typeof var6;
			if(var17 == "object")
			{
				if(var6.length < 3)
				{
					ank.utils.Logger.err("[launchVisualEffect] l\'anim " + var6 + " est invalide");
					return undefined;
				}
				var var18 = var11.cellNum;
				var var19 = this._mcBattlefield.mapHandler.getCellData(var18);
				var var20 = this._mcBattlefield.mapHandler.getCellData(var4);
				var var21 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(var19.x,var19.y,var20.x,var20.y,false);
				var var22 = ank.battlefield.utils.Compressor.makeFullPath(this._mcBattlefield.mapHandler,ank.battlefield.utils.Pathfinding.pathFind(this.api,this._mcBattlefield.mapHandler,var18,var4,{bIgnoreSprites:true,bWithBeginCellNum:true}));
				var22.pop();
				var var23 = var22[var22.length - 1];
				this.moveSprite(sID,var22,var14,false,var6[0],false,true);
				var14.addAction(13,false,var13,var13.setDirection,[ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(var21)]);
				var14.addAction(14,true,var13,var13.setAnim,[var6[1]]);
				if(var15)
				{
					var14.addAction(15,var16,this._mcBattlefield.visualEffectHandler,this._mcBattlefield.visualEffectHandler.addEffect,[var11,var3,var4,var5,var12,!var9?var11.isVisible:true]);
				}
				var var24 = ank.battlefield.utils.Compressor.makeFullPath(this._mcBattlefield.mapHandler,ank.battlefield.utils.Pathfinding.pathFind(this.api,this._mcBattlefield.mapHandler,var23,var18,{bIgnoreSprites:true,bWithBeginCellNum:true}));
				this.moveSprite(sID,var24,var14,false,var6[2],false,true);
				var14.addAction(16,false,var13,var13.setDirection,[var21]);
				if(var6[3] != undefined)
				{
					var14.addAction(17,false,var13,var13.setAnim,[var6[3]]);
				}
				var14.execute();
				return undefined;
			}
			if(var17 == "string")
			{
				var14.addAction(18,true,var13,var13.setAnim,[var6,false,true]);
			}
		}
		if(var8 != undefined)
		{
			var14.addAction(19,false,this,this.hideSprite,[var8.id,true]);
		}
		if(var15)
		{
			var14.addAction(20,var16,this._mcBattlefield.visualEffectHandler,this._mcBattlefield.visualEffectHandler.addEffect,[var11,var3,var4,var5,var12,!var9?var11.isVisible:true]);
		}
		if(var8 != undefined)
		{
			var14.addAction(21,false,this,this.hideSprite,[var8.id,false]);
		}
		var14.execute();
	}
	function launchCarriedSprite(sID, §\x1e\x19\x11§, §\x07\x11§, §\x06\x02§)
	{
		var var6 = this._oSprites.getItemAt(sID);
		var var7 = var6.sequencer;
		if(var6 == undefined)
		{
			ank.utils.Logger.err("[launchCarriedSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		var var8 = var6.carriedChild;
		this.launchVisualEffect(sID,var3,var4,var5,"carringThrow",undefined,var8);
		var7.addAction(22,false,this,this.setSpritePosition,[var8.id,var4]);
		this.uncarriedSprite(var8.id,var4,false,var7);
		var7.addAction(23,false,this,this.setSpriteAnim,[sID,"static"]);
		var7.execute();
	}
	function autoCalculateSpriteDirection(sID, §\x07\x11§)
	{
		var var4 = this._oSprites.getItemAt(sID);
		if(var4 == undefined)
		{
			ank.utils.Logger.err("[launchVisualEffect] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(var4.cellNum != var3)
		{
			var var5 = var4.mc;
			var var6 = this._mcBattlefield.mapHandler.getCellData(var4.cellNum);
			var var7 = this._mcBattlefield.mapHandler.getCellData(var3);
			var var8 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(var6.x,var6.rootY,var7.x,var7.rootY,false);
			var5.setDirection(var8);
		}
	}
	function convertHeightToFourSpriteDirection(sID)
	{
		var var3 = this._oSprites.getItemAt(sID);
		if(var3 == undefined)
		{
			ank.utils.Logger.err("[convertHeightToFourSpriteDirection] Sprite " + sID + " inexistant");
			return undefined;
		}
		this.setSpriteDirection(sID,ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(var3.direction));
	}
	function setSpriteAnim(sID, §\x1e\x02§, §\x19\x19§)
	{
		var var5 = this._oSprites.getItemAt(sID);
		if(var5 == undefined)
		{
			ank.utils.Logger.err("[setSpriteAnim(" + var3 + ")] Sprite " + sID + " inexistant");
			return undefined;
		}
		ank.utils.Timer.removeTimer(var5.mc,"battlefield");
		var5.mc.setAnim(var3,false,var4);
	}
	function setSpriteLoopAnim(sID, §\x1e\x02§, §\x1e\x1b\x1a§)
	{
		var var5 = this._oSprites.getItemAt(sID);
		if(var5 == undefined)
		{
			ank.utils.Logger.err("[setSpriteLoopAnim] Sprite " + sID + " inexistant");
			return undefined;
		}
		ank.utils.Timer.removeTimer(var5.mc,"battlefield");
		var5.mc.setAnim(var3,true);
		ank.utils.Timer.setTimer(var5.mc,"battlefield",var5.mc,var5.mc.setAnim,var4,["static"]);
	}
	function setSpriteTimerAnim(sID, §\x1e\x02§, §\x19\x19§, §\x1e\x1b\x1a§)
	{
		var var6 = this._oSprites.getItemAt(sID);
		if(var6 == undefined)
		{
			ank.utils.Logger.err("[setSpriteTimerAnim] Sprite " + sID + " inexistant");
			return undefined;
		}
		ank.utils.Timer.removeTimer(var6.mc,"battlefield");
		var6.mc.setAnimTimer(var3,false,var4,var5);
	}
	function setSpriteGfx(sID, §\x1e\x12\x0b§)
	{
		var var4 = this._oSprites.getItemAt(sID);
		if(var4 == undefined)
		{
			ank.utils.Logger.err("[setSpriteGfx] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(var3 != var4.gfxFile)
		{
			var4.gfxFile = var3;
			var4.mc.draw();
			if(var4.allowGhostMode && this._mcBattlefield.bGhostView)
			{
				var4.mc.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
			}
		}
	}
	function setSpriteColorTransform(sID, §\x1e\x0b\x12§)
	{
		var var4 = this._oSprites.getItemAt(sID);
		if(var4 == undefined)
		{
			ank.utils.Logger.err("[setSpriteColorTransform] Sprite " + sID + " inexistant");
			return undefined;
		}
		var4.mc.setColorTransform(var3);
	}
	function setSpriteAlpha(sID, §\b\x19§)
	{
		var var4 = this._oSprites.getItemAt(sID);
		if(var4 == undefined)
		{
			ank.utils.Logger.err("[setSpriteAlpha] Sprite " + sID + " inexistant");
			return undefined;
		}
		var4.mc.setAlpha(var3);
	}
	function addSpriteExtraClip(sID, §\x12\x19§, §\x12\x15§, §\x14\r§)
	{
		var var6 = this._oSprites.getItemAt(sID);
		if(var6 == undefined)
		{
			ank.utils.Logger.err("[addSpriteExtraClip] Sprite " + sID + " inexistant");
			return undefined;
		}
		var6.mc.addExtraClip(var3,var4,var5);
	}
	function removeSpriteExtraClip(sID, §\x14\r§)
	{
		var var4 = this._oSprites.getItemAt(sID);
		if(var4 == undefined)
		{
			ank.utils.Logger.err("[removeSpriteExtraClip] Sprite " + sID + " inexistant");
			return undefined;
		}
		var4.mc.removeExtraClip(var3);
	}
	function showSpritePoints(sID, §\x1e\n\x02§, §\x12\x15§)
	{
		var var5 = this._oSprites.getItemAt(sID);
		if(var5 == undefined)
		{
			ank.utils.Logger.err("[showSpritePoints] Sprite " + sID + " inexistant");
			return undefined;
		}
		var5.mc.showPoints(var3,var4);
	}
	function setSpriteGhostView(var2)
	{
		var var3 = this._oSprites.getItems();
		for(var var4 in var3)
		{
			var4.mc.setGhostView(var4.allowGhostMode && var2);
		}
	}
	function selectSprite(sID, §\x15\x16§)
	{
		var var4 = this._oSprites.getItemAt(sID);
		if(var4 == undefined)
		{
			ank.utils.Logger.err("[selectSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(var4.hasChilds)
		{
			var var5 = var4.linkedChilds.getItems();
			for(var k in var5)
			{
				this.selectSprite(var5[k].id,var3);
			}
		}
		var4.mc.select(var3);
	}
	function setSpriteScale(sID, §\x1e\x1d\x19§, §\x1e\x1d\x18§)
	{
		var var5 = this._oSprites.getItemAt(sID);
		if(var5 == undefined)
		{
			ank.utils.Logger.err("[selectSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		var5.mc.setScale(var3,var4);
	}
}
