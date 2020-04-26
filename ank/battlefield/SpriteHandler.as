class ank.battlefield.SpriteHandler
{
	static var DEFAULT_RUNLINIT = 6;
	static var _bPlayerSpritesHidden = false;
	static var _bShowMonstersTooltip = false;
	function SpriteHandler(loc3, loc4, loc5)
	{
		this.initialize(loc2,loc3,loc4);
	}
	function __get__isShowingMonstersTooltip()
	{
		return ank.battlefield.SpriteHandler._bShowMonstersTooltip;
	}
	function __get__isPlayerSpritesHidden()
	{
		return ank.battlefield.SpriteHandler._bPlayerSpritesHidden;
	}
	function initialize(loc2, loc3, loc4)
	{
		this._mcBattlefield = loc2;
		this._oSprites = loc4;
		this._mcContainer = loc3;
		this.api = _global.API;
	}
	function clear(loc2)
	{
		var loc3 = this._oSprites.getItems();
		for(var k in loc3)
		{
			this.removeSprite(k,loc2);
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
		var loc4 = true;
		if(oSprite == undefined)
		{
			loc4 = false;
			oSprite = this._oSprites.getItemAt(sID);
		}
		if(oSprite == undefined)
		{
			ank.utils.Logger.err("[addSprite] pas de spriteData");
			return undefined;
		}
		if(loc4)
		{
			this._oSprites.addItemAt(sID,oSprite);
		}
		this._mcContainer["sprite" + sID].removeMovieClip();
		var loc5 = ank.battlefield.utils.SpriteDepthFinder.getFreeDepthOnCell(this._mcBattlefield.mapHandler,this._oSprites,oSprite.cellNum,oSprite.allowGhostMode && this._mcBattlefield.bGhostView);
		var loc6 = this._mcContainer.getInstanceAtDepth(loc5);
		oSprite.mc = this._mcContainer.attachClassMovie(oSprite.clipClass,"sprite" + sID,loc5,[this._mcBattlefield,this._oSprites,oSprite]);
		oSprite.isHidden = this._bAllSpritesMasked;
		if(oSprite.allowGhostMode && this._mcBattlefield.bGhostView)
		{
			oSprite.mc.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
		}
	}
	function addLinkedSprite(sID, §\x1e\x11\x04§, §\b\f§, oSprite)
	{
		var loc6 = true;
		var loc7 = this._oSprites.getItemAt(loc3);
		if(loc7 == undefined)
		{
			ank.utils.Logger.err("[addLinkedSprite] pas de spriteData parent");
			return undefined;
		}
		if(oSprite == undefined)
		{
			loc6 = false;
			oSprite = this._oSprites.getItemAt(sID);
		}
		if(oSprite == undefined)
		{
			ank.utils.Logger.err("[addLinkedSprite] pas de spriteData");
			return undefined;
		}
		if(loc6)
		{
			this._oSprites.addItemAt(sID,oSprite);
		}
		var loc8 = ank.battlefield.utils.Pathfinding.getArroundCellNum(this._mcBattlefield.mapHandler,loc7.cellNum,loc7.direction,loc4);
		var loc9 = this._mcBattlefield.mapHandler.getCellData(loc8);
		if(loc9.movement > 0 && loc9.active)
		{
			oSprite.cellNum = loc8;
		}
		else
		{
			oSprite.cellNum = loc7.cellNum;
		}
		oSprite.linkedParent = loc7;
		oSprite.childIndex = loc4;
		loc7.linkedChilds.addItemAt(sID,oSprite);
		this.addSprite(sID);
	}
	function carriedSprite(sID, §\x1e\x11\x04§)
	{
		var loc4 = this._oSprites.getItemAt(sID);
		if(loc4 == undefined)
		{
			ank.utils.Logger.err("[carriedSprite] pas de spriteData");
			return undefined;
		}
		var loc5 = this._oSprites.getItemAt(loc3);
		if(loc5 == undefined)
		{
			ank.utils.Logger.err("[carriedSprite] pas de spriteData parent");
			return undefined;
		}
		if(!loc5.hasCarriedChild())
		{
			this.autoCalculateSpriteDirection(loc3,loc4.cellNum);
			loc4.direction = loc5.direction;
			loc4.carriedParent = loc5;
			loc5.carriedChild = loc4;
			var loc6 = loc5.mc;
			loc6.setAnim("carring",false,false);
			loc6.onEnterFrame = function()
			{
				this.updateCarriedPosition();
				delete this.onEnterFrame;
			};
			loc4.mc.updateMap(loc5.cellNum,loc4.isVisible);
			loc4.mc.setNewCellNum(loc5.cellNum);
		}
	}
	function uncarriedSprite(sID, §\b\x1a§, §\x14\x12§, §\x1e\x19\x11§)
	{
		var oSprite = this._oSprites.getItemAt(sID);
		if(oSprite == undefined)
		{
			ank.utils.Logger.err("[addLinkedSprite] pas de spriteData parent");
			return undefined;
		}
		if(oSprite.hasCarriedParent())
		{
			var loc6 = oSprite.carriedParent;
			var loc7 = loc6.mc;
			var loc8 = loc6.sequencer;
			if(loc5 == undefined)
			{
				loc5 = loc8;
			}
			else if(loc4)
			{
				loc5.addAction(false,this,function(loc2, loc3)
				{
					loc2.sequencer = loc3;
				}
				,[loc6,loc5]);
			}
			if(loc4)
			{
				loc5.addAction(false,this,this.autoCalculateSpriteDirection,[loc6.id,loc3]);
				loc5.addAction(true,loc7,loc7.setAnim,["carringEnd",false,false]);
				loc7.onEnterFrame = function()
				{
					this.updateCarriedPosition();
					delete this.onEnterFrame;
				};
			}
			loc5.addAction(false,this,function(loc2, loc3)
			{
				oSprite.carriedParent = undefined;
				loc3.carriedChild = undefined;
			}
			,[oSprite,loc6]);
			loc5.addAction(false,this,this.setSpritePosition,[oSprite.id,loc3]);
			if(loc4)
			{
				loc5.addAction(false,loc7,loc7.setAnim,["static",false,false]);
				loc5.addAction(false,this,function(loc2, loc3)
				{
					loc2.sequencer = loc3;
				}
				,[loc6,loc8]);
			}
			loc5.execute();
		}
	}
	function mountSprite(sID, §\x1e\x1a\t§)
	{
		var loc4 = this._oSprites.getItemAt(sID);
		if(loc4 == undefined)
		{
			ank.utils.Logger.err("[mountSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(loc3 != loc4.mount)
		{
			loc4.mount = loc3;
			loc4.mc.draw();
		}
	}
	function unmountSprite(sID)
	{
		var loc3 = this._oSprites.getItemAt(sID);
		if(loc3 == undefined)
		{
			ank.utils.Logger.err("[unmountSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(loc3.mount != undefined)
		{
			loc3.mount = undefined;
			loc3.mc.draw();
		}
	}
	function removeSprite(sID, §\x18\x14§)
	{
		this._mcBattlefield.removeSpriteBubble(sID);
		this._mcBattlefield.hideSpriteOverHead(sID);
		if(loc3 == undefined)
		{
			loc3 = false;
		}
		var loc4 = this._oSprites.getItemAt(sID);
		if(loc4.hasChilds)
		{
			var loc5 = loc4.linkedChilds.getItems();
			for(var k in loc5)
			{
				this.removeSprite(loc5[k].id,loc3);
			}
		}
		if(loc4.hasParent && !loc3)
		{
			loc4.linkedParent.linkedChilds.removeItemAt(sID);
		}
		if(loc4.hasCarriedChild())
		{
			loc4.carriedChild.carriedParent = undefined;
			loc4.carriedChild.mc.setPosition();
		}
		if(loc4.hasCarriedParent())
		{
			var loc6 = loc4.carriedParent;
			loc4.carriedParent.carriedChild = undefined;
			loc6.mc.setAnim("static",false,false);
		}
		this._mcContainer["sprite" + sID].__proto__ = MovieClip.prototype;
		this._mcContainer["sprite" + sID].removeMovieClip();
		this._mcBattlefield.mapHandler.getCellData(loc4.cellNum).removeSpriteOnID(loc4.id);
		if(!loc3)
		{
			this._oSprites.removeItemAt(sID);
		}
	}
	function hideSprite(sID, §\x19\x15§)
	{
		var loc4 = this._oSprites.getItemAt(sID);
		if(loc4.hasChilds)
		{
			var loc5 = loc4.linkedChilds.getItems();
			for(var k in loc5)
			{
				this.hideSprite(loc5[k].id,loc3);
			}
		}
		loc4.mc.setVisible(!loc3);
	}
	function unmaskAllSprites()
	{
		this._bAllSpritesMasked = false;
		var loc2 = this._oSprites.getItems();
		for(var k in loc2)
		{
			loc2[k].isHidden = false;
		}
	}
	function maskAllSprites()
	{
		this._bAllSpritesMasked = true;
		var loc2 = this._oSprites.getItems();
		for(var k in loc2)
		{
			loc2[k].isHidden = true;
		}
	}
	function setSpriteDirection(sID, §\x07\x12§)
	{
		if(loc3 == undefined)
		{
			return undefined;
		}
		var loc4 = this._oSprites.getItemAt(sID);
		if(loc4 == undefined)
		{
			ank.utils.Logger.err("[setSpriteDirection] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(loc4.hasChilds)
		{
			var loc5 = loc4.linkedChilds.getItems();
			for(var k in loc5)
			{
				this.setSpriteDirection(loc5[k].id,loc3);
			}
		}
		if(loc4.hasCarriedChild())
		{
			loc4.carriedChild.mc.setDirection(loc3);
		}
		var loc6 = loc4.mc;
		loc6.setDirection(loc3);
	}
	function setSpritePosition(sID, §\b\x1a§, §\x07\x12§)
	{
		var loc5 = this._oSprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			ank.utils.Logger.err("[setSpritePosition] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(_global.isNaN(Number(loc3)))
		{
			ank.utils.Logger.err("[setSpritePosition] cellNum n\'est pas un nombre");
			return undefined;
		}
		if(Number(loc3) < 0 || Number(loc3) > this._mcBattlefield.mapHandler.getCellCount())
		{
			ank.utils.Logger.err("[setSpritePosition] cellNum invalide");
			return undefined;
		}
		if(loc5.hasChilds)
		{
			var loc6 = loc5.linkedChilds.getItems();
			for(var k in loc6)
			{
				var loc7 = ank.battlefield.utils.Pathfinding.getArroundCellNum(this._mcBattlefield.mapHandler,loc3,loc4,loc6[k].childIndex);
				this.setSpriteDirection(loc6[k].id,loc7,loc4);
			}
		}
		this._mcBattlefield.removeSpriteBubble(sID);
		this._mcBattlefield.hideSpriteOverHead(sID);
		if(loc4 != undefined)
		{
			loc5.direction = loc4;
		}
		var loc8 = loc5.mc;
		loc8.setPosition(loc3);
	}
	function stopSpriteMove(sID, §\x1e\x19\x11§, §\b\x1a§)
	{
		loc3.clearAllNextActions();
		var loc5 = this._oSprites.getItemAt(sID);
		var loc6 = loc5.mc;
		loc5.isInMove = false;
		loc3.addAction(false,loc6,loc6.setPosition,[loc4]);
		loc3.addAction(false,loc6,loc6.setAnim,["static"]);
	}
	function slideSprite(sID, cellNum, §\x1e\x14\x0e§, §\x1e\x16\r§)
	{
		if(loc5 == undefined)
		{
			loc5 = "static";
		}
		var loc6 = this._oSprites.getItemAt(sID);
		var loc7 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(this._mcBattlefield.mapHandler.getCellData(loc6.cellNum).x,this._mcBattlefield.mapHandler.getCellData(loc6.cellNum).rootY,this._mcBattlefield.mapHandler.getCellData(cellNum).x,this._mcBattlefield.mapHandler.getCellData(cellNum).rootY,false);
		var loc8 = ank.battlefield.utils.Compressor.makeFullPath(this._mcBattlefield.mapHandler,[{num:loc6.cellNum},{num:cellNum,dir:loc7}]);
		if(loc8 != undefined)
		{
			this.moveSprite(sID,loc8,loc4,false,loc5);
		}
	}
	function moveSprite(sID, §\x1e\x18\x10§, §\x1e\x14\x0e§, §\x1b\x17§, §\x1e\x16\r§, §\x1a\x05§, §\x1a\x04§, §\x1e\x16\x14§)
	{
		this._mcBattlefield.removeSpriteBubble(sID);
		this._mcBattlefield.hideSpriteOverHead(sID);
		var loc10 = loc6 != undefined;
		if(loc9 == undefined)
		{
			loc9 = ank.battlefield.SpriteHandler.DEFAULT_RUNLINIT;
		}
		if(loc7 == undefined)
		{
			loc7 = false;
		}
		if(loc8 == undefined)
		{
			loc8 = false;
		}
		var loc11 = !loc10?"walk":"slide";
		if(loc8)
		{
			loc11 = "walk";
		}
		else if(loc7)
		{
			loc11 = "run";
		}
		else if(!loc7 && (!loc8 && !loc10))
		{
			if(loc3.length > loc9)
			{
				loc11 = "run";
			}
		}
		var loc12 = this._oSprites.getItemAt(sID);
		if(loc12 == undefined)
		{
			ank.utils.Logger.err("[moveSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(loc4 == undefined)
		{
			loc4 = loc12.sequencer;
		}
		if(loc12.hasChilds)
		{
			var loc13 = Number(loc3[loc3.length - 1]);
			if(loc3.length > 1)
			{
				var loc14 = ank.battlefield.utils.Pathfinding.getDirection(this._mcBattlefield.mapHandler,Number(loc3[loc3.length - 2]),loc13);
			}
			else
			{
				loc14 = loc12.direction;
			}
			var loc15 = loc12.linkedChilds.getItems();
			for(var k in loc15)
			{
				var loc16 = loc15[k];
				var loc17 = ank.battlefield.utils.Pathfinding.getArroundCellNum(this._mcBattlefield.mapHandler,loc13,loc14,loc16.childIndex);
				var loc18 = ank.battlefield.utils.Pathfinding.pathFind(this._mcBattlefield.mapHandler,loc16.cellNum,loc17,{bAllDirections:loc16.allDirections,bIgnoreSprites:true,bCellNumOnly:true,bWithBeginCellNum:true});
				if(loc18 != null)
				{
					ank.utils.Timer.setTimer(loc16,"battlefield",this,this.moveSprite,200 + (loc12.cellNum != loc16.cellNum?0:200),[loc16.id,loc18,loc16.sequencer,loc5,loc6,loc16.forceRun || loc7,loc16.forceWalk || loc8,loc9]);
				}
			}
		}
		var loc19 = loc12.mc;
		if(loc5)
		{
			if(!loc10)
			{
				loc4.clearAllNextActions();
			}
		}
		loc4.addAction(false,loc19,loc19.setPosition,[loc3[0]]);
		var loc20 = loc3.length;
		var loc21 = loc20 - 1;
		var loc22 = 0;
		while(loc22 < loc20)
		{
			var loc23 = loc6;
			var loc24 = loc11;
			var loc25 = false;
			if(loc22 != 0)
			{
				var loc26 = this._mcBattlefield.mapHandler.getCellHeight(loc3[loc22 - 1]);
				var loc27 = this._mcBattlefield.mapHandler.getCellHeight(loc3[loc22]);
				if(Math.abs(loc26 - loc27) > 0.5 && this._mcBattlefield.isJumpActivate)
				{
					loc23 = "jump";
					loc24 = "run";
					loc25 = true;
				}
			}
			loc4.addAction(true,loc19,loc19.moveToCell,[loc4,loc3[loc22],loc22 == loc21,loc24,loc23,loc25]);
			loc22 = loc22 + 1;
		}
		loc4.execute();
	}
	function setCreatureMode(loc2)
	{
		var loc3 = this.api.datacenter.Sprites.getItems();
		for(var k in loc3)
		{
			var loc4 = loc3[k];
			if(loc4 instanceof dofus.datacenter.Character)
			{
				if(loc4.canSwitchInCreaturesMode)
				{
					if(!(loc4 instanceof dofus.datacenter.Mutant))
					{
						if(loc2)
						{
							if(!loc4.bInCreaturesMode)
							{
								loc4.tmpGfxFile = loc4.gfxFile;
								loc4.tmpMount = loc4.mount;
								loc4.mount = undefined;
								var loc5 = dofus.Constants.CLIPS_PERSOS_PATH + loc4.Guild + "2.swf";
								this.api.gfx.setSpriteGfx(loc4.id,loc5);
								loc4.bInCreaturesMode = true;
							}
						}
						else if(loc4.bInCreaturesMode)
						{
							loc4.mount = loc4.tmpMount;
							delete register4.tmpMount;
							var loc6 = loc4.tmpGfxFile != undefined?loc4.tmpGfxFile:loc4.gfxFile;
							delete register4.tmpGfxFile;
							this.api.gfx.setSpriteGfx(loc4.id,loc6);
							loc4.bInCreaturesMode = false;
						}
					}
				}
			}
		}
	}
	function hidePlayerSprites(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = true;
		}
		else
		{
			ank.battlefield.SpriteHandler._bPlayerSpritesHidden = loc2;
		}
		if(!this.api.datacenter.Game.isFight)
		{
			var loc3 = this.getSprites().getItems();
			for(var sID in loc3)
			{
				if(sID != this.api.datacenter.Player.ID)
				{
					var loc4 = loc3[sID];
					var loc5 = loc4.mc;
					var loc6 = loc5.data;
					if(loc6 instanceof dofus.datacenter.Character || (loc6 instanceof dofus.datacenter.OfflineCharacter || loc6 instanceof dofus.datacenter.MonsterGroup))
					{
						loc4.isHidden = loc2;
						var loc7 = loc4.linkedChilds.getItems();
						for(var sChildID in loc7)
						{
							var loc8 = loc7[sChildID];
							loc8.isHidden = loc2;
						}
					}
				}
			}
		}
	}
	function showMonstersTooltip(loc2)
	{
		ank.battlefield.SpriteHandler._bShowMonstersTooltip = loc2;
		var loc3 = this.api.gfx.spriteHandler.getSprites().getItems();
		for(var sID in loc3)
		{
			var loc4 = loc3[sID].mc;
			var loc5 = loc4.data;
			if(loc5 instanceof dofus.datacenter.MonsterGroup)
			{
				if(loc2)
				{
					loc4._rollOver();
				}
				else
				{
					loc4._rollOut();
				}
			}
		}
	}
	function launchVisualEffect(sID, §\x1e\x1b\x06§, §\b\x1a§, §\x07\r§, §\n\x12§, §\x1e\x0f\x02§, §\x1e\x19\b§, §\x19\x19§, §\x1c\b§)
	{
		if(loc10 == undefined)
		{
			loc10 = true;
		}
		var loc11 = this._oSprites.getItemAt(sID);
		if(loc11 == undefined)
		{
			ank.utils.Logger.err("[launchVisualEffect] Sprite " + sID + " inexistant");
			return undefined;
		}
		var loc12 = this._oSprites.getItemAt(loc7);
		if(!loc10)
		{
			this._mcBattlefield.visualEffectHandler.addEffect(loc11,loc3,loc4,loc5,loc12,!loc9?loc11.isVisible:true);
			return undefined;
		}
		var loc13 = loc11.mc;
		var loc14 = loc11.sequencer;
		var loc15 = true;
		loop0:
		switch(loc5)
		{
			case 0:
				var loc16 = false;
				loc15 = false;
				break;
			case 10:
			case 11:
				loc16 = false;
				break;
			case 12:
				loc16 = true;
				break;
			default:
				switch(null)
				{
					case 20:
					case 21:
						loc16 = false;
						break loop0;
					case 30:
					case 31:
						loc16 = true;
						break loop0;
					default:
						switch(null)
						{
							case 40:
							case 41:
								loc16 = true;
								break loop0;
							case 50:
								loc16 = false;
								break loop0;
							case 51:
								loc16 = true;
								break loop0;
							default:
								loc16 = false;
								loc15 = false;
						}
				}
		}
		loc13._ACTION = loc11;
		loc13._OBJECT = loc13;
		loc14.addAction(false,this,this.autoCalculateSpriteDirection,[sID,loc4]);
		if(loc6 != undefined)
		{
			var loc17 = typeof loc6;
			if(loc17 == "object")
			{
				if(loc6.length < 3)
				{
					ank.utils.Logger.err("[launchVisualEffect] l\'anim " + loc6 + " est invalide");
					return undefined;
				}
				var loc18 = loc11.cellNum;
				var loc19 = this._mcBattlefield.mapHandler.getCellData(loc18);
				var loc20 = this._mcBattlefield.mapHandler.getCellData(loc4);
				var loc21 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(loc19.x,loc19.y,loc20.x,loc20.y,false);
				var loc22 = ank.battlefield.utils.Compressor.makeFullPath(this._mcBattlefield.mapHandler,ank.battlefield.utils.Pathfinding.pathFind(this._mcBattlefield.mapHandler,loc18,loc4,{bIgnoreSprites:true,bWithBeginCellNum:true}));
				loc22.pop();
				var loc23 = loc22[loc22.length - 1];
				this.moveSprite(sID,loc22,loc14,false,loc6[0],false,true);
				loc14.addAction(false,loc13,loc13.setDirection,[ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(loc21)]);
				loc14.addAction(true,loc13,loc13.setAnim,[loc6[1]]);
				if(loc15)
				{
					loc14.addAction(loc16,this._mcBattlefield.visualEffectHandler,this._mcBattlefield.visualEffectHandler.addEffect,[loc11,loc3,loc4,loc5,loc12,!loc9?loc11.isVisible:true]);
				}
				var loc24 = ank.battlefield.utils.Compressor.makeFullPath(this._mcBattlefield.mapHandler,ank.battlefield.utils.Pathfinding.pathFind(this._mcBattlefield.mapHandler,loc23,loc18,{bIgnoreSprites:true,bWithBeginCellNum:true}));
				this.moveSprite(sID,loc24,loc14,false,loc6[2],false,true);
				loc14.addAction(false,loc13,loc13.setDirection,[loc21]);
				if(loc6[3] != undefined)
				{
					loc14.addAction(false,loc13,loc13.setAnim,[loc6[3]]);
				}
				loc14.execute();
				return undefined;
			}
			if(loc17 == "string")
			{
				loc14.addAction(true,loc13,loc13.setAnim,[loc6,false,true]);
			}
		}
		if(loc8 != undefined)
		{
			loc14.addAction(false,this,this.hideSprite,[loc8.id,true]);
		}
		if(loc15)
		{
			loc14.addAction(loc16,this._mcBattlefield.visualEffectHandler,this._mcBattlefield.visualEffectHandler.addEffect,[loc11,loc3,loc4,loc5,loc12,!loc9?loc11.isVisible:true]);
		}
		if(loc8 != undefined)
		{
			loc14.addAction(false,this,this.hideSprite,[loc8.id,false]);
		}
		loc14.execute();
	}
	function launchCarriedSprite(sID, §\x1e\x1b\x06§, §\b\x1a§, §\x07\r§)
	{
		var loc6 = this._oSprites.getItemAt(sID);
		var loc7 = loc6.sequencer;
		if(loc6 == undefined)
		{
			ank.utils.Logger.err("[launchCarriedSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		var loc8 = loc6.carriedChild;
		this.launchVisualEffect(sID,loc3,loc4,loc5,"carringThrow",undefined,loc8);
		loc7.addAction(false,this,this.setSpritePosition,[loc8.id,loc4]);
		this.uncarriedSprite(loc8.id,loc4,false,loc7);
		loc7.addAction(false,this,this.setSpriteAnim,[sID,"static"]);
		loc7.execute();
	}
	function autoCalculateSpriteDirection(sID, §\b\x1a§)
	{
		var loc4 = this._oSprites.getItemAt(sID);
		if(loc4 == undefined)
		{
			ank.utils.Logger.err("[launchVisualEffect] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(loc4.cellNum != loc3)
		{
			var loc5 = loc4.mc;
			var loc6 = this._mcBattlefield.mapHandler.getCellData(loc4.cellNum);
			var loc7 = this._mcBattlefield.mapHandler.getCellData(loc3);
			var loc8 = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(loc6.x,loc6.rootY,loc7.x,loc7.rootY,false);
			loc5.setDirection(loc8);
		}
	}
	function convertHeightToFourSpriteDirection(sID)
	{
		var loc3 = this._oSprites.getItemAt(sID);
		if(loc3 == undefined)
		{
			ank.utils.Logger.err("[convertHeightToFourSpriteDirection] Sprite " + sID + " inexistant");
			return undefined;
		}
		this.setSpriteDirection(sID,ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(loc3.direction));
	}
	function setSpriteAnim(sID, §\x1e\x03§, §\x1a\x07§)
	{
		var loc5 = this._oSprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			ank.utils.Logger.err("[setSpriteAnim(" + loc3 + ")] Sprite " + sID + " inexistant");
			return undefined;
		}
		ank.utils.Timer.removeTimer(loc5.mc,"battlefield");
		loc5.mc.setAnim(loc3,false,loc4);
	}
	function setSpriteLoopAnim(sID, §\x1e\x03§, §\x1e\x1d\x0f§)
	{
		var loc5 = this._oSprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			ank.utils.Logger.err("[setSpriteLoopAnim] Sprite " + sID + " inexistant");
			return undefined;
		}
		ank.utils.Timer.removeTimer(loc5.mc,"battlefield");
		loc5.mc.setAnim(loc3,true);
		ank.utils.Timer.setTimer(loc5.mc,"battlefield",loc5.mc,loc5.mc.setAnim,loc4,["static"]);
	}
	function setSpriteTimerAnim(sID, §\x1e\x03§, §\x1a\x07§, §\x1e\x1d\x0f§)
	{
		var loc6 = this._oSprites.getItemAt(sID);
		if(loc6 == undefined)
		{
			ank.utils.Logger.err("[setSpriteTimerAnim] Sprite " + sID + " inexistant");
			return undefined;
		}
		ank.utils.Timer.removeTimer(loc6.mc,"battlefield");
		loc6.mc.setAnimTimer(loc3,false,loc4,loc5);
	}
	function setSpriteGfx(sID, §\x1e\x14\x04§)
	{
		var loc4 = this._oSprites.getItemAt(sID);
		if(loc4 == undefined)
		{
			ank.utils.Logger.err("[setSpriteGfx] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(loc3 != loc4.gfxFile)
		{
			loc4.gfxFile = loc3;
			loc4.mc.draw();
			if(loc4.allowGhostMode && this._mcBattlefield.bGhostView)
			{
				loc4.mc.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
			}
		}
	}
	function setSpriteColorTransform(sID, §\x1e\r\x1a§)
	{
		var loc4 = this._oSprites.getItemAt(sID);
		if(loc4 == undefined)
		{
			ank.utils.Logger.err("[setSpriteColorTransform] Sprite " + sID + " inexistant");
			return undefined;
		}
		loc4.mc.setColorTransform(loc3);
	}
	function setSpriteAlpha(sID, §\n\x03§)
	{
		var loc4 = this._oSprites.getItemAt(sID);
		if(loc4 == undefined)
		{
			ank.utils.Logger.err("[setSpriteAlpha] Sprite " + sID + " inexistant");
			return undefined;
		}
		loc4.mc.setAlpha(loc3);
	}
	function addSpriteExtraClip(sID, §\x13\x18§, §\x13\x14§, §\x15\x07§)
	{
		var loc6 = this._oSprites.getItemAt(sID);
		if(loc6 == undefined)
		{
			ank.utils.Logger.err("[addSpriteExtraClip] Sprite " + sID + " inexistant");
			return undefined;
		}
		loc6.mc.addExtraClip(loc3,loc4,loc5);
	}
	function removeSpriteExtraClip(sID, §\x15\x07§)
	{
		var loc4 = this._oSprites.getItemAt(sID);
		if(loc4 == undefined)
		{
			ank.utils.Logger.err("[removeSpriteExtraClip] Sprite " + sID + " inexistant");
			return undefined;
		}
		loc4.mc.removeExtraClip(loc3);
	}
	function showSpritePoints(sID, §\x1e\f\x0b§, §\x13\x14§)
	{
		var loc5 = this._oSprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			ank.utils.Logger.err("[showSpritePoints] Sprite " + sID + " inexistant");
			return undefined;
		}
		loc5.mc.showPoints(loc3,loc4);
	}
	function setSpriteGhostView(loc2)
	{
		var loc3 = this._oSprites.getItems();
		for(var loc4 in loc3)
		{
			loc4.mc.setGhostView(loc4.allowGhostMode && loc2);
		}
	}
	function selectSprite(sID, §\x16\x0e§)
	{
		var loc4 = this._oSprites.getItemAt(sID);
		if(loc4 == undefined)
		{
			ank.utils.Logger.err("[selectSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		if(loc4.hasChilds)
		{
			var loc5 = loc4.linkedChilds.getItems();
			for(var k in loc5)
			{
				this.selectSprite(loc5[k].id,loc3);
			}
		}
		loc4.mc.select(loc3);
	}
	function setSpriteScale(sID, §\x01\r§, §\x01\f§)
	{
		var loc5 = this._oSprites.getItemAt(sID);
		if(loc5 == undefined)
		{
			ank.utils.Logger.err("[selectSprite] Sprite " + sID + " inexistant");
			return undefined;
		}
		loc5.mc.setScale(loc3,loc4);
	}
}
